Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1DCGl98026900
	for <selinux@tycho.nsa.gov>; Sun, 13 Feb 2011 07:16:48 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1DCGiV4006778
	for <selinux@tycho.nsa.gov>; Sun, 13 Feb 2011 12:16:46 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EACBD180B1
	for <selinux@tycho.nsa.gov>; Sun, 13 Feb 2011 23:15:31 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: kdm patch
Date: Sun, 13 Feb 2011 23:16:34 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iu8VN2HFl+wWMtS"
Message-Id: <201102132316.34972.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_iu8VN2HFl+wWMtS
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

The attached patch makes kdm do all the work of determining the correct SE 
Linux context.  With this patch there is no need for pam_selinux.so for a kdm 
login.

The reason for this is that currently when kdm creates a ~/.xsession-errors 
file it uses the default level - IE the low level of the kdm process itself.  
If the user has a low level that's higher than SystemLow then they won't be 
able to write to the errors file.  My patch makes it call setfscreatecon() 
before doing that.

Please tell me what you think, both about the patch itself and the concept.  
If we go ahead with this then I'll probably have to write similar patches for 
all the other common xdm programs.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_iu8VN2HFl+wWMtS
Content-Type: text/x-patch;
  charset="UTF-8";
  name="kdm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kdm.diff"

diff -ru kdebase-workspace-4.4.5.old/kdm/backend/client.c kdebase-workspace-4.4.5.new/kdm/backend/client.c
--- kdebase-workspace-4.4.5.old/kdm/backend/client.c	2011-02-06 19:24:00.747577619 +1100
+++ kdebase-workspace-4.4.5.new/kdm/backend/client.c	2011-02-13 21:46:19.560460860 +1100
@@ -127,6 +127,125 @@
 # endif
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/get_context_list.h>
+
+/* Wrapper around is_selinux_enabled() to log its return value once only */
+int
+kdm_selinux_enabled(void)
+{
+	static int enabled = -1;
+
+	if (enabled == -1)
+		enabled = is_selinux_enabled();
+
+	return (enabled);
+}
+
+/* Return the default security context for the given username */
+static security_context_t
+kdm_selinux_getctxbyname(const char *const pwname)
+{
+	security_context_t sc = NULL, mycon = NULL;
+	char *sename = NULL, *lvl = NULL;
+	int r;
+
+	if (getseuserbyname(pwname, &sename, &lvl) != 0)
+		return NULL;
+
+	r = getcon(&mycon);
+	if(!r)
+		r = get_default_context_with_level(sename, lvl, mycon, &sc);
+
+	if (r != 0) {
+		if(mycon)
+			freecon(mycon);
+
+		switch (security_getenforce()) {
+		case -1:
+			logError("%s: security_getenforce() failed", __func__);
+			exit(1);
+		case 0:
+			logError("%s: Failed to get default SELinux security "
+			    "context for %s", __func__, pwname);
+		break;
+		default:
+			logError("%s: Failed to get default SELinux security "
+			    "context for %s (in enforcing mode)",
+			    __func__, pwname);
+			exit(1);
+		}
+	}
+
+	if (sename != NULL)
+		free(sename);
+	if (lvl != NULL)
+		free(lvl);
+
+	return (sc);
+}
+
+/* Return the default security context for the given .xsession-errors file */
+void kdm_selinux_set_homefile_ctx(const security_context_t user_ctx, const char * const home)
+{
+	security_context_t dir_ctx, newcon;
+	if(getfilecon(home, &dir_ctx) == -1)
+	{
+		logError("%s: getfilecon(\"%s\") failed", __func__, home);
+		exit(1);
+	}
+	if(security_compute_create(user_ctx, dir_ctx, SECCLASS_DIR, &newcon))
+	{
+		logError("%s: security_compute_create(%s, %s, SECCLASS_DIR) failed", __func__, user_ctx, dir_ctx);
+		exit(1);
+	}
+	freecon(dir_ctx);
+	if(setfscreatecon(newcon))
+	{
+		logError("%s: setfscreatecon(\"%s\") failed", __func__, newcon);
+		exit(1);
+	}
+	freecon(newcon);
+}
+
+/* Set the execution context to the default for the specified user */
+void
+kdm_selinux_setup_exec_context(const char *const pwname, const char * const home)
+{
+	security_context_t user_ctx = NULL;
+
+	if (!kdm_selinux_enabled())
+		return;
+
+	debug("%s: setting execution context", __func__);
+
+	user_ctx = kdm_selinux_getctxbyname(pwname);
+	if (setexeccon(user_ctx) != 0) {
+		switch (security_getenforce()) {
+		case -1:
+			logError("%s: security_getenforce() failed", __func__);
+			exit(1);
+		case 0:
+			logError("%s: Failed to set SELinux execution "
+			    "context for %s", __func__, pwname);
+		break;
+		default:
+			logError("%s: Failed to set SELinux execution context "
+			    "for %s (in enforcing mode)", __func__, pwname);
+			exit(1);
+		}
+	}
+
+	if (user_ctx != NULL)
+	{
+		kdm_selinux_set_homefile_ctx(user_ctx, home);
+		freecon(user_ctx);
+	}
+}
+#endif
+
 static void
 displayStr( int lv, const char *msg )
 {
@@ -1733,6 +1852,9 @@
 			userEnviron = setEnv( userEnviron, "HOME", "/" );
 			home = 0;
 		}
+#ifdef WITH_SELINUX
+		kdm_selinux_setup_exec_context(curuser, home);
+#endif
 		if (home || td->clientLogFile[0] == '/') {
 			if (!createClientLog( td->clientLogFile )) {
 				logWarn( "Session log file according to %s cannot be created: %m\n",
@@ -1746,6 +1868,9 @@
 				          td->clientLogFallback );
 			/* Could inform the user, but I guess this is only confusing. */
 		}
+#ifdef WITH_SELINUX
+		setfscreatecon(NULL);
+#endif
 		if (!*dmrcDir)
 			mergeSessionArgs( home != 0 );
 		if (!(desksess = iniEntry( curdmrc, "Desktop", "Session", 0 )))

--Boundary-00=_iu8VN2HFl+wWMtS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
