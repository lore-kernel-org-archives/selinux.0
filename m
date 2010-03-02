Message-ID: <4B8D4AED.80203@tycho.nsa.gov>
Date: Tue, 02 Mar 2010 12:29:17 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] libselinux: fix avc_netlink_loop() error caused by nonblocking
 mode.
References: <4B691583.5060608@ak.jp.nec.com> <4B881D79.4000500@tycho.nsa.gov> <4B8833C6.9070503@tycho.nsa.gov> <4B88356E.1040501@tycho.nsa.gov> <4B8C7C88.4090701@ak.jp.nec.com>
In-Reply-To: <4B8C7C88.4090701@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/01/2010 09:48 PM, KaiGai Kohei wrote:
> (2010/02/27 5:56), Eamon Walsh wrote:
>   
>> avc_open() creates the netlink socket in nonblocking mode.  If the
>> application later takes control of the netlink socket with
>> avc_netlink_acquire_fd() and then calls avc_netlink_loop(), it
>> will fail with EWOULDBLOCK.
>>
>> To remedy this, remove the O_NONBLOCK flag from the netlink socket
>> at the start of avc_netlink_loop().  Also, with this fix, there is
>> no need for avc_open() to ever create a blocking socket, so change
>> that and update the man page.
>>     
> Apart from this design is sane, the libselinux allows applications to
> call avc_netlink_check_nb() directly.
> If we call the function although its worker thread calls avc_netlink_loop(),
> the invocation of avc_netlink_check_nb() can be blocked, because it
> assumes the internal netlink socket is non-blocking mode.
> (Of course, we will not see the matter in most of sane applications.)
>
> I think a better approach is to put select(2) with zero or infinite
> timeout just before avc_netlink_receive() calls to check whether the
> unread message is in the netlink socket, or not.
> And the 'blocking' argument of avc_netlink_open() shall be obsoleted,
> because this design makes nonsense whether the socket has O_NONBLOCK
> flag, or not.
>   

OK I see your point. How about the following:

libselinux: fix avc_netlink_loop() error caused by nonblocking mode.

avc_open() creates the netlink socket in nonblocking mode.  If the
application later takes control of the netlink socket with
avc_netlink_acquire_fd() and then calls avc_netlink_loop(), it
will fail with EWOULDBLOCK.

To remedy this, remove the O_NONBLOCK flag from the netlink socket
at the start of avc_netlink_loop().  Also, with this fix, there is
no need for avc_open() to ever create a blocking socket, so change
that and update the man page.

-v2: use poll() in avc_netlink_check_nb().  This makes both
avc_netlink_loop() and avc_netlink_check_nb() independent of the
O_NONBLOCK flag.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
--

 man/man3/avc_netlink_loop.3 |   11 +++--------
 src/avc.c                   |    2 +-
 src/avc_internal.c          |   13 +++++++++++++
 3 files changed, 17 insertions(+), 9 deletions(-)


diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index 67df6e4..785be4c 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -41,12 +41,9 @@ descriptor is stored internally; use
 .BR avc_netlink_acquire_fd (3)
 to take ownership of it in application code.  The
 .I blocking
-argument specifies whether read operations on the socket will block.
+argument controls whether the O_NONBLOCK flag is set on the socket descriptor.
 .BR avc_open (3)
-calls this function internally, specifying non-blocking behavior (unless
-threading callbacks were explicitly set using the deprecated
-.BR avc_init (3)
-interface, in which case blocking behavior is set).
+calls this function internally, specifying non-blocking behavior.
 
 .B avc_netlink_close
 closes the netlink socket.  This function is called automatically by
@@ -66,9 +63,7 @@ checks the netlink socket for pending messages and processes them.
 Callbacks for policyload and enforcing changes will be called;
 see
 .BR selinux_set_callback (3).
-This function does not block unless
-.BR avc_netlink_open (3)
-specified blocking behavior.
+This function does not block.
 
 .B avc_netlink_loop
 enters a loop blocking on the netlink socket and processing messages as they
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
index 8372f52..7a39c61 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <poll.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <linux/types.h>
@@ -205,8 +206,18 @@ int avc_netlink_check_nb(void)
 {
 	int rc;
 	char buf[1024] __attribute__ ((aligned));
+	struct pollfd pfd = { fd, POLLIN | POLLPRI, 0 };
 
 	while (1) {
+		rc = poll(&pfd, 1, 0);
+		if (rc == 0)
+			return 0;
+		if (rc < 0) {
+			avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
+				avc_prefix, errno);
+			return rc;
+		}
+
 		errno = 0;
 		rc = avc_netlink_receive(buf, sizeof(buf));
 		if (rc < 0) {
@@ -233,6 +244,8 @@ void avc_netlink_loop(void)
 	int rc;
 	char buf[1024] __attribute__ ((aligned));
 
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+
 	while (1) {
 		errno = 0;
 		rc = avc_netlink_receive(buf, sizeof(buf));



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
