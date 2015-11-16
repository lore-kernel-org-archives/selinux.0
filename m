Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAGLB2ia023324
 for <selinux@tycho.nsa.gov>; Mon, 16 Nov 2015 16:11:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id 324B41308
 for <selinux@tycho.nsa.gov>; Mon, 16 Nov 2015 21:10:51 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: improve sepolicy command line interface
Date: Mon, 16 Nov 2015 22:10:43 +0100
Message-Id: <1447708243-11610-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Previously, when sepolicy was run without any argument, the usage message
with the error "too few arguments" was shown. Using Python 3 it threw a traceback.
This patch unifies behavior on Py2 and Py3 so that sepolicy shows the help
message in this case.

Fixes:
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 647, in <module>
    args.func(args)
AttributeError: 'Namespace' object has no attribute 'func'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sepolicy/sepolicy.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sepolicy/sepolicy.py
index 08a5c2f..7d57f6e 100755
--- a/policycoreutils/sepolicy/sepolicy.py
+++ b/policycoreutils/sepolicy/sepolicy.py
@@ -685,9 +685,12 @@ if __name__ == '__main__':
 
     try:
         if os.path.basename(sys.argv[0]) == "sepolgen":
-            args = parser.parse_args(["generate"] + sys.argv[1:])
+            parser_args = [ "generate" ] + sys.argv[1:]
+        elif len(sys.argv) > 1:
+            parser_args = sys.argv[1:]
         else:
-            args = parser.parse_args()
+            parser_args = ["-h"]
+        args = parser.parse_args(args=parser_args)
         args.func(args)
         sys.exit(0)
     except ValueError, e:
-- 
2.6.2
