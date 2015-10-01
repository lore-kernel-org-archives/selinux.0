From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] Open stdin as read/write
Date: Thu,  1 Oct 2015 15:51:31 -0400
Message-Id: <1443729091-9496-3-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1443729091-9496-1-git-send-email-sds@tycho.nsa.gov>
References: <1443729091-9496-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Sven Vermeulen <sven.vermeulen@siphos.be>

As per the discussion on the selinux development mailinglist, the tmux
application expects the stdin to be writeable. Although perhaps not the most
proper way, having newrole opening the descriptor in read/write keeps the
behaviour in line with what applications expect.

See also http://marc.info/?l=selinux&m=136518126930710&w=2

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/newrole/newrole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index af7198d..65a945d 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1249,7 +1249,7 @@ int main(int argc, char *argv[])
 			fprintf(stderr, _("Could not close descriptors.\n"));
 			goto err_close_pam;
 		}
-		fd = open(ttyn, O_RDONLY | O_NONBLOCK);
+		fd = open(ttyn, O_RDWR | O_NONBLOCK);
 		if (fd != 0)
 			goto err_close_pam;
 		rc = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
-- 
2.1.0
