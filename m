Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75EaCD9019460
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:36:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75EaCSF023400
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 14:36:12 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m75Ea6D2008857
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:36:11 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m75EZsCC005985
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:36:04 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m75EZhjr003841
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:35:44 -0400
Message-ID: <4898651F.9040005@redhat.com>
Date: Tue, 05 Aug 2008 10:35:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add /etc/services to restorecond file.
Content-Type: multipart/mixed;
 boundary="------------090209080304050602060102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090209080304050602060102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/etc/services labeling is being destroyed by vmware post install script.
 This causes several confined domains to blow up trying to read
rmp_script_tmp_t.


--------------090209080304050602060102
Content-Type: text/plain;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/restorecond/restorecond.conf policycoreutils-2.0.53/restorecond/restorecond.conf
--- nsapolicycoreutils/restorecond/restorecond.conf	2008-08-05 09:58:27.000000000 -0400
+++ policycoreutils-2.0.53/restorecond/restorecond.conf	2008-08-01 10:54:17.000000000 -0400
@@ -1,3 +1,4 @@
+/etc/services
 /etc/resolv.conf
 /etc/samba/secrets.tdb
 /etc/mtab

--------------090209080304050602060102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
