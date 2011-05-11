Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4B7PlPJ011818
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 03:25:48 -0400
Received: from cluster-e.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4B7Pj7c018107
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 07:25:46 GMT
Received: from rly60e.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly60e.srv.mailcontrol.com (MailControl) with ESMTP id p4B7PfDc021069
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 08:25:43 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly60e.srv.mailcontrol.com (MailControl) id p4B7P9pX018700
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2011 08:25:09 +0100
From: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 11 May 2011 08:24:59 +0100
Subject: [1/2] selinux: fix case of names with whitespace/multibytes on
 /selinux/create
Message-ID: <A9F5079BABDEE646AEBDB6831725762C5560111DD6@EUEXCLU01.EU.NEC.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I submit the patch again, according to patch submission convension.

This patch enables to accept percent-encoded object names as forth argument of /selinux/create interface to avoid possible bugs when we give an object name including whitespace or multibutes.

E.g) if and when a userspace object manager tries to create a new object
  named as "resolve.conf but fake", it shall give this name as the forth
  argument of the /selinux/create. But sscanf() logic in kernel space
  fetches only the part earlier than the first whitespace.
  In this case, selinux may unexpectedly answer a default security context
  configured to "resolve.conf", but it is bug.

Although I could not test this patch on named TYPE_TRANSITION rules actually, But debug printk() message seems to me the logic works correctly.
I assume the libselinux provides an interface to apply this logic transparently, so nothing shall not be changed from the viewpoint of application.

Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
---
 security/selinux/selinuxfs.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c index 973f5a4..4fde279 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -28,6 +28,7 @@
 #include <linux/percpu.h>
 #include <linux/audit.h>
 #include <linux/uaccess.h>
+#include <linux/ctype.h>

 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */ @@ -750,6 +751,15 @@ out:
 	return length;
 }

+static inline int hexcode_to_int(int code) {
+	if (code == '\0' || !isxdigit(code))
+		return -1;
+	if (isdigit(code))
+		return code - '0';
+	return tolower(code) - 'a' + 10;
+}
+
 static ssize_t sel_write_create(struct file *file, char *buf, size_t size)  {
 	char *scon = NULL, *tcon = NULL;
@@ -784,8 +794,34 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	nargs = sscanf(buf, "%s %s %hu %s", scon, tcon, &tclass, namebuf);
 	if (nargs < 3 || nargs > 4)
 		goto out;
-	if (nargs == 4)
+	if (nargs == 4) {
+		/*
+		 * If and when the name of new object to be queried contains
+		 * either whitespace or multibyte characters, they shall be
+		 * encoded based on the percentage-encoding rule.
+		 * If not encoded, the sscanf logic picks up only left-half
+		 * of the supplied name; splitted by a whitespace unexpectedly.
+		 */
+		char   *r, *w;
+		int	c1, c2;
+
+		r = w = namebuf;
+		do {
+			c1 = *r++;
+			if (c1 == '+')
+				c1 = ' ';
+			else if (c1 == '%') {
+				if ((c1 = hexcode_to_int(*r++)) < 0)
+					goto out;
+				if ((c2 = hexcode_to_int(*r++)) < 0)
+					goto out;
+				c1 = (c1 << 4) | c2;
+			}
+			*w++ = c1;
+		} while (c1 != '\0');
+
 		objname = namebuf;
+	}

 	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
 	if (length)

--
NEC Europe Ltd, SAP Global Competence Center
KaiGai Kohei <kohei.kaigai@emea.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
