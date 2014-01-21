# This is a simple, CSS-like way to style your application.
# You can set these attributes in your screens by using `add` or `set_attributes`
# and passing in the method you want to use.
#
# Example usage: `add UILabel.new, :label_view_style`
module HomeStyles
  def apple_button_style
    {
      resize: [ :left, :right, :top ], # ProMotion sugar here
      frame: CGRectMake(10, 150, 283, 338)
    }
  end

  def home_view_style
    {
      background_color: UIColor.whiteColor
    }
  end
end
