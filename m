Message-ID: <4357DB72.4090004@cornell.edu>
Date: Thu, 20 Oct 2005 14:01:22 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Fix user record memory leak
Content-Type: multipart/mixed;
 boundary="------------020100040508020608030904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020100040508020608030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch fixes a memory leak discovered by valgrind.

--------------020100040508020608030904
Content-Type: text/x-patch;
 name="libsepol.user_memleak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.user_memleak.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/src/user_record.c	2005-10-20 13:57:37.000000000 -0400
@@ -361,6 +361,7 @@ void sepol_user_free(sepol_user_t* user)
 	free(user->name);
 	for (i = 0; i < user->num_roles; i++)
 		free(user->roles[i]);
+	free(user->def_role);
 	free(user->roles);
 	free(user->mls_level);
 	free(user->mls_range);

--------------020100040508020608030904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
