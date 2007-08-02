Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JOEgY018576
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:24:14 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JOCev023163
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:24:13 GMT
Message-ID: <46B22F59.7070502@redhat.com>
Date: Thu, 02 Aug 2007 15:24:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Pattern patch.  I believe this is a cut and paste error
Content-Type: multipart/mixed;
 boundary="------------070500050900080701020700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070500050900080701020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070500050900080701020700
Content-Type: text/x-patch;
 name="pattern.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pattern.patch"

--- nsaserefpolicy/policy/support/file_patterns.spt	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.5/policy/support/file_patterns.spt	2007-08-02 11:02:03.000000000 -0400
@@ -310,47 +310,47 @@
 #
 define(`getattr_sock_files_pattern',`
 	allow $1 $2:dir search_dir_perms;
-	allow $1 $3:sock_file getattr_fifo_file_perms;
+	allow $1 $3:sock_file getattr_sock_file_perms;
 ')
 
 define(`setattr_sock_files_pattern',`
 	allow $1 $2:dir search_dir_perms;
-	allow $1 $3:sock_file setattr_fifo_file_perms;
+	allow $1 $3:sock_file setattr_sock_file_perms;
 ')
 
 define(`read_sock_files_pattern',`
 	allow $1 $2:dir search_dir_perms;
-	allow $1 $3:sock_file read_fifo_file_perms;
+	allow $1 $3:sock_file read_sock_file_perms;
 ')
 
 define(`write_sock_files_pattern',`
 	allow $1 $2:dir search_dir_perms;
-	allow $1 $3:sock_file write_fifo_file_perms;
+	allow $1 $3:sock_file write_sock_file_perms;
 ')
 
 define(`rw_sock_files_pattern',`
 	allow $1 $2:dir search_dir_perms;
-	allow $1 $3:sock_file rw_fifo_file_perms;
+	allow $1 $3:sock_file rw_sock_file_perms;
 ')
 
 define(`create_sock_files_pattern',`
 	allow $1 $2:dir add_entry_dir_perms;
-	allow $1 $3:sock_file create_fifo_file_perms;
+	allow $1 $3:sock_file create_sock_file_perms;
 ')
 
 define(`delete_sock_files_pattern',`
 	allow $1 $2:dir del_entry_dir_perms;
-	allow $1 $3:sock_file delete_fifo_file_perms;
+	allow $1 $3:sock_file delete_sock_file_perms;
 ')
 
 define(`rename_sock_files_pattern',`
 	allow $1 $2:dir rw_dir_perms;
-	allow $1 $3:sock_file rename_fifo_file_perms;
+	allow $1 $3:sock_file rename_sock_file_perms;
 ')
 
 define(`manage_sock_files_pattern',`
 	allow $1 $2:dir rw_dir_perms;
-	allow $1 $3:sock_file manage_fifo_file_perms;
+	allow $1 $3:sock_file manage_sock_file_perms;
 ')
 
 define(`relabelfrom_sock_files_pattern',`

--------------070500050900080701020700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
