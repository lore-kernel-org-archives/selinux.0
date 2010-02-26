Message-ID: <4B881D79.4000500@tycho.nsa.gov>
Date: Fri, 26 Feb 2010 14:14:01 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: avc_open() and netlink_loop()
References: <4B691583.5060608@ak.jp.nec.com>
In-Reply-To: <4B691583.5060608@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------020709050706010106010703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020709050706010106010703
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

On 02/03/2010 01:19 AM, KaiGai Kohei wrote:
> When we initialize userspace avc using avc_open(3), it internally calls
> avc_init(3) without any callback functions. The avc_init() is introduced
> as a deprecated interface from application code, so it is recommended to
> use avc_open() instead for new applications.
>
> The avc_init() internally calls avc_netlink_open(). If no thread callback
> is not given, the 'blocking' argument shall be 0, then avc_netlink_open()
> set O_NONBLOCK flag on the socket file descriptor.
>
> Next, application will create a thread to receive messages via netlink
> socket to invalidate userspace avc, using avc_netlink_loop().
> However, if userspace avc of libselinux is already initialized,
> the avc_netlink_loop() immediately returns with EWOULDBLOCK, because the
> netlink socket is not blocked and avc_netlink_receive() does not expect
> recvfrom() returns error.
>
> It seems to me O_NONBLOCK is a wrong strategy in this case, and select(2)
> should be checked in avc_netlink_check_nb() instead.
>
> Eamon, what is your opinion?
>   


Hi, my apologies for the delayed response. Yes it appears as though this
is a bug. I think the solution is to configure the file descriptor in
blocking mode at the start of avc_netlink_loop(). When
avc_netlink_loop() is called, we always want blocking behavior. See the
attached patch.


-- 

Eamon Walsh 
National Security Agency


--------------020709050706010106010703
Content-Type: text/x-patch;
 name="avc_blocking_bug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="avc_blocking_bug.patch"

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
 
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK)
+
 	while (1) {
 		errno = 0;
 		rc = avc_netlink_receive(buf, sizeof(buf));

--------------020709050706010106010703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
