module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - MuraQiita"
    else
      'MuraQiita'
    end
  end
end

