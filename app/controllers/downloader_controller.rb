class DownloaderController < ApplicationController
  def csv
    @libraries = Library.all.includes(:reader_cards => :user)
    headers['Content-Disposition'] = "attachment; filename=\"libraries_and_readers.csv\""
    headers['Content-Type'] ||= 'text/csv'
    csv_data = DownloadGenerator.generate_csv(headers, @libraries)
    render plain: csv_data
  end

  def pdf
    @libraries = Library.all.includes(:reader_cards => :user)
    send_data DownloadGenerator.generate_pdf(@libraries), filename: "library_data.pdf", type: "application/pdf", disposition: "attachment"
  end

  def pdf_library
    library = Library.find(params[:id])
    send_data DownloadGenerator.generate_library_report(library), filename: "#{library.name}.pdf", type: "application/pdf"
  end

  def pdf_user
    user = User.find(params[:id])
    send_data DownloadGenerator.generate_user_report(user), filename: "user_report_#{user.name}.pdf", type: 'application/pdf'
  end
end
