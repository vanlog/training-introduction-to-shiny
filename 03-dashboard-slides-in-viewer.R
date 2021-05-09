## Source the whole file: CTRL + A CTRL + ENTER

slides <- here::here("03-dashboard-slides.html")

myViewer <- getOption("viewer")
tmp_dir <- tempdir()
file.copy(slides, file.path(tmp_dir, "test.html"), overwrite = T)
myViewer(file.path(tmp_dir, "test.html"), height = 500)
