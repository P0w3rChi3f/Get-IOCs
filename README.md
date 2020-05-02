# Get-IOCs  

A script that will take in a text file and pull out all the IOCs and export them into a Zeek Intel Framework format.

## Updates

### 21 March 2020

Just uploaded a better working script.  There are some minor changes to the ouput that I need to tweek.  However, the person that is using this script in production is happy with the current results.  The current script has shaved hours off the old way they were doing this.  I hope you and your co-workers enjoy what I have started and improve upon it.  

---  

### 01 May 2020

Updated the script to allow changing the filename with the `$filename` parameter and the output path with the `$outpath` parameter.  I also changed the `$date` parameter to be the date of the report instead of the date the tool was run.  The original ouput file was in TSV format, which means it had quotation marks.  I added some formating code to remove the quotation marks,  this helps with sending the file over to Zeek.  

---

### To Do List

1. Test to verify that a .txt file was selected for input.  
2. Test to verify the OS the script is running on.  At this time it only works on Windows due to the underlineing .Net Calls it has.  
3. Add the ability to read in multiple .txt files.  
4. Remove duplicate IPs in the OutputFile.  
5. Add a column for the date of the report, not the date the report was run - format (DDMMYYY)  
6. Add an DOMAIN IOC to the outfile.  

---
