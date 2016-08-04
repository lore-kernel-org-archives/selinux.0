Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IZJk2011426
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:35:19 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so17904142pab.3
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:55 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 12/12] semanage: Print usage when no args
Date: Fri,  5 Aug 2016 02:34:05 +0800
Message-Id: <1470335645-24224-13-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://bugs.python.org/issue16308

Traceback (most recent call last):
  File "semanage", line 932, in <module>
    do_parser()
  File "semanage", line 911, in do_parser
    args.func(args)
AttributeError: 'Namespace' object has no attribute 'func'
---
 policycoreutils/semanage/semanage | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index d945243..5d783b1 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -856,6 +856,7 @@ def createCommandParser():
 
     #To add a new subcommand define the parser for it in a function above and call it here.
     subparsers = commandParser.add_subparsers(dest='subcommand')
+    subparsers.required = True
     setupImportParser(subparsers)
     setupExportParser(subparsers)
     setupLoginParser(subparsers)
-- 
2.7.3
