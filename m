Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NKCJUY008837
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:12:19 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NKCGsr018191
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:12:17 GMT
Message-ID: <4604349B.9010203@redhat.com>
Date: Fri, 23 Mar 2007 16:12:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: kudzu requests sys_ptrace,  I am denying it.
Content-Type: multipart/mixed;
 boundary="------------040008050104090702050101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040008050104090702050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040008050104090702050101
Content-Type: text/x-patch;
 name="kudzu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kudzu.patch"

--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-03-20 23:38:29.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/admin/kudzu.te	2007-03-23 10:42:14.000000000 -0400
@@ -22,7 +22,7 @@
 #
 
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-dontaudit kudzu_t self:capability sys_tty_config;
+dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
 allow kudzu_t self:process { signal_perms execmem };
 allow kudzu_t self:fifo_file rw_fifo_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };

--------------040008050104090702050101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
