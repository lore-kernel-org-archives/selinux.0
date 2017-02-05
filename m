Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipF005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:45 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id ECA2A564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:40 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/8] mcstrans: fix -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:17 +0100
Message-Id: <20170205155820.29157-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/src/mcscolor.c  | 2 +-
 mcstrans/src/mcstransd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 558c2a0efc4b..e713da9aea1f 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -38,7 +38,7 @@ typedef struct setab {
 #define N_COLOR		4
 
 #define AUX_RULE_COLOR "color"
-static char *rules[] = { "user", "role", "type", "range" };
+static const char *rules[] = { "user", "role", "type", "range" };
 
 static setab_t *clist[N_COLOR];
 static setab_t *cend[N_COLOR];
diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index a5ed36181fc6..d7fc5dea3dd3 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -90,7 +90,7 @@ send_response(int fd, uint32_t function, char *data, int32_t ret_val)
 	ssize_t count;
 
 	if (!data)
-		data = "";
+		data = (char *)"";
 
 	data_size = strlen(data) + 1;
 
-- 
2.11.0
