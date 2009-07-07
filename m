Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n67GUv2w011393
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 12:30:57 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n67GValO014381
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 16:31:36 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n67GUtYu021741
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 12:30:55 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n67GUtSM010357
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 12:30:55 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n67GUqPO002340
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 12:30:54 -0400
Message-ID: <4A53783C.5080509@redhat.com>
Date: Tue, 07 Jul 2009 12:30:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Matchpathcon patch to print <<none>> when it gets enoent.
Content-Type: multipart/mixed;
 boundary="------------060800010502020809040904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060800010502020809040904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060800010502020809040904
Content-Type: text/plain;
 name="libselinux-matchpathcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-matchpathcon.patch"

Subject: [PATCH] refpolicy: nsalibselinux_utils_matchpathcon.c changes
--text follows this line--
--- nsalibselinux/utils/matchpathcon.c	2009-07-07 11:10:42.033956000 -0400
+++ libselinux-2.0.83/utils/matchpathcon.c	2009-07-07 12:22:39.395209000 -0400
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

--------------060800010502020809040904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
