Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8BAfoOO016112
 for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2017 06:41:53 -0400
Received: by mail-wr0-f173.google.com with SMTP id m18so13646769wrm.2
 for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2017 03:41:47 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Date: Mon, 11 Sep 2017 12:41:41 +0200
Message-Id: <20170911104141.2629-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] libselinux: log no default label warning in verbose
 mode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since 1cd972f restorecon does not print a warning in recurse mode for child files without a default label.
Change it back in verbose mode:

$ touch /run/test.pid
$ restorecon -R /run
$ restorecon -v -R /run
Warning no default label for /run/test.pid

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index ced41152..6d0eabe0 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -614,7 +614,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 						    sb->st_mode);
 
 	if (rc < 0) {
-		if (errno == ENOENT && flags->warnonnomatch)
+		if (errno == ENOENT && (flags->verbose || flags->warnonnomatch))
 			selinux_log(SELINUX_INFO,
 				    "Warning no default label for %s\n",
 				    lookup_path);
-- 
2.14.1
