Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h936aLsJ008373
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 02:36:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h936aK7d003379
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 06:36:21 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h936aKRn003376 for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 06:36:20 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 93251169D4BF
	for <selinux@tycho.nsa.gov>; Fri,  3 Oct 2003 08:36:14 +0200 (CEST)
Date: Fri, 3 Oct 2003 08:36:14 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: libselinux-1.2 and const usage
Message-ID: <20031003063614.GA20539@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

when trying to add selinux support to some of my applications, I
found out that the libselinux interface does not make usage of
"const", which ends in a lot of compiler warnings.

Attached is a patch for libselinux to solve this.

  Thorsten
-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libselinux-1.2.dif"

--- include/selinux/get_context_list.h
+++ include/selinux/get_context_list.h	2003/10/03 06:17:18
@@ -13,7 +13,7 @@
    customizable preferences.  Returns number of entries in *conary.
    If 'fromcon' is NULL, defaults to current context.
    Caller must free via freeconary. */
-extern int get_ordered_context_list(char *user, 
+extern int get_ordered_context_list(const char *user, 
 				    security_context_t fromcon,
 				    security_context_t **list);
 
@@ -24,7 +24,7 @@
    If 'fromcon' is NULL, defaults to current context.
    Returns 0 on success or -1 otherwise.
    Caller must free via freecon. */
-extern int get_default_context(char* user, 
+extern int get_default_context(const char* user, 
 			       security_context_t fromcon,
 			       security_context_t *newcon);
 
@@ -39,6 +39,7 @@
    if a list of authorized contexts could not be obtained. 
    Caller must free via freecon.
    Returns 0 on success or -1 otherwise. */
-extern int manual_user_enter_context(char *user, security_context_t *newcon);
+extern int manual_user_enter_context(const char *user,
+				     security_context_t *newcon);
 
 #endif
--- include/selinux/selinux.h
+++ include/selinux/selinux.h	2003/10/03 06:19:39
@@ -98,7 +98,7 @@
 /* Compute the set of reachable user contexts and set *con to refer to 
    the NULL-terminated array of contexts.  Caller must free via freeconary. */
 extern int security_compute_user(security_context_t scon,
-				 char *username,
+				 const char *username,
 				 security_context_t **con);
 
 /* Load a policy configuration. */
--- src/compute_user.c
+++ src/compute_user.c	2003/10/03 06:19:00
@@ -10,7 +10,7 @@
 #include "policy.h"
 
 int security_compute_user(security_context_t scon,
-			  char *user,
+			  const char *user,
 			  security_context_t **con)
 {
 	char **ary;
--- src/get_context_list.c
+++ src/get_context_list.c	2003/10/03 06:17:18
@@ -10,7 +10,7 @@
 #define USERPRIORITY 1
 #define SYSTEMPRIORITY 2
 
-int get_default_context(char* user, 
+int get_default_context(const char* user, 
 			security_context_t fromcon,
 			security_context_t *newcon)
 {
@@ -112,7 +112,7 @@
 		      pri_list.  The number of elements stored in pri_list 
 		      is returned.
 */
-static int list_from_string (char *instr, char *user, 
+static int list_from_string (char *instr, const char *user, 
                              security_context_t *pri_list, 
                              int pri_length)
 {
@@ -170,7 +170,7 @@
                       in pri_list or -1 on error.
 */
 static int get_context_list (FILE *infile, security_context_t fromcon, 
-                             char *user, security_context_t *pri_list, 
+                             const char *user, security_context_t *pri_list, 
                              int pri_length)
 {
     int ret_val = 0;        /* Used for return values                    */
@@ -197,7 +197,7 @@
                          system configuration file.  The number of contexts placed
                          in pri_list is returned.
  */
-static int get_config_priority (security_context_t fromcon, char *user, 
+static int get_config_priority (security_context_t fromcon, const char *user, 
                          security_context_t *pri_list, int pri_length, int which,
                          int default_user_flag)
 {
@@ -346,7 +346,7 @@
     return ret_val;
 }
 
-int get_ordered_context_list (char *user, 
+int get_ordered_context_list (const char *user, 
 			      security_context_t fromcon, 
 			      security_context_t **list)
 {
@@ -376,7 +376,7 @@
 	    freefrom = 1;
     }
 
-    rc = security_compute_user(fromcon, (char*)user, &init_list);
+    rc = security_compute_user(fromcon, user, &init_list);
     if (rc < 0) {
 	    /* Retry with the default SELinux user identity. */
 	    rc = security_compute_user(fromcon, 
--- src/query_user_context.c
+++ src/query_user_context.c	2003/10/03 06:17:18
@@ -109,7 +109,7 @@
  *                     context chosen by the user into usercon.  Returns 0
  *                     on success.
  */
-int manual_user_enter_context (char *user, security_context_t *newcon)
+int manual_user_enter_context (const char *user, security_context_t *newcon)
 {
     char response[10];     /* Used to get yes or no answers from user */
     char role[100];        /* The role requested by the user          */
@@ -120,9 +120,9 @@
     int  levellen = 100;
     int mls_enabled = 0;
 
-    context_t new_context; /* The new context chosen by the user      */
-    char *user_context;    /* String value of the user's context      */
-    int done = 0;          /* true if a valid sid has been obtained   */
+    context_t new_context;     /* The new context chosen by the user     */
+    char *user_context = NULL; /* String value of the user's context     */
+    int done = 0;              /* true if a valid sid has been obtained  */
 
     /* Initialize the context.  How this is done depends on whether
        or not MLS is enabled                                        */

--uAKRQypu60I7Lcqm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
