Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5DH7f005762
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:13:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so1781687plt.2
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:12:24 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:17 +0800
Message-Id: <20180517051117.48454-6-jason@perfinion.com>
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
Subject: [PATCH 5/5] genhomedircon: sysconf can return -1 without
 failure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

from getpwnam_r(3): "The call sysconf(_SC_GETPW_R_SIZE_MAX) returns
either -1, without changing errno, or an initial suggested size for buf.
(If this size is too small, the call fails with ERANGE, in which case
the caller can retry with a larger buffer.)"

The same can happen for _SC_GETGR_R_SIZE_MAX. 1024 appears to be a good
fallback but may need revisiting in the future.

This triggered an error on musl libc but could happen other places too.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d09d82ff..3e61b510 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -972,9 +972,13 @@ static int add_user(genhomedircon_settings_t * s,
 	char uid[11];
 	char gid[11];
 
+	errno = 0;
 	/* Allocate space for the getpwnam_r buffer */
 	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (rbuflen <= 0)
+	if (rbuflen == -1 && errno == 0)
+		/* sysconf returning -1 with no errno means indeterminate size */
+		rbuflen = 1024;
+	else if (rbuflen <= 0)
 		goto cleanup;
 	rbuf = malloc(rbuflen);
 	if (rbuf == NULL)
@@ -1057,8 +1061,12 @@ static int get_group_users(genhomedircon_settings_t * s,
 	struct group grstorage, *group = NULL;
 	struct passwd *pw = NULL;
 
+	errno = 0;
 	grbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
-	if (grbuflen <= 0)
+	if (grbuflen == -1 && errno == 0)
+		/* sysconf returning -1 with no errno means indeterminate size */
+		grbuflen = 1024;
+	else if (grbuflen <= 0)
 		goto cleanup;
 	grbuf = malloc(grbuflen);
 	if (grbuf == NULL)
-- 
2.16.1
