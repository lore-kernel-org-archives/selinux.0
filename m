Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA781U69006318
 for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2016 03:01:30 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id EE4871A1AF
 for <selinux@tycho.nsa.gov>; Mon,  7 Nov 2016 09:01:20 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cy3Ag4o_u-r6 for <selinux@tycho.nsa.gov>;
 Mon,  7 Nov 2016 09:01:18 +0100 (CET)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 2C8D01A1AE
 for <selinux@tycho.nsa.gov>; Mon,  7 Nov 2016 09:01:18 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] Sandbox: Use next() over the sepolicy.info() result
Date: Mon,  7 Nov 2016 09:01:16 +0100
Message-Id: <20161107080117.24030-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

sepolicy.info() now returns a generator, use next() to get the results.

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/sandbox/sandbox | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 4010e83..c07a1d8 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -305,8 +305,8 @@ kill -TERM $WM_PID  2> /dev/null
             types = _("""
 Policy defines the following types for use with the -t:
 \t%s
-""") % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))[0]['types'])
-        except RuntimeError:
+""") % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))['types'])
+        except StopIteration:
             pass
 
         usage = _("""
@@ -380,8 +380,8 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
             self.setype = DEFAULT_X_TYPE
         else:
             try:
-                sepolicy.info(sepolicy.TYPE, "sandbox_t")
-            except RuntimeError:
+                next(sepolicy.info(sepolicy.TYPE, "sandbox_t"))
+            except StopIteration:
                 raise ValueError(_("Sandbox Policy is not currently installed.\nYou need to install the selinux-policy-sandbox package in order to run this command"))
 
         if self.__options.setype:
-- 
2.10.2
