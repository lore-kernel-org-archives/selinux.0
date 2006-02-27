Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1SDDkul019463
	for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2006 08:13:46 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1SDCGpu024239
	for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2006 13:12:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1SDCb0A011351
	for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2006 08:12:37 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1SDCbIw011350
	for selinux@tycho.nsa.gov; Tue, 28 Feb 2006 08:12:37 -0500
Message-ID: <44037A30.2040406@cornell.edu>
Date: Mon, 27 Feb 2006 17:16:16 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Deprecate freecon and freeconary
Content-Type: multipart/mixed;
 boundary="------------070402090704060607070904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070402090704060607070904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch marks freecon and freeconary as deprecated.
All uses of freecon() are changed to free().
Uses of freeconary() remain within the library, since this is a useful 
function.
stdlib.h has been included where appropriate.
stddef.h has been included where size_t was needed
Manpages and comments have been edited appropriately.

The next logical patch is to remove security_context_t, and replace it 
with char*, although I'm not sure whether that should be done throughout 
the library, or just in the API.
===================

Why?

1. Freecon and freeconary are not in a proper namespace. All such 
functions should be deprecated and replaced in general.

2. The security_context_t type has the wrong namespace, which should be 
replaced with selinux.

3. The security_context_t type is not opaque - it is externally defined 
as a char*. This means it provides no encapsulation of any kind. A 
context can be treated as a char*. Therefore freecon() offers no 
benefits over free(), and just adds an additional layer of overhead. It 
was pointed out that the string might not be allocated with malloc() [ 
in the future ], so freecon() might need to do special handling on it. 
This scenario doesn't seem probable at all. Also, such a string would 
most likely be cloned by the client immediately into a regular string, 
since we don't have a proper API for working with security_context_t - 
how do I clone one into another for example?

4. The security_context_t type has a drawback over char*. Since selinux 
is an optional integration feature in most other code, 
security_context_t must be placed in an ifdef block. char* doesn't 
require that, so it is easier to use.

5. security_context_t is unclear... since the pointer is hidden, it is 
not immediately obvious what its data size is when looking at the code.


--------------070402090704060607070904
Content-Type: text/x-patch;
 name="libselinux.freecon_deprecate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.freecon_deprecate.diff"

diff -Naurp --exclude-from excludes old/libselinux/include/selinux/avc.h new/libselinux/include/selinux/avc.h
--- old/libselinux/include/selinux/avc.h	2004-11-30 15:56:55.000000000 -0500
+++ new/libselinux/include/selinux/avc.h	2006-02-27 16:36:00.000000000 -0500
@@ -34,7 +34,7 @@ typedef struct security_id *security_id_
  *
  * Return a copy of the security context corresponding to the input
  * @sid in the memory referenced by @ctx.  The caller is expected to 
- * free the context with freecon().  Return %0 on success, -%1 on
+ * free the context.  Return %0 on success, -%1 on
  * failure, with @errno set to %ENOMEM if insufficient memory was
  * available to make the copy, or %EINVAL if the input SID is invalid.
  */
diff -Naurp --exclude-from excludes old/libselinux/include/selinux/get_context_list.h new/libselinux/include/selinux/get_context_list.h
--- old/libselinux/include/selinux/get_context_list.h	2005-10-18 12:28:31.000000000 -0400
+++ new/libselinux/include/selinux/get_context_list.h	2006-02-27 16:35:47.000000000 -0500
@@ -16,7 +16,7 @@ extern "C"
    be authorized by the policy, but the ordering is subject to user
    customizable preferences.  Returns number of entries in *conary.
    If 'fromcon' is NULL, defaults to current context.
-   Caller must free via freeconary. */
+   Caller must free. */
 extern int get_ordered_context_list(const char *user, 
 				    security_context_t fromcon,
 				    security_context_t **list);
@@ -34,7 +34,7 @@ int get_ordered_context_list_with_level 
    of a default is subject to user customizable preferences.
    If 'fromcon' is NULL, defaults to current context.
    Returns 0 on success or -1 otherwise.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int get_default_context(const char* user, 
 			       security_context_t fromcon,
 			       security_context_t *newcon);
@@ -65,14 +65,14 @@ int get_default_context_with_rolelevel(c
 
 /* Given a list of authorized security contexts for the user, 
    query the user to select one and set *newcon to refer to it.
-   Caller must free via freecon.
+   Caller must free.
    Returns 0 on sucess or -1 otherwise. */
 extern int query_user_context(security_context_t *list, 
 			      security_context_t *newcon);
 
 /* Allow the user to manually enter a context as a fallback
    if a list of authorized contexts could not be obtained. 
-   Caller must free via freecon.
+   Caller must free.
    Returns 0 on success or -1 otherwise. */
 extern int manual_user_enter_context(const char *user,
 				     security_context_t *newcon);
diff -Naurp --exclude-from excludes old/libselinux/include/selinux/selinux.h new/libselinux/include/selinux/selinux.h
--- old/libselinux/include/selinux/selinux.h	2005-12-01 10:10:32.000000000 -0500
+++ new/libselinux/include/selinux/selinux.h	2006-02-27 16:38:42.000000000 -0500
@@ -16,16 +16,20 @@ extern int is_selinux_mls_enabled(void);
 
 typedef char* security_context_t;
 
+/* ======== Deprecated ============ */
+
 /* Free the memory allocated for a context by any of the below get* calls. */
 extern void freecon(security_context_t con);
 
 /* Free the memory allocated for a context array by security_compute_user. */
 extern void freeconary(security_context_t *con);
 
+/* ======== End Deprecated ========= */
+
 /* Wrappers for the /proc/pid/attr API. */
 
 /* Get current context, and set *con to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int getcon(security_context_t *con);
 extern int getcon_raw(security_context_t *con);
 
@@ -41,18 +45,18 @@ extern int setcon(security_context_t con
 extern int setcon_raw(security_context_t con);
 
 /* Get context of process identified by pid, and 
-   set *con to refer to it.  Caller must free via freecon. */
+   set *con to refer to it.  Caller must free. */
 extern int getpidcon(pid_t pid, security_context_t *con);
 extern int getpidcon_raw(pid_t pid, security_context_t *con);
 
 /* Get previous context (prior to last exec), and set *con to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int getprevcon(security_context_t *con);
 extern int getprevcon_raw(security_context_t *con);
 
 /* Get exec context, and set *con to refer to it.
    Sets *con to NULL if no exec context has been set, i.e. using default.
-   If non-NULL, caller must free via freecon. */
+   Caller must free. */
 extern int getexeccon(security_context_t *con);
 extern int getexeccon_raw(security_context_t *con);
 
@@ -63,7 +67,7 @@ extern int setexeccon_raw(security_conte
 
 /* Get fscreate context, and set *con to refer to it.
    Sets *con to NULL if no fs create context has been set, i.e. using default.
-   If non-NULL, caller must free via freecon. */
+   Caller must free.  */
 extern int getfscreatecon(security_context_t *con);
 extern int getfscreatecon_raw(security_context_t *con);
 
@@ -76,7 +80,7 @@ extern int setfscreatecon_raw(security_c
 /* Wrappers for the xattr API. */
 
 /* Get file context, and set *con to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int getfilecon(const char *path, security_context_t *con);
 extern int getfilecon_raw(const char *path, security_context_t *con);
 extern int lgetfilecon(const char *path, security_context_t *con);
@@ -96,7 +100,7 @@ extern int fsetfilecon_raw(int fd, secur
 /* Wrappers for the socket API */
 
 /* Get context of peer socket, and set *con to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int getpeercon(int fd, security_context_t *con);
 extern int getpeercon_raw(int fd, security_context_t *con);
 
@@ -127,7 +131,7 @@ extern int security_compute_av_raw(secur
                                    struct av_decision *avd);
 
 /* Compute a labeling decision and set *newcon to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int security_compute_create(security_context_t scon,
 				   security_context_t tcon,
 				   security_class_t tclass,
@@ -138,7 +142,7 @@ extern int security_compute_create_raw(s
                                        security_context_t *newcon);
 
 /* Compute a relabeling decision and set *newcon to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int security_compute_relabel(security_context_t scon,
 				    security_context_t tcon,
 				    security_class_t tclass,
@@ -149,7 +153,7 @@ extern int security_compute_relabel_raw(
                                         security_context_t *newcon);
 
 /* Compute a polyinstantiation member decision and set *newcon to refer to it.
-   Caller must free via freecon. */
+   Caller must free. */
 extern int security_compute_member(security_context_t scon,
 				   security_context_t tcon,
 				   security_class_t tclass,
@@ -160,7 +164,7 @@ extern int security_compute_member_raw(s
                                        security_context_t *newcon);
 
 /* Compute the set of reachable user contexts and set *con to refer to 
-   the NULL-terminated array of contexts.  Caller must free via freeconary. */
+   the NULL-terminated array of contexts.  Caller must free. */
 extern int security_compute_user(security_context_t scon,
 				 const char *username,
 				 security_context_t **con);
@@ -313,7 +317,7 @@ extern int matchpathcon_init_prefix(cons
 /* Match the specified pathname and mode against the file contexts
    configuration and set *con to refer to the resulting context.
    'mode' can be 0 to disable mode matching.
-   Caller must free via freecon.
+   Caller must free.
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
@@ -346,7 +350,7 @@ extern void matchpathcon_checkmatches(ch
 
 /* Match the specified media and against the media contexts 
    configuration and set *con to refer to the resulting context.
-   Caller must free con via freecon. */
+   Caller must free. */
 extern int matchmediacon(const char *media,
 		 security_context_t *con);
 
@@ -404,7 +408,7 @@ extern int is_context_customizable (secu
 
 /* Perform context translation between the human-readable format
    ("translated") and the internal system format ("raw"). 
-   Caller must free the resulting context via freecon.  
+   Caller must free the resulting context.  
    Returns -1 upon an error or 0 otherwise.
    If passed NULL, sets the returned context to NULL and returns 0. */
 extern int selinux_trans_to_raw_context(security_context_t trans, 
diff -Naurp --exclude-from excludes old/libselinux/man/man3/avc_context_to_sid.3 new/libselinux/man/man3/avc_context_to_sid.3
--- old/libselinux/man/man3/avc_context_to_sid.3	2004-06-15 09:16:30.000000000 -0400
+++ new/libselinux/man/man3/avc_context_to_sid.3	2006-02-27 16:34:47.000000000 -0500
@@ -31,8 +31,7 @@ returns a copy of the context represente
 .I sid
 in the memory referenced by
 .IR ctx .
-The user must free the copy with
-.BR freecon (3).
+The user must free the copy.
 
 .B sidget
 increments the reference count of
@@ -87,4 +86,3 @@ Eamon Walsh <ewalsh@epoch.ncsc.mil>
 .BR avc_cache_stats (3),
 .BR avc_add_callback (3),
 .BR getcon (3),
-.BR freecon (3)
diff -Naurp --exclude-from excludes old/libselinux/man/man3/freecon.3 new/libselinux/man/man3/freecon.3
--- old/libselinux/man/man3/freecon.3	2004-05-20 11:32:44.000000000 -0400
+++ new/libselinux/man/man3/freecon.3	2006-02-27 17:00:57.000000000 -0500
@@ -14,3 +14,6 @@ frees the memory allocated for a securit
 
 .B freeconary
 frees the memory allocated for a context array.
+
+.B NOTE: 
+These functions are now deprecated. The type security_context_t can be treated as an ascii string (char*) allocated via malloc(), and can be freed via free().
diff -Naurp --exclude-from excludes old/libselinux/man/man3/getcon.3 new/libselinux/man/man3/getcon.3
--- old/libselinux/man/man3/getcon.3	2006-01-04 07:06:39.000000000 -0500
+++ new/libselinux/man/man3/getcon.3	2006-02-27 16:34:07.000000000 -0500
@@ -20,8 +20,7 @@ setcon - set current security context of
 
 .SH "DESCRIPTION"
 .B getcon
-retrieves the context of the current process, which must be free'd with
-freecon.
+retrieves the context of the current process, which must be freed by the caller.
 
 .B getprevcon
 same as getcon but gets the context before the last exec.
@@ -30,7 +29,7 @@ same as getcon but gets the context befo
 returns the process context for the specified PID.
 
 .B getpeercon
-retrieves context of peer socket, and set *context to refer to it, which must be free'd with freecon.
+retrieves context of peer socket, and set *context to refer to it, which must be freed by the caller.
 
 .B setcon
 sets the current security context of the process to a new value.  Note
@@ -59,4 +58,4 @@ context and the setcon() will fail if it
 On error -1 is returned.  On success 0 is returned.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setexeccon "(3)"
+.BR setexeccon "(3)"
diff -Naurp --exclude-from excludes old/libselinux/man/man3/getexeccon.3 new/libselinux/man/man3/getexeccon.3
--- old/libselinux/man/man3/getexeccon.3	2004-11-30 15:56:55.000000000 -0500
+++ new/libselinux/man/man3/getexeccon.3	2006-02-27 16:29:15.000000000 -0500
@@ -16,7 +16,7 @@ rpm_execcon \- run a helper for rpm in a
 .SH "DESCRIPTION"
 .B getexeccon
 retrieves the context used for executing a new process.
-This returned context should be freed with freecon if non-NULL.  
+This returned context must be freed by the caller.  
 getexeccon sets *con to NULL if no exec context has been explicitly 
 set by the program (i.e. using the default policy behavior).
 
@@ -55,6 +55,6 @@ On success getexeccon and setexeccon ret
 rpm_execcon only returns upon errors, as it calls execve(2).
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getcon "(3)"
+.BR getcon "(3)"
 
 
diff -Naurp --exclude-from excludes old/libselinux/man/man3/getfilecon.3 new/libselinux/man/man3/getfilecon.3
--- old/libselinux/man/man3/getfilecon.3	2004-05-20 11:32:44.000000000 -0400
+++ new/libselinux/man/man3/getfilecon.3	2006-02-27 16:27:54.000000000 -0500
@@ -24,7 +24,7 @@ returned by open(2)) is interrogated in 
 
 .br
 
-The returned context should be freed with freecon if non-NULL.  
+The returned context must be freed by the caller.  
 .SH "RETURN VALUE"
 On success, a positive number is returned indicating the size of the
 extended attribute value. On failure, \-1 is returned and errno is  set
@@ -40,4 +40,4 @@ The errors documented for the stat(2) sy
 here.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
+.BR setfilecon "(3), " setfscreatecon "(3)"
diff -Naurp --exclude-from excludes old/libselinux/man/man3/getfscreatecon.3 new/libselinux/man/man3/getfscreatecon.3
--- old/libselinux/man/man3/getfscreatecon.3	2004-05-20 11:32:44.000000000 -0400
+++ new/libselinux/man/man3/getfscreatecon.3	2006-02-27 16:34:26.000000000 -0500
@@ -12,7 +12,7 @@ getfscreatecon, setfscreatecon \- get or
 .SH "DESCRIPTION"
 .B getfscreatecon
 retrieves the context used for creating a new file system object.
-This returned context should be freed with freecon if non-NULL.  
+This returned context must be freed by the caller.  
 getfscreatecon sets *con to NULL if no fscreate context has been explicitly 
 set by the program (i.e. using the default policy behavior).
 
@@ -37,4 +37,4 @@ On success getfscreatecon returns the le
 the trailing zero byte).  On success setfscreatecon returns 0.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getcon "(3), " getexeccon "(3)"
+.BR getcon "(3), " getexeccon "(3)"
diff -Naurp --exclude-from excludes old/libselinux/man/man3/get_ordered_context_list.3 new/libselinux/man/man3/get_ordered_context_list.3
--- old/libselinux/man/man3/get_ordered_context_list.3	2005-10-18 12:28:41.000000000 -0400
+++ new/libselinux/man/man3/get_ordered_context_list.3	2006-02-27 16:33:34.000000000 -0500
@@ -41,16 +41,14 @@ file if it exists.  The 
 .I fromcon
 parameter may be NULL to indicate that the current context should
 be used.  The function returns the number of contexts in the
-list, or -1 upon errors.  The list must be freed using the
-.B freeconary
-function.
+list, or -1 upon errors.  The list must be freed by the caller.
 
 .B get_ordered_context_list_with_level
 invokes the get_ordered_context_list function and applies the specified level.
 
 .B get_default_context
 is the same as get_ordered_context_list but only returns a single context
-which has to be freed with freecon.
+which must be freed by the caller.
 
 .B get_default_context_with_level
 invokes the get_default_context function and applies the specified level.
@@ -63,18 +61,17 @@ invokes the get_default_context_with_rol
 
 .B query_user_context
 takes a list of contexts, queries the user via stdin/stdout as to which context
-they want, and returns a new context as selected by the user (which has to be
-freed with freecon).
+they want, and returns a new context as selected by the user (which must be freed by the caller).
 
 .B manual_user_enter_context
-allows the user to manually enter a context as a fallback if a list of authorized contexts could not be obtained. Caller must free via freecon.
+allows the user to manually enter a context as a fallback if a list of authorized contexts could not be obtained. Caller must free the context.
 
 .B get_default_type
-Get the default type (domain) for 'role' and set 'type' to refer to it, which has to be freed with free.
+Get the default type (domain) for 'role' and set 'type' to refer to it, which must be freed by the caller.
 
 .SH "RETURN VALUE"
 get_ordered_context_list and get_ordered_context_list_with_level return the number of contexts in the list upon success or -1 upon errors.
 The other functions return 0 for success or -1 for errors.
 
 .SH "SEE ALSO"
-.BR freeconary "(3), " freecon "(3), " security_compute_av "(3)", getseuserbyname"(3)"
+.BR security_compute_av "(3)", getseuserbyname"(3)"
diff -Naurp --exclude-from excludes old/libselinux/man/man3/matchmediacon.3 new/libselinux/man/man3/matchmediacon.3
--- old/libselinux/man/man3/matchmediacon.3	2004-11-30 15:59:02.000000000 -0500
+++ new/libselinux/man/man3/matchmediacon.3	2006-02-27 16:34:09.000000000 -0500
@@ -15,12 +15,9 @@ matches the specified media type with th
 .sp
 .br
 .B Note: 
-   Caller must free returned security context "con" using freecon.
+   Caller must free returned security context "con".
 .SH "RETURN VALUE"
 Returns 0 on success or -1 otherwise.
 
 .SH Files
 /etc/selinux/POLICYTYPE/contexts/files/media
-
-.SH "SEE ALSO"
-.BR freecon "(3)
diff -Naurp --exclude-from excludes old/libselinux/man/man3/matchpathcon.3 new/libselinux/man/man3/matchpathcon.3
--- old/libselinux/man/man3/matchpathcon.3	2005-03-16 10:33:58.000000000 -0500
+++ new/libselinux/man/man3/matchpathcon.3	2006-02-27 16:30:50.000000000 -0500
@@ -47,7 +47,7 @@ configuration and sets the security cont
 to refer to the
 resulting context. The caller must free the returned security context 
 .I con
-using freecon when finished using it.
+when finished using it.
 .I mode
 can be 0 to disable mode matching, but
 should be provided whenever possible, as it may affect the matching.
@@ -106,4 +106,4 @@ will be processed, not any dynamically g
 Returns 0 on success or -1 otherwise.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
+.BR setfilecon "(3), " setfscreatecon "(3)"
diff -Naurp --exclude-from excludes old/libselinux/man/man3/setfilecon.3 new/libselinux/man/man3/setfilecon.3
--- old/libselinux/man/man3/setfilecon.3	2004-05-20 11:32:44.000000000 -0400
+++ new/libselinux/man/man3/setfilecon.3	2006-02-27 16:34:56.000000000 -0500
@@ -38,4 +38,4 @@ The errors documented for the stat(2) sy
 here.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getfilecon "(3), " setfscreatecon "(3)"
+.BR getfilecon "(3), " setfscreatecon "(3)"
diff -Naurp --exclude-from excludes old/libselinux/src/avc.c new/libselinux/src/avc.c
--- old/libselinux/src/avc.c	2005-02-01 10:11:40.000000000 -0500
+++ new/libselinux/src/avc.c	2006-02-27 16:43:58.000000000 -0500
@@ -232,7 +232,7 @@ int avc_sid_to_context(security_id_t sid
   *ctx = NULL;
   avc_get_lock(avc_lock);
   if (sid->refcnt > 0) {
-    *ctx = strdup(sid->ctx);    /* caller must free via freecon */
+    *ctx = strdup(sid->ctx);    /* caller must free */
     rc = *ctx ? 0 : -1;
   } else {
     errno = EINVAL;             /* bad reference count */
diff -Naurp --exclude-from excludes old/libselinux/src/avc_internal.c new/libselinux/src/avc_internal.c
--- old/libselinux/src/avc_internal.c	2004-11-05 14:15:27.000000000 -0500
+++ new/libselinux/src/avc_internal.c	2006-02-27 16:55:48.000000000 -0500
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
diff -Naurp --exclude-from excludes old/libselinux/src/avc_internal.h new/libselinux/src/avc_internal.h
--- old/libselinux/src/avc_internal.h	2004-08-25 08:44:17.000000000 -0400
+++ new/libselinux/src/avc_internal.h	2006-02-27 16:57:09.000000000 -0500
@@ -11,6 +11,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <selinux/avc.h>
 #include "dso.h"
diff -Naurp --exclude-from excludes old/libselinux/src/avc_sidtab.c new/libselinux/src/avc_sidtab.c
--- old/libselinux/src/avc_sidtab.c	2005-08-11 10:12:38.000000000 -0400
+++ new/libselinux/src/avc_sidtab.c	2006-02-27 16:43:41.000000000 -0500
@@ -183,7 +183,7 @@ void sidtab_destroy(struct sidtab *s)
 		while (cur != NULL) {
 			temp = cur;
 			cur = cur->next;
-			freecon(temp->sid_s.ctx);
+			free(temp->sid_s.ctx);
 			avc_free(temp);
 		}
 		s->htable[i] = NULL;
diff -Naurp --exclude-from excludes old/libselinux/src/booleans.c new/libselinux/src/booleans.c
--- old/libselinux/src/booleans.c	2006-01-04 10:47:44.000000000 -0500
+++ new/libselinux/src/booleans.c	2006-02-27 16:54:45.000000000 -0500
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <assert.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <dirent.h>
 #include <string.h>
 #include <stdio.h>
diff -Naurp --exclude-from excludes old/libselinux/src/canonicalize_context.c new/libselinux/src/canonicalize_context.c
--- old/libselinux/src/canonicalize_context.c	2005-11-08 09:34:17.000000000 -0500
+++ new/libselinux/src/canonicalize_context.c	2006-02-27 16:54:27.000000000 -0500
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
@@ -70,13 +71,13 @@ int security_canonicalize_context(securi
  	ret = security_canonicalize_context_raw(rcon, &rcanoncon);
 
 	if (context_translations) {
-		freecon(rcon);
+		free(rcon);
 		if (!ret) {
 			if (raw_to_trans_context(rcanoncon, canoncon)) {
 				*canoncon = NULL;
 				ret = -1;
 			}
-			freecon(rcanoncon);
+			free(rcanoncon);
 		}
 	} else if (!ret) {
 		*canoncon = rcanoncon;
diff -Naurp --exclude-from excludes old/libselinux/src/checkAccess.c new/libselinux/src/checkAccess.c
--- old/libselinux/src/checkAccess.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/checkAccess.c	2006-02-27 16:43:46.000000000 -0500
@@ -23,7 +23,7 @@ int selinux_check_passwd_access(access_v
                     ((requested & avd.allowed) == requested)) {
                         status=0;
                 }
-                freecon(user_context);
+                free(user_context);
         }
         
         if (status != 0 && security_getenforce()==0) 
diff -Naurp --exclude-from excludes old/libselinux/src/check_context.c new/libselinux/src/check_context.c
--- old/libselinux/src/check_context.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/check_context.c	2006-02-27 16:44:15.000000000 -0500
@@ -38,7 +38,7 @@ int security_check_context(security_cont
  	ret = security_check_context_raw(rcon);
 
 	if (context_translations)
-		freecon(rcon);
+		free(rcon);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/compute_av.c new/libselinux/src/compute_av.c
--- old/libselinux/src/compute_av.c	2006-02-06 16:35:28.000000000 -0500
+++ new/libselinux/src/compute_av.c	2006-02-27 16:55:22.000000000 -0500
@@ -3,6 +3,7 @@
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stddef.h>
 #include <errno.h>
 #include <string.h>
 #include <asm/page.h>
@@ -76,7 +77,7 @@ int security_compute_av(security_context
 		if (trans_to_raw_context(scon, &rscon)) 
 			return -1;
 		if (trans_to_raw_context(tcon, &rtcon)) {
-			freecon(rscon);
+			free(rscon);
 			return -1;
 		}
 	}
@@ -84,8 +85,8 @@ int security_compute_av(security_context
  	ret = security_compute_av_raw(rscon, rtcon, tclass, requested, avd);
 
 	if (context_translations) {
-		freecon(rscon);
-		freecon(rtcon);
+		free(rscon);
+		free(rtcon);
 	}
 
 	printf("Ret was %u\n", ret);	
diff -Naurp --exclude-from excludes old/libselinux/src/compute_create.c new/libselinux/src/compute_create.c
--- old/libselinux/src/compute_create.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/compute_create.c	2006-02-27 16:56:20.000000000 -0500
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
@@ -70,7 +71,7 @@ int security_compute_create(security_con
 		if (trans_to_raw_context(scon, &rscon))
 			return -1;
 		if (trans_to_raw_context(tcon, &rtcon)) {
-			freecon(rscon);
+			free(rscon);
 			return -1;
 		}
 	}
@@ -78,14 +79,14 @@ int security_compute_create(security_con
  	ret = security_compute_create_raw(rscon, rtcon, tclass, &rnewcon);
 
 	if (context_translations) {
-		freecon(rscon);
-		freecon(rtcon);
+		free(rscon);
+		free(rtcon);
 		if (!ret) {
 			if (raw_to_trans_context(rnewcon, newcon)) {
 				*newcon = NULL;
 				ret = -1;
 			}
-			freecon(rnewcon);
+			free(rnewcon);
 		}
 	} else if (!ret)
 		*newcon = rnewcon;
diff -Naurp --exclude-from excludes old/libselinux/src/compute_member.c new/libselinux/src/compute_member.c
--- old/libselinux/src/compute_member.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/compute_member.c	2006-02-27 16:53:58.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
@@ -70,7 +71,7 @@ int security_compute_member(security_con
 		if (trans_to_raw_context(scon, &rscon))
 			return -1;
 		if (trans_to_raw_context(tcon, &rtcon)) {
-			freecon(rscon);
+			free(rscon);
 			return -1;
 		}
 	}
@@ -78,14 +79,14 @@ int security_compute_member(security_con
  	ret = security_compute_member_raw(rscon, rtcon, tclass, &rnewcon);
 
 	if (context_translations) {
-		freecon(rscon);
-		freecon(rtcon);
+		free(rscon);
+		free(rtcon);
 		if (!ret) {
 			if (raw_to_trans_context(rnewcon, newcon)) {
 				*newcon = NULL;
 				ret = -1;
 			}
-			freecon(rnewcon);
+			free(rnewcon);
 		}
 	} else if (!ret)
 		*newcon = rnewcon;
diff -Naurp --exclude-from excludes old/libselinux/src/compute_relabel.c new/libselinux/src/compute_relabel.c
--- old/libselinux/src/compute_relabel.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/compute_relabel.c	2006-02-27 16:54:53.000000000 -0500
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
@@ -70,7 +71,7 @@ int security_compute_relabel(security_co
 		if (trans_to_raw_context(scon, &rscon))
 			return -1;
 		if (trans_to_raw_context(tcon, &rtcon)) {
-			freecon(rscon);
+			free(rscon);
 			return -1;
 		}
 	}
@@ -78,14 +79,14 @@ int security_compute_relabel(security_co
  	ret = security_compute_relabel_raw(rscon, rtcon, tclass, &rnewcon);
 
 	if (context_translations) {
-		freecon(rscon);
-		freecon(rtcon);
+		free(rscon);
+		free(rtcon);
 		if (!ret) {
 			if (raw_to_trans_context(rnewcon, newcon)) {
 				*newcon = NULL;
 				ret = -1;
 			}
-			freecon(rnewcon);
+			free(rnewcon);
 		}
 	} else if (!ret)
 		*newcon = rnewcon;
diff -Naurp --exclude-from excludes old/libselinux/src/compute_user.c new/libselinux/src/compute_user.c
--- old/libselinux/src/compute_user.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/compute_user.c	2006-02-27 16:53:35.000000000 -0500
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
+#include <stddef.h>
 #include <string.h>
 #include <asm/page.h>
 #include "selinux_internal.h"
@@ -88,7 +89,7 @@ int security_compute_user(security_conte
  	ret = security_compute_user_raw(rscon, user, con);
 
 	if (context_translations) {
-		freecon(rscon);
+		free(rscon);
 		if (!ret) {
 			security_context_t *ptr, tmpcon;
 			for (ptr = *con; *ptr; ptr++) {
@@ -97,7 +98,7 @@ int security_compute_user(security_conte
 					*con = NULL;
 					return -1;
 				}
-				freecon(*ptr);
+				free(*ptr);
 				*ptr = tmpcon;
 			}
 		}
diff -Naurp --exclude-from excludes old/libselinux/src/context.c new/libselinux/src/context.c
--- old/libselinux/src/context.c	2005-08-26 15:03:21.000000000 -0400
+++ new/libselinux/src/context.c	2006-02-27 16:54:05.000000000 -0500
@@ -1,5 +1,6 @@
 #include "context_internal.h"
 #include <string.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 
diff -Naurp --exclude-from excludes old/libselinux/src/enabled.c new/libselinux/src/enabled.c
--- old/libselinux/src/enabled.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/enabled.c	2006-02-27 16:55:39.000000000 -0500
@@ -1,5 +1,6 @@
 #include <unistd.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <string.h>
 #include "selinux_internal.h"
 #include <stdlib.h>
@@ -45,7 +46,7 @@ int is_selinux_enabled(void)
 	if (getcon_raw(&con) == 0) {
 		if (!strcmp(con, "kernel"))
 			enabled = 0;
-		freecon(con);
+		free(con);
 	}
 out2:
 	free(buf);
diff -Naurp --exclude-from excludes old/libselinux/src/fgetfilecon.c new/libselinux/src/fgetfilecon.c
--- old/libselinux/src/fgetfilecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/fgetfilecon.c	2006-02-27 16:55:56.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
@@ -57,7 +58,7 @@ int fgetfilecon(int fd, security_context
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (ret > 0)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/freeconary.c new/libselinux/src/freeconary.c
--- old/libselinux/src/freeconary.c	2004-08-25 08:44:17.000000000 -0400
+++ new/libselinux/src/freeconary.c	2006-02-27 16:25:16.000000000 -0500
@@ -3,6 +3,8 @@
 #include <stdlib.h>
 #include <errno.h>
 
+/* Deprecated: Use free() directly */
+
 void freeconary(security_context_t *con)
 {
 	char **ptr;
diff -Naurp --exclude-from excludes old/libselinux/src/freecon.c new/libselinux/src/freecon.c
--- old/libselinux/src/freecon.c	2004-08-25 08:44:17.000000000 -0400
+++ new/libselinux/src/freecon.c	2006-02-27 16:25:03.000000000 -0500
@@ -3,6 +3,8 @@
 #include <stdlib.h>
 #include <errno.h>
 
+/* Deprecated: Use free() directly */
+
 void freecon(security_context_t con)
 {
 	free(con);
diff -Naurp --exclude-from excludes old/libselinux/src/fsetfilecon.c new/libselinux/src/fsetfilecon.c
--- old/libselinux/src/fsetfilecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/fsetfilecon.c	2006-02-27 16:42:53.000000000 -0500
@@ -24,7 +24,7 @@ int fsetfilecon(int fd, security_context
  	ret = fsetfilecon_raw(fd, rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/getcon.c new/libselinux/src/getcon.c
--- old/libselinux/src/getcon.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/getcon.c	2006-02-27 16:56:29.000000000 -0500
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "selinux_internal.h"
 #include <stdlib.h>
+#include <stddef.h>
 #include <errno.h>
 #include <asm/page.h>
 #include "policy.h"
@@ -56,7 +57,7 @@ int getcon(security_context_t *context)
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/get_context_list.c new/libselinux/src/get_context_list.c
--- old/libselinux/src/get_context_list.c	2006-02-06 16:38:46.000000000 -0500
+++ new/libselinux/src/get_context_list.c	2006-02-27 16:55:14.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
+#include <stddef.h>
 #include <stdio_ext.h>
 #include <stdlib.h>
 #include <string.h>
@@ -88,7 +89,7 @@ int get_default_context_with_rolelevel(c
 out:
     context_free(con);
     if (freefrom) 
-	    freecon(fromcon);
+	    free(fromcon);
     return rc;
 
 }
@@ -370,7 +371,7 @@ int get_ordered_context_list_with_level 
 out:
     context_free(con);
     if (freefrom) 
-	    freecon(fromcon);
+	    free(fromcon);
     return rc;
 }
 hidden_def(get_ordered_context_list_with_level)
@@ -505,7 +506,7 @@ out:
 
     free(ordering);
     if (freefrom)
-	    freecon(fromcon);
+	    free(fromcon);
 
     return rc;
 
diff -Naurp --exclude-from excludes old/libselinux/src/get_default_type.c new/libselinux/src/get_default_type.c
--- old/libselinux/src/get_default_type.c	2004-08-30 11:46:50.000000000 -0400
+++ new/libselinux/src/get_default_type.c	2006-02-27 16:55:32.000000000 -0500
@@ -1,5 +1,6 @@
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <ctype.h>
 #include "get_default_type_internal.h"
diff -Naurp --exclude-from excludes old/libselinux/src/getexeccon.c new/libselinux/src/getexeccon.c
--- old/libselinux/src/getexeccon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/getexeccon.c	2006-02-27 16:56:57.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/page.h>
@@ -61,7 +62,7 @@ int getexeccon(security_context_t *conte
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/getfilecon.c new/libselinux/src/getfilecon.c
--- old/libselinux/src/getfilecon.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/getfilecon.c	2006-02-27 16:56:49.000000000 -0500
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "selinux_internal.h"
 #include <stdlib.h>
+#include <stddef.h>
 #include <errno.h>
 #include <sys/xattr.h>
 #include "policy.h"
@@ -57,7 +58,7 @@ int getfilecon(const char *path, securit
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (ret > 0)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/getfscreatecon.c new/libselinux/src/getfscreatecon.c
--- old/libselinux/src/getfscreatecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/getfscreatecon.c	2006-02-27 16:54:18.000000000 -0500
@@ -1,5 +1,6 @@
 #include <unistd.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
@@ -61,7 +62,7 @@ int getfscreatecon(security_context_t *c
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/getpeercon.c new/libselinux/src/getpeercon.c
--- old/libselinux/src/getpeercon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/getpeercon.c	2006-02-27 16:53:24.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/socket.h>
@@ -56,7 +57,7 @@ int getpeercon(int fd, security_context_
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/getpidcon.c new/libselinux/src/getpidcon.c
--- old/libselinux/src/getpidcon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/getpidcon.c	2006-02-27 16:56:38.000000000 -0500
@@ -2,6 +2,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <stdio.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/page.h>
@@ -60,7 +61,7 @@ int getpidcon(pid_t pid, security_contex
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/getprevcon.c new/libselinux/src/getprevcon.c
--- old/libselinux/src/getprevcon.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/getprevcon.c	2006-02-27 16:53:07.000000000 -0500
@@ -1,5 +1,6 @@
 #include <unistd.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <string.h>
 #include "selinux_internal.h"
 #include <stdlib.h>
@@ -56,7 +57,7 @@ int getprevcon(security_context_t *conte
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (!ret)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/init.c new/libselinux/src/init.c
--- old/libselinux/src/init.c	2005-12-14 11:04:23.000000000 -0500
+++ new/libselinux/src/init.c	2006-02-27 16:54:36.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
diff -Naurp --exclude-from excludes old/libselinux/src/lgetfilecon.c new/libselinux/src/lgetfilecon.c
--- old/libselinux/src/lgetfilecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/lgetfilecon.c	2006-02-27 16:52:41.000000000 -0500
@@ -2,6 +2,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <errno.h>
 #include <sys/xattr.h>
 #include "selinux_internal.h"
@@ -57,7 +58,7 @@ int lgetfilecon(const char *path, securi
 			*context = NULL;
 			ret = -1;
 		}
-		freecon(rcontext);
+		free(rcontext);
 	} else if (ret > 0)
 		*context = rcontext;
 
diff -Naurp --exclude-from excludes old/libselinux/src/load_policy.c new/libselinux/src/load_policy.c
--- old/libselinux/src/load_policy.c	2005-10-18 10:08:40.000000000 -0400
+++ new/libselinux/src/load_policy.c	2006-02-27 16:55:02.000000000 -0500
@@ -5,6 +5,7 @@
 #include <sys/mount.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
diff -Naurp --exclude-from excludes old/libselinux/src/lsetfilecon.c new/libselinux/src/lsetfilecon.c
--- old/libselinux/src/lsetfilecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/lsetfilecon.c	2006-02-27 16:41:07.000000000 -0500
@@ -24,7 +24,7 @@ int lsetfilecon(const char *path, securi
  	ret = lsetfilecon_raw(path, rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/matchpathcon.c new/libselinux/src/matchpathcon.c
--- old/libselinux/src/matchpathcon.c	2006-01-06 09:26:00.000000000 -0500
+++ new/libselinux/src/matchpathcon.c	2006-02-27 16:56:06.000000000 -0500
@@ -3,6 +3,7 @@
 #include <sys/stat.h>
 #include <string.h>
 #include "selinux_internal.h"
+#include <stddef.h>
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <stdlib.h>
diff -Naurp --exclude-from excludes old/libselinux/src/rpm.c new/libselinux/src/rpm.c
--- old/libselinux/src/rpm.c	2005-11-15 08:07:15.000000000 -0500
+++ new/libselinux/src/rpm.c	2006-02-27 16:47:49.000000000 -0500
@@ -1,3 +1,4 @@
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
@@ -36,7 +37,7 @@ int rpm_execcon(unsigned int verified __
 			goto out;
 		if (context_type_set(con, "rpm_script_t"))
 			goto out;
-		freecon(newcon);
+		free(newcon);
 		newcon = strdup(context_str(con));
 		if (!newcon)
 			goto out;
@@ -52,8 +53,8 @@ out:
 		rc = execve(filename, argv, envp); 
 
 	context_free(con);
-	freecon(newcon);
-	freecon(fcon);
-	freecon(mycon);
+	free(newcon);
+	free(fcon);
+	free(mycon);
 	return rc < 0 ? rc : 0;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/setcon.c new/libselinux/src/setcon.c
--- old/libselinux/src/setcon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/setcon.c	2006-02-27 16:52:48.000000000 -0500
@@ -2,6 +2,8 @@
  * Author: Trusted Computer Solutions, Inc. <chanson@trustedcs.com>
  */
 
+#include <stdlib.h>
+#include <stddef.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
@@ -38,7 +40,7 @@ int setcon(char *context)
  	ret = setcon_raw(rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/setexeccon.c new/libselinux/src/setexeccon.c
--- old/libselinux/src/setexeccon.c	2005-08-23 13:34:34.000000000 -0400
+++ new/libselinux/src/setexeccon.c	2006-02-27 16:57:21.000000000 -0500
@@ -1,3 +1,5 @@
+#include <stdlib.h>
+#include <stddef.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
@@ -34,7 +36,7 @@ int setexeccon(char *context)
  	ret = setexeccon_raw(rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/setfilecon.c new/libselinux/src/setfilecon.c
--- old/libselinux/src/setfilecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/setfilecon.c	2006-02-27 16:43:35.000000000 -0500
@@ -24,7 +24,7 @@ int setfilecon(const char *path, securit
  	ret = setfilecon_raw(path, rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/setfscreatecon.c new/libselinux/src/setfscreatecon.c
--- old/libselinux/src/setfscreatecon.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/setfscreatecon.c	2006-02-27 16:57:30.000000000 -0500
@@ -1,4 +1,6 @@
+#include <stdlib.h>
 #include <unistd.h>
+#include <stddef.h>
 #include <string.h>
 #include <fcntl.h>
 #include "selinux_internal.h"
@@ -34,7 +36,7 @@ int setfscreatecon(char *context)
  	ret = setfscreatecon_raw(rcontext);
 
 	if (context_translations)
-		freecon(rcontext);
+		free(rcontext);
 
 	return ret;
 }
diff -Naurp --exclude-from excludes old/libselinux/src/seusers.c new/libselinux/src/seusers.c
--- old/libselinux/src/seusers.c	2006-02-06 16:46:12.000000000 -0500
+++ new/libselinux/src/seusers.c	2006-02-27 16:53:15.000000000 -0500
@@ -1,6 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdio_ext.h>
diff -Naurp --exclude-from excludes old/libselinux/utils/avcstat.c new/libselinux/utils/avcstat.c
--- old/libselinux/utils/avcstat.c	2005-05-19 15:24:25.000000000 -0400
+++ new/libselinux/utils/avcstat.c	2006-02-27 16:52:03.000000000 -0500
@@ -10,6 +10,7 @@
  */
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <libgen.h>
 #include <stdarg.h>
 #include <errno.h>
diff -Naurp --exclude-from excludes old/libselinux/utils/compute_create.c new/libselinux/utils/compute_create.c
--- old/libselinux/utils/compute_create.c	2003-08-14 08:37:35.000000000 -0400
+++ new/libselinux/utils/compute_create.c	2006-02-27 16:46:07.000000000 -0500
@@ -29,6 +29,6 @@ int main(int argc, char **argv) 
 	}
 
 	printf("%s\n", buf);
-	freecon(buf);
+	free(buf);
 	exit(0);
 }
diff -Naurp --exclude-from excludes old/libselinux/utils/compute_member.c new/libselinux/utils/compute_member.c
--- old/libselinux/utils/compute_member.c	2004-12-02 13:20:19.000000000 -0500
+++ new/libselinux/utils/compute_member.c	2006-02-27 16:46:13.000000000 -0500
@@ -29,6 +29,6 @@ int main(int argc, char **argv) 
 	}
 
 	printf("%s\n", buf);
-	freecon(buf);
+	free(buf);
 	exit(0);
 }
diff -Naurp --exclude-from excludes old/libselinux/utils/compute_relabel.c new/libselinux/utils/compute_relabel.c
--- old/libselinux/utils/compute_relabel.c	2003-08-14 08:37:35.000000000 -0400
+++ new/libselinux/utils/compute_relabel.c	2006-02-27 16:46:45.000000000 -0500
@@ -29,6 +29,6 @@ int main(int argc, char **argv) 
 	}
 
 	printf("%s\n", buf);
-	freecon(buf);
+	free(buf);
 	exit(0);
 }
diff -Naurp --exclude-from excludes old/libselinux/utils/getfilecon.c new/libselinux/utils/getfilecon.c
--- old/libselinux/utils/getfilecon.c	2003-08-14 08:37:35.000000000 -0400
+++ new/libselinux/utils/getfilecon.c	2006-02-27 16:46:38.000000000 -0500
@@ -20,7 +20,7 @@ int main(int argc, char **argv) 
 			exit(2);
 		}
 		printf("%s\t%s\n", argv[i], buf);
-		freecon(buf);
+		free(buf);
 	}
 	exit(0);
 }
diff -Naurp --exclude-from excludes old/libselinux/utils/getpidcon.c new/libselinux/utils/getpidcon.c
--- old/libselinux/utils/getpidcon.c	2003-08-14 08:37:35.000000000 -0400
+++ new/libselinux/utils/getpidcon.c	2006-02-27 16:46:22.000000000 -0500
@@ -26,6 +26,6 @@ int main(int argc, char **argv) 
 	}
 
 	printf("%s\n", buf);
-	freecon(buf);
+	free(buf);
 	exit(0);
 }
diff -Naurp --exclude-from excludes old/libselinux/utils/matchpathcon.c new/libselinux/utils/matchpathcon.c
--- old/libselinux/utils/matchpathcon.c	2005-12-01 10:10:32.000000000 -0500
+++ new/libselinux/utils/matchpathcon.c	2006-02-27 16:46:29.000000000 -0500
@@ -64,7 +64,7 @@ int main(int argc, char **argv) 
 		else
 			printf("%s\n", buf);
 
-		freecon(buf);
+		free(buf);
 	}
 	return 0;
 }

--------------070402090704060607070904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
