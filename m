Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i867FMrT020331
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 03:15:22 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i867ETvL018112
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 07:14:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: hald and kudzu policy patch
Date: Mon, 6 Sep 2004 17:15:15 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D6APBeEf0hZb6Ua"
Message-Id: <200409061715.15957.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_D6APBeEf0hZb6Ua
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows hald and kudzu to read usbfs_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_D6APBeEf0hZb6Ua
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-02 23:18:49.000000000 +1000
+++ hald.te	2004-09-06 17:01:43.000000000 +1000
@@ -47,3 +47,5 @@
 
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
+allow hald_t usbfs_t:dir search;
+allow hald_t usbfs_t:file { getattr read };
--- /usr/src/se/policy/domains/program/unused/kudzu.te	2004-07-08 13:09:34.000000000 +1000
+++ kudzu.te	2004-09-06 17:01:14.000000000 +1000
@@ -29,6 +29,8 @@
 allow kudzu_t sysctl_kernel_t:file { getattr read write };
 allow kudzu_t usbdevfs_t:dir search;
 allow kudzu_t usbdevfs_t:file { getattr read };
+allow kudzu_t usbfs_t:dir search;
+allow kudzu_t usbfs_t:file { getattr read };
 allow kudzu_t var_t:dir search;
 allow kudzu_t kernel_t:system { syslog_console };
 allow kudzu_t self:udp_socket { create ioctl };

--Boundary-00=_D6APBeEf0hZb6Ua--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
