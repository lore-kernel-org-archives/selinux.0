Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75Gc8V1007238
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:10 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3710B56497D
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:38:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:50 +0200
Message-Id: <20170805163750.1920-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170805163750.1920-1-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 6/6] sepolicy: remove stray space in section "SEE
 ALSO"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The space after "sepolicy(8)" breaks the formatting of section SEE ALSO
in man pages generated with sepolicy:

  SEE ALSO
    selinux(8), ssh(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)  ,  setsebool(8),

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/manpage.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 35b3722dbe45..ed8cb71cd6d4 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -922,8 +922,7 @@ This manual page was auto-generated using
 .B "sepolicy manpage".
 
 .SH "SEE ALSO"
-selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
-""" % (self.domainname))
+selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)""" % (self.domainname))
 
         if self.booltext != "":
             self.fd.write(", setsebool(8)")
-- 
2.13.3
