Received: from goalie.tycho.ncsc.mil (goalie.tycho.ncsc.mil [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w93FpfOC001359
 for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2018 11:51:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so6685024wrw.12
 for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2018 08:51:24 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed,  3 Oct 2018 17:50:07 +0200
Message-Id: <20181003155007.26898-1-omosnace@redhat.com>
Subject: [PATCH] restorecond: Do not ignore the -f option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since the default value of watch_file is set unconditionally *after* the
command-line arguments have been parsed, the -f option is (and has
always been) effectively ignored. Fix this by setting it before the
parsing.

Fixes: 48681bb49c03 ("policycoreutils: restorecond: make restorecond dbuss-able")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 restorecond/restorecond.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index e1d26cb9..7b984b29 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -148,6 +148,8 @@ int main(int argc, char **argv)
 	if (is_selinux_enabled() != 1)
 		return 0;
 
+	watch_file = server_watch_file;
+
 	/* Set all options to zero/NULL except for ignore_noent & digest. */
 	memset(&r_opts, 0, sizeof(r_opts));
 	r_opts.ignore_noent = SELINUX_RESTORECON_IGNORE_NOENTRY;
@@ -205,7 +207,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	watch_file = server_watch_file;
 	read_config(master_fd, watch_file);
 
 	if (!debug_mode) {
-- 
2.17.1
