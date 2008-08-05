Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75EY0UO019041
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:34:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75EXxSF022872
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 14:33:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m75EXwSf007868
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:33:58 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m75EXv9j004433
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:33:57 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m75EXuv7003269
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:33:56 -0400
Message-ID: <489864B4.1090605@redhat.com>
Date: Tue, 05 Aug 2008 10:33:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Can we make libsemanage default to expand-check=0
Content-Type: multipart/mixed;
 boundary="------------090600060409020604080009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090600060409020604080009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090600060409020604080009
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage.conf libsemanage-2.0.25/src/semanage.conf
--- nsalibsemanage/src/semanage.conf	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.25/src/semanage.conf	2008-07-17 13:58:44.000000000 -0400
@@ -35,4 +35,4 @@
 # given in <sepol/policydb.h>.  Change this setting if a different
 # version is necessary.
 #policy-version = 19
-
+expand-check=0

--------------090600060409020604080009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
