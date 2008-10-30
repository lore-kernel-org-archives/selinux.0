Message-ID: <4909F443.10007@tycho.nsa.gov>
Date: Thu, 30 Oct 2008 13:52:03 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: use message types when logging messages
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch puts a proper message type into each message logged by the
userspace AVC.
Currently, the message types are defined but not used.

This will allow better separation of messages when logging to facilities
such as libaudit.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 avc.c          |   31 ++++++++++++++++++++-----------
 avc_internal.c |   39 ++++++++++++++++++++++++++-------------
 avc_internal.h |    4 ++--
 3 files changed, 48 insertions(+), 26 deletions(-)

--

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index ddc367c..899e074 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -199,13 +199,17 @@ int avc_init(const char *prefix,
 
 	rc = sidtab_init(&avc_sidtab);
 	if (rc) {
-		avc_log("%s:  unable to initialize SID table\n", avc_prefix);
+		avc_log(SELINUX_ERROR,
+			"%s:  unable to initialize SID table\n",
+			avc_prefix);
 		goto out;
 	}
 
 	avc_audit_buf = (char *)avc_malloc(AVC_AUDIT_BUFSIZE);
 	if (!avc_audit_buf) {
-		avc_log("%s:  unable to allocate audit buffer\n", avc_prefix);
+		avc_log(SELINUX_ERROR,
+			"%s:  unable to allocate audit buffer\n",
+			avc_prefix);
 		rc = -1;
 		goto out;
 	}
@@ -213,7 +217,8 @@ int avc_init(const char *prefix,
 	for (i = 0; i < AVC_CACHE_MAXNODES; i++) {
 		new = avc_malloc(sizeof(*new));
 		if (!new) {
-			avc_log("%s:  warning: only got %d av entries\n",
+			avc_log(SELINUX_WARNING,
+				"%s:  warning: only got %d av entries\n",
 				avc_prefix, i);
 			break;
 		}
@@ -225,7 +230,8 @@ int avc_init(const char *prefix,
 	if (!avc_setenforce) {
 		rc = security_getenforce();
 		if (rc < 0) {
-			avc_log("%s:  could not determine enforcing mode\n",
+			avc_log(SELINUX_ERROR,
+				"%s:  could not determine enforcing mode\n",
 				avc_prefix);
 			goto out;
 		}
@@ -234,8 +240,9 @@ int avc_init(const char *prefix,
 
 	rc = avc_netlink_open(avc_using_threads);
 	if (rc < 0) {
-		avc_log("%s:  can't open netlink socket: %d (%s)\n", avc_prefix,
-			errno, strerror(errno));
+		avc_log(SELINUX_ERROR,
+			"%s:  can't open netlink socket: %d (%s)\n",
+			avc_prefix, errno, strerror(errno));
 		goto out;
 	}
 	if (avc_using_threads) {
@@ -258,7 +265,7 @@ void avc_sid_stats(void)
 	avc_get_lock(avc_lock);
 	sidtab_sid_stats(&avc_sidtab, avc_audit_buf, AVC_AUDIT_BUFSIZE);
 	avc_release_lock(avc_lock);
-	avc_log("%s", avc_audit_buf);
+	avc_log(SELINUX_INFO, "%s", avc_audit_buf);
 	avc_release_lock(avc_log_lock);
 }
 
@@ -287,7 +294,7 @@ void avc_av_stats(void)
 
 	avc_release_lock(avc_lock);
 
-	avc_log("%s:  %d AV entries and %d/%d buckets used, "
+	avc_log(SELINUX_INFO, "%s:  %d AV entries and %d/%d buckets used, "
 		"longest chain length %d\n", avc_prefix,
 		avc_cache.active_nodes,
 		slots_used, AVC_CACHE_SLOTS, max_chain_len);
@@ -463,7 +470,8 @@ static int avc_insert(security_id_t ssid, security_id_t tsid,
 	int rc = 0;
 
 	if (ae->avd.seqno < avc_cache.latest_notif) {
-		avc_log("%s:  seqno %d < latest_notif %d\n", avc_prefix,
+		avc_log(SELINUX_WARNING,
+			"%s:  seqno %d < latest_notif %d\n", avc_prefix,
 			ae->avd.seqno, avc_cache.latest_notif);
 		errno = EAGAIN;
 		rc = -1;
@@ -665,7 +673,8 @@ static int avc_ratelimit(void)
 		toks -= AVC_MSG_COST;
 		avc_release_lock(ratelimit_lock);
 		if (lost) {
-			avc_log("%s:  %d messages suppressed.\n", avc_prefix,
+			avc_log(SELINUX_WARNING,
+				"%s:  %d messages suppressed.\n", avc_prefix,
 				lost);
 		}
 		rc = 1;
@@ -784,7 +793,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 	log_append(avc_audit_buf, " ");
 	avc_dump_query(ssid, tsid, tclass);
 	log_append(avc_audit_buf, "\n");
-	avc_log("%s", avc_audit_buf);
+	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
 
 	avc_release_lock(avc_log_lock);
 }
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index b9e9db2..354d32e 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -103,26 +103,30 @@ static int avc_netlink_receive(char *buf, unsigned buflen)
 		return rc;
 
 	if (nladdrlen != sizeof nladdr) {
-		avc_log("%s:  warning: netlink address truncated, len %d?\n",
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: netlink address truncated, len %d?\n",
 			avc_prefix, nladdrlen);
 		return -1;
 	}
 
 	if (nladdr.nl_pid) {
-		avc_log("%s:  warning: received spoofed netlink packet from: %d\n",
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: received spoofed netlink packet from: %d\n",
 			avc_prefix, nladdr.nl_pid);
 		return -1;
 	}
 
 	if (rc == 0) {
-		avc_log("%s:  warning: received EOF on netlink socket\n",
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: received EOF on netlink socket\n",
 			avc_prefix);
 		errno = EBADFD;
 		return -1;
 	}
 
 	if (nlh->nlmsg_flags & MSG_TRUNC || nlh->nlmsg_len > (unsigned)rc) {
-		avc_log("%s:  warning: incomplete netlink message\n",
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: incomplete netlink message\n",
 			avc_prefix);
 		return -1;
 	}
@@ -144,19 +148,22 @@ static int avc_netlink_process(char *buf)
 			break;
 
 		errno = -err->error;
-		avc_log("%s:  netlink error: %d\n", avc_prefix, errno);
+		avc_log(SELINUX_ERROR,
+			"%s:  netlink error: %d\n", avc_prefix, errno);
 		return -1;
 	}
 
 	case SELNL_MSG_SETENFORCE:{
 		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
-		avc_log("%s:  received setenforce notice (enforcing=%d)\n",
+		avc_log(SELINUX_INFO,
+			"%s:  received setenforce notice (enforcing=%d)\n",
 			avc_prefix, msg->val);
 		if (avc_setenforce)
 			break;
 		avc_enforcing = msg->val;
 		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
-			avc_log("%s:  cache reset returned %d (errno %d)\n",
+			avc_log(SELINUX_ERROR,
+				"%s:  cache reset returned %d (errno %d)\n",
 				avc_prefix, rc, errno);
 			return rc;
 		}
@@ -165,11 +172,13 @@ static int avc_netlink_process(char *buf)
 
 	case SELNL_MSG_POLICYLOAD:{
 		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
-		avc_log("%s:  received policyload notice (seqno=%d)\n",
+		avc_log(SELINUX_INFO,
+			"%s:  received policyload notice (seqno=%d)\n",
 			avc_prefix, msg->seqno);
 		rc = avc_ss_reset(msg->seqno);
 		if (rc < 0) {
-			avc_log("%s:  cache reset returned %d (errno %d)\n",
+			avc_log(SELINUX_ERROR,
+				"%s:  cache reset returned %d (errno %d)\n",
 				avc_prefix, rc, errno);
 			return rc;
 		}
@@ -177,7 +186,8 @@ static int avc_netlink_process(char *buf)
 	}
 
 	default:
-		avc_log("%s:  warning: unknown netlink message %d\n",
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: unknown netlink message %d\n",
 			avc_prefix, nlh->nlmsg_type);
 	}
 	return 0;
@@ -197,7 +207,8 @@ int avc_netlink_check_nb(void)
 			if (errno == 0 || errno == EINTR)
 				continue;
 			else {
-				avc_log("%s:  netlink recvfrom: error %d\n",
+				avc_log(SELINUX_ERROR,
+					"%s:  netlink recvfrom: error %d\n",
 					avc_prefix, errno);
 				return rc;
 			}
@@ -221,7 +232,8 @@ void avc_netlink_loop(void)
 			if (errno == 0 || errno == EINTR)
 				continue;
 			else {
-				avc_log("%s:  netlink recvfrom: error %d\n",
+				avc_log(SELINUX_ERROR,
+					"%s:  netlink recvfrom: error %d\n",
 					avc_prefix, errno);
 				break;
 			}
@@ -234,6 +246,7 @@ void avc_netlink_loop(void)
 
 	close(fd);
 	avc_netlink_trouble = 1;
-	avc_log("%s:  netlink thread: errors encountered, terminating\n",
+	avc_log(SELINUX_ERROR,
+		"%s:  netlink thread: errors encountered, terminating\n",
 		avc_prefix);
 }
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index cd50dc8..31bd7e1 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -91,11 +91,11 @@ static inline void avc_free(void *ptr)
 }
 
 /* this is a macro in order to use the variadic capability. */
-#define avc_log(format...) \
+#define avc_log(type, format...) \
   if (avc_func_log) \
     avc_func_log(format); \
   else \
-    selinux_log(SELINUX_ERROR, format);
+    selinux_log(type, format);
 
 static inline void avc_suppl_audit(void *ptr, security_class_t class,
 				   char *buf, size_t len)

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
