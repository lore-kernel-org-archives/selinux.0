Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4NIADt8015313
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 14:10:13 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so5064417wgg.1
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 11:10:13 -0700 (PDT)
Received: from eversmanni.home.iosenag.net (158.222.74.86.rev.sfr.net.
 [86.74.222.158])
 by mx.google.com with ESMTPSA id l9sm4109716wic.21.2014.05.23.11.10.11
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 23 May 2014 11:10:11 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: fix typo in man page
Date: Fri, 23 May 2014 20:10:05 +0200
Message-Id: <1400868605-17628-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libselinux/man/man8/selinux.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index e89b1ef..9e3bdc4 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -74,7 +74,7 @@ The best way to relabel the file system is to create the flag file
 and reboot.
 .BR system\-config\-selinux ,
 also has this capability.  The
-.BR restorcon / fixfiles
+.BR restorecon / fixfiles
 commands are also available for relabeling files.
 .
 .SH AUTHOR	
-- 
1.9.2
