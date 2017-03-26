Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2QEaVpX010246
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 10:36:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so5556131wrx.0
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 07:36:30 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 2/2] policycoreutils: fixfiles: handle unexpected spaces in
 command
Date: Sun, 26 Mar 2017 15:35:51 +0100
Message-Id: <20170326143551.9407-2-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170326143551.9407-1-alan.christopher.jenkins@gmail.com>
References: <20170326143551.9407-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I accidently ran `fixfiles "a b"` during testing.  Let's fix this too.
Before:

   /sbin/fixfiles: line 394: [: a: binary operator expected

   Usage: ...

After:

    Usage: ...

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/scripts/fixfiles | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index d3a53ba..58a364f 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -378,8 +378,8 @@ done
 shift $(( OPTIND - 1 ))
 
 # Check for the command
-command=$1
-if [ -z $command ]; then
+command="$1"
+if [ -z "$command" ]; then
     usage
 fi
 
@@ -391,17 +391,17 @@ shift
 #
 
 if [ ! -z "$RPMFILES" ]; then
-    process $command
+    process "$command"
     if [ $# -gt 0 ]; then
 	    usage
     fi
 else
     if [ -z "$1" ]; then
-	process $command
+	process "$command"
     else
 	while [ -n "$1" ]; do
 	    FILEPATH="$1"
-	    process $command
+	    process "$command"
 	    shift
 	done
     fi
-- 
2.9.3
