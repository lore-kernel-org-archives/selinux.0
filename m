Return-Path: <SRS0=tWfz=YG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA16ECE587
	for <selinux@archiver.kernel.org>; Sun, 13 Oct 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119182084D
	for <selinux@archiver.kernel.org>; Sun, 13 Oct 2019 10:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfJMKwx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Oct 2019 06:52:53 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58090 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMKwx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Oct 2019 06:52:53 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9E6D2564679;
        Sun, 13 Oct 2019 12:52:46 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
Subject: [PATCH 1/2] libselinux: mark all exported function "extern"
Date:   Sun, 13 Oct 2019 12:52:15 +0200
Message-Id: <20191013105216.614224-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Oct 13 12:52:47 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Many functions are already marked "extern" in libselinux's public
headers and this will help using the content of the headers in order to
automatically generate some glue code for Python bindings.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/include/selinux/avc.h              | 112 +++++++++---------
 libselinux/include/selinux/get_context_list.h |  34 +++---
 libselinux/include/selinux/get_default_type.h |   4 +-
 libselinux/include/selinux/label.h            |  58 ++++-----
 libselinux/include/selinux/selinux.h          |   6 +-
 5 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index b4bc6f3f07f8..46c51419f588 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -37,8 +37,8 @@ typedef struct security_id *security_id_t;
  * failure, with @errno set to %ENOMEM if insufficient memory was
  * available to make the copy, or %EINVAL if the input SID is invalid.
  */
-int avc_sid_to_context(security_id_t sid, char ** ctx);
-int avc_sid_to_context_raw(security_id_t sid, char ** ctx);
+extern int avc_sid_to_context(security_id_t sid, char ** ctx);
+extern int avc_sid_to_context_raw(security_id_t sid, char ** ctx);
 
 /**
  * avc_context_to_sid - get SID for context.
@@ -51,8 +51,8 @@ int avc_sid_to_context_raw(security_id_t sid, char ** ctx);
  * to the SID structure into the memory referenced by @sid, 
  * returning %0 on success or -%1 on error with @errno set.  
  */
-int avc_context_to_sid(const char * ctx, security_id_t * sid);
-int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
+extern int avc_context_to_sid(const char * ctx, security_id_t * sid);
+extern int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
 
 /**
  * sidget - increment SID reference counter.
@@ -64,7 +64,7 @@ int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
  * reference count).  Note that avc_context_to_sid() also
  * increments reference counts.
  */
-int sidget(security_id_t sid);
+extern int sidget(security_id_t sid);
 
 /**
  * sidput - decrement SID reference counter.
@@ -76,7 +76,7 @@ int sidget(security_id_t sid);
  * zero, the SID is invalid, and avc_context_to_sid() must
  * be called to obtain a new SID for the security context.
  */
-int sidput(security_id_t sid);
+extern int sidput(security_id_t sid);
 
 /**
  * avc_get_initial_sid - get SID for an initial kernel security identifier
@@ -87,7 +87,7 @@ int sidput(security_id_t sid);
  * @name using security_get_initial_context() and then call 
  * avc_context_to_sid() to get the corresponding SID.
  */
-int avc_get_initial_sid(const char *name, security_id_t * sid);
+extern int avc_get_initial_sid(const char *name, security_id_t * sid);
 
 /*
  * AVC entry
@@ -188,11 +188,11 @@ struct avc_lock_callback {
  * for those callbacks (see the definition of the callback
  * structures above).
  */
-int avc_init(const char *msgprefix,
-	     const struct avc_memory_callback *mem_callbacks,
-	     const struct avc_log_callback *log_callbacks,
-	     const struct avc_thread_callback *thread_callbacks,
-	     const struct avc_lock_callback *lock_callbacks);
+extern int avc_init(const char *msgprefix,
+		    const struct avc_memory_callback *mem_callbacks,
+		    const struct avc_log_callback *log_callbacks,
+		    const struct avc_thread_callback *thread_callbacks,
+		    const struct avc_lock_callback *lock_callbacks);
 
 /**
  * avc_open - Initialize the AVC.
@@ -203,7 +203,7 @@ int avc_init(const char *msgprefix,
  * is set to "avc" and any callbacks desired should be specified via
  * selinux_set_callback().  Available options are listed above.
  */
-int avc_open(struct selinux_opt *opts, unsigned nopts);
+extern int avc_open(struct selinux_opt *opts, unsigned nopts);
 
 /**
  * avc_cleanup - Remove unused SIDs and AVC entries.
@@ -213,7 +213,7 @@ int avc_open(struct selinux_opt *opts, unsigned nopts);
  * AVC entries that reference them.  This can be used
  * to return memory to the system.
  */
-void avc_cleanup(void);
+extern void avc_cleanup(void);
 
 /**
  * avc_reset - Flush the cache and reset statistics.
@@ -223,7 +223,7 @@ void avc_cleanup(void);
  * The SID mapping is not affected.  Return %0 on success, 
  * -%1 with @errno set on error.
  */
-int avc_reset(void);
+extern int avc_reset(void);
 
 /**
  * avc_destroy - Free all AVC structures.
@@ -234,7 +234,7 @@ int avc_reset(void);
  * callbacks will not.  All SID's will be invalidated.
  * User must call avc_init() if further use of AVC is desired.
  */
-void avc_destroy(void);
+extern void avc_destroy(void);
 
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
@@ -257,11 +257,11 @@ void avc_destroy(void);
  * auditing, e.g. in cases where a lock must be held for the check but
  * should be released for the auditing.
  */
-int avc_has_perm_noaudit(security_id_t ssid,
-			 security_id_t tsid,
-			 security_class_t tclass,
-			 access_vector_t requested,
-			 struct avc_entry_ref *aeref, struct av_decision *avd);
+extern int avc_has_perm_noaudit(security_id_t ssid,
+				security_id_t tsid,
+				security_class_t tclass,
+				access_vector_t requested,
+				struct avc_entry_ref *aeref, struct av_decision *avd);
 
 /**
  * avc_has_perm - Check permissions and perform any appropriate auditing.
@@ -281,9 +281,9 @@ int avc_has_perm_noaudit(security_id_t ssid,
  * permissions are granted, -%1 with @errno set to %EACCES if any permissions
  * are denied or to another value upon other errors.
  */
-int avc_has_perm(security_id_t ssid, security_id_t tsid,
-		 security_class_t tclass, access_vector_t requested,
-		 struct avc_entry_ref *aeref, void *auditdata);
+extern int avc_has_perm(security_id_t ssid, security_id_t tsid,
+			security_class_t tclass, access_vector_t requested,
+			struct avc_entry_ref *aeref, void *auditdata);
 
 /**
  * avc_audit - Audit the granting or denial of permissions.
@@ -304,9 +304,9 @@ int avc_has_perm(security_id_t ssid, security_id_t tsid,
  * be performed under a lock, to allow the lock to be released
  * before calling the auditing code.
  */
-void avc_audit(security_id_t ssid, security_id_t tsid,
-	       security_class_t tclass, access_vector_t requested,
-	       struct av_decision *avd, int result, void *auditdata);
+extern void avc_audit(security_id_t ssid, security_id_t tsid,
+		      security_class_t tclass, access_vector_t requested,
+		      struct av_decision *avd, int result, void *auditdata);
 
 /**
  * avc_compute_create - Compute SID for labeling a new object.
@@ -322,9 +322,9 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
  * memory referenced by @newsid, returning %0 on success or -%1 on
  * error with @errno set.  
  */
-int avc_compute_create(security_id_t ssid,
-		       security_id_t tsid,
-		       security_class_t tclass, security_id_t * newsid);
+extern int avc_compute_create(security_id_t ssid,
+			      security_id_t tsid,
+			      security_class_t tclass, security_id_t * newsid);
 
 /**
  * avc_compute_member - Compute SID for polyinstantation.
@@ -340,9 +340,9 @@ int avc_compute_create(security_id_t ssid,
  * memory referenced by @newsid, returning %0 on success or -%1 on
  * error with @errno set.  
  */
-int avc_compute_member(security_id_t ssid,
-		       security_id_t tsid,
-		       security_class_t tclass, security_id_t * newsid);
+extern int avc_compute_member(security_id_t ssid,
+			      security_id_t tsid,
+			      security_class_t tclass, security_id_t * newsid);
 
 /* 
  * security event callback facility
@@ -373,14 +373,14 @@ int avc_compute_member(security_id_t ssid,
  * @perms based on @tclass.  Returns %0 on success or
  * -%1 if insufficient memory exists to add the callback.
  */
-int avc_add_callback(int (*callback)
-		      (uint32_t event, security_id_t ssid,
-		       security_id_t tsid, security_class_t tclass,
-		       access_vector_t perms,
-		       access_vector_t * out_retained),
-		     uint32_t events, security_id_t ssid,
-		     security_id_t tsid, security_class_t tclass,
-		     access_vector_t perms);
+extern int avc_add_callback(int (*callback)
+			     (uint32_t event, security_id_t ssid,
+			      security_id_t tsid, security_class_t tclass,
+			      access_vector_t perms,
+			      access_vector_t * out_retained),
+			    uint32_t events, security_id_t ssid,
+			    security_id_t tsid, security_class_t tclass,
+			    access_vector_t perms);
 
 /*
  * AVC statistics 
@@ -411,7 +411,7 @@ struct avc_cache_stats {
  * avc_reset().  See the structure definition for
  * details.
  */
-void avc_cache_stats(struct avc_cache_stats *stats);
+extern void avc_cache_stats(struct avc_cache_stats *stats);
 
 /**
  * avc_av_stats - log av table statistics.
@@ -420,7 +420,7 @@ void avc_cache_stats(struct avc_cache_stats *stats);
  * distribution of the access vector table.  The audit
  * callback is used to print the message.
  */
-void avc_av_stats(void);
+extern void avc_av_stats(void);
 
 /**
  * avc_sid_stats - log SID table statistics.
@@ -429,22 +429,22 @@ void avc_av_stats(void);
  * distribution of the SID table.  The audit callback
  * is used to print the message.
  */
-void avc_sid_stats(void);
+extern void avc_sid_stats(void);
 
 /**
  * avc_netlink_open - Create a netlink socket and connect to the kernel.
  */
-int avc_netlink_open(int blocking);
+extern int avc_netlink_open(int blocking);
 
 /**
  * avc_netlink_loop - Wait for netlink messages from the kernel
  */
-void avc_netlink_loop(void);
+extern void avc_netlink_loop(void);
 
 /**
  * avc_netlink_close - Close the netlink socket
  */
-void avc_netlink_close(void);
+extern void avc_netlink_close(void);
 
 /**
  * avc_netlink_acquire_fd - Acquire netlink socket fd.
@@ -452,14 +452,14 @@ void avc_netlink_close(void);
  * Allows the application to manage messages from the netlink socket in
  * its own main loop.
  */
-int avc_netlink_acquire_fd(void);
+extern int avc_netlink_acquire_fd(void);
 
 /**
  * avc_netlink_release_fd - Release netlink socket fd.
  *
  * Returns ownership of the netlink socket to the library.
  */
-void avc_netlink_release_fd(void);
+extern void avc_netlink_release_fd(void);
 
 /**
  * avc_netlink_check_nb - Check netlink socket for new messages.
@@ -467,43 +467,43 @@ void avc_netlink_release_fd(void);
  * Called by the application when using avc_netlink_acquire_fd() to
  * process kernel netlink events.
  */
-int avc_netlink_check_nb(void);
+extern int avc_netlink_check_nb(void);
 
 /**
  * selinux_status_open - Open and map SELinux kernel status page
  *
  */
-int selinux_status_open(int fallback);
+extern int selinux_status_open(int fallback);
 
 /**
  * selinux_status_close - Unmap and close SELinux kernel status page
  *
  */
-void selinux_status_close(void);
+extern void selinux_status_close(void);
 
 /**
  * selinux_status_updated - Inform us whether the kernel status has been updated
  *
  */
-int selinux_status_updated(void);
+extern int selinux_status_updated(void);
 
 /**
  * selinux_status_getenforce - Get the enforce flag value
  *
  */
-int selinux_status_getenforce(void);
+extern int selinux_status_getenforce(void);
 
 /**
  * selinux_status_policyload - Get the number of policy reloaded
  *
  */
-int selinux_status_policyload(void);
+extern int selinux_status_policyload(void);
 
 /**
  * selinux_status_deny_unknown - Get the  behavior for undefined classes/permissions
  *
  */
-int selinux_status_deny_unknown(void);
+extern int selinux_status_deny_unknown(void);
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/include/selinux/get_context_list.h b/libselinux/include/selinux/get_context_list.h
index 905f6af3db3b..db8641a4ca8f 100644
--- a/libselinux/include/selinux/get_context_list.h
+++ b/libselinux/include/selinux/get_context_list.h
@@ -22,10 +22,10 @@ extern "C" {
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
-	int get_ordered_context_list_with_level(const char *user,
-						const char *level,
-						char * fromcon,
-						char *** list);
+	extern int get_ordered_context_list_with_level(const char *user,
+						       const char *level,
+						       char * fromcon,
+						       char *** list);
 
 /* Get the default security context for a user session for 'user'
    spawned by 'fromcon' and set *newcon to refer to it.  The context
@@ -40,27 +40,27 @@ extern "C" {
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
-	int get_default_context_with_level(const char *user,
-					   const char *level,
-					   char * fromcon,
-					   char ** newcon);
+	extern int get_default_context_with_level(const char *user,
+						  const char *level,
+						  char * fromcon,
+						  char ** newcon);
 
 /* Same as get_default_context, but only return a context
    that has the specified role.  If no reachable context exists
    for the user with that role, then return -1. */
-	int get_default_context_with_role(const char *user,
-					  const char *role,
-					  char * fromcon,
-					  char ** newcon);
+	extern int get_default_context_with_role(const char *user,
+						 const char *role,
+						 char * fromcon,
+						 char ** newcon);
 
 /* Same as get_default_context, but only return a context
    that has the specified role and level.  If no reachable context exists
    for the user with that role, then return -1. */
-	int get_default_context_with_rolelevel(const char *user,
-					       const char *role,
-					       const char *level,
-					       char * fromcon,
-					       char ** newcon);
+	extern int get_default_context_with_rolelevel(const char *user,
+						      const char *role,
+						      const char *level,
+						      char * fromcon,
+						      char ** newcon);
 
 /* Given a list of authorized security contexts for the user, 
    query the user to select one and set *newcon to refer to it.
diff --git a/libselinux/include/selinux/get_default_type.h b/libselinux/include/selinux/get_default_type.h
index 65c5dd40a3d4..93f5b2764d38 100644
--- a/libselinux/include/selinux/get_default_type.h
+++ b/libselinux/include/selinux/get_default_type.h
@@ -10,12 +10,12 @@ extern "C" {
 #endif
 
 /* Return path to default type file. */
-	const char *selinux_default_type_path(void);
+	extern const char *selinux_default_type_path(void);
 
 /* Get the default type (domain) for 'role' and set 'type' to refer to it.
    Caller must free via free().
    Return 0 on success or -1 otherwise. */
-	int get_default_type(const char *role, char **type);
+	extern int get_default_type(const char *role, char **type);
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 962826326a17..e8983606d93b 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -73,9 +73,9 @@ struct selabel_handle;
  * backend.  Return value is the created handle on success or NULL with
  * @errno set on failure.
  */
-struct selabel_handle *selabel_open(unsigned int backend,
-				    const struct selinux_opt *opts,
-				    unsigned nopts);
+extern struct selabel_handle *selabel_open(unsigned int backend,
+					   const struct selinux_opt *opts,
+					   unsigned nopts);
 
 /**
  * selabel_close - Close a labeling handle.
@@ -84,7 +84,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
  * Destroy the specified handle, closing files, freeing allocated memory,
  * etc.  The handle may not be further used after it has been closed.
  */
-void selabel_close(struct selabel_handle *handle);
+extern void selabel_close(struct selabel_handle *handle);
 
 /**
  * selabel_lookup - Perform labeling lookup operation.
@@ -99,25 +99,25 @@ void selabel_close(struct selabel_handle *handle);
  * The result is returned in the memory pointed to by @con and must be freed
  * by the user with freecon().
  */
-int selabel_lookup(struct selabel_handle *handle, char **con,
-		   const char *key, int type);
-int selabel_lookup_raw(struct selabel_handle *handle, char **con,
-		       const char *key, int type);
-
-bool selabel_partial_match(struct selabel_handle *handle, const char *key);
-
-bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
-					     const char *key,
-					     uint8_t **calculated_digest,
-					     uint8_t **xattr_digest,
-					     size_t *digest_len);
-bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
-                                      const char *key, uint8_t* digest);
-
-int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
-			      const char *key, const char **aliases, int type);
-int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
-			      const char *key, const char **aliases, int type);
+extern int selabel_lookup(struct selabel_handle *handle, char **con,
+			  const char *key, int type);
+extern int selabel_lookup_raw(struct selabel_handle *handle, char **con,
+			      const char *key, int type);
+
+extern bool selabel_partial_match(struct selabel_handle *handle, const char *key);
+
+extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
+						    const char *key,
+						    uint8_t **calculated_digest,
+						    uint8_t **xattr_digest,
+						    size_t *digest_len);
+extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
+					     const char *key, uint8_t* digest);
+
+extern int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
+				     const char *key, const char **aliases, int type);
+extern int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
+					 const char *key, const char **aliases, int type);
 
 /**
  * selabel_digest - Retrieve the SHA1 digest and the list of specfiles used to
@@ -132,9 +132,9 @@ int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
  *
  * Return %0 on success, -%1 with @errno set on failure.
  */
-int selabel_digest(struct selabel_handle *rec,
-			    unsigned char **digest, size_t *digest_len,
-			    char ***specfiles, size_t *num_specfiles);
+extern int selabel_digest(struct selabel_handle *rec,
+			  unsigned char **digest, size_t *digest_len,
+			  char ***specfiles, size_t *num_specfiles);
 
 enum selabel_cmp_result {
 	SELABEL_SUBSET,
@@ -153,8 +153,8 @@ enum selabel_cmp_result {
  * if @h1 is identical to @h2, %SELABEL_SUPERSET if @h1 is a superset
  * of @h2, and %SELABEL_INCOMPARABLE if @h1 and @h2 are incomparable.
  */
-enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
-				    struct selabel_handle *h2);
+extern enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
+					   struct selabel_handle *h2);
 
 /**
  * selabel_stats - log labeling operation statistics.
@@ -164,7 +164,7 @@ enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
  * number of unused matching entries, or other operational statistics.
  * Message is backend-specific, some backends may not output a message.
  */
-void selabel_stats(struct selabel_handle *handle);
+extern void selabel_stats(struct selabel_handle *handle);
 
 /*
  * Type codes used by specific backends
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 6db98e0e68cf..fe46e681488d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -610,13 +610,13 @@ extern int selinux_check_securetty_context(const char * tty_context);
    Normally, this is determined automatically during libselinux 
    initialization, but this is not always possible, e.g. for /sbin/init
    which performs the initial mount of selinuxfs. */
-void set_selinuxmnt(const char *mnt);
+extern void set_selinuxmnt(const char *mnt);
 
 /* Check if selinuxfs exists as a kernel filesystem */
-int selinuxfs_exists(void);
+extern int selinuxfs_exists(void);
 
 /* clear selinuxmnt variable and free allocated memory */
-void fini_selinuxmnt(void);
+extern void fini_selinuxmnt(void);
 
 /* Set an appropriate security context based on the filename of a helper
  * program, falling back to a new context with the specified type. */
-- 
2.22.0

