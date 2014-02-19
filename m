Message-ID: <530515D5.8030608@tycho.nsa.gov>
Date: Wed, 19 Feb 2014 15:36:37 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: [PATCH] Get rid of security_context_t and fix const declarations.
Content-Type: multipart/mixed; boundary="------------040908060801030506030803"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------040908060801030506030803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040908060801030506030803
Content-Type: text/x-patch;
 name="0001-Get-rid-of-security_context_t-and-fix-const-declarat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Get-rid-of-security_context_t-and-fix-const-declarat.pa";
 filename*1="tch"

>From a664afd9ef4b7820a35e50ecf91f0b8622930e79 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 19 Feb 2014 09:16:17 -0500
Subject: [PATCH] Get rid of security_context_t and fix const declarations.

In attempting to enable building various part of Android with -Wall -Werror,
we found that the const security_context_t declarations in libselinux
are incorrect; const char * was intended, but const security_context_t
translates to char * const and triggers warnings on passing
const char * from the caller.   Easiest fix is to replace them all with
const char *.  And while we are at it, just get rid of all usage of
security_context_t itself as it adds no value - there is no true
encapsulation of the security context strings and callers already
directly use string functions on them.  typedef left to permit
building legacy users until such a time as all are updated.

This is a port of Change-Id I2f9df7bb9f575f76024c3e5f5b660345da2931a7
from Android, augmented to deal with all of the other code in upstream
libselinux and updating the man pages too.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/include/selinux/avc.h                   |  10 +-
 libselinux/include/selinux/get_context_list.h      |  30 ++--
 libselinux/include/selinux/label.h                 |   4 +-
 libselinux/include/selinux/selinux.h               | 197 +++++++++++----------
 libselinux/man/man3/avc_context_to_sid.3           |   4 +-
 libselinux/man/man3/get_ordered_context_list.3     |  16 +-
 libselinux/man/man3/getcon.3                       |  24 +--
 libselinux/man/man3/getexeccon.3                   |   8 +-
 libselinux/man/man3/getfilecon.3                   |  12 +-
 libselinux/man/man3/getfscreatecon.3               |   8 +-
 libselinux/man/man3/getkeycreatecon.3              |   8 +-
 libselinux/man/man3/getsockcreatecon.3             |   8 +-
 libselinux/man/man3/is_context_customizable.3      |   2 +-
 libselinux/man/man3/matchmediacon.3                |   2 +-
 libselinux/man/man3/matchpathcon.3                 |   4 +-
 libselinux/man/man3/security_check_context.3       |   4 +-
 libselinux/man/man3/security_compute_av.3          |  34 ++--
 libselinux/man/man3/selabel_lookup.3               |   4 +-
 .../man/man3/selinux_check_securetty_context.3     |   2 +-
 libselinux/man/man3/selinux_file_context_cmp.3     |   4 +-
 libselinux/man/man3/selinux_raw_context_to_color.3 |   2 +-
 libselinux/man/man3/selinux_set_callback.3         |   2 +-
 libselinux/man/man3/setfilecon.3                   |  12 +-
 libselinux/man/man5/selabel_db.5                   |   4 +-
 libselinux/man/man5/selabel_file.5                 |   4 +-
 libselinux/man/man5/selabel_media.5                |   4 +-
 libselinux/man/man5/selabel_x.5                    |   4 +-
 libselinux/src/audit2why.c                         |   4 +-
 libselinux/src/avc.c                               |  18 +-
 libselinux/src/avc_sidtab.c                        |  10 +-
 libselinux/src/avc_sidtab.h                        |   4 +-
 libselinux/src/callbacks.c                         |   4 +-
 libselinux/src/callbacks.h                         |   2 +-
 libselinux/src/canonicalize_context.c              |  12 +-
 libselinux/src/checkAccess.c                       |   4 +-
 libselinux/src/check_context.c                     |   6 +-
 libselinux/src/compute_av.c                        |  20 +--
 libselinux/src/compute_create.c                    |  30 ++--
 libselinux/src/compute_member.c                    |  18 +-
 libselinux/src/compute_relabel.c                   |  18 +-
 libselinux/src/compute_user.c                      |  12 +-
 libselinux/src/enabled.c                           |   2 +-
 libselinux/src/fgetfilecon.c                       |   6 +-
 libselinux/src/freecon.c                           |   2 +-
 libselinux/src/freeconary.c                        |   2 +-
 libselinux/src/fsetfilecon.c                       |   8 +-
 libselinux/src/get_context_list.c                  |  42 ++---
 libselinux/src/get_initial_context.c               |   6 +-
 libselinux/src/getfilecon.c                        |   6 +-
 libselinux/src/getpeercon.c                        |   6 +-
 libselinux/src/is_customizable_type.c              |  12 +-
 libselinux/src/label.c                             |   4 +-
 libselinux/src/label_internal.h                    |   4 +-
 libselinux/src/lgetfilecon.c                       |   6 +-
 libselinux/src/lsetfilecon.c                       |   8 +-
 libselinux/src/matchmediacon.c                     |   2 +-
 libselinux/src/matchpathcon.c                      |  14 +-
 libselinux/src/procattr.c                          |  50 +++---
 libselinux/src/query_user_context.c                |   6 +-
 libselinux/src/selinux_check_securetty_context.c   |   2 +-
 libselinux/src/selinuxswig.i                       |   4 +-
 libselinux/src/selinuxswig_python.i                |  10 +-
 libselinux/src/selinuxswig_ruby.i                  |   6 +-
 libselinux/src/setexecfilecon.c                    |   2 +-
 libselinux/src/setfilecon.c                        |   8 +-
 libselinux/src/setrans_client.c                    |  28 +--
 libselinux/utils/getconlist.c                      |   2 +-
 libselinux/utils/getdefaultcon.c                   |   2 +-
 libselinux/utils/getseuser.c                       |   2 +-
 libselinux/utils/matchpathcon.c                    |   2 +-
 libselinux/utils/selinuxexeccon.c                  |   6 +-
 71 files changed, 420 insertions(+), 419 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 87a2b12..b4bc6f3 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -19,7 +19,7 @@ extern "C" {
  * SID format and operations
  */
 struct security_id {
-	security_context_t ctx;
+	char * ctx;
 	unsigned int refcnt;
 };
 typedef struct security_id *security_id_t;
@@ -37,8 +37,8 @@ typedef struct security_id *security_id_t;
  * failure, with @errno set to %ENOMEM if insufficient memory was
  * available to make the copy, or %EINVAL if the input SID is invalid.
  */
-int avc_sid_to_context(security_id_t sid, security_context_t * ctx);
-int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx);
+int avc_sid_to_context(security_id_t sid, char ** ctx);
+int avc_sid_to_context_raw(security_id_t sid, char ** ctx);
 
 /**
  * avc_context_to_sid - get SID for context.
@@ -51,8 +51,8 @@ int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx);
  * to the SID structure into the memory referenced by @sid, 
  * returning %0 on success or -%1 on error with @errno set.  
  */
-int avc_context_to_sid(const security_context_t ctx, security_id_t * sid);
-int avc_context_to_sid_raw(const security_context_t ctx, security_id_t * sid);
+int avc_context_to_sid(const char * ctx, security_id_t * sid);
+int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
 
 /**
  * sidget - increment SID reference counter.
diff --git a/libselinux/include/selinux/get_context_list.h b/libselinux/include/selinux/get_context_list.h
index f678c18..8bd8f99 100644
--- a/libselinux/include/selinux/get_context_list.h
+++ b/libselinux/include/selinux/get_context_list.h
@@ -17,15 +17,15 @@ extern "C" {
    If 'fromcon' is NULL, defaults to current context.
    Caller must free via freeconary. */
 	extern int get_ordered_context_list(const char *user,
-					    security_context_t fromcon,
-					    security_context_t ** list);
+					    char * fromcon,
+					    char *** list);
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
 	int get_ordered_context_list_with_level(const char *user,
 						const char *level,
-						security_context_t fromcon,
-						security_context_t ** list);
+						char * fromcon,
+						char *** list);
 
 /* Get the default security context for a user session for 'user'
    spawned by 'fromcon' and set *newcon to refer to it.  The context
@@ -35,23 +35,23 @@ extern "C" {
    Returns 0 on success or -1 otherwise.
    Caller must free via freecon. */
 	extern int get_default_context(const char *user,
-				       security_context_t fromcon,
-				       security_context_t * newcon);
+				       char * fromcon,
+				       char ** newcon);
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
 	int get_default_context_with_level(const char *user,
 					   const char *level,
-					   security_context_t fromcon,
-					   security_context_t * newcon);
+					   char * fromcon,
+					   char ** newcon);
 
 /* Same as get_default_context, but only return a context
    that has the specified role.  If no reachable context exists
    for the user with that role, then return -1. */
 	int get_default_context_with_role(const char *user,
 					  const char *role,
-					  security_context_t fromcon,
-					  security_context_t * newcon);
+					  char * fromcon,
+					  char ** newcon);
 
 /* Same as get_default_context, but only return a context
    that has the specified role and level.  If no reachable context exists
@@ -59,22 +59,22 @@ extern "C" {
 	int get_default_context_with_rolelevel(const char *user,
 					       const char *level,
 					       const char *role,
-					       security_context_t fromcon,
-					       security_context_t * newcon);
+					       char * fromcon,
+					       char ** newcon);
 
 /* Given a list of authorized security contexts for the user, 
    query the user to select one and set *newcon to refer to it.
    Caller must free via freecon.
    Returns 0 on sucess or -1 otherwise. */
-	extern int query_user_context(security_context_t * list,
-				      security_context_t * newcon);
+	extern int query_user_context(char ** list,
+				      char ** newcon);
 
 /* Allow the user to manually enter a context as a fallback
    if a list of authorized contexts could not be obtained. 
    Caller must free via freecon.
    Returns 0 on success or -1 otherwise. */
 	extern int manual_user_enter_context(const char *user,
-					     security_context_t * newcon);
+					     char ** newcon);
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 8263f32..c63ea7d 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -92,9 +92,9 @@ void selabel_close(struct selabel_handle *handle);
  * The result is returned in the memory pointed to by @con and must be freed
  * by the user with freecon().
  */
-int selabel_lookup(struct selabel_handle *handle, security_context_t *con,
+int selabel_lookup(struct selabel_handle *handle, char **con,
 		   const char *key, int type);
-int selabel_lookup_raw(struct selabel_handle *handle, security_context_t *con,
+int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 		       const char *key, int type);
 
 /**
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 00fb54d..d0eb5c6 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -13,20 +13,21 @@ extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
 extern int is_selinux_mls_enabled(void);
 
+/* No longer used; here for compatibility with legacy callers. */
 typedef char *security_context_t;
 
 /* Free the memory allocated for a context by any of the below get* calls. */
-extern void freecon(security_context_t con);
+extern void freecon(char * con);
 
 /* Free the memory allocated for a context array by security_compute_user. */
-extern void freeconary(security_context_t * con);
+extern void freeconary(char ** con);
 
 /* Wrappers for the /proc/pid/attr API. */
 
 /* Get current context, and set *con to refer to it.
    Caller must free via freecon. */
-extern int getcon(security_context_t * con);
-extern int getcon_raw(security_context_t * con);
+extern int getcon(char ** con);
+extern int getcon_raw(char ** con);
 
 /* Set the current security context to con.  
    Note that use of this function requires that the entire application
@@ -36,88 +37,88 @@ extern int getcon_raw(security_context_t * con);
    instead. Note that the application may lose access to its open descriptors
    as a result of a setcon() unless policy allows it to use descriptors opened
    by the old context. */
-extern int setcon(const security_context_t con);
-extern int setcon_raw(const security_context_t con);
+extern int setcon(const char * con);
+extern int setcon_raw(const char * con);
 
 /* Get context of process identified by pid, and 
    set *con to refer to it.  Caller must free via freecon. */
-extern int getpidcon(pid_t pid, security_context_t * con);
-extern int getpidcon_raw(pid_t pid, security_context_t * con);
+extern int getpidcon(pid_t pid, char ** con);
+extern int getpidcon_raw(pid_t pid, char ** con);
 
 /* Get previous context (prior to last exec), and set *con to refer to it.
    Caller must free via freecon. */
-extern int getprevcon(security_context_t * con);
-extern int getprevcon_raw(security_context_t * con);
+extern int getprevcon(char ** con);
+extern int getprevcon_raw(char ** con);
 
 /* Get exec context, and set *con to refer to it.
    Sets *con to NULL if no exec context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
-extern int getexeccon(security_context_t * con);
-extern int getexeccon_raw(security_context_t * con);
+extern int getexeccon(char ** con);
+extern int getexeccon_raw(char ** con);
 
 /* Set exec security context for the next execve. 
    Call with NULL if you want to reset to the default. */
-extern int setexeccon(const security_context_t con);
-extern int setexeccon_raw(const security_context_t con);
+extern int setexeccon(const char * con);
+extern int setexeccon_raw(const char * con);
 
 /* Get fscreate context, and set *con to refer to it.
    Sets *con to NULL if no fs create context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
-extern int getfscreatecon(security_context_t * con);
-extern int getfscreatecon_raw(security_context_t * con);
+extern int getfscreatecon(char ** con);
+extern int getfscreatecon_raw(char ** con);
 
 /* Set the fscreate security context for subsequent file creations.
    Call with NULL if you want to reset to the default. */
-extern int setfscreatecon(const security_context_t context);
-extern int setfscreatecon_raw(const security_context_t context);
+extern int setfscreatecon(const char * context);
+extern int setfscreatecon_raw(const char * context);
 
 /* Get keycreate context, and set *con to refer to it.
    Sets *con to NULL if no key create context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
-extern int getkeycreatecon(security_context_t * con);
-extern int getkeycreatecon_raw(security_context_t * con);
+extern int getkeycreatecon(char ** con);
+extern int getkeycreatecon_raw(char ** con);
 
 /* Set the keycreate security context for subsequent key creations.
    Call with NULL if you want to reset to the default. */
-extern int setkeycreatecon(const security_context_t context);
-extern int setkeycreatecon_raw(const security_context_t context);
+extern int setkeycreatecon(const char * context);
+extern int setkeycreatecon_raw(const char * context);
 
 /* Get sockcreate context, and set *con to refer to it.
    Sets *con to NULL if no socket create context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
-extern int getsockcreatecon(security_context_t * con);
-extern int getsockcreatecon_raw(security_context_t * con);
+extern int getsockcreatecon(char ** con);
+extern int getsockcreatecon_raw(char ** con);
 
 /* Set the sockcreate security context for subsequent socket creations.
    Call with NULL if you want to reset to the default. */
-extern int setsockcreatecon(const security_context_t context);
-extern int setsockcreatecon_raw(const security_context_t context);
+extern int setsockcreatecon(const char * context);
+extern int setsockcreatecon_raw(const char * context);
 
 /* Wrappers for the xattr API. */
 
 /* Get file context, and set *con to refer to it.
    Caller must free via freecon. */
-extern int getfilecon(const char *path, security_context_t * con);
-extern int getfilecon_raw(const char *path, security_context_t * con);
-extern int lgetfilecon(const char *path, security_context_t * con);
-extern int lgetfilecon_raw(const char *path, security_context_t * con);
-extern int fgetfilecon(int fd, security_context_t * con);
-extern int fgetfilecon_raw(int fd, security_context_t * con);
+extern int getfilecon(const char *path, char ** con);
+extern int getfilecon_raw(const char *path, char ** con);
+extern int lgetfilecon(const char *path, char ** con);
+extern int lgetfilecon_raw(const char *path, char ** con);
+extern int fgetfilecon(int fd, char ** con);
+extern int fgetfilecon_raw(int fd, char ** con);
 
 /* Set file context */
-extern int setfilecon(const char *path, security_context_t con);
-extern int setfilecon_raw(const char *path, security_context_t con);
-extern int lsetfilecon(const char *path, security_context_t con);
-extern int lsetfilecon_raw(const char *path, security_context_t con);
-extern int fsetfilecon(int fd, security_context_t con);
-extern int fsetfilecon_raw(int fd, security_context_t con);
+extern int setfilecon(const char *path, const char * con);
+extern int setfilecon_raw(const char *path, const char * con);
+extern int lsetfilecon(const char *path, const char * con);
+extern int lsetfilecon_raw(const char *path, const char * con);
+extern int fsetfilecon(int fd, const char * con);
+extern int fsetfilecon_raw(int fd, const char * con);
 
 /* Wrappers for the socket API */
 
 /* Get context of peer socket, and set *con to refer to it.
    Caller must free via freecon. */
-extern int getpeercon(int fd, security_context_t * con);
-extern int getpeercon_raw(int fd, security_context_t * con);
+extern int getpeercon(int fd, char ** con);
+extern int getpeercon_raw(int fd, char ** con);
 
 /* Wrappers for the selinuxfs (policy) API. */
 
@@ -156,7 +157,7 @@ __attribute__ ((format(printf, 2, 3)))
 	int (*func_audit) (void *auditdata, security_class_t cls,
 			   char *msgbuf, size_t msgbufsize);
 	/* validate the supplied context, modifying if necessary */
-	int (*func_validate) (security_context_t *ctx);
+	int (*func_validate) (char **ctx);
 	/* netlink callback for setenforce message */
 	int (*func_setenforce) (int enforcing);
 	/* netlink callback for policyload message */
@@ -180,79 +181,79 @@ extern void selinux_set_callback(int type, union selinux_callback cb);
 #define SELINUX_TRANS_DIR	"/var/run/setrans"
 
 /* Compute an access decision. */
-extern int security_compute_av(const security_context_t scon,
-			       const security_context_t tcon,
+extern int security_compute_av(const char * scon,
+			       const char * tcon,
 			       security_class_t tclass,
 			       access_vector_t requested,
 			       struct av_decision *avd);
-extern int security_compute_av_raw(const security_context_t scon,
-				   const security_context_t tcon,
+extern int security_compute_av_raw(const char * scon,
+				   const char * tcon,
 				   security_class_t tclass,
 				   access_vector_t requested,
 				   struct av_decision *avd);
 
-extern int security_compute_av_flags(const security_context_t scon,
-				     const security_context_t tcon,
+extern int security_compute_av_flags(const char * scon,
+				     const char * tcon,
 				     security_class_t tclass,
 				     access_vector_t requested,
 				     struct av_decision *avd);
-extern int security_compute_av_flags_raw(const security_context_t scon,
-					 const security_context_t tcon,
+extern int security_compute_av_flags_raw(const char * scon,
+					 const char * tcon,
 					 security_class_t tclass,
 					 access_vector_t requested,
 					 struct av_decision *avd);
 
 /* Compute a labeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
-extern int security_compute_create(const security_context_t scon,
-				   const security_context_t tcon,
+extern int security_compute_create(const char * scon,
+				   const char * tcon,
 				   security_class_t tclass,
-				   security_context_t * newcon);
-extern int security_compute_create_raw(const security_context_t scon,
-				       const security_context_t tcon,
+				   char ** newcon);
+extern int security_compute_create_raw(const char * scon,
+				       const char * tcon,
 				       security_class_t tclass,
-				       security_context_t * newcon);
-extern int security_compute_create_name(const security_context_t scon,
-					const security_context_t tcon,
+				       char ** newcon);
+extern int security_compute_create_name(const char * scon,
+					const char * tcon,
 					security_class_t tclass,
 					const char *objname,
-					security_context_t * newcon);
-extern int security_compute_create_name_raw(const security_context_t scon,
-					    const security_context_t tcon,
+					char ** newcon);
+extern int security_compute_create_name_raw(const char * scon,
+					    const char * tcon,
 					    security_class_t tclass,
 					    const char *objname,
-					    security_context_t * newcon);
+					    char ** newcon);
 
 /* Compute a relabeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
-extern int security_compute_relabel(const security_context_t scon,
-				    const security_context_t tcon,
+extern int security_compute_relabel(const char * scon,
+				    const char * tcon,
 				    security_class_t tclass,
-				    security_context_t * newcon);
-extern int security_compute_relabel_raw(const security_context_t scon,
-					const security_context_t tcon,
+				    char ** newcon);
+extern int security_compute_relabel_raw(const char * scon,
+					const char * tcon,
 					security_class_t tclass,
-					security_context_t * newcon);
+					char ** newcon);
 
 /* Compute a polyinstantiation member decision and set *newcon to refer to it.
    Caller must free via freecon. */
-extern int security_compute_member(const security_context_t scon,
-				   const security_context_t tcon,
+extern int security_compute_member(const char * scon,
+				   const char * tcon,
 				   security_class_t tclass,
-				   security_context_t * newcon);
-extern int security_compute_member_raw(const security_context_t scon,
-				       const security_context_t tcon,
+				   char ** newcon);
+extern int security_compute_member_raw(const char * scon,
+				       const char * tcon,
 				       security_class_t tclass,
-				       security_context_t * newcon);
+				       char ** newcon);
 
 /* Compute the set of reachable user contexts and set *con to refer to 
    the NULL-terminated array of contexts.  Caller must free via freeconary. */
-extern int security_compute_user(const security_context_t scon,
+extern int security_compute_user(const char * scon,
 				 const char *username,
-				 security_context_t ** con);
-extern int security_compute_user_raw(const security_context_t scon,
+				 char *** con);
+extern int security_compute_user_raw(const char * scon,
 				     const char *username,
-				     security_context_t ** con);
+				     char *** con);
 
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
@@ -260,9 +261,9 @@ extern int security_load_policy(void *data, size_t len);
 /* Get the context of an initial kernel security identifier by name.  
    Caller must free via freecon */
 extern int security_get_initial_context(const char *name,
-					security_context_t * con);
+					char ** con);
 extern int security_get_initial_context_raw(const char *name,
-					    security_context_t * con);
+					    char ** con);
 
 /*
  * Make a policy image and load it.
@@ -312,14 +313,14 @@ extern int security_set_boolean_list(size_t boolcnt,
 extern int security_load_booleans(char *path);
 
 /* Check the validity of a security context. */
-extern int security_check_context(const security_context_t con);
-extern int security_check_context_raw(const security_context_t con);
+extern int security_check_context(const char * con);
+extern int security_check_context_raw(const char * con);
 
 /* Canonicalize a security context. */
-extern int security_canonicalize_context(const security_context_t con,
-					 security_context_t * canoncon);
-extern int security_canonicalize_context_raw(const security_context_t con,
-					     security_context_t * canoncon);
+extern int security_canonicalize_context(const char * con,
+					 char ** canoncon);
+extern int security_canonicalize_context_raw(const char * con,
+					     char ** canoncon);
 
 /* Get the enforce flag value. */
 extern int security_getenforce(void);
@@ -457,12 +458,12 @@ extern int realpath_not_final(const char *name, char *resolved_path);
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-			mode_t mode, security_context_t * con);
+			mode_t mode, char ** con);
 
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
 extern int matchpathcon_index(const char *path,
-			      mode_t mode, security_context_t * con);
+			      mode_t mode, char ** con);
 
 /* Maintain an association between an inode and a specification index,
    and check whether a conflicting specification is already associated
@@ -485,7 +486,7 @@ extern void matchpathcon_checkmatches(char *str);
 /* Match the specified media and against the media contexts 
    configuration and set *con to refer to the resulting context.
    Caller must free con via freecon. */
-extern int matchmediacon(const char *media, security_context_t * con);
+extern int matchmediacon(const char *media, char ** con);
 
 /*
   selinux_getenforcemode reads the /etc/selinux/config file and determines 
@@ -572,7 +573,7 @@ extern const char *selinux_path(void);
  * If auditing or logging is configured the appropriate callbacks will be called
  * and passed the auditdata field
  */
-extern int selinux_check_access(const security_context_t scon, const security_context_t tcon, const char *tclass, const char *perm, void *auditdata);
+extern int selinux_check_access(const char * scon, const char * tcon, const char *tclass, const char *perm, void *auditdata);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
@@ -581,7 +582,7 @@ extern int checkPasswdAccess(access_vector_t requested);
 
 /* Check if the tty_context is defined as a securetty
    Return 0 if secure, < 0 otherwise. */
-extern int selinux_check_securetty_context(const security_context_t tty_context);
+extern int selinux_check_securetty_context(const char * tty_context);
 
 /* Set the path to the selinuxfs mount point explicitly.
    Normally, this is determined automatically during libselinux 
@@ -606,24 +607,24 @@ extern int rpm_execcon(unsigned int verified,
 
 /* Returns whether a file context is customizable, and should not 
    be relabeled . */
-extern int is_context_customizable(const security_context_t scontext);
+extern int is_context_customizable(const char * scontext);
 
 /* Perform context translation between the human-readable format
    ("translated") and the internal system format ("raw"). 
    Caller must free the resulting context via freecon.  
    Returns -1 upon an error or 0 otherwise.
    If passed NULL, sets the returned context to NULL and returns 0. */
-extern int selinux_trans_to_raw_context(const security_context_t trans,
-					security_context_t * rawp);
-extern int selinux_raw_to_trans_context(const security_context_t raw,
-					security_context_t * transp);
+extern int selinux_trans_to_raw_context(const char * trans,
+					char ** rawp);
+extern int selinux_raw_to_trans_context(const char * raw,
+					char ** transp);
 
 /* Perform context translation between security contexts
    and display colors.  Returns a space-separated list of ten
    ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
    Caller must free the resulting string via free.
    Returns -1 upon an error or 0 otherwise. */
-extern int selinux_raw_context_to_color(const security_context_t raw,
+extern int selinux_raw_context_to_color(const char * raw,
 					char **color_str);
 
 /* Get the SELinux username and level to use for a given Linux username. 
@@ -642,8 +643,8 @@ extern int getseuser(const char *username, const char *service,
 		     char **r_seuser, char **r_level);
 
 /* Compare two file contexts, return 0 if equivalent. */
-extern int selinux_file_context_cmp(const security_context_t a,
-			     const security_context_t b);
+extern int selinux_file_context_cmp(const char * a,
+			     const char * b);
 
 /* 
  * Verify the context of the file 'path' against policy.
diff --git a/libselinux/man/man3/avc_context_to_sid.3 b/libselinux/man/man3/avc_context_to_sid.3
index e416b09..021ff37 100644
--- a/libselinux/man/man3/avc_context_to_sid.3
+++ b/libselinux/man/man3/avc_context_to_sid.3
@@ -10,9 +10,9 @@ avc_context_to_sid, avc_sid_to_context, avc_get_initial_sid \- obtain and manipu
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_context_to_sid(security_context_t " ctx ", security_id_t *" sid ");"
+.BI "int avc_context_to_sid(char * " ctx ", security_id_t *" sid ");"
 .sp
-.BI "int avc_sid_to_context(security_id_t " sid ", security_context_t *" ctx ");"
+.BI "int avc_sid_to_context(security_id_t " sid ", char **" ctx ");"
 .sp
 .BI "int avc_get_initial_sid(const char *" name ", security_id_t *" sid ");"
 .
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index 63cba81..b1dabb6 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -7,21 +7,21 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 .br
 .B #include <selinux/get_context_list.h>
 .sp
-.BI "int get_ordered_context_list(const char *" user ", security_context_t "fromcon ", security_context_t **" list );
+.BI "int get_ordered_context_list(const char *" user ", char * "fromcon ", char ***" list );
 .sp
-.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", security_context_t "fromcon ", security_context_t **" list );
+.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", char * "fromcon ", char ***" list );
 .sp
-.BI "int get_default_context(const char *" user ", security_context_t "fromcon ", security_context_t *" newcon );
+.BI "int get_default_context(const char *" user ", char * "fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_level(const char *" user ", const char *" level ", security_context_t "fromcon ", security_context_t *" newcon );
+.BI "int get_default_context_with_level(const char *" user ", const char *" level ", char * "fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_role(const char *" user ", const char *" role ", security_context_t " fromcon ", security_context_t *" newcon ");
+.BI "int get_default_context_with_role(const char *" user ", const char *" role ", char * " fromcon ", char **" newcon ");
 .sp
-.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" level ", const char *" role ", security_context_t " fromcon ", security_context_t *" newcon ");
+.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" level ", const char *" role ", char * " fromcon ", char **" newcon ");
 .sp
-.BI "int query_user_context(security_context_t *" list ", security_context_t *" newcon );
+.BI "int query_user_context(char **" list ", char **" newcon );
 .sp
-.BI "int manual_user_enter_context(const char *" user ", security_context_t *" newcon );
+.BI "int manual_user_enter_context(const char *" user ", char **" newcon );
 .sp
 .BI "int get_default_type(const char *" role ", char **" type );
 .
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index 239bb7d..fd0e02b 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -11,29 +11,29 @@ setcon \- set current security context of a process
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getcon(security_context_t *" context );
+.BI "int getcon(char **" context );
 .sp
-.BI "int getcon_raw(security_context_t *" context );
+.BI "int getcon_raw(char **" context );
 .sp
-.BI "int getprevcon(security_context_t *" context );
+.BI "int getprevcon(char **" context );
 .sp
-.BI "int getprevcon_raw(security_context_t *" context );
+.BI "int getprevcon_raw(char **" context );
 .sp
-.BI "int getpidcon(pid_t " pid ", security_context_t *" context );
+.BI "int getpidcon(pid_t " pid ", char **" context );
 .sp
-.BI "int getpidcon_raw(pid_t " pid ", security_context_t *" context );
+.BI "int getpidcon_raw(pid_t " pid ", char **" context );
 .sp
-.BI "int getpeercon(int " fd ", security_context_t *" context );
+.BI "int getpeercon(int " fd ", char **" context );
 .sp
-.BI "int getpeercon_raw(int " fd ", security_context_t *" context );
+.BI "int getpeercon_raw(int " fd ", char **" context );
 .sp
-.BI "void freecon(security_context_t "con );
+.BI "void freecon(char * "con );
 .sp
-.BI "void freeconary(security_context_t *" con );
+.BI "void freeconary(char **" con );
 .sp
-.BI "int setcon(security_context_t " context );
+.BI "int setcon(char * " context );
 .sp
-.BI "int setcon_raw(security_context_t " context );
+.BI "int setcon_raw(char * " context );
 .
 .SH "DESCRIPTION"
 .BR getcon ()
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index 1b66ab6..73c9e49 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -7,13 +7,13 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getexeccon(security_context_t *" context );
+.BI "int getexeccon(char **" context );
 .sp
-.BI "int getexeccon_raw(security_context_t *" context );
+.BI "int getexeccon_raw(char **" context );
 .sp
-.BI "int setexeccon(security_context_t "context );
+.BI "int setexeccon(char * "context );
 .sp
-.BI "int setexeccon_raw(security_context_t "context );
+.BI "int setexeccon_raw(char * "context );
 .sp
 .BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
 .sp
diff --git a/libselinux/man/man3/getfilecon.3 b/libselinux/man/man3/getfilecon.3
index ea79b31..5bb575b 100644
--- a/libselinux/man/man3/getfilecon.3
+++ b/libselinux/man/man3/getfilecon.3
@@ -5,17 +5,17 @@ getfilecon, fgetfilecon, lgetfilecon \- get SELinux security context of a file
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getfilecon(const char *" path ", security_context_t *" con );
+.BI "int getfilecon(const char *" path ", char **" con );
 .sp
-.BI "int getfilecon_raw(const char *" path ", security_context_t *" con );
+.BI "int getfilecon_raw(const char *" path ", char **" con );
 .sp
-.BI "int lgetfilecon(const char *" path ", security_context_t *" con );
+.BI "int lgetfilecon(const char *" path ", char **" con );
 .sp
-.BI "int lgetfilecon_raw(const char *" path ", security_context_t *" con );
+.BI "int lgetfilecon_raw(const char *" path ", char **" con );
 .sp
-.BI "int fgetfilecon(int "fd ", security_context_t *" con );
+.BI "int fgetfilecon(int "fd ", char **" con );
 .sp
-.BI "int fgetfilecon_raw(int "fd ", security_context_t *" con );
+.BI "int fgetfilecon_raw(int "fd ", char **" con );
 .
 .SH "DESCRIPTION"
 .BR getfilecon ()
diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index c7675be..e348d3b 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -5,13 +5,13 @@ getfscreatecon, setfscreatecon \- get or set the SELinux security context used f
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getfscreatecon(security_context_t *" con );
+.BI "int getfscreatecon(char **" con );
 .sp
-.BI "int getfscreatecon_raw(security_context_t *" con );
+.BI "int getfscreatecon_raw(char **" con );
 .sp
-.BI "int setfscreatecon(security_context_t "context );
+.BI "int setfscreatecon(char * "context );
 .sp
-.BI "int setfscreatecon_raw(security_context_t "context );
+.BI "int setfscreatecon_raw(char * "context );
 .
 .SH "DESCRIPTION"
 .BR getfscreatecon ()
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index d6a118c..4d70f10 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -5,13 +5,13 @@ getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getkeycreatecon(security_context_t *" con );
+.BI "int getkeycreatecon(char **" con );
 .sp
-.BI "int getkeycreatecon_raw(security_context_t *" con );
+.BI "int getkeycreatecon_raw(char **" con );
 .sp
-.BI "int setkeycreatecon(security_context_t "context );
+.BI "int setkeycreatecon(char * "context );
 .sp
-.BI "int setkeycreatecon_raw(security_context_t "context );
+.BI "int setkeycreatecon_raw(char * "context );
 .
 .SH "DESCRIPTION"
 .BR getkeycreatecon ()
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 99e9436..4dd8f30 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -5,13 +5,13 @@ getsockcreatecon, setsockcreatecon \- get or set the SELinux security context us
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getsockcreatecon(security_context_t *" con );
+.BI "int getsockcreatecon(char **" con );
 .sp
-.BI "int getsockcreatecon_raw(security_context_t *" con );
+.BI "int getsockcreatecon_raw(char **" con );
 .sp
-.BI "int setsockcreatecon(security_context_t "context );
+.BI "int setsockcreatecon(char * "context );
 .sp
-.BI "int setsockcreatecon_raw(security_context_t "context );
+.BI "int setsockcreatecon_raw(char * "context );
 .
 .SH "DESCRIPTION"
 .BR getsockcreatecon ()
diff --git a/libselinux/man/man3/is_context_customizable.3 b/libselinux/man/man3/is_context_customizable.3
index 0f748b6..7fed837 100644
--- a/libselinux/man/man3/is_context_customizable.3
+++ b/libselinux/man/man3/is_context_customizable.3
@@ -5,7 +5,7 @@ is_context_customizable \- check whether SELinux context type is customizable by
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int is_context_customizable(security_context_t " scon );
+.BI "int is_context_customizable(char * " scon );
 .
 .SH "DESCRIPTION"
 This function checks whether the type of scon is in the
diff --git a/libselinux/man/man3/matchmediacon.3 b/libselinux/man/man3/matchmediacon.3
index f77ab5e..187e1c1 100644
--- a/libselinux/man/man3/matchmediacon.3
+++ b/libselinux/man/man3/matchmediacon.3
@@ -5,7 +5,7 @@ matchmediacon \- get the default SELinux security context for the specified medi
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int matchmediacon(const char *" media ", security_context_t *" con );
+.BI "int matchmediacon(const char *" media ", char **" con );
 .
 .SH "DESCRIPTION"
 .BR matchmediacon ()
diff --git a/libselinux/man/man3/matchpathcon.3 b/libselinux/man/man3/matchpathcon.3
index 4c320ab..1bc7ba1 100644
--- a/libselinux/man/man3/matchpathcon.3
+++ b/libselinux/man/man3/matchpathcon.3
@@ -11,9 +11,9 @@ matchpathcon, matchpathcon_index \- get the default SELinux security context for
 .sp
 .BI "int matchpathcon_fini(void);"
 .sp
-.BI "int matchpathcon(const char *" path ", mode_t " mode ", security_context_t *" con ");
+.BI "int matchpathcon(const char *" path ", mode_t " mode ", char **" con ");
 .sp
-.BI "int matchpathcon_index(const char *" name ", mode_t " mode ", security_context_t *" con ");"
+.BI "int matchpathcon_index(const char *" name ", mode_t " mode ", char **" con ");"
 .
 .SH "DESCRIPTION"
 .BR matchpathcon_init ()
diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index 7ba4ead..8ece48c 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -5,9 +5,9 @@ security_check_context \- check the validity of a SELinux context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_check_context(security_context_t "con );
+.BI "int security_check_context(char * "con );
 .sp
-.BI "int security_check_context_raw(security_context_t "con );
+.BI "int security_check_context_raw(char * "con );
 .
 .SH "DESCRIPTION"
 .BR security_check_context ()
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index de62d26..04e7a0d 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -9,39 +9,39 @@ the SELinux policy database in the kernel
 .br
 .B #include <selinux/flask.h>
 .sp
-.BI "int security_compute_av(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_create(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_create(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_create_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_name(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", const char *"objname ", security_context_t *" newcon );
+.BI "int security_compute_create_name(char * "scon ", char * "tcon ", security_class_t "tclass ", const char *"objname ", char **" newcon );
 .sp
-.BI "int security_compute_create_name_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", const char *"objname ", security_context_t *" newcon );
+.BI "int security_compute_create_name_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", const char *"objname ", char **" newcon );
 .sp
-.BI "int security_compute_relabel(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_relabel(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_relabel_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_relabel_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_member(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.BI "int security_compute_member_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_user(security_context_t "scon ", const char *" username ", security_context_t **" con );
+.BI "int security_compute_user(char * "scon ", const char *" username ", char ***" con );
 .sp
-.BI "int security_compute_user_raw(security_context_t "scon ", const char *" username ", security_context_t **" con );
+.BI "int security_compute_user_raw(char * "scon ", const char *" username ", char ***" con );
 .sp
-.BI "int security_get_initial_context(const char *" name ", security_context_t *" con );
+.BI "int security_get_initial_context(const char *" name ", char **" con );
 .sp
-.BI "int security_get_initial_context_raw(const char *" name ", security_context_t *" con );
+.BI "int security_get_initial_context_raw(const char *" name ", char **" con );
 .sp
-.BI "int selinux_check_access(const security_context_t " scon ", const security_context_t " tcon ", const char *" class ", const char *" perm ", void *" auditdata);
+.BI "int selinux_check_access(const char * " scon ", const char * " tcon ", const char *" class ", const char *" perm ", void *" auditdata);
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp
diff --git a/libselinux/man/man3/selabel_lookup.3 b/libselinux/man/man3/selabel_lookup.3
index 08b3161..4e47c3e 100644
--- a/libselinux/man/man3/selabel_lookup.3
+++ b/libselinux/man/man3/selabel_lookup.3
@@ -12,14 +12,14 @@ selabel_lookup \- obtain SELinux security context from a string label
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" key ", int " type ");"
 .in
 .sp
 .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup_raw('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" key ", int " type ");"
 .in
diff --git a/libselinux/man/man3/selinux_check_securetty_context.3 b/libselinux/man/man3/selinux_check_securetty_context.3
index 22e8533..05f2344 100644
--- a/libselinux/man/man3/selinux_check_securetty_context.3
+++ b/libselinux/man/man3/selinux_check_securetty_context.3
@@ -5,7 +5,7 @@ selinux_check_securetty_context \- check whether a SELinux tty security context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_check_securetty_context(security_context_t "tty_context );
+.BI "int selinux_check_securetty_context(char * "tty_context );
 .
 .SH "DESCRIPTION"
 .BR selinux_check_securetty_context ()
diff --git a/libselinux/man/man3/selinux_file_context_cmp.3 b/libselinux/man/man3/selinux_file_context_cmp.3
index 30bbaa3..f7cd7ec 100644
--- a/libselinux/man/man3/selinux_file_context_cmp.3
+++ b/libselinux/man/man3/selinux_file_context_cmp.3
@@ -5,9 +5,9 @@ selinux_file_context_cmp \- Compare two SELinux security contexts excluding the
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_file_context_cmp(const security_context_t " a ", "
+.BI "int selinux_file_context_cmp(const char * " a ", "
 .RS
-.BI "const security_context_t " b ");"
+.BI "const char * " b ");"
 .RE
 .
 .SH "DESCRIPTION"
diff --git a/libselinux/man/man3/selinux_raw_context_to_color.3 b/libselinux/man/man3/selinux_raw_context_to_color.3
index 3737f60..530e876 100644
--- a/libselinux/man/man3/selinux_raw_context_to_color.3
+++ b/libselinux/man/man3/selinux_raw_context_to_color.3
@@ -5,7 +5,7 @@ selinux_raw_context_to_color \- Return RGB color string for an SELinux security
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_raw_context_to_color(security_context_t " raw ", "
+.BI "int selinux_raw_context_to_color(char * " raw ", "
 .RS
 .BI "char **" color_str ");"
 .RE
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 073e135..a4c613a 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -68,7 +68,7 @@ characters.
 .
 .TP
 .B SELINUX_CB_VALIDATE
-.BI "int (*" func_validate ") (security_context_t *" ctx ");"
+.BI "int (*" func_validate ") (char **" ctx ");"
 
 This callback is used for context validation.  The callback may optionally modify the input context by setting the target of the 
 .I ctx
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 5acc9bb..9fe8997 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -5,17 +5,17 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int setfilecon(const char *" path ", security_context_t "con );
+.BI "int setfilecon(const char *" path ", char * "con );
 .sp
-.BI "int setfilecon_raw(const char *" path ", security_context_t "con );
+.BI "int setfilecon_raw(const char *" path ", char * "con );
 .sp
-.BI "int lsetfilecon(const char *" path ", security_context_t "con );
+.BI "int lsetfilecon(const char *" path ", char * "con );
 .sp
-.BI "int lsetfilecon_raw(const char *" path ", security_context_t "con );
+.BI "int lsetfilecon_raw(const char *" path ", char * "con );
 .sp
-.BI "int fsetfilecon(int "fd ", security_context_t "con );
+.BI "int fsetfilecon(int "fd ", char * "con );
 .sp
-.BI "int fsetfilecon_raw(int "fd ", security_context_t "con );
+.BI "int fsetfilecon_raw(int "fd ", char * "con );
 .
 .SH "DESCRIPTION"
 .BR setfilecon ()
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
index b3342f6..51b5848 100644
--- a/libselinux/man/man5/selabel_db.5
+++ b/libselinux/man/man5/selabel_db.5
@@ -10,14 +10,14 @@ selabel_db \- userspace SELinux labeling interface and configuration file format
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" object_name ", int " object_type ");"
 .in
 .sp
 .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" object_name ", int " object_type ");"
 .
diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 5703f27..79eca95 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -10,14 +10,14 @@ selabel_file \- userspace SELinux labeling interface and configuration file form
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" path ", int " mode ");"
 .in
 .sp
 .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" path ", int " mode ");"
 .
diff --git a/libselinux/man/man5/selabel_media.5 b/libselinux/man/man5/selabel_media.5
index 398f0fc..395ed0e 100644
--- a/libselinux/man/man5/selabel_media.5
+++ b/libselinux/man/man5/selabel_media.5
@@ -10,14 +10,14 @@ selabel_media \- userspace SELinux labeling interface and configuration file for
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" device_name ", int " unused ");"
 .in
 .sp
 .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" device_name ", int " unused ");"
 .
diff --git a/libselinux/man/man5/selabel_x.5 b/libselinux/man/man5/selabel_x.5
index 5a38a8d..198a3e1 100644
--- a/libselinux/man/man5/selabel_x.5
+++ b/libselinux/man/man5/selabel_x.5
@@ -10,14 +10,14 @@ selabel_x \- userspace SELinux labeling interface and configuration file format
 .sp
 .BI "int selabel_lookup(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" object_name ", int " object_type ");"
 .in
 .sp
 .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
 .in +\w'int selabel_lookup('u
-.BI "security_context_t *" context ,
+.BI "char **" context ,
 .br
 .BI "const char *" object_name ", int " object_type ");"
 .
diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index ec946bb..c91b65e 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -300,8 +300,8 @@ static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
 
 static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args) {
 	char *reason_buf = NULL;
-	security_context_t scon; 
-	security_context_t tcon;
+	char * scon;
+	char * tcon;
 	char *tclassstr; 
 	PyObject *listObj;
 	PyObject *strObj;
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 1f7aca9..2bd7d13 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -67,7 +67,7 @@ static inline int avc_hash(security_id_t ssid,
 	    & (AVC_CACHE_SLOTS - 1);
 }
 
-int avc_context_to_sid_raw(const security_context_t ctx, security_id_t * sid)
+int avc_context_to_sid_raw(const char * ctx, security_id_t * sid)
 {
 	int rc;
 	/* avc_init needs to be called before this function */
@@ -79,10 +79,10 @@ int avc_context_to_sid_raw(const security_context_t ctx, security_id_t * sid)
 	return rc;
 }
 
-int avc_context_to_sid(const security_context_t ctx, security_id_t * sid)
+int avc_context_to_sid(const char * ctx, security_id_t * sid)
 {
 	int ret;
-	security_context_t rctx;
+	char * rctx;
 
 	if (selinux_trans_to_raw_context(ctx, &rctx))
 		return -1;
@@ -94,7 +94,7 @@ int avc_context_to_sid(const security_context_t ctx, security_id_t * sid)
 	return ret;
 }
 
-int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx)
+int avc_sid_to_context_raw(security_id_t sid, char ** ctx)
 {
 	int rc;
 	*ctx = NULL;
@@ -105,10 +105,10 @@ int avc_sid_to_context_raw(security_id_t sid, security_context_t * ctx)
 	return rc;
 }
 
-int avc_sid_to_context(security_id_t sid, security_context_t * ctx)
+int avc_sid_to_context(security_id_t sid, char ** ctx)
 {
 	int ret;
-	security_context_t rctx;
+	char * rctx;
 
 	ret = avc_sid_to_context_raw(sid, &rctx);
 
@@ -133,7 +133,7 @@ int sidput(security_id_t sid __attribute__((unused)))
 int avc_get_initial_sid(const char * name, security_id_t * sid)
 {
 	int rc;
-	security_context_t con;
+	char * con;
 
 	rc = security_get_initial_context_raw(name, &con);
 	if (rc < 0)
@@ -843,7 +843,7 @@ int avc_compute_create(security_id_t ssid,  security_id_t tsid,
 	int rc;
 	struct avc_entry_ref aeref;
 	struct avc_entry entry;
-	security_context_t ctx;
+	char * ctx;
 
 	*newsid = NULL;
 	avc_entry_ref_init(&aeref);
@@ -891,7 +891,7 @@ int avc_compute_member(security_id_t ssid,  security_id_t tsid,
 		       security_class_t tclass, security_id_t *newsid)
 {
 	int rc;
-	security_context_t ctx = NULL;
+	char * ctx = NULL;
 	*newsid = NULL;
 	/* avc_init needs to be called before this function */
 	assert(avc_running);
diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 0b696bb..52f21df 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -13,7 +13,7 @@
 #include "avc_sidtab.h"
 #include "avc_internal.h"
 
-static inline unsigned sidtab_hash(security_context_t key)
+static inline unsigned sidtab_hash(const char * key)
 {
 	char *p, *keyp;
 	unsigned int size;
@@ -46,18 +46,18 @@ int sidtab_init(struct sidtab *s)
 	return rc;
 }
 
-int sidtab_insert(struct sidtab *s, const security_context_t ctx)
+int sidtab_insert(struct sidtab *s, const char * ctx)
 {
 	int hvalue, rc = 0;
 	struct sidtab_node *newnode;
-	security_context_t newctx;
+	char * newctx;
 
 	newnode = (struct sidtab_node *)avc_malloc(sizeof(*newnode));
 	if (!newnode) {
 		rc = -1;
 		goto out;
 	}
-	newctx = (security_context_t) strdup(ctx);
+	newctx = (char *) strdup(ctx);
 	if (!newctx) {
 		rc = -1;
 		avc_free(newnode);
@@ -76,7 +76,7 @@ int sidtab_insert(struct sidtab *s, const security_context_t ctx)
 
 int
 sidtab_context_to_sid(struct sidtab *s,
-		      const security_context_t ctx, security_id_t * sid)
+		      const char * ctx, security_id_t * sid)
 {
 	int hvalue, rc = 0;
 	struct sidtab_node *cur;
diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
index 29b5d8b..bce9b87 100644
--- a/libselinux/src/avc_sidtab.h
+++ b/libselinux/src/avc_sidtab.h
@@ -25,10 +25,10 @@ struct sidtab {
 };
 
 int sidtab_init(struct sidtab *s) hidden;
-int sidtab_insert(struct sidtab *s, security_context_t ctx) hidden;
+int sidtab_insert(struct sidtab *s, const char * ctx) hidden;
 
 int sidtab_context_to_sid(struct sidtab *s,
-			  security_context_t ctx, security_id_t * sid) hidden;
+			  const char * ctx, security_id_t * sid) hidden;
 
 void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) hidden;
 void sidtab_destroy(struct sidtab *s) hidden;
diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index 7c47222..cdf7b63 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -33,7 +33,7 @@ default_selinux_audit(void *ptr __attribute__((unused)),
 }
 
 static int
-default_selinux_validate(security_context_t *ctx)
+default_selinux_validate(char **ctx)
 {
 	return security_check_context(*ctx);
 }
@@ -60,7 +60,7 @@ int
 	default_selinux_audit;
 
 int
-(*selinux_validate)(security_context_t *ctx) =
+(*selinux_validate)(char **ctx) =
 	default_selinux_validate;
 
 int
diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index 52ad555..2a572e0 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -19,7 +19,7 @@ extern int
 (*selinux_audit) (void *, security_class_t, char *, size_t) hidden;
 
 extern int
-(*selinux_validate)(security_context_t *ctx) hidden;
+(*selinux_validate)(char **ctx) hidden;
 
 extern int
 (*selinux_netlink_setenforce) (int enforcing) hidden;
diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index 176c45a..7cf3139 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -9,8 +9,8 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_canonicalize_context_raw(const security_context_t con,
-				      security_context_t * canoncon)
+int security_canonicalize_context_raw(const char * con,
+				      char ** canoncon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -62,12 +62,12 @@ int security_canonicalize_context_raw(const security_context_t con,
 
 hidden_def(security_canonicalize_context_raw)
 
-int security_canonicalize_context(const security_context_t con,
-				  security_context_t * canoncon)
+int security_canonicalize_context(const char * con,
+				      char ** canoncon)
 {
 	int ret;
-	security_context_t rcon;
-	security_context_t rcanoncon;
+	char * rcon;
+	char * rcanoncon;
 
 	if (selinux_trans_to_raw_context(con, &rcon))
 		return -1;
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index aaebb94..4d70ebe 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -15,7 +15,7 @@ static void avc_init_once(void)
 	avc_open(NULL, 0);
 }
 
-int selinux_check_access(const security_context_t scon, const security_context_t tcon, const char *class, const char *perm, void *aux) {
+int selinux_check_access(const char *scon, const char *tcon, const char *class, const char *perm, void *aux) {
 	int rc;
 	security_id_t scon_id;
 	security_id_t tcon_id;
@@ -59,7 +59,7 @@ int selinux_check_access(const security_context_t scon, const security_context_t
 int selinux_check_passwd_access(access_vector_t requested)
 {
 	int status = -1;
-	security_context_t user_context;
+	char *user_context;
 	if (is_selinux_enabled() == 0)
 		return 0;
 	if (getprevcon_raw(&user_context) == 0) {
diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
index 33ab5e3..52063fa 100644
--- a/libselinux/src/check_context.c
+++ b/libselinux/src/check_context.c
@@ -9,7 +9,7 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_check_context_raw(const security_context_t con)
+int security_check_context_raw(const char * con)
 {
 	char path[PATH_MAX];
 	int fd, ret;
@@ -33,10 +33,10 @@ int security_check_context_raw(const security_context_t con)
 
 hidden_def(security_check_context_raw)
 
-int security_check_context(const security_context_t con)
+int security_check_context(const char * con)
 {
 	int ret;
-	security_context_t rcon;
+	char * rcon;
 
 	if (selinux_trans_to_raw_context(con, &rcon))
 		return -1;
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 5962c0b..937e5c3 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -10,8 +10,8 @@
 #include "policy.h"
 #include "mapping.h"
 
-int security_compute_av_flags_raw(const security_context_t scon,
-				  const security_context_t tcon,
+int security_compute_av_flags_raw(const char * scon,
+				  const char * tcon,
 				  security_class_t tclass,
 				  access_vector_t requested,
 				  struct av_decision *avd)
@@ -74,8 +74,8 @@ int security_compute_av_flags_raw(const security_context_t scon,
 
 hidden_def(security_compute_av_flags_raw)
 
-int security_compute_av_raw(const security_context_t scon,
-			    const security_context_t tcon,
+int security_compute_av_raw(const char * scon,
+			    const char * tcon,
 			    security_class_t tclass,
 			    access_vector_t requested,
 			    struct av_decision *avd)
@@ -101,14 +101,14 @@ int security_compute_av_raw(const security_context_t scon,
 
 hidden_def(security_compute_av_raw)
 
-int security_compute_av_flags(const security_context_t scon,
-			      const security_context_t tcon,
+int security_compute_av_flags(const char * scon,
+			      const char * tcon,
 			      security_class_t tclass,
 			      access_vector_t requested,
 			      struct av_decision *avd)
 {
-	security_context_t rscon;
-	security_context_t rtcon;
+	char * rscon;
+	char * rtcon;
 	int ret;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
@@ -128,8 +128,8 @@ int security_compute_av_flags(const security_context_t scon,
 
 hidden_def(security_compute_av_flags)
 
-int security_compute_av(const security_context_t scon,
-			const security_context_t tcon,
+int security_compute_av(const char * scon,
+			const char * tcon,
 			security_class_t tclass,
 			access_vector_t requested, struct av_decision *avd)
 {
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 3c05be3..9559d42 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -48,11 +48,11 @@ static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 	return 0;
 }
 
-int security_compute_create_name_raw(const security_context_t scon,
-				     const security_context_t tcon,
+int security_compute_create_name_raw(const char * scon,
+				     const char * tcon,
 				     security_class_t tclass,
 				     const char *objname,
-				     security_context_t * newcon)
+				     char ** newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -107,26 +107,26 @@ int security_compute_create_name_raw(const security_context_t scon,
 }
 hidden_def(security_compute_create_name_raw)
 
-int security_compute_create_raw(const security_context_t scon,
-				const security_context_t tcon,
+int security_compute_create_raw(const char * scon,
+				const char * tcon,
 				security_class_t tclass,
-				security_context_t * newcon)
+				char ** newcon)
 {
 	return security_compute_create_name_raw(scon, tcon, tclass,
 						NULL, newcon);
 }
 hidden_def(security_compute_create_raw)
 
-int security_compute_create_name(const security_context_t scon,
-				 const security_context_t tcon,
+int security_compute_create_name(const char * scon,
+				 const char * tcon,
 				 security_class_t tclass,
 				 const char *objname,
-				 security_context_t * newcon)
+				 char ** newcon)
 {
 	int ret;
-	security_context_t rscon;
-	security_context_t rtcon;
-	security_context_t rnewcon;
+	char * rscon;
+	char * rtcon;
+	char * rnewcon;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
@@ -148,10 +148,10 @@ int security_compute_create_name(const security_context_t scon,
 }
 hidden_def(security_compute_create_name)
 
-int security_compute_create(const security_context_t scon,
-			    const security_context_t tcon,
+int security_compute_create(const char * scon,
+				const char * tcon,
 			    security_class_t tclass,
-			    security_context_t * newcon)
+				char ** newcon)
 {
 	return security_compute_create_name(scon, tcon, tclass, NULL, newcon);
 }
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index dad0a77..1fc7e41 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -10,10 +10,10 @@
 #include "policy.h"
 #include "mapping.h"
 
-int security_compute_member_raw(const security_context_t scon,
-				const security_context_t tcon,
+int security_compute_member_raw(const char * scon,
+				const char * tcon,
 				security_class_t tclass,
-				security_context_t * newcon)
+				char ** newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -62,15 +62,15 @@ int security_compute_member_raw(const security_context_t scon,
 
 hidden_def(security_compute_member_raw)
 
-int security_compute_member(const security_context_t scon,
-			    const security_context_t tcon,
+int security_compute_member(const char * scon,
+			    const char * tcon,
 			    security_class_t tclass,
-			    security_context_t * newcon)
+			    char ** newcon)
 {
 	int ret;
-	security_context_t rscon;
-	security_context_t rtcon;
-	security_context_t rnewcon;
+	char * rscon;
+	char * rtcon;
+	char * rnewcon;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index 656f00a..4615aee 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -10,10 +10,10 @@
 #include "policy.h"
 #include "mapping.h"
 
-int security_compute_relabel_raw(const security_context_t scon,
-				 const security_context_t tcon,
+int security_compute_relabel_raw(const char * scon,
+				 const char * tcon,
 				 security_class_t tclass,
-				 security_context_t * newcon)
+				 char ** newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -62,15 +62,15 @@ int security_compute_relabel_raw(const security_context_t scon,
 
 hidden_def(security_compute_relabel_raw)
 
-int security_compute_relabel(const security_context_t scon,
-			     const security_context_t tcon,
+int security_compute_relabel(const char * scon,
+			     const char * tcon,
 			     security_class_t tclass,
-			     security_context_t * newcon)
+			     char ** newcon)
 {
 	int ret;
-	security_context_t rscon;
-	security_context_t rtcon;
-	security_context_t rnewcon;
+	char * rscon;
+	char * rtcon;
+	char * rnewcon;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index 3b39ddd..b37c5d3 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -9,8 +9,8 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_user_raw(const security_context_t scon,
-			      const char *user, security_context_t ** con)
+int security_compute_user_raw(const char * scon,
+			      const char *user, char *** con)
 {
 	char path[PATH_MAX];
 	char **ary;
@@ -79,11 +79,11 @@ int security_compute_user_raw(const security_context_t scon,
 
 hidden_def(security_compute_user_raw)
 
-int security_compute_user(const security_context_t scon,
-			  const char *user, security_context_t ** con)
+int security_compute_user(const char * scon,
+			  const char *user, char *** con)
 {
 	int ret;
-	security_context_t rscon;
+	char * rscon;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
@@ -92,7 +92,7 @@ int security_compute_user(const security_context_t scon,
 
 	freecon(rscon);
 	if (!ret) {
-		security_context_t *ptr, tmpcon;
+		char **ptr, *tmpcon;
 		for (ptr = *con; *ptr; ptr++) {
 			if (selinux_raw_to_trans_context(*ptr, &tmpcon)) {
 				freeconary(*con);
diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index 018c787..5c252dd 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -12,7 +12,7 @@
 int is_selinux_enabled(void)
 {
 	int enabled = 0;
-	security_context_t con;
+	char * con;
 
 	/* init_selinuxmnt() gets called before this function. We
  	 * will assume that if a selinux file system is mounted, then
diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index 3395c9f..3954e64 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -7,7 +7,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-int fgetfilecon_raw(int fd, security_context_t * context)
+int fgetfilecon_raw(int fd, char ** context)
 {
 	char *buf;
 	ssize_t size;
@@ -51,9 +51,9 @@ int fgetfilecon_raw(int fd, security_context_t * context)
 
 hidden_def(fgetfilecon_raw)
 
-int fgetfilecon(int fd, security_context_t * context)
+int fgetfilecon(int fd, char ** context)
 {
-	security_context_t rcontext;
+	char * rcontext;
 	int ret;
 
 	*context = NULL;
diff --git a/libselinux/src/freecon.c b/libselinux/src/freecon.c
index 3ec4fe2..5290dfa 100644
--- a/libselinux/src/freecon.c
+++ b/libselinux/src/freecon.c
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <errno.h>
 
-void freecon(security_context_t con)
+void freecon(char * con)
 {
 	free(con);
 }
diff --git a/libselinux/src/freeconary.c b/libselinux/src/freeconary.c
index 835f5bc..8d07718 100644
--- a/libselinux/src/freeconary.c
+++ b/libselinux/src/freeconary.c
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <errno.h>
 
-void freeconary(security_context_t * con)
+void freeconary(char ** con)
 {
 	char **ptr;
 
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index 9963f7a..52707d0 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -7,12 +7,12 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-int fsetfilecon_raw(int fd, const security_context_t context)
+int fsetfilecon_raw(int fd, const char * context)
 {
 	int rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
 			 0);
 	if (rc < 0 && errno == ENOTSUP) {
-		security_context_t ccontext = NULL;
+		char * ccontext = NULL;
 		int err = errno;
 		if ((fgetfilecon_raw(fd, &ccontext) >= 0) &&
 		    (strcmp(context,ccontext) == 0)) {
@@ -27,10 +27,10 @@ int fsetfilecon_raw(int fd, const security_context_t context)
 
 hidden_def(fsetfilecon_raw)
 
-int fsetfilecon(int fd, const security_context_t context)
+int fsetfilecon(int fd, const char *context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	if (selinux_trans_to_raw_context(context, &rcontext))
 		return -1;
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 1d91123..f3fa4a9 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -12,10 +12,10 @@
 
 int get_default_context_with_role(const char *user,
 				  const char *role,
-				  security_context_t fromcon,
-				  security_context_t * newcon)
+				  char * fromcon,
+				  char ** newcon)
 {
-	security_context_t *conary;
+	char **conary;
 	char **ptr;
 	context_t con;
 	const char *role2;
@@ -56,8 +56,8 @@ hidden_def(get_default_context_with_role)
 int get_default_context_with_rolelevel(const char *user,
 				       const char *role,
 				       const char *level,
-				       security_context_t fromcon,
-				       security_context_t * newcon)
+				       char * fromcon,
+				       char ** newcon)
 {
 
 	int rc = 0;
@@ -98,9 +98,9 @@ int get_default_context_with_rolelevel(const char *user,
 }
 
 int get_default_context(const char *user,
-			security_context_t fromcon, security_context_t * newcon)
+			char * fromcon, char ** newcon)
 {
-	security_context_t *conary;
+	char **conary;
 	int rc;
 
 	rc = get_ordered_context_list(user, fromcon, &conary);
@@ -114,7 +114,7 @@ int get_default_context(const char *user,
 	return 0;
 }
 
-static int find_partialcon(security_context_t * list,
+static int find_partialcon(char ** list,
 			   unsigned int nreach, char *part)
 {
 	const char *conrole, *contype;
@@ -155,8 +155,8 @@ static int find_partialcon(security_context_t * list,
 }
 
 static int get_context_order(FILE * fp,
-			     security_context_t fromcon,
-			     security_context_t * reachable,
+			     char * fromcon,
+			     char ** reachable,
 			     unsigned int nreach,
 			     unsigned int *ordering, unsigned int *nordered)
 {
@@ -268,7 +268,7 @@ static int get_context_order(FILE * fp,
 	return rc;
 }
 
-static int get_failsafe_context(const char *user, security_context_t * newcon)
+static int get_failsafe_context(const char *user, char ** newcon)
 {
 	FILE *fp;
 	char buf[255], *ptr;
@@ -314,7 +314,7 @@ static int get_failsafe_context(const char *user, security_context_t * newcon)
 }
 
 struct context_order {
-	security_context_t con;
+	char * con;
 	unsigned int order;
 };
 
@@ -330,8 +330,8 @@ static int order_compare(const void *A, const void *B)
 
 int get_ordered_context_list_with_level(const char *user,
 					const char *level,
-					security_context_t fromcon,
-					security_context_t ** list)
+					char * fromcon,
+					char *** list)
 {
 	int rc;
 	int freefrom = 0;
@@ -373,10 +373,10 @@ hidden_def(get_ordered_context_list_with_level)
 
 int get_default_context_with_level(const char *user,
 				   const char *level,
-				   security_context_t fromcon,
-				   security_context_t * newcon)
+				   char * fromcon,
+				   char ** newcon)
 {
-	security_context_t *conary;
+	char **conary;
 	int rc;
 
 	rc = get_ordered_context_list_with_level(user, level, fromcon, &conary);
@@ -391,10 +391,10 @@ int get_default_context_with_level(const char *user,
 }
 
 int get_ordered_context_list(const char *user,
-			     security_context_t fromcon,
-			     security_context_t ** list)
+			     char * fromcon,
+			     char *** list)
 {
-	security_context_t *reachable = NULL;
+	char **reachable = NULL;
 	unsigned int *ordering = NULL;
 	struct context_order *co = NULL;
 	char **ptr;
@@ -507,7 +507,7 @@ int get_ordered_context_list(const char *user,
 	   the "failsafe" context to at least permit root login
 	   for emergency recovery if possible. */
 	freeconary(reachable);
-	reachable = malloc(2 * sizeof(security_context_t));
+	reachable = malloc(2 * sizeof(char *));
 	if (!reachable) {
 		rc = -1;
 		goto out;
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 1676435..522ed78 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -11,7 +11,7 @@
 
 #define SELINUX_INITCON_DIR "/initial_contexts/"
 
-int security_get_initial_context_raw(const char * name, security_context_t * con)
+int security_get_initial_context_raw(const char * name, char ** con)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -55,10 +55,10 @@ int security_get_initial_context_raw(const char * name, security_context_t * con
 
 hidden_def(security_get_initial_context_raw)
 
-int security_get_initial_context(const char * name, security_context_t * con)
+int security_get_initial_context(const char * name, char ** con)
 {
 	int ret;
-	security_context_t rcon;
+	char * rcon;
 
 	ret = security_get_initial_context_raw(name, &rcon);
 	if (!ret) {
diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
index eb2ce8a..5d4d483 100644
--- a/libselinux/src/getfilecon.c
+++ b/libselinux/src/getfilecon.c
@@ -7,7 +7,7 @@
 #include <sys/xattr.h>
 #include "policy.h"
 
-int getfilecon_raw(const char *path, security_context_t * context)
+int getfilecon_raw(const char *path, char ** context)
 {
 	char *buf;
 	ssize_t size;
@@ -51,10 +51,10 @@ int getfilecon_raw(const char *path, security_context_t * context)
 
 hidden_def(getfilecon_raw)
 
-int getfilecon(const char *path, security_context_t * context)
+int getfilecon(const char *path, char ** context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	*context = NULL;
 
diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
index 5c01ed5..3a77a2d 100644
--- a/libselinux/src/getpeercon.c
+++ b/libselinux/src/getpeercon.c
@@ -11,7 +11,7 @@
 #define SO_PEERSEC 31
 #endif
 
-int getpeercon_raw(int fd, security_context_t * context)
+int getpeercon_raw(int fd, char ** context)
 {
 	char *buf;
 	socklen_t size;
@@ -45,10 +45,10 @@ int getpeercon_raw(int fd, security_context_t * context)
 
 hidden_def(getpeercon_raw)
 
-int getpeercon(int fd, security_context_t * context)
+int getpeercon(int fd, char ** context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	ret = getpeercon_raw(fd, &rcontext);
 
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index a8e2183..0b33edc 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -9,12 +9,12 @@
 #include "selinux_internal.h"
 #include "context_internal.h"
 
-static int get_customizable_type_list(security_context_t ** retlist)
+static int get_customizable_type_list(char *** retlist)
 {
 	FILE *fp;
 	char *buf;
 	unsigned int ctr = 0, i;
-	security_context_t *list = NULL;
+	char **list = NULL;
 
 	fp = fopen(selinux_customizable_types_path(), "r");
 	if (!fp)
@@ -31,14 +31,14 @@ static int get_customizable_type_list(security_context_t ** retlist)
 	rewind(fp);
 	if (ctr) {
 		list =
-		    (security_context_t *) calloc(sizeof(security_context_t),
+		    (char **) calloc(sizeof(char *),
 						  ctr + 1);
 		if (list) {
 			i = 0;
 			while (fgets_unlocked(buf, selinux_page_size, fp)
 			       && i < ctr) {
 				buf[strlen(buf) - 1] = 0;
-				list[i] = (security_context_t) strdup(buf);
+				list[i] = (char *) strdup(buf);
 				if (!list[i]) {
 					unsigned int j;
 					for (j = 0; j < i; j++)
@@ -59,9 +59,9 @@ static int get_customizable_type_list(security_context_t ** retlist)
 	return 0;
 }
 
-static security_context_t *customizable_list = NULL;
+static char **customizable_list = NULL;
 
-int is_context_customizable(const security_context_t scontext)
+int is_context_customizable(const char * scontext)
 {
 	int i;
 	const char *type;
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 8341e8c..c3c099e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -230,7 +230,7 @@ selabel_lookup_common(struct selabel_handle *rec, int translating,
 	return lr;
 }
 
-int selabel_lookup(struct selabel_handle *rec, security_context_t *con,
+int selabel_lookup(struct selabel_handle *rec, char **con,
 		   const char *key, int type)
 {
 	struct selabel_lookup_rec *lr;
@@ -243,7 +243,7 @@ int selabel_lookup(struct selabel_handle *rec, security_context_t *con,
 	return *con ? 0 : -1;
 }
 
-int selabel_lookup_raw(struct selabel_handle *rec, security_context_t *con,
+int selabel_lookup_raw(struct selabel_handle *rec, char **con,
 		       const char *key, int type)
 {
 	struct selabel_lookup_rec *lr;
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index b6ae140..a1fa4fd 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -42,8 +42,8 @@ extern struct selabel_sub *selabel_subs_init(const char *path,
 					     struct selabel_sub *list);
 
 struct selabel_lookup_rec {
-	security_context_t ctx_raw;
-	security_context_t ctx_trans;
+	char * ctx_raw;
+	char * ctx_trans;
 	int validated;
 };
 
diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
index 58dc807..478e0c6 100644
--- a/libselinux/src/lgetfilecon.c
+++ b/libselinux/src/lgetfilecon.c
@@ -7,7 +7,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-int lgetfilecon_raw(const char *path, security_context_t * context)
+int lgetfilecon_raw(const char *path, char ** context)
 {
 	char *buf;
 	ssize_t size;
@@ -51,10 +51,10 @@ int lgetfilecon_raw(const char *path, security_context_t * context)
 
 hidden_def(lgetfilecon_raw)
 
-int lgetfilecon(const char *path, security_context_t * context)
+int lgetfilecon(const char *path, char ** context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	*context = NULL;
 
diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index fd9bb26..1d3b28a 100644
--- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -7,12 +7,12 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-int lsetfilecon_raw(const char *path, const security_context_t context)
+int lsetfilecon_raw(const char *path, const char * context)
 {
 	int rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
 			 0);
 	if (rc < 0 && errno == ENOTSUP) {
-		security_context_t ccontext = NULL;
+		char * ccontext = NULL;
 		int err = errno;
 		if ((lgetfilecon_raw(path, &ccontext) >= 0) &&
 		    (strcmp(context,ccontext) == 0)) {
@@ -27,10 +27,10 @@ int lsetfilecon_raw(const char *path, const security_context_t context)
 
 hidden_def(lsetfilecon_raw)
 
-int lsetfilecon(const char *path, const security_context_t context)
+int lsetfilecon(const char *path, const char *context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	if (selinux_trans_to_raw_context(context, &rcontext))
 		return -1;
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index f4699d9..46cba46 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -11,7 +11,7 @@
 #include <regex.h>
 #include <stdarg.h>
 
-int matchmediacon(const char *media, security_context_t * con)
+int matchmediacon(const char *media, char ** con)
 {
 	const char *path = selinux_media_context_path();
 	FILE *infile;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2d7369e..3b96b1d 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -406,7 +406,7 @@ out:
 	return rc;
 }
 
-int matchpathcon(const char *path, mode_t mode, security_context_t * con)
+int matchpathcon(const char *path, mode_t mode, char ** con)
 {
 	char stackpath[PATH_MAX + 1];
 	char *p = NULL;
@@ -427,7 +427,7 @@ int matchpathcon(const char *path, mode_t mode, security_context_t * con)
 		selabel_lookup(hnd, con, path, mode);
 }
 
-int matchpathcon_index(const char *name, mode_t mode, security_context_t * con)
+int matchpathcon_index(const char *name, mode_t mode, char ** con)
 {
 	int i = matchpathcon(name, mode, con);
 
@@ -444,8 +444,8 @@ void matchpathcon_checkmatches(char *str __attribute__((unused)))
 
 /* Compare two contexts to see if their differences are "significant",
  * or whether the only difference is in the user. */
-int selinux_file_context_cmp(const security_context_t a,
-			     const security_context_t b)
+int selinux_file_context_cmp(const char * a,
+			     const char * b)
 {
 	char *rest_a, *rest_b;	/* Rest of the context after the user */
 	if (!a && !b)
@@ -467,8 +467,8 @@ int selinux_file_context_cmp(const security_context_t a,
 
 int selinux_file_context_verify(const char *path, mode_t mode)
 {
-	security_context_t con = NULL;
-	security_context_t fcontext = NULL;
+	char * con = NULL;
+	char * fcontext = NULL;
 	int rc = 0;
 
 	rc = lgetfilecon_raw(path, &con);
@@ -506,7 +506,7 @@ int selinux_lsetfilecon_default(const char *path)
 {
 	struct stat st;
 	int rc = -1;
-	security_context_t scontext = NULL;
+	char * scontext = NULL;
 	if (lstat(path, &st) != 0)
 		return rc;
 
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 9fa6138..f990350 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -9,15 +9,15 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-#define UNSET (const security_context_t) -1
+#define UNSET (char *) -1
 
 static __thread pid_t cpid;
 static __thread pid_t tid;
-static __thread security_context_t prev_current = UNSET;
-static __thread security_context_t prev_exec = UNSET;
-static __thread security_context_t prev_fscreate = UNSET;
-static __thread security_context_t prev_keycreate = UNSET;
-static __thread security_context_t prev_sockcreate = UNSET;
+static __thread char *prev_current = UNSET;
+static __thread char * prev_exec = UNSET;
+static __thread char * prev_fscreate = UNSET;
+static __thread char * prev_keycreate = UNSET;
+static __thread char * prev_sockcreate = UNSET;
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
@@ -107,7 +107,7 @@ static int openattr(pid_t pid, const char *attr, int flags)
 	return fd;
 }
 
-static int getprocattrcon_raw(security_context_t * context,
+static int getprocattrcon_raw(char ** context,
 			      pid_t pid, const char *attr)
 {
 	char *buf;
@@ -115,7 +115,7 @@ static int getprocattrcon_raw(security_context_t * context,
 	int fd;
 	ssize_t ret;
 	int errno_hold;
-	security_context_t prev_context;
+	char * prev_context;
 
 	__selinux_once(once, init_procattr);
 	init_thread_destructor();
@@ -193,11 +193,11 @@ static int getprocattrcon_raw(security_context_t * context,
 	return ret;
 }
 
-static int getprocattrcon(security_context_t * context,
+static int getprocattrcon(char ** context,
 			  pid_t pid, const char *attr)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	ret = getprocattrcon_raw(&rcontext, pid, attr);
 
@@ -209,13 +209,13 @@ static int getprocattrcon(security_context_t * context,
 	return ret;
 }
 
-static int setprocattrcon_raw(security_context_t context,
+static int setprocattrcon_raw(const char * context,
 			      pid_t pid, const char *attr)
 {
 	int fd;
 	ssize_t ret;
 	int errno_hold;
-	security_context_t *prev_context;
+	char **prev_context, *context2 = NULL;
 
 	__selinux_once(once, init_procattr);
 	init_thread_destructor();
@@ -255,11 +255,11 @@ static int setprocattrcon_raw(security_context_t context,
 		return -1;
 	if (context) {
 		ret = -1;
-		context = strdup(context);
-		if (!context)
+		context2 = strdup(context);
+		if (!context2)
 			goto out;
 		do {
-			ret = write(fd, context, strlen(context) + 1);
+			ret = write(fd, context2, strlen(context2) + 1);
 		} while (ret < 0 && errno == EINTR);
 	} else {
 		do {
@@ -271,21 +271,21 @@ out:
 	close(fd);
 	errno = errno_hold;
 	if (ret < 0) {
-		free(context);
+		free(context2);
 		return -1;
 	} else {
 		if (*prev_context != UNSET)
 			free(*prev_context);
-		*prev_context = context;
+		*prev_context = context2;
 		return 0;
 	}
 }
 
-static int setprocattrcon(const security_context_t context,
+static int setprocattrcon(const char * context,
 			  pid_t pid, const char *attr)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	if (selinux_trans_to_raw_context(context, &rcontext))
 		return -1;
@@ -298,21 +298,21 @@ static int setprocattrcon(const security_context_t context,
 }
 
 #define getselfattr_def(fn, attr) \
-	int get##fn##_raw(security_context_t *c) \
+	int get##fn##_raw(char **c) \
 	{ \
 		return getprocattrcon_raw(c, 0, #attr); \
 	} \
-	int get##fn(security_context_t *c) \
+	int get##fn(char **c) \
 	{ \
 		return getprocattrcon(c, 0, #attr); \
 	}
 
 #define setselfattr_def(fn, attr) \
-	int set##fn##_raw(const security_context_t c) \
+	int set##fn##_raw(const char * c) \
 	{ \
 		return setprocattrcon_raw(c, 0, #attr); \
 	} \
-	int set##fn(const security_context_t c) \
+	int set##fn(const char * c) \
 	{ \
 		return setprocattrcon(c, 0, #attr); \
 	}
@@ -322,11 +322,11 @@ static int setprocattrcon(const security_context_t context,
 	setselfattr_def(fn, attr)
 
 #define getpidattr_def(fn, attr) \
-	int get##fn##_raw(pid_t pid, security_context_t *c)	\
+	int get##fn##_raw(pid_t pid, char **c)	\
 	{ \
 		return getprocattrcon_raw(c, pid, #attr); \
 	} \
-	int get##fn(pid_t pid, security_context_t *c)	\
+	int get##fn(pid_t pid, char **c)	\
 	{ \
 		return getprocattrcon(c, pid, #attr); \
 	}
diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_user_context.c
index dcfc1b0..b8125c9 100644
--- a/libselinux/src/query_user_context.c
+++ b/libselinux/src/query_user_context.c
@@ -9,7 +9,7 @@
  *            to the user.  Returns the number (position in the list) of
  *            the user selected context.
  */
-static int context_menu(security_context_t * list)
+static int context_menu(char ** list)
 {
 	int i;			/* array index                        */
 	int choice = 0;		/* index of the user's choice         */
@@ -35,7 +35,7 @@ static int context_menu(security_context_t * list)
  *                  default is the first context in the list.  Returns 0 on
  *                  success, -1 on failure
  */
-int query_user_context(security_context_t * list, security_context_t * usercon)
+int query_user_context(char ** list, char ** usercon)
 {
 	char response[10];	/* The user's response                        */
 	int choice;		/* The index in the list of the sid chosen by
@@ -103,7 +103,7 @@ static void get_field(const char *fieldstr, char *newfield, int newfieldlen)
  *                     context chosen by the user into usercon.  Returns 0
  *                     on success.
  */
-int manual_user_enter_context(const char *user, security_context_t * newcon)
+int manual_user_enter_context(const char *user, char ** newcon)
 {
 	char response[10];	/* Used to get yes or no answers from user */
 	char role[100];		/* The role requested by the user          */
diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index e6d2501..24e5e2c 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -6,7 +6,7 @@
 #include "selinux_internal.h"
 #include "context_internal.h"
 
-int selinux_check_securetty_context(const security_context_t tty_context)
+int selinux_check_securetty_context(const char * tty_context)
 {
 	char *line = NULL;
 	char *start, *end = NULL;
diff --git a/libselinux/src/selinuxswig.i b/libselinux/src/selinuxswig.i
index 74b1032..969863a 100644
--- a/libselinux/src/selinuxswig.i
+++ b/libselinux/src/selinuxswig.i
@@ -34,11 +34,11 @@
 	}
 }
 
-%typemap(in, numinputs=0) (security_context_t **) (security_context_t *temp) {
+%typemap(in, numinputs=0) (char ***) (char **temp) {
 	$1 = &temp;
 }
 
-%typemap(freearg) (security_context_t **) {
+%typemap(freearg) (char ***) {
 	if (*$1) freeconary(*$1);
 }
 
diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 9884454..ae72246 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -83,7 +83,7 @@ def install(src, dest):
 }
 
 /* Makes security_compute_user() return a Python list of contexts */
-%typemap(argout) (security_context_t **con) {
+%typemap(argout) (char ***con) {
 	PyObject* plist;
 	int i, len = 0;
 	
@@ -104,7 +104,7 @@ def install(src, dest):
 }
 
 /* Makes functions in get_context_list.h return a Python list of contexts */
-%typemap(argout) (security_context_t **list) {
+%typemap(argout) (char ***list) {
 	PyObject* plist;
 	int i;
 	
@@ -122,11 +122,11 @@ def install(src, dest):
 	$result = plist;
 }
 
-%typemap(in,noblock=1,numinputs=0) security_context_t * (security_context_t temp = 0) {
+%typemap(in,noblock=1,numinputs=0) char ** (char * temp = 0) {
 	$1 = &temp;
 }
-%typemap(freearg,match="in") security_context_t * "";
-%typemap(argout,noblock=1) security_context_t * {
+%typemap(freearg,match="in") char ** "";
+%typemap(argout,noblock=1) char ** {
 	if (*$1) {
 		%append_output(SWIG_FromCharPtr(*$1));
 		freecon(*$1);
diff --git a/libselinux/src/selinuxswig_ruby.i b/libselinux/src/selinuxswig_ruby.i
index e46826b..12d63c4 100644
--- a/libselinux/src/selinuxswig_ruby.i
+++ b/libselinux/src/selinuxswig_ruby.i
@@ -18,11 +18,11 @@
   $1 = &temp;
 }
 
-%typemap(in,noblock=1,numinputs=0) security_context_t * (security_context_t temp = 0) {
+%typemap(in,noblock=1,numinputs=0) char ** (char * temp = 0) {
 	$1 = &temp;
 }
-%typemap(freearg,match="in") security_context_t * "";
-%typemap(argout,noblock=1) security_context_t * {
+%typemap(freearg,match="in") char ** "";
+%typemap(argout,noblock=1) char ** {
 	if (*$1) {
 		%append_output(SWIG_FromCharPtr(*$1));
 		freecon(*$1);
diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfilecon.c
index b3afa13..e574de1 100644
--- a/libselinux/src/setexecfilecon.c
+++ b/libselinux/src/setexecfilecon.c
@@ -7,7 +7,7 @@
 
 int setexecfilecon(const char *filename, const char *fallback_type)
 {
-	security_context_t mycon = NULL, fcon = NULL, newcon = NULL;
+	char * mycon = NULL, *fcon = NULL, *newcon = NULL;
 	context_t con = NULL;
 	int rc = 0;
 
diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c
index 50cb228..d05969c 100644
--- a/libselinux/src/setfilecon.c
+++ b/libselinux/src/setfilecon.c
@@ -7,12 +7,12 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-int setfilecon_raw(const char *path, const security_context_t context)
+int setfilecon_raw(const char *path, const char * context)
 {
 	int rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
 			0);
 	if (rc < 0 && errno == ENOTSUP) {
-		security_context_t ccontext = NULL;
+		char * ccontext = NULL;
 		int err = errno;
 		if ((getfilecon_raw(path, &ccontext) >= 0) &&
 		    (strcmp(context,ccontext) == 0)) {
@@ -27,10 +27,10 @@ int setfilecon_raw(const char *path, const security_context_t context)
 
 hidden_def(setfilecon_raw)
 
-int setfilecon(const char *path, const security_context_t context)
+int setfilecon(const char *path, const char *context)
 {
 	int ret;
-	security_context_t rcontext;
+	char * rcontext;
 
 	if (selinux_trans_to_raw_context(context, &rcontext))
 		return -1;
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index f9065bd..d9e87a9 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -26,12 +26,12 @@
 static int mls_enabled = -1;
 
 // Simple cache
-static __thread security_context_t prev_t2r_trans = NULL;
-static __thread security_context_t prev_t2r_raw = NULL;
-static __thread security_context_t prev_r2t_trans = NULL;
-static __thread security_context_t prev_r2t_raw = NULL;
+static __thread char * prev_t2r_trans = NULL;
+static __thread char * prev_t2r_raw = NULL;
+static __thread char * prev_r2t_trans = NULL;
+static __thread char * prev_r2t_raw = NULL;
 static __thread char *prev_r2c_trans = NULL;
-static __thread security_context_t prev_r2c_raw = NULL;
+static __thread char * prev_r2c_raw = NULL;
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
@@ -281,8 +281,8 @@ static void init_context_translations(void)
 	mls_enabled = is_selinux_mls_enabled();
 }
 
-int selinux_trans_to_raw_context(const security_context_t trans,
-				 security_context_t * rawp)
+int selinux_trans_to_raw_context(const char * trans,
+				 char ** rawp)
 {
 	if (!trans) {
 		*rawp = NULL;
@@ -323,8 +323,8 @@ int selinux_trans_to_raw_context(const security_context_t trans,
 
 hidden_def(selinux_trans_to_raw_context)
 
-int selinux_raw_to_trans_context(const security_context_t raw,
-				 security_context_t * transp)
+int selinux_raw_to_trans_context(const char * raw,
+				 char ** transp)
 {
 	if (!raw) {
 		*transp = NULL;
@@ -365,7 +365,7 @@ int selinux_raw_to_trans_context(const security_context_t raw,
 
 hidden_def(selinux_raw_to_trans_context)
 
-int selinux_raw_context_to_color(const security_context_t raw, char **transp)
+int selinux_raw_context_to_color(const char * raw, char **transp)
 {
 	if (!raw) {
 		*transp = NULL;
@@ -402,8 +402,8 @@ int selinux_raw_context_to_color(const security_context_t raw, char **transp)
 hidden_def(selinux_raw_context_to_color)
 #else /*DISABLE_SETRANS*/
 
-int selinux_trans_to_raw_context(const security_context_t trans,
-				 security_context_t * rawp)
+int selinux_trans_to_raw_context(const char * trans,
+				 char ** rawp)
 {
 	if (!trans) {
 		*rawp = NULL;
@@ -417,8 +417,8 @@ int selinux_trans_to_raw_context(const security_context_t trans,
 
 hidden_def(selinux_trans_to_raw_context)
 
-int selinux_raw_to_trans_context(const security_context_t raw,
-				 security_context_t * transp)
+int selinux_raw_to_trans_context(const char * raw,
+				 char ** transp)
 {
 	if (!raw) {
 		*transp = NULL;
diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 94c9bff..872ce05 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -19,7 +19,7 @@ static void usage(const char *name, const char *detail, int rc)
 
 int main(int argc, char **argv)
 {
-	security_context_t *list, usercon = NULL, cur_context = NULL;
+	char **list, *usercon = NULL, *cur_context = NULL;
 	char *user = NULL, *level = NULL;
 	int ret, i, opt;
 
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 42f4598..c6f7151 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -19,7 +19,7 @@ static void usage(const char *name, const char *detail, int rc)
 
 int main(int argc, char **argv)
 {
-	security_context_t usercon = NULL, cur_context = NULL;
+	char * usercon = NULL, *cur_context = NULL;
 	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
 	char *service = NULL;
 	int ret, opt;
diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
index 1e7ed76..c33a4ad 100644
--- a/libselinux/utils/getseuser.c
+++ b/libselinux/utils/getseuser.c
@@ -8,7 +8,7 @@
 int main(int argc, char **argv)
 {
 	char *seuser = NULL, *level = NULL;
-	security_context_t *contextlist;
+	char **contextlist;
 	int rc, n, i;
 
 	if (argc != 3) {
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index 9d3ff3a..d1f1348 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 			} else if (rc == 1) {
 				printf("%s verified.\n", path);
 			} else {
-				security_context_t con;
+				char * con;
 				error = 1;
 				if (notrans)
 					rc = lgetfilecon_raw(path, &con);
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index 476f564..4ac7e86 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -17,8 +17,8 @@ static void usage(const char *name, const char *detail, int rc)
 	exit(rc);
 }
 
-static security_context_t get_selinux_proc_context(const char *command, security_context_t execcon) {
-	security_context_t fcon = NULL, newcon = NULL;
+static char * get_selinux_proc_context(const char *command, char * execcon) {
+	char * fcon = NULL, *newcon = NULL;
 
 	int ret = getfilecon(command, &fcon);
 	if (ret < 0) goto err;
@@ -33,7 +33,7 @@ err:
 int main(int argc, char **argv)
 {
 	int ret = -1;
-	security_context_t proccon = NULL, con = NULL;
+	char * proccon = NULL, *con = NULL;
 	if (argc < 2 || argc > 3)
 		usage(argv[0], "Invalid number of arguments", -1);
 
-- 
1.8.3.1


--------------040908060801030506030803--
