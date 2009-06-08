Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n58J86OK003051
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:08:06 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n58J8ReX003708
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 19:08:28 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n58J851G024987
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:08:05 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n58J83XE025021
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:08:04 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n58J82bp029384
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:08:03 -0400
Message-ID: <4A2D618F.2050509@redhat.com>
Date: Mon, 08 Jun 2009 15:07:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsemanage direct_api can return errors < 0.
Content-Type: multipart/mixed;
 boundary="------------070601080400010101000209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070601080400010101000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070601080400010101000209
Content-Type: text/plain;
 name="libsemanage-directapi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-directapi.patch"

--- nsalibsemanage/src/direct_api.c	2009-01-13 08:45:35.000000000 -0500
+++ libsemanage-2.0.31/src/direct_api.c	2009-06-02 14:54:20.000000000 -0400
@@ -991,7 +991,7 @@
 
 	int retval = -1;
 	char *data = NULL;
-	size_t data_len = 0;
+	ssize_t data_len = 0;
 	int compressed = 0;
 	int in_fd = -1;
 
@@ -999,7 +999,7 @@
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 		
@@ -1117,7 +1117,7 @@
 {
 	int retval = -1;
 	char *data = NULL;
-	size_t data_len = 0;
+	ssize_t data_len = 0;
 	int compressed = 0;
 	int in_fd = -1;
 
@@ -1125,7 +1125,7 @@
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 
@@ -1187,7 +1187,7 @@
 {
 	int retval = -1;
 	char *data = NULL;
-	size_t data_len = 0;
+	ssize_t data_len = 0;
 	int compressed = 0;
 	int in_fd;
 
@@ -1195,7 +1195,7 @@
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 		

--------------070601080400010101000209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
