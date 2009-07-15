Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6FEb3UA030346
	for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2009 10:37:03 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6FEbmuM006396
	for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2009 14:37:49 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6FEb1Cc004964
	for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2009 10:37:02 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6FEb0Fw015880
	for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2009 10:37:01 -0400
Received: from localhost.localdomain (vpn-12-115.rdu.redhat.com [10.11.12.115])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6FEb00v024669
	for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2009 10:37:00 -0400
Message-ID: <4A5DE96B.7080400@redhat.com>
Date: Wed, 15 Jul 2009 10:36:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libsemanage patch
Content-Type: multipart/mixed;
 boundary="------------070100060303060807060501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070100060303060807060501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If you have a homedir that ends in '/', genhomedircon gets confused.

# useradd -h /home2/dwalsh/ dwalsh
# genhomedircon

Check out the labeling.  genhomedircon thinks dwalsh is a toplevel home root.  

We should just get rid of this command...  :^)

Patch removes all trailing '/' from homedir.

--------------070100060303060807060501
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.33/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.33/src/genhomedircon.c	2009-07-15 10:32:20.000000000 -0400
@@ -304,6 +304,10 @@
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
+		int len = strlen(pwbuf->pw_dir) -1;
+		for(; len > 0 && pwbuf->pw_dir[len]=='/'; len--) {
+			pwbuf->pw_dir[len]=0;
+		}
 		if (strcmp(pwbuf->pw_dir, "/") == 0)
 			continue;
 		if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)

--------------070100060303060807060501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
