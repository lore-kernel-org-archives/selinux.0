Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75Gc8V0007238
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:08 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9804356497D
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:38:00 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:49 +0200
Message-Id: <20170805163750.1920-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170805163750.1920-1-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 5/6] sepolicy: support non-MCS policy in manpage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This prevents the following exception to occur when using "sepolicy
manpage":

    Traceback (most recent call last):
      File "/bin/sepolicy", line 699, in <module>
        args.func(args)
      File "/bin/sepolicy", line 359, in manpage
        m = ManPage(domain, path, args.root, args.source_files, args.web)
      File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 459, in __init__
        self.__gen_man_page()
      File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 548, in __gen_man_page
        self._mcs_types()
      File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 978, in _mcs_types
        mcs_constrained_type = next(sepolicy.info(sepolicy.ATTRIBUTE, "mcs_constrained_type"))
    StopIteration

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/manpage.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 494c34319c26..35b3722dbe45 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -975,7 +975,10 @@ All executeables with the default executable label, usually stored in /usr/bin a
 %s""" % ", ".join(paths))
 
     def _mcs_types(self):
-        mcs_constrained_type = next(sepolicy.info(sepolicy.ATTRIBUTE, "mcs_constrained_type"))
+        try:
+            mcs_constrained_type = next(sepolicy.info(sepolicy.ATTRIBUTE, "mcs_constrained_type"))
+        except StopIteration:
+            return
         if self.type not in mcs_constrained_type['types']:
             return
         self.fd.write ("""
-- 
2.13.3
