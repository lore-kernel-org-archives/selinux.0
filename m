Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k58Ju90J007439
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:09 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k58Ju8rG014378
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 19:56:09 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Ju8YD009232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k58Ju2AS273842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:56:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k58Ju8Uj015105
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:56:08 -0600
Received: from sergelap.hallyn.com (sig-9-65-96-38.mts.ibm.com [9.65.96.38])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Ju7V9015086
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:56:08 -0600
Date: Thu, 8 Jun 2006 14:55:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 3/3] libsemanage: fix memory semanage_fc_sort leak
Message-ID: <20060608195519.GC29665@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

'temp' is not destroyed on return(-1) in three places before it
is linked into head.

thanks,
-serge

--- libsemanage/src/semanage_store.c.orig	2006-06-08 13:51:57.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-06-08 14:54:03.000000000 -0500
@@ -1969,6 +1969,7 @@ int semanage_fc_sort(semanage_handle_t *
 		temp->path = (char*)strndup(&line_buf[start], regex_len);
 		if (!temp->path) {
 			ERR(sh, "Failure allocating memory.");
+			semanage_fc_node_destroy(temp);
 			semanage_fc_node_list_destroy(head);
 			return -1;
 		}
@@ -2000,6 +2001,7 @@ int semanage_fc_sort(semanage_handle_t *
 			temp->file_type = (char*)strndup(&line_buf[i], type_len);
 			if (!temp->file_type) {
 				ERR(sh, "Failure allocating memory.");
+				semanage_fc_node_destroy(temp);
 				semanage_fc_node_list_destroy(head);
 				return -1;
 			}
@@ -2031,6 +2033,7 @@ int semanage_fc_sort(semanage_handle_t *
 		temp->context = (char*)strndup(&line_buf[start], context_len);
 		if (!temp->context) {
 			ERR(sh, "Failure allocating memory.");
+			semanage_fc_node_destroy(temp);
 			semanage_fc_node_list_destroy(head);
 			return -1;
 		}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
