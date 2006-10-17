Message-ID: <4534FE82.4020306@trustedcs.com>
Date: Tue, 17 Oct 2006 11:02:10 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [PATCH 4/4] implement setransd access check for translations
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add an access check for translating contexts.  This uses the new context
security class.  This is currently implemented as strictly an MLS check because
the target context is always the context of the daemon with the MLS portion
modified to match that of the context being translated.  The policy to
translate contexts includes TE access for "<domain doing the translation>
setrans_t:context translate)".  This allows all TE checks to pass.  The
mlsconstraint then checks to make sure that the process requesting the
translation is cleared to do the translation.  This all goes through a userspace
AVC and is expandable to include a TE check in the future (just get away from
building the "fake" context).  This access is disabled by default.  One must
put the line "accesscheck=1" in the setrans.conf file to enable the access
check (not the prettiest method, but it does work...).  The MLS policy will
need that line added to the default setrans.conf file as well.

---

 src/mcstrans.c  |   18 +++++++-
 src/mcstransd.c |  118 +++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 95 insertions(+), 41 deletions(-)

diff --git a/src/mcstrans.c b/src/mcstrans.c
index b2354df..2ae75ef 100644
--- a/src/mcstrans.c
+++ b/src/mcstrans.c
@@ -24,6 +24,8 @@ typedef struct labels {
 
 static labels_t *labellist=NULL;
 
+extern int access_check;
+
 void finish_context_translations(void) {
 	labels_t *ptr=NULL;
 	labels_t *current=NULL;
@@ -398,14 +400,24 @@ int init_translations(void) {
 	}
 
 	while (getline(&buffer, &size, cfg) > 0) {
-		if(process_label(buffer, &next)) {
-			ptr->next=next;
-			ptr=next;
+		int ret = process_label(buffer, &next);
+		if (ret > 0) {
 			if ((strcasecmp(next->label.name,"disable")==0) &&
 			    (strcmp(next->label.sename,"1") == 0)) {
 				finish_context_translations();
 				break;
 			}
+			if ((strcasecmp(next->label.name,"accesscheck")==0) &&
+			    (strcmp(next->label.sename,"1") == 0)) {
+				access_check = 1;
+				free(next);
+				continue;
+			}
+			ptr->next=next;
+			ptr=next;
+		} else if (ret < 0){
+			finish_context_translations();
+			break;
 		}
 	}
 	free(buffer);
diff --git a/src/mcstransd.c b/src/mcstransd.c
index 637c508..d27bcd0 100644
--- a/src/mcstransd.c
+++ b/src/mcstransd.c
@@ -13,6 +13,10 @@ #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
 #include <syslog.h>
+#include <selinux/avc.h>
+#include <selinux/av_permissions.h>
+#include <selinux/context.h>
+#include <selinux/flask.h>
 #include <selinux/selinux.h>
 #include <sys/types.h>
 #include <sys/capability.h>
@@ -53,12 +57,18 @@ #define SETRANSD_PATHNAME "/sbin/mcstran
 #define SETRANSD_PROGNAME "mcstransd"
 
 static int sockfd = -1;	/* socket we are listening on */
+int access_check = 0; /* should we perform access checks */
+static security_context_t base_context; /* base context for access check */
 
 static volatile int restart_daemon = 0;
 static void cleanup_exit(int ret) __attribute__ ((noreturn));
 static void
 cleanup_exit(int ret) 
 {
+	avc_destroy();
+
+	free(base_context);
+
 	if (sockfd >=0)
 		(void)unlink(SETRANS_UNIX_SOCKET);
 	exit(ret);
@@ -71,22 +81,59 @@ static  __attribute__((noreturn)) void c
 }
 
 /*
+ * Make sure that the process has permission to translate the context
+ */
+static int can_translate(char *pcon, char *tcon)
+{
+	security_id_t psid, tsid;
+	context_t fake_con, target_con;
+	int retval;
+
+	if (access_check) {
+		if (avc_context_to_sid_raw(pcon, &psid))
+			return -1;
+
+		fake_con = context_new(base_context);
+		if (!fake_con)
+			return -1;
+		target_con = context_new(tcon);
+		if (!target_con) {
+			context_free(fake_con);
+			return -1;
+		}
+		retval = context_range_set(fake_con,
+		                           context_range_get(target_con));
+		context_free(target_con);
+		if (retval) {
+			context_free(fake_con);
+			return -1;
+		}
+		retval = avc_context_to_sid_raw(context_str(fake_con), &tsid);
+		context_free(fake_con);
+		if (retval)
+			return -1;
+
+		if (avc_has_perm(psid, tsid, SECCLASS_CONTEXT,
+		                 CONTEXT__TRANSLATE, NULL, NULL))
+			return -1;
+	}
+
+	return 0;
+}
+
+/*
  * Convert raw label portion of a security context to translated label
  * Returns:  0 on success, 1 on failure
  */
 static int
-raw_to_trans_context(char *in, char **out, char *UNUSED(pcon))
+raw_to_trans_context(char *in, char **out, char *pcon)
 {
-
 	*out = NULL; 
 
-	/* TODO: Check if MLS clearance (in "pcon") dominates the MLS label
-	 * (in "in").
-	 */
+	if (can_translate(pcon, in))
+		return -1;
 
-	trans_context(in, out);
-	
-	return 0;
+	return trans_context(in, out);
 }
 
 
@@ -95,15 +142,21 @@ raw_to_trans_context(char *in, char **ou
  * Returns:  0 on success, 1 on failure
  */
 static int
-trans_to_raw_context(char *in, char **out, char *UNUSED(pcon))
+trans_to_raw_context(char *in, char **out, char *pcon)
 {
+	int retval;
+
 	*out = NULL;
 	
-	/* TODO: Check if MLS clearance (in "pcon") dominates the MLS label
-	 * (in "in").
-	 */
+	retval = untrans_context(in, out);
+	if (retval)
+		return retval;
 
-	untrans_context(in, out);
+	if (can_translate(pcon, *out)) {
+		free(*out);
+		*out = NULL;
+		return -1;
+	}
 
 	return 0;
 }
@@ -152,29 +205,6 @@ send_response(int fd, uint32_t function,
 }
 
 static int
-get_peer_con(int fd, char **peercon)
-{
-	int ret;
-	socklen_t size = sizeof(struct ucred);
-	struct ucred peercred;
-
-	/* get the context of the requesting process */
-	ret = getsockopt(fd, SOL_SOCKET, SO_PEERCRED, &peercred, &size);
-	if (ret < 0) {
-		syslog(LOG_ERR, "Failed to get PID of client process");
-		return -1;
-	}
-	ret = getpidcon_raw(peercred.pid, peercon);
-	if (ret) {
-		syslog(LOG_ERR, 
-			"Failed to get context of client process (pid=%u)",
-			peercred.pid);
-		return -1;
-	}
-	return 0;
-}
-
-static int
 process_request(int fd, uint32_t function, char *data1, char *data2)
 {
 	int32_t result;
@@ -191,14 +221,14 @@ process_request(int fd, uint32_t functio
 		ret = send_response(fd, function, NULL, result);
 		break;
 	case RAW_TO_TRANS_CONTEXT:
-		ret = get_peer_con(fd, &peercon);
+		ret = getpeercon_raw(fd, &peercon);
 		if (ret)
 			return ret;
 		result = raw_to_trans_context(data1, &out, peercon);
 		ret = send_response(fd, function, out, result);
 		break;
 	case TRANS_TO_RAW_CONTEXT:
-		ret = get_peer_con(fd, &peercon);
+		ret = getpeercon_raw(fd, &peercon);
 		if (ret)
 			return ret;
 		result = trans_to_raw_context(data1, &out, peercon);
@@ -493,6 +523,18 @@ initialize(void)
 		cleanup_exit(1);
 	}
 
+	if (avc_init("setransd", NULL, NULL, NULL, NULL)) {
+		syslog(LOG_ERR, "Failed to initialize AVC for "
+		       "label translations");
+		cleanup_exit(1);
+	}
+
+	if (getcon_raw(&base_context)) {
+		syslog(LOG_ERR, "Failed to initialize base context "
+		       "label translations");
+		cleanup_exit(1);
+	}
+
 	/* the socket will be unlinked when the daemon terminates */
 	act.sa_handler = sigterm_handler;
 	sigemptyset(&act.sa_mask);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
