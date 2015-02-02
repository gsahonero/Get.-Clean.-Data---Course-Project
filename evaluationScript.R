#evaluation script: to load the csv file of the student.

#downloading and loading the file:
fileD <- function (url)
{
    tmp=tempfile();
    download.file(url=url, destfile=tmp);    
    E<-read.csv(tmp);
    View(`E`)
}