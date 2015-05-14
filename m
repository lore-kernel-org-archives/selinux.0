From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] mcstransd: don't reinvent getpeercon, badly.
Date: Thu, 14 May 2015 13:00:03 -0400
Message-Id: <1431622803-30765-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libselinux provides a proper getpeercon() implementation that uses
getsockopt with SO_PEERSEC to reliably obtain the peer's security
context from the kernel.  mcstransd for reasons unknown rolled its
own get_peer_con() function that uses getsockopt SO_PEERCRED
to obtain the peer PID and then calls getpidcon_raw().  That's
less efficient and less secure (subject to races; peer context
may have changed since connect).  Don't do that.

The peer context doesn't appear to be used for anything currently,
although there is a comment suggesting adding a permission check to
see if the requester dominates the label to be translated to control
what labels can be translated by what peers.  Could likely dispense
with it altogether.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/mcstrans/src/mcstransd.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/policycoreutils/mcstrans/src/mcstransd.c b/policycoreutils/mcstrans/src/mcstransd.c
index a65076d..6c8c703 100644
--- a/policycoreutils/mcstrans/src/mcstransd.c
+++ b/policycoreutils/mcstrans/src/mcstransd.c
@@ -139,24 +139,6 @@ get_peer_pid(int fd, pid_t *pid)
 
 
 static int
-get_peer_con(int fd, char **peercon)
-{
-	int ret;
-	pid_t pid;
-	ret = get_peer_pid(fd, &pid);
-	if (ret)
-		return -1;
-	ret = getpidcon_raw(pid, peercon);
-	if (ret) {
-		syslog(LOG_ERR, 
-			"Failed to get context of client process (pid=%u)",
-			pid);
-		return -1;
-	}
-	return 0;
-}
-
-static int
 process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 {
 	int32_t result;
@@ -164,7 +146,7 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 	char *peercon = NULL;
 	int ret;
 
-	ret = get_peer_con(fd, &peercon);
+	ret = getpeercon_raw(fd, &peercon);
 	if (ret)
 		return ret;
 
-- 
2.1.0
