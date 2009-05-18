Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IIHkpQ030483
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:17:46 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IIHrup019643
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 18:17:53 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIHi0R008408
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:17:44 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4IIHihD008915
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:17:44 -0400
Received: from localhost.localdomain (vpn-10-81.bos.redhat.com [10.16.10.81])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIHhWN003178
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:17:43 -0400
Message-ID: <4A11A64A.4030901@redhat.com>
Date: Mon, 18 May 2009 14:17:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This patch outputs <<none>> from the matchpathcon command when it
 gets enoent
Content-Type: multipart/mixed;
 boundary="------------060300090201000508010202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060300090201000508010202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060300090201000508010202
Content-Type: text/plain;
 name="libselinux_matchpathcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_matchpathcon.patch"

--- nsalibselinux/utils/matchpathcon.c	2009-05-18 13:53:14.000000000 -0400
+++ libselinux-2.0.81/utils/matchpathcon.c	2009-05-18 14:04:07.000000000 -0400
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

--------------060300090201000508010202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
