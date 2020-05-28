
Dir.glob "_posts/*.md" do |filename|
    dt = "2019-10-22-"
    newf = filename.gsub(/_posts\/(.*?)/,"_posts/#{dt}")
    File.rename(filename,newf)
end