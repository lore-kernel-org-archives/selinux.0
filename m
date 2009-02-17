Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGhA6e011629
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:43:10 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HGh9ZD026059
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 16:43:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGh8Aj022182
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:43:08 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1HGh8CG007420
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:43:09 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGh7Ct017734
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:43:07 -0500
Message-ID: <499AE91A.30400@redhat.com>
Date: Tue, 17 Feb 2009 11:43:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add missing --level option to semanage
Content-Type: multipart/mixed;
 boundary="------------030707050002000201030801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030707050002000201030801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030707050002000201030801
Content-Type: text/plain;
 name="nsapolicycoreutils_semanage_semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_semanage_semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2008-11-14 17:10:15.000000000 -0500
+++ policycoreutils-2.0.61/semanage/semanage	2009-01-20 09:49:03.000000000 -0500
@@ -219,6 +219,7 @@
 					     'seuser=',
 					     'store=',
 					     'range=',
+					     'locallist=',
 					     'level=',
 					     'roles=',
 					     'type=',

--------------030707050002000201030801
Content-Type: application/pgp-signature;
 name="nsapolicycoreutils_semanage_semanage.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="nsapolicycoreutils_semanage_semanage.patch.sig"

iEYEABECAAYFAkma6RoACgkQrlYvE4MpobNzbgCfZKoulNbQU31KIQ7ZZMvc+qRQVYMAnAoA
Q4tNnySfjGZ34cQ5XyFiq78e
--------------030707050002000201030801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
