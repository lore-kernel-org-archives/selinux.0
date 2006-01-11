Message-ID: <43C59613.4010206@cornell.edu>
Date: Wed, 11 Jan 2006 16:34:43 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Fix calloc check in semanage_store:115
Content-Type: multipart/mixed;
 boundary="------------010101060304000800080305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010101060304000800080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes an omem check bug noticed by Steve Grubb.


--------------010101060304000800080305
Content-Type: text/x-patch;
 name="libsemanage.calloc_store.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.calloc_store.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-06 08:41:43.000000000 -0700
+++ new/libsemanage/src/semanage_store.c	2006-01-11 16:27:15.000000000 -0700
@@ -114,7 +114,7 @@ static int semanage_init_paths(const cha
 	for (i = 0; i < SEMANAGE_NUM_FILES; i++) {
 		len = (strlen(semanage_relative_files[i]) + prefix_len);
 		semanage_files[i] = calloc(len + 1, sizeof(char));
-		if (!semanage_files[SEMANAGE_ROOT])
+		if (!semanage_files[i])
 			return -1;
 		sprintf(semanage_files[i], "%s%s%s", root, SEMANAGE_MOD_DIR,
 				  semanage_relative_files[i]); 

--------------010101060304000800080305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
