module ApplicationHelper
  def category_color(category_name)
    colors = {
      "Electronics" => "#3498db",
      "Clothing" => "#e74c3c",
      "Books" => "#2ecc71",
      "Home & Garden" => "#f39c12",
      "Toys" => "#9b59b6"
    }
    colors[category_name] || "#95a5a6"  # Default color if category is not in the list
  end

  def contrasting_text_color(bg_color)
    # Convert hex to RGB
    rgb = bg_color.gsub("#", "").scan(/../).map(&:hex)
    # Calculate luminance
    luminance = (0.299 * rgb[0] + 0.587 * rgb[1] + 0.114 * rgb[2]) / 255
    luminance > 0.5 ? "#000000" : "#ffffff"
  end
end
