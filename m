Message-ID: <43AC9DAD.1050903@cornell.edu>
Date: Fri, 23 Dec 2005 20:00:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMODULE] Make -B flag force rebuild (without changes)
Content-Type: multipart/mixed;
 boundary="------------070204080700070300060803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070204080700070300060803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use semanage_set_rebuild() to make the -B flag force a rebuild.
This is necessary since I changed commit to only rebuild if changes were 
made.

The whitespace in semodule is an awful mess..

--------------070204080700070300060803
Content-Type: text/x-patch;
 name="semodule.force_rebuild.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semodule.force_rebuild.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semodule/semodule.c new/policycoreutils/semodule/semodule.c
--- old/policycoreutils/semodule/semodule.c	2005-11-29 10:55:01.000000000 -0500
+++ new/policycoreutils/semodule/semodule.c	2005-12-23 19:51:39.000000000 -0500
@@ -334,13 +334,13 @@ int main(int argc, char *argv[]) {
         }
         
         if (commit) {
-                if (verbose) {
-                        printf("Committing changes:\n");
-                }
-		if (no_reload) {
+		if (verbose)
+			printf("Committing changes:\n");
+		if (no_reload)
 			semanage_set_reload(sh, 0);
-		}
-                result = semanage_commit(sh);
+		if (build)
+			semanage_set_rebuild(sh, 1);
+ 		result = semanage_commit(sh);
         }
         
         if (result < 0) {

--------------070204080700070300060803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
