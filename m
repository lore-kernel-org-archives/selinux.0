Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n31EJg50022605
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:19:43 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n31EJfrT019198
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 14:19:42 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n31EJfSH028324
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:19:41 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n31EJguc030009
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:19:42 -0400
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n31EJfUs028163
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:19:41 -0400
Message-ID: <49D377FC.1040303@redhat.com>
Date: Wed, 01 Apr 2009 10:19:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fixes for libselinux/matchpathcon
Content-Type: multipart/mixed;
 boundary="------------010909020800020005050706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010909020800020005050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removing trailing / if given to matchpathcon.

If matchpathcon returns ENOENT, we return <<none>>

--------------010909020800020005050706
Content-Type: text/plain;
 name="matchpathcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="matchpathcon.patch"

--- nsalibselinux/utils/matchpathcon.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.79/utils/matchpathcon.c	2009-03-27 10:09:31.000000000 -0400
@@ -22,9 +22,13 @@
 	char *buf;
 	int rc = matchpathcon(path, mode, &buf);
 	if (rc < 0) {
-		fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
-			strerror(errno));
-		return 1;
+		if (errno == ENOENT) {
+			buf=strdup("<<none>>");
+		} else {
+			fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
+				strerror(errno));
+			return 1;
+		}
 	}
 	if (header)
 		printf("%s\t%s\n", path, buf);
@@ -101,6 +105,11 @@
 	for (i = optind; i < argc; i++) {
 		int mode = 0;
 		struct stat buf;
+		int len = strlen(argv[i]);
+		if (len > 1  && argv[i][len - 1 ] == '/') {
+			argv[i][len - 1 ] = '\0';
+		}
+
 		if (lstat(argv[i], &buf) == 0)
 			mode = buf.st_mode;
 

--------------010909020800020005050706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
