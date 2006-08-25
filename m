Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PBsIYs018300
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 07:54:18 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PBs1Ns025440
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 11:54:01 GMT
Received: by py-out-1112.google.com with SMTP id 39so1031635pyu
        for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 04:54:17 -0700 (PDT)
Message-ID: <44EEE4DD.5080301@kaigai.gr.jp>
Date: Fri, 25 Aug 2006 20:54:05 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH] add fs_use_xattr on jffs2
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch enables to use xattr on jffs2 filesystem.

The jffs2 filesystem is a filesystem for memory technology
devices (MTD), and xattr supporting on jffs2 is neccesary
to use SELinux with a small diskless PDA and so on.
This facility is queued for kernel 2.6.18 now, so I hope
to merge this small patch into the refpolicy repository.

Example of xattr/jffs2: SELinux on OpenZaurus :D
  http://www.kaigai.gr.jp/pub/sezaurus.jpg

Thanks,
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

Index: policy/modules/kernel/filesystem.te
===================================================================
--- policy/modules/kernel/filesystem.te (revision 1965)
+++ policy/modules/kernel/filesystem.te (working copy)
@@ -24,6 +24,7 @@
 fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr jffs2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr jfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr xfs gen_context(system_u:object_r:fs_t,s0);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
