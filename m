Message-ID: <45253C1C.7010803@trustedcs.com>
Date: Thu, 05 Oct 2006 12:08:44 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [PATCH] libselinux: always store raw contexts in the avc sidtab
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Always store raw contexts in the avc sidtab.  This is accomplished by
providing functions to deal with raw contexts when converting contexts
to sids and vice versa.  The security_compute_av is also switch to the raw
version because the contexts will now all be raw.  When the raw context is
being converted to a sid, there will be no overhead.  When a translated context
is converted, there will be a translation to raw for storage.  There conversion
back from sid to context via avc_context_to_sid() will translate the context,
while avc_context_to_sid_raw() will not.  These functions make it easy to
optimize some code paths be removing translations for contexts that will never
be presented to the user.

Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>

___

Note that I will be posting some patches for comment that make use of these
new functions in RedHat's context translation daemon.

 include/selinux/avc.h |    2 ++
 src/avc.c             |   39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)


diff -ruNp --exclude=.svn selinux-base/libselinux/include/selinux/avc.h selinux/libselinux/include/selinux/avc.h
--- selinux-base/libselinux/include/selinux/avc.h	2006-10-03 05:08:16.000000000 -0500
+++ selinux/libselinux/include/selinux/avc.h	2006-10-05 03:25:59.000000000 -0500
@@ -38,6 +38,7 @@ extern "C" {
  * available to make the copy, or %EINVAL if the input SID is invalid.
  */
 	int avc_sid_to_context(security_id_t sid, security_context_t * ctx);
+	int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx);
 
 /**
  * avc_context_to_sid - get SID for context.
@@ -51,6 +52,7 @@ extern "C" {
  * returning %0 on success or -%1 on error with @errno set.  
  */
 	int avc_context_to_sid(security_context_t ctx, security_id_t * sid);
+	int avc_context_to_sid_raw(security_context_t ctx, security_id_t * sid);
 
 /**
  * sidget - increment SID reference counter.
diff -ruNp --exclude=.svn selinux-base/libselinux/src/avc.c selinux/libselinux/src/avc.c
--- selinux-base/libselinux/src/avc.c	2006-10-03 05:08:17.000000000 -0500
+++ selinux/libselinux/src/avc.c	2006-10-05 03:25:58.000000000 -0500
@@ -203,7 +203,7 @@ static inline int avc_hash(security_id_t
 	    & (AVC_CACHE_SLOTS - 1);
 }
 
-int avc_context_to_sid(security_context_t ctx, security_id_t * sid)
+int avc_context_to_sid_raw(security_context_t ctx, security_id_t * sid)
 {
 	int rc;
 	avc_get_lock(avc_lock);
@@ -214,7 +214,22 @@ int avc_context_to_sid(security_context_
 	return rc;
 }
 
-int avc_sid_to_context(security_id_t sid, security_context_t * ctx)
+int avc_context_to_sid(security_context_t ctx, security_id_t * sid)
+{
+	int ret;
+	security_context_t rctx;
+
+	if (selinux_trans_to_raw_context(ctx, &rctx))
+		return -1;
+
+	ret = avc_context_to_sid_raw(rctx, sid);
+
+	freecon(rctx);
+
+	return ret;
+}
+
+int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx)
 {
 	int rc;
 	*ctx = NULL;
@@ -230,6 +245,21 @@ int avc_sid_to_context(security_id_t sid
 	return rc;
 }
 
+int avc_sid_to_context(security_id_t sid, security_context_t * ctx)
+{
+	int ret;
+	security_context_t rctx;
+
+	ret = avc_sid_to_context_raw(sid, &rctx);
+
+	if (ret == 0) {
+		ret = selinux_raw_to_trans_context(rctx, ctx);
+		freecon(rctx);
+	}
+
+	return ret;
+}
+
 int sidget(security_id_t sid)
 {
 	int rc;
@@ -935,8 +965,9 @@ int avc_has_perm_noaudit(security_id_t s
 				rc = -1;
 				goto out;
 			}
-			rc = security_compute_av(ssid->ctx, tsid->ctx, tclass,
-						 requested, &entry.avd);
+			rc = security_compute_av_raw(ssid->ctx, tsid->ctx,
+						     tclass, requested,
+						     &entry.avd);
 			if (rc)
 				goto out;
 			rc = avc_insert(ssid, tsid, tclass, &entry, aeref);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
