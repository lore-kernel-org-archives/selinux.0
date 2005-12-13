Message-ID: <439E16FC.7020708@cornell.edu>
Date: Mon, 12 Dec 2005 19:34:04 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Toggle modified flag in semanage_policydb_modify
Content-Type: multipart/mixed;
 boundary="------------090701000708080009000101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090701000708080009000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's some patches that have been lying around for a while...
This one sets the modify flag in policydb_modify.


--------------090701000708080009000101
Content-Type: text/x-patch;
 name="libsemanage.policydb_modify_flag.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policydb_modify_flag.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-11-23 23:21:26.000000000 -0500
@@ -257,6 +257,7 @@ static int dbase_policydb_modify (
 		dbase->policydb, key, data) < 0)
 		goto err;
 
+	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
 	err:

--------------090701000708080009000101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
