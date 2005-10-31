Message-ID: <4365BF77.9000604@cornell.edu>
Date: Mon, 31 Oct 2005 01:53:43 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 2 ] Fix bug in dbase_file_flush
Content-Type: multipart/mixed;
 boundary="------------060709030103090202080405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060709030103090202080405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a bug in the file flush function.
Applies on top of the large patch I sent earlier.


--------------060709030103090202080405
Content-Type: text/x-patch;
 name="libsemanage.fix_flush.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_flush.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-31 01:48:29.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-10-31 01:50:30.000000000 -0500
@@ -180,7 +180,7 @@ static int dbase_file_flush(
 	if (!dbase->modified || !dbase->cached)
 		return STATUS_SUCCESS;
 
-	if (!construct_filename(handle, dbase, &fname) < 0)
+	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
 
 	str = fopen(fname, "w");

--------------060709030103090202080405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
