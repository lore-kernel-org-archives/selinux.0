Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3PM2MgA004773
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:02:22 -0400 (EDT)
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3PM2TYj006303
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 22:02:29 GMT
Received: from taynzmail03.nz-tay.cpqcorp.net (taynzmail03.nz-tay.cpqcorp.net [16.47.4.103])
	by atlrel6.hp.com (Postfix) with ESMTP id 0915B1293
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:02:32 -0400 (EDT)
Received: from anw.zk3.dec.com (and.zk3.dec.com [16.140.64.3])
	by taynzmail03.nz-tay.cpqcorp.net (Postfix) with ESMTP id D0EF9214D
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:02:31 -0400 (EDT)
Message-ID: <426D68F2.6040509@hp.com>
Date: Mon, 25 Apr 2005 18:02:26 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Small patch to udev.te
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is another small patch to fix a problem with udev on bootup.

Index: udev.te
===================================================================
RCS file: 
/cvsroot/selinux/nsa/selinux-usr/policy/domains/program/unused/udev.te,v
retrieving revision 1.42
diff -u -r1.42 udev.te
--- udev.te     22 Apr 2005 15:02:30 -0000      1.42
+++ udev.te     25 Apr 2005 22:00:44 -0000
@@ -33,7 +33,7 @@
  allow udev_t self:unix_stream_socket {connectto 
create_stream_socket_perms};
  allow udev_t self:unix_dgram_socket create_socket_perms;
  allow udev_t self:fifo_file rw_file_perms;
-allow udev_t device_t:file rw_file_perms;
+allow udev_t device_t:file { unlink rw_file_perms };
  allow udev_t device_t:sock_file create_file_perms;
  allow udev_t device_t:lnk_file create_lnk_perms;
  allow udev_t { device_t device_type }:{ chr_file blk_file } { 
relabelfrom relabelto create_file_perms };

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
