From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: alan.christopher.jenkins@gmail.com, dwalsh@redhat.com,
 richard_c_haines@btinternet.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: selinux_restorecon: only log no default label
 warning for caller-supplied pathname
Date: Fri, 13 Jan 2017 15:31:21 -0500
Message-Id: <1484339481-3260-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

$ touch /tmp/foo
$ chcon -t etc_t /tmp/foo
$ restorecon /tmp/foo
Warning no default label for /tmp/foo
$ restorecon -R /tmp/foo
Warning no default label for /tmp/foo
$ restorecon -R /tmp

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/selinux_restorecon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index f5fa8f5..7020669 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -90,6 +90,7 @@ struct rest_flags {
 	bool syslog_changes;
 	bool log_matches;
 	bool ignore_noent;
+	bool warnonnomatch;
 };
 
 static void restorecon_init(void)
@@ -613,7 +614,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 						    sb->st_mode);
 
 	if (rc < 0) {
-		if (errno == ENOENT && flags->verbose && !flags->recurse)
+		if (errno == ENOENT && flags->warnonnomatch)
 			selinux_log(SELINUX_INFO,
 				    "Warning no default label for %s\n",
 				    lookup_path);
@@ -761,6 +762,7 @@ int selinux_restorecon(const char *pathname_orig,
 		   SELINUX_RESTORECON_LOG_MATCHES) ? true : false;
 	flags.ignore_noent = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_NOENTRY) ? true : false;
+	flags.warnonnomatch = true;
 	ignore_mounts = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
 
@@ -983,7 +985,8 @@ int selinux_restorecon(const char *pathname_orig,
 		default:
 			error |= restorecon_sb(ftsent->fts_path,
 					       ftsent->fts_statp, &flags);
-
+			if (flags.warnonnomatch)
+				flags.warnonnomatch = false;
 			if (error && flags.abort_on_error)
 				goto out;
 			break;
-- 
2.7.4
