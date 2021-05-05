## Source the whole file: CTRL + A CTRL + ENTER

slides <- "01-simple-shiny-app.html"

myViewer <- getOption("viewer")
tmp_dir <- tempdir()
file.copy(slides, file.path(tmp_dir, "test.html"), overwrite = T)
myViewer(file.path(tmp_dir, "test.html"), height = 500)
