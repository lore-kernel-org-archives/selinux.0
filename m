Message-ID: <4207BAB7.3060406@redhat.com>
Date: Mon, 07 Feb 2005 14:00:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: policycoreutils diff
Content-Type: multipart/mixed;
 boundary="------------030309010900020008020009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030309010900020008020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

sestatus was going into infinite loops with booleans > 30 chars.

Dan

--------------030309010900020008020009
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.12/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-02-02 17:20:59.000000000 -0500
+++ policycoreutils-1.21.12/scripts/fixfiles	2005-02-02 17:23:48.000000000 -0500
@@ -67,8 +67,8 @@
                -e 's|\?.*|*|g' \
 	       -e 's|\(.*|*|g' \
 	       -e 's|\[.*|*|g' \
-               -e 's|\.\*|*|g' \
-               -e 's|\.\+|*|g' | \
+               -e 's|\.\*.*|*|g' \
+               -e 's|\.\+.*|*|g' | \
 	sort -d -u | \
         while read pattern ; \
 	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
@@ -79,7 +79,7 @@
                fi; \
             done | \
 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	${RESTORECON} -R $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
+	 ${RESTORECON} -R $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
 	rm -f ${TEMPFILE}
 fi
 }
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/sestatus/sestatus.c policycoreutils-1.21.12/sestatus/sestatus.c
--- nsapolicycoreutils/sestatus/sestatus.c	2004-11-03 15:29:44.000000000 -0500
+++ policycoreutils-1.21.12/sestatus/sestatus.c	2005-02-07 13:55:06.000000000 -0500
@@ -30,7 +30,7 @@
 #define BUFSIZE 255
 
 /* column to put the output (must be a multiple of 8) */
-#define COL 32
+static int COL=32;
 
 extern char *selinux_mnt;
 
@@ -152,15 +152,10 @@
 }
 
 void printf_tab(const char *outp) {
-	/* print then add appropriate number of tabs */
-	int i, count;
+  char buf[20];
+  snprintf(buf, sizeof(buf), "%%-%ds", COL);
+	printf(buf, outp);
 
-	printf("%s",outp);
-
-	/* insert the right number of tabs */
-	count=((COL - strlen(outp) -1) / 8);
-	for( i=0 ; i<count ; i++ )
-		printf("\t");
 }
 
 int main(int argc, char **argv) {
@@ -276,6 +271,10 @@
 		printf("\nPolicy booleans:\n");
 
 		for( i=0 ; i<nbool ; i++ ) {
+			if (strlen(bools[i]) + 1 > COL) 
+			    COL=strlen(bools[i])+1;
+		}
+		for( i=0 ; i<nbool ; i++ ) {
 			printf_tab(bools[i]);
 
 			rc=security_get_boolean_active(bools[i]);

--------------030309010900020008020009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
