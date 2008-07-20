Date: Mon, 21 Jul 2008 00:42:58 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: [patch] SELinux: Trivial minor fixes, pt. 2
Message-ID: <Pine.LNX.4.64L.0807210041240.7451@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Again, trivial minor fixes that change C null character style.

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

Again, trivial minor fixes that change C null character style.

 security/selinux/hooks.c |    2 +-
 security/selinux/xfrm.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)



--- security-testing-2.6/security/selinux/hooks.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/hooks.c	2008-07-21 00:30:43.000000000 +0300
@@ -5185,7 +5185,7 @@
 	/* Obtain a SID for the context, if one was specified. */
 	if (size && str[1] && str[1] != '\n') {
 		if (str[size-1] == '\n') {
-			str[size-1] = 0;
+			str[size-1] = '\0';
 			size--;
 		}
 		error = security_context_to_sid(value, size, &sid);
--- security-testing-2.6/security/selinux/xfrm.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/xfrm.c	2008-07-21 00:12:48.000000000 +0300
@@ -228,7 +228,7 @@
 	memcpy(ctx->ctx_str,
 	       uctx+1,
 	       str_len);
-	ctx->ctx_str[str_len] = 0;
+	ctx->ctx_str[str_len] = '\0';
 	rc = security_context_to_sid(ctx->ctx_str,
 				     str_len,
 				     &ctx->ctx_sid);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
