Message-ID: <4B88356E.1040501@tycho.nsa.gov>
Date: Fri, 26 Feb 2010 15:56:14 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH] libselinux: fix avc_netlink_loop() error caused by nonblocking
 mode.
References: <4B691583.5060608@ak.jp.nec.com> <4B881D79.4000500@tycho.nsa.gov> <4B8833C6.9070503@tycho.nsa.gov>
In-Reply-To: <4B8833C6.9070503@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc_open() creates the netlink socket in nonblocking mode.  If the
application later takes control of the netlink socket with
avc_netlink_acquire_fd() and then calls avc_netlink_loop(), it
will fail with EWOULDBLOCK.
    
To remedy this, remove the O_NONBLOCK flag from the netlink socket
at the start of avc_netlink_loop().  Also, with this fix, there is
no need for avc_open() to ever create a blocking socket, so change
that and update the man page.
    
Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 man/man3/avc_netlink_loop.3 |    5 +----
 src/avc.c                   |    2 +-
 src/avc_internal.c          |    2 ++
 3 files changed, 4 insertions(+), 5 deletions(-)


diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index 67df6e4..7d8c9a4 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -43,10 +43,7 @@ to take ownership of it in application code.  The
 .I blocking
 argument specifies whether read operations on the socket will block.
 .BR avc_open (3)
-calls this function internally, specifying non-blocking behavior (unless
-threading callbacks were explicitly set using the deprecated
-.BR avc_init (3)
-interface, in which case blocking behavior is set).
+calls this function internally, specifying non-blocking behavior.
 
 .B avc_netlink_close
 closes the netlink socket.  This function is called automatically by
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 881b915..5c8def0 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -222,7 +222,7 @@ int avc_init(const char *prefix,
 		avc_enforcing = rc;
 	}
 
-	rc = avc_netlink_open(avc_using_threads);
+	rc = avc_netlink_open(0);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
 			"%s:  can't open netlink socket: %d (%s)\n",
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 8372f52..90dfa51 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -233,6 +233,8 @@ void avc_netlink_loop(void)
 	int rc;
 	char buf[1024] __attribute__ ((aligned));
 
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+
 	while (1) {
 		errno = 0;
 		rc = avc_netlink_receive(buf, sizeof(buf));



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
