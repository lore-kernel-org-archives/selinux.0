Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HP022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so4753116wrc.3
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:34 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 04/10] policycoreutils: fixfiles: usage errors are fatal
Date: Sun,  7 May 2017 12:05:50 +0100
Message-Id: <20170507110556.7740-4-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The idea is to print a usage error, then terminate with EXIT_FAILURE.

Don't print the usage error twice when run with no command.

Don't try to check for bogus extra arguments _after_
performing a long-running operation... particularly
if that operation terminates the script with EXIT_SUCCESS first.
---
 policycoreutils/scripts/fixfiles | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 29982e2..014ab04 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -365,6 +365,7 @@ shift $(( OPTIND - 1 ))
 command="$1"
 if [ -z "$command" ]; then
     usage
+    exit 1
 fi
 
 # Move out command from arguments
@@ -375,10 +376,11 @@ shift
 #
 
 if [ ! -z "$RPMFILES" ]; then
-    process "$command"
     if [ $# -gt 0 ]; then
-	    usage
+	usage
+	exit 1
     fi
+    process "$command"
 else
     if [ -z "$1" ]; then
 	process "$command"
-- 
2.9.3
