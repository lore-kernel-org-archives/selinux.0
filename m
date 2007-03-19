Subject: Re: [PATCH] libselinux lazy init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <183389.69237.qm@web51509.mail.re2.yahoo.com>
References: <183389.69237.qm@web51509.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 13:26:15 -0400
Message-Id: <1174325175.22565.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-03-18 at 06:28 -0700, Steve G wrote:
> Hi,
> 
> Attached is the re-worked (and tested) patch that changes libselinux's startup
> behavior of reading /etc/selinux/config to be on-demand. This improves
> performance measurably for small programs that do not need to know the details of
> policy. (Examples are cp, ls, id, install, ...) Please apply.
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

diff -urp libselinux-2.0.7.orig/src/selinux_config.c libselinux-2.0.7/src/selinux_config.c
--- libselinux-2.0.7.orig/src/selinux_config.c	2007-03-17 21:09:48.000000000 -0400
+++ libselinux-2.0.7/src/selinux_config.c	2007-03-18 09:03:05.000000000 -0400
@@ -40,6 +41,24 @@
 #define SECURETTY_TYPES   18
 #define NEL               19
 
+/* Make pthread_once optional */
+#pragma weak pthread_once
+
+/* Part of one-time lazy init */
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+static void init_selinux_config(void);
+
+/* Call handler iff the first call.  */
+#define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)	\
+	do {						\
+		if (pthread_once != NULL)		\
+			pthread_once (&(ONCE_CONTROL), (INIT_FUNCTION));  \
+		else if ((ONCE_CONTROL) == PTHREAD_ONCE_INIT) {		  \
+			INIT_FUNCTION ();		\
+			(ONCE_CONTROL) = 2;		\
+		}					\
+	} while (0)
+


Looking back at Roland's advice, I notice that his sample code
introduced an explicit bool flag rather than overloading the
pthread_once_t variable.  To me, that suggested that he thought that we
shouldn't make assumptions about the pthread_once_t variable being an
integer, which the above code does assume.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
