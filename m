Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4IJ8Ug9016258
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 15:08:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so28166955pfg.3
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 12:08:24 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
Date: Thu, 18 May 2017 12:07:59 -0700
Message-Id: <20170518190759.28560-1-mka@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The array is only referenced in an ARRAY_SIZE() statement. Adding the
attribute fixes the following warning when building with clang:

security/selinux/hooks.c:338:20: error: variable 'labeling_behaviors'
    is not needed and will not be emitted
    [-Werror,-Wunneeded-internal-declaration]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526d1f30..450ff9f3161c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -400,7 +400,7 @@ static void superblock_free_security(struct super_block *sb)
 
 /* The file system's label must be initialized prior to use. */
 
-static const char *labeling_behaviors[7] = {
+static const char * __maybe_unused labeling_behaviors[7] = {
 	"uses xattr",
 	"uses transition SIDs",
 	"uses task SIDs",
-- 
2.13.0.303.g4ebf302169-goog
