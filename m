Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JmZoO007487
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:48:35 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 49B78561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:23 +0200
Message-Id: <20180804194734.12577-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 02/13] python/sepolgen: do not import twice the
 modules
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

util.py starts by importing "locale" and "sys", so there is no need to
import these modules again in the functions.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/util.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/util.py b/python/sepolgen/src/sepolgen/util.py
index 1fca9717c05a..5d38bce29827 100644
--- a/python/sepolgen/src/sepolgen/util.py
+++ b/python/sepolgen/src/sepolgen/util.py
@@ -90,7 +90,6 @@ def first(s, sorted=False):
             return x
 
 def encode_input(text):
-    import locale
     """Encode given text via preferred system encoding"""
     # locale will often find out the correct encoding
     encoding = locale.getpreferredencoding()
@@ -104,7 +103,6 @@ def encode_input(text):
     return encoded_text
 
 def decode_input(text):
-    import locale
     """Decode given text via preferred system encoding"""
     # locale will often find out the correct encoding
     encoding = locale.getpreferredencoding()
@@ -172,11 +170,9 @@ def cmp(first, second):
     return (first > second) - (second > first)
 
 if __name__ == "__main__":
-    import sys
     import time
     p = ConsoleProgressBar(sys.stdout, steps=999)
     p.start("computing pi")
     for i in range(999):
         p.step()
         time.sleep(0.001)
-
-- 
2.18.0
