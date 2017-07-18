From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jason@perfinion.com, bigon@debian.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 18 Jul 2017 09:04:53 -0400
Message-Id: <20170718130454.21079-1-sds@tycho.nsa.gov>
Subject: [PATCH 1/2] Revert "open_init_pty: Do not make stdin and stdout
 non-blocking"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Making stdin/stdout non-blocking causes open_init_pty to hang if
they are closed, ala
./open_init_pty bash -c 'echo hello; exec >&- 2>&- <&-; sleep 1; '
and per
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956#10

This reverts commit fb081eb64b36a9de5a43f3d69d9e628b6eb1afc7.

Reported-by: Laurent Bigonville <bigon@debian.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/run_init/open_init_pty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index b37ae4d..6e25ea3 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -276,8 +276,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	/* Non blocking mode for the pty master. */
+	/* Non blocking mode for all file descriptors. */
 	setfd_nonblock(pty_master);
+	setfd_nonblock(STDIN_FILENO);
+	setfd_nonblock(STDOUT_FILENO);
 
 	if (isatty(STDIN_FILENO)) {
 		if (tty_semi_raw(STDIN_FILENO) < 0) {
-- 
2.9.4
