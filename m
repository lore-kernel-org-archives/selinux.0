Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4M64hgA001503
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 02:04:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4M601vS006454
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 06:00:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id ACFE361AEF
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 01:23:50 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18412-03 for <selinux@tycho.nsa.gov>;
	Sun, 22 May 2005 01:23:50 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4734B61AEA
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 01:23:50 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: pppd.fc
Date: Sun, 22 May 2005 16:00:00 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k/BkCzX5gILasaV"
Message-Id: <200505221600.04526.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_k/BkCzX5gILasaV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed because pppd sometimes uses names such 
as /var/run/pppd2.tdb .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_k/BkCzX5gILasaV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- file_contexts/program/pppd.fc.orig	2005-05-22 15:58:22.000000000 +1000
+++ file_contexts/program/pppd.fc	2005-05-22 15:58:49.000000000 +1000
@@ -4,7 +4,7 @@
 /dev/ppp		-c	system_u:object_r:ppp_device_t
 /dev/pppox.*		-c	system_u:object_r:ppp_device_t
 /dev/ippp.*		-c	system_u:object_r:ppp_device_t
-/var/run/pppd\.tdb	--	system_u:object_r:pppd_var_run_t
+/var/run/pppd[0-9]*\.tdb --	system_u:object_r:pppd_var_run_t
 /var/run/ppp(/.*)?		system_u:object_r:pppd_var_run_t
 /etc/ppp		-d	system_u:object_r:pppd_etc_t
 /etc/ppp/.*		--	system_u:object_r:pppd_etc_rw_t

--Boundary-00=_k/BkCzX5gILasaV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
