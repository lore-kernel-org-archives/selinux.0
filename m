Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8UINrAl019267
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:23:53 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8UIPPWi022954
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 18:25:25 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UINoAR012880
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:23:51 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UINonw018200
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:23:50 -0400
Message-ID: <4AC3A237.3050908@redhat.com>
Date: Wed, 30 Sep 2009 14:23:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fix boolean handling in semanage
Content-Type: multipart/mixed;
 boundary="------------090001070908000109080102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090001070908000109080102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Also fix error message triggered by broken boolean handling.


--------------090001070908000109080102
Content-Type: text/plain;
 name="booleans.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="booleans.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index ffaca5b..437eca3 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -315,6 +315,7 @@ Object-specific Options (see above):
 		
 		if object == "boolean":
 			OBJECT = seobject.booleanRecords(store)
+                        modify = True
 		
 		if object == "permissive":
 			OBJECT = seobject.permissiveRecords(store)
@@ -404,7 +405,7 @@ Object-specific Options (see above):
 
                         return
 
-                raise ValueError(_("Invalid command") % " ".join(argv))
+                raise ValueError(_("Invalid command: semanage %s") % " ".join(argv))
 
 	#
 	# 

--------------090001070908000109080102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
