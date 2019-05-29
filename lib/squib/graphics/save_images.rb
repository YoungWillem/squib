module Squib
  class Card

    # :nodoc:
    # @api private
    def save_png(batch, scale_box)
      surface = if preprocess_save?(batch, scale_box)
                  w, h = compute_dimensions(scale_box, batch.rotate, batch.trim)
                  preprocessed_save(w, h, batch, scale_box)
                else
                  @cairo_surface
                end
      write_png(surface, index, batch.dir, batch.prefix, batch.count_format)
    end

    # :nodoc:
    # @api private
    def preprocess_save?(batch, box)
        box.width != @width ||
        box.height != @height ||
        batch.rotate != false ||
        batch.trim > 0
    end

    def compute_dimensions(box, rotate, trim)
      if rotate
         [ @height - 2 * trim, @width - 2 * trim ]
       else
         [ @width - 2 * trim, @height - 2 * trim ]
       end
    end

    def preprocessed_save(trimmed_w, trimmed_h, batch, scale_box)
      scale_w = scale_box.width.to_f / trimmed_w
      scale_h = scale_box.height.to_f / trimmed_h
      w = if scale_box.width == @width
            trimmed_w
          else # user specified a width
            scale_box.width
          end
      h = if scale_box.height == @height # specified height
            trimmed_h
          else # user specified a width
            scale_box.height
          end
      new_cc = Cairo::Context.new(Cairo::ImageSurface.new(w, h))
      new_cc.scale(scale_w, scale_h) # scale back
      trim_radius = batch.trim_radius
      if batch.rotate != false
        new_cc.translate(w * 0.5, h * 0.5)
        new_cc.rotate(batch.angle)
        new_cc.translate(h * -0.5, w * -0.5)
        new_cc.rounded_rectangle(0, 0,
                                 trimmed_h, trimmed_w,
                                 trim_radius, trim_radius)
      else
        new_cc.rounded_rectangle(0, 0,
                                 trimmed_w, trimmed_h,
                                 trim_radius, trim_radius)
      end
      new_cc.clip
      new_cc.set_source(@cairo_surface, -batch.trim, -batch.trim)
      new_cc.paint
      return new_cc.target
    end

    def write_png(surface, i, dir, prefix, count_format)
      surface.write_to_png("#{dir}/#{prefix}#{count_format % i}.png")
    end

  end
end
