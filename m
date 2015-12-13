Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBDMfRoU003246
 for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2015 17:41:27 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 603181A1D8
 for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2015 23:40:44 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id I9Pz1DVKmwLp for <selinux@tycho.nsa.gov>;
 Sun, 13 Dec 2015 23:40:42 +0100 (CET)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1::6b5])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id CD9901A070
 for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2015 23:40:41 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/chcat: Add a fallback in case os.getlogin()
 returns nothing
Date: Sun, 13 Dec 2015 23:40:40 +0100
Message-Id: <1450046440-25449-1-git-send-email-bigon@bigon.be>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Some teminal emulators (like the latest version of gnome-terminal) are
not setting entries in the utmp file, this leads getlogin() to return an
empty string.

Fallback to the name of the user running the chcat process.
---
 policycoreutils/scripts/chcat | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index ec527e5..472785c 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -372,7 +372,10 @@ def listcats():
 
 def listusercats(users):
     if len(users) == 0:
-        users.append(os.getlogin())
+        try:
+            users.append(os.getlogin())
+        except:
+            users.append(pwd.getpwuid(os.getuid()).pw_name)
 
     verify_users(users)
     for u in users:
-- 
2.6.4
