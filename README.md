# Get-IOCs  

A script that will take in a text file and pull out all the IOCs and export them into a Zeek Intel Framework format.

## 21 March 2020

Just uploaded a better working script.  There are some minor changes to the ouput that I need to tweek.  However, the person that is using this script in production is happy with the current results.  The current script has shaved hours off the old way they were doing this.  I hope you and your co-workers enjoy what I have started and improve upon it.  

---  

## 01 May 2020

Updated the script to allow changing the filename with the `$filename` parameter and the output path with the `$outpath` parameter.  I also changed the `$date` parameter to be the date of the report instead of the date the tool was run.  The original ouput file was in TSV format, which means it had quotation marks.  I added some formating code to remove the quotation marks,  this helps with sending the file over to Zeek.  

---
