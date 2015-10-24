Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9OIhsdu012331
 for <selinux@tycho.nsa.gov>; Sat, 24 Oct 2015 14:43:54 -0400
Received: by wikq8 with SMTP id q8so115436145wik.1
 for <selinux@tycho.nsa.gov>; Sat, 24 Oct 2015 11:43:41 -0700 (PDT)
Received: from iosakhe.localdomain
 (2a02-8428-04da-9800-7d98-5bb9-8168-a113.rev.sfr.net.
 [2a02:8428:4da:9800:7d98:5bb9:8168:a113])
 by smtp.gmail.com with ESMTPSA id p10sm29469708wjx.36.2015.10.24.11.43.39
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 24 Oct 2015 11:43:39 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sepolgen: Reset line numbers when parsing files
Date: Sat, 24 Oct 2015 20:43:27 +0200
Message-Id: <1445712207-23254-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running sepolgen-ifgen on refpolicy (git master branch), the
following messages show up:

    /usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error
    on line 3369 gen_context [type=GEN_CONTEXT]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 188379 ' [type=SQUOTE]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 188385 ' [type=SQUOTE]

The line numbers are incorrect because the lineno member of the lexer
object is not resetted after each file has been processed.  After fixing
this, the messages are nicer:

    /usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error
    on line 43 gen_context [type=GEN_CONTEXT]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 1416 ' [type=SQUOTE]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 1422 ' [type=SQUOTE]

As line 43 of kernel/selinux.if contains a genfscon statement with a
gen_context component, the reported line numbers are now correct.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 sepolgen/src/sepolgen/refparser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index b50112ccd900..3132c6fe7109 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -1003,6 +1003,7 @@ def parse(text, module=None, support=None, debug=False):
     create_globals(module, support, debug)
     global error, parser, lexer, success
 
+    lexer.lineno = 1
     success = True
 
     try:
-- 
2.6.2
