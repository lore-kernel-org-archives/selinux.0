Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGE5qCg011174
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 09:05:52 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so9953570pfv.0
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 06:05:51 -0800 (PST)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] restorecond: Add gitignore
Date: Wed, 16 Nov 2016 22:05:22 +0800
Message-Id: <1479305122-2419-5-git-send-email-jason@perfinion.com>
In-Reply-To: <1479305122-2419-1-git-send-email-jason@perfinion.com>
References: <1479305122-2419-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 .gitignore             | 2 +-
 restorecond/.gitignore | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 restorecond/.gitignore

diff --git a/.gitignore b/.gitignore
index 265cd23..6ff6126 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,10 +18,10 @@
 *.orig
 *.rej
 *.pyc
+*.pyo
 cscope.*
 .#*
 \#*
 .*.swp
 # Failsafes
 !.gitignore
-restorecond/restorecond
diff --git a/restorecond/.gitignore b/restorecond/.gitignore
new file mode 100644
index 0000000..f128429
--- /dev/null
+++ b/restorecond/.gitignore
@@ -0,0 +1 @@
+restorecond
-- 
2.7.3
