/*
 <block> <parameter> {
     <args>
 }
*/

resource "local_file" "my_file" {
  filename = "automate.txt"
  content  = "hi terraform this file genrated by terraform."
}