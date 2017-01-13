From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: alan.christopher.jenkins@gmail.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: selinux_restorecon: only log no default label
 warning if recursive
Date: Fri, 13 Jan 2017 10:00:16 -0500
Message-Id: <1484319616-7202-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In commit 36f1ccbb574374 ("policycoreutils: setfiles: print error if
no default label found"), a warning message was added to setfiles/restorecon
if the user explicitly does a restorecon /path/to/foo and
/path/to/foo does not have any matching label in file_contexts; in the
case of a restorecon -R or setfiles, the warning isn't supposed to be
logged.  The check on the recursive flag got dropped when this logic was
taken into selinux_restorecon(3) in libselinux.  Restore this check so
that we do not generate noisy log messages on restorecon -R or setfiles.

Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index e38d1d0..f5fa8f5 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -613,7 +613,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 						    sb->st_mode);
 
 	if (rc < 0) {
-		if (errno == ENOENT && flags->verbose)
+		if (errno == ENOENT && flags->verbose && !flags->recurse)
 			selinux_log(SELINUX_INFO,
 				    "Warning no default label for %s\n",
 				    lookup_path);
-- 
2.7.4
