Message-ID: <1343743408.13704.10.camel@moss-pluto.epoch.ncsc.mil>
Subject: [PATCH] libselinux: Ensure that we only close the selinux netlink
 socket once
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
Date: Tue, 31 Jul 2012 10:03:28 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ensure that we only close the selinux netlink socket once.
Taken from our Android libselinux tree.

---
 libselinux/src/avc_internal.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index a07aa7f..d219331 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -53,7 +53,7 @@ int avc_setenforce = 0;
 int avc_netlink_trouble = 0;
 
 /* netlink socket code */
-static int fd;
+static int fd = -1;
 
 int avc_netlink_open(int blocking)
 {
@@ -69,6 +69,7 @@ int avc_netlink_open(int blocking)
 	fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (!blocking && fcntl(fd, F_SETFL, O_NONBLOCK)) {
 		close(fd);
+		fd = -1;
 		rc = -1;
 		goto out;
 	}
@@ -81,6 +82,7 @@ int avc_netlink_open(int blocking)
 
 	if (bind(fd, (struct sockaddr *)&addr, len) < 0) {
 		close(fd);
+		fd = -1;
 		rc = -1;
 		goto out;
 	}
@@ -90,7 +92,9 @@ int avc_netlink_open(int blocking)
 
 void avc_netlink_close(void)
 {
-	close(fd);
+	if (fd >= 0)
+		close(fd);
+	fd = -1;	
 }
 
 static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
@@ -269,6 +273,7 @@ void avc_netlink_loop(void)
 	}
 
 	close(fd);
+	fd = -1;
 	avc_netlink_trouble = 1;
 	avc_log(SELINUX_ERROR,
 		"%s:  netlink thread: errors encountered, terminating\n",
-- 
1.7.10.4


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
