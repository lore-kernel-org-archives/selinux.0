From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jason@perfinion.com, bigon@debian.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] open_init_pty: Do not make stdin and stdout non-blocking
Date: Mon, 10 Jul 2017 13:12:00 -0400
Message-Id: <20170710171200.15812-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It is unclear why this was being done in the first place, and
it has caused multiple bugs with run_init/open_init_pty usage.

Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187
Fixes: https://bugs.gentoo.org/show_bug.cgi?id=621062
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/run_init/open_init_pty.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index 6e25ea3..b37ae4d 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -276,10 +276,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	/* Non blocking mode for all file descriptors. */
+	/* Non blocking mode for the pty master. */
 	setfd_nonblock(pty_master);
-	setfd_nonblock(STDIN_FILENO);
-	setfd_nonblock(STDOUT_FILENO);
 
 	if (isatty(STDIN_FILENO)) {
 		if (tty_semi_raw(STDIN_FILENO) < 0) {
-- 
2.9.4
