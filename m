Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGE5ZKP011164
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 09:05:45 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so14830608pga.2
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 06:05:44 -0800 (PST)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] mcstrans: Add utils gitignore
Date: Wed, 16 Nov 2016 22:05:21 +0800
Message-Id: <1479305122-2419-4-git-send-email-jason@perfinion.com>
In-Reply-To: <1479305122-2419-1-git-send-email-jason@perfinion.com>
References: <1479305122-2419-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 mcstrans/utils/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 mcstrans/utils/.gitignore

diff --git a/mcstrans/utils/.gitignore b/mcstrans/utils/.gitignore
new file mode 100644
index 0000000..5c6ee0b
--- /dev/null
+++ b/mcstrans/utils/.gitignore
@@ -0,0 +1,2 @@
+transcon
+untranscon
-- 
2.7.3
