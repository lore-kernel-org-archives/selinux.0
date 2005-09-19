Subject: Re: Doing testing with MCS looks like we get initial roles/levels
	by using fromcon.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <432B2B68.5030006@redhat.com>
References: <4329DF91.2060208@redhat.com>
	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>
	 <432AFFE4.3010001@redhat.com>
	 <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>
	 <432B1157.8070703@redhat.com>
	 <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>
	 <432B1BAC.9000800@redhat.com>
	 <1126899285.27393.129.camel@moss-spartans.epoch.ncsc.mil>
	 <432B2B68.5030006@redhat.com>
Content-Type: multipart/mixed; boundary="=-6q1o2iZhlYvVMUMwrj4R"
Date: Mon, 19 Sep 2005 11:50:56 -0400
Message-Id: <1127145056.29404.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6q1o2iZhlYvVMUMwrj4R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-09-16 at 16:30 -0400, Daniel J Walsh wrote:
> Ok how about this patch for libselinux.
> 
> Includes STRIP_LEVEL for removing :s0* from matchpathcon if non MLS 
> system.   This is needed for upgrading machines to MCS/MLS

- I think that the first STRIP_LEVEL call is unnecessary, as you only
need to do this once prior to calling the myinvalidcon callback for
context validation.
- The second STRIP_LEVEL call should be moved into the if block so that
it isn't applied to <<none>>.  This also means we should move down the
assignment to the spec array until after that block so that we use the
final stripped value.
- I don't think that the STRIP_LEVEL call should occur if context
translations are enabled.  
- STRIP_LEVEL can fail upon memory allocation failures in context_str
and strdup, so we need to check errors there and propagate them to the
caller.

Revised patch for STRIP_LEVEL attached, separated from the rest of the
patch.  Please review.

> Added selinux_getpolicytype(), even though not used yet by external 
> apps, it could be used in the future.

I think that I will omit this until we have a real user, and if we do
find a real user, I'd suggest making it consistent with the other
selinux* functions there, i.e. return the string as the return value
rather than as a pointer argument.

> Added  int get_ordered_context_list_with_level (const char *user,
>                                         const char *level,
>                                         security_context_t fromcon,
>                                         security_context_t **list)

- context_range_set and context_str can fail on memory allocation, so
you need to separate them out and check for errors.

Revised patch for get_ordered_context_list_with_level attached, with
function prototypes added, get_default_context_with_level helper added,
and changes to the getconlist utility to allow testing it.  Please
review.


-- 
Stephen Smalley
National Security Agency

--=-6q1o2iZhlYvVMUMwrj4R
Content-Disposition: attachment; filename=getconlist.patch
Content-Type: text/x-patch; name=getconlist.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/get_context_list.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list.c,v
retrieving revision 1.27
diff -u -p -r1.27 get_context_list.c
--- libselinux/src/get_context_list.c	11 Aug 2005 13:58:28 -0000	1.27
+++ libselinux/src/get_context_list.c	19 Sep 2005 14:43:40 -0000
@@ -288,6 +288,71 @@ static int order_compare(const void *A, 
 	return strcmp(c1->con, c2->con);
 }
 
+int get_ordered_context_list_with_level (const char *user, 
+					 const char *level, 
+					 security_context_t fromcon, 
+					 security_context_t **list)
+{
+    int rc;
+    int freefrom = 0;
+    context_t con;
+    char *newfromcon;
+
+    if (!level) 
+	    return get_ordered_context_list (user, fromcon, list);
+
+    if (!fromcon) {
+	rc = getcon(&fromcon);
+	if (rc < 0)
+		return rc;
+	freefrom = 1;
+    }
+
+    rc = -1;
+    con=context_new(fromcon);
+    if (!con)
+	    goto out;
+
+    if (context_range_set(con, level)) {
+	    rc = -1;
+	    goto out;
+    }
+
+    newfromcon = context_str(con);
+    if (!newfromcon) {
+	    rc = -1;
+	    goto out;
+    }
+
+    rc = get_ordered_context_list (user, newfromcon, list);
+
+out:
+    context_free(con);
+    if (freefrom) 
+	    freecon(fromcon);
+    return rc;
+}
+hidden_def(get_ordered_context_list_with_level)
+
+int get_default_context_with_level(const char *user, 
+				   const char *level,
+				   security_context_t fromcon,
+				   security_context_t *newcon)
+{
+    security_context_t *conary;
+    int rc;
+
+    rc = get_ordered_context_list_with_level(user, level, fromcon, &conary);
+    if (rc <= 0)
+	    return -1;
+
+    *newcon = strdup(conary[0]);
+    freeconary(conary);
+    if (!(*newcon))
+	    return -1;
+    return 0;
+}
+
 int get_ordered_context_list (const char *user, 
 			      security_context_t fromcon, 
 			      security_context_t **list)
Index: libselinux/src/get_context_list_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list_internal.h,v
retrieving revision 1.1
diff -u -p -r1.1 get_context_list_internal.h
--- libselinux/src/get_context_list_internal.h	25 Aug 2004 12:20:47 -0000	1.1
+++ libselinux/src/get_context_list_internal.h	19 Sep 2005 14:43:40 -0000
@@ -2,3 +2,4 @@
 #include "dso.h"
 
 hidden_proto(get_ordered_context_list)
+hidden_proto(get_ordered_context_list_with_level)
Index: libselinux/utils/getconlist.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/utils/getconlist.c,v
retrieving revision 1.3
diff -u -p -r1.3 getconlist.c
--- libselinux/utils/getconlist.c	4 Apr 2005 15:27:09 -0000	1.3
+++ libselinux/utils/getconlist.c	19 Sep 2005 15:00:01 -0000
@@ -9,16 +9,33 @@
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
 
+void usage(char *name, char *detail, int rc) 
+{
+	fprintf(stderr, "usage:  %s [-l level] user [context]\n", name);
+	if (detail)
+		fprintf(stderr, "%s:  %s\n", name, detail);
+	exit(rc);
+}
+
 int main(int argc, char **argv) 
 {
 	security_context_t *list, usercon = NULL, cur_context = NULL;
-	int ret, i;
+	char *user = NULL, *level = NULL;
+	int ret, i, opt;
 
-	if (argc < 2 || argc > 3) {
-		fprintf(stderr, "usage:  %s user [context]\n", argv[0]);
-		return 1;
+	while ((opt = getopt(argc, argv, "l:")) > 0) {
+		switch (opt) {
+		case 'l':
+			level = strdup(optarg);
+			break;
+		default:
+			usage(argv[0], "invalid option", 1);
+		}
 	}
 
+	if (((argc - optind) < 1) || ((argc - optind) > 2))
+		usage(argv[0], "invalid number of arguments", 2);
+
 	/* If selinux isn't available, bail out. */
 	if( !is_selinux_enabled() ) {
 	    fprintf( stderr,
@@ -26,18 +43,23 @@ int main(int argc, char **argv) 
 	    return 1;
 	}
 
+	user = argv[optind];
+
 	/* If a context wasn't passed, use the current context. */
-	if (argc < 3) {
+	if (((argc - optind) < 2)) {
 		if (getcon(&cur_context) < 0) {
 			fprintf( stderr, "Couldn't get current context.\n" );
 			return 2;
 		}
 	}
 	else
-		cur_context = argv[2];
+		cur_context = argv[optind+1];
 
 	/* Get the list and print it */
-	ret = get_ordered_context_list(argv[1], cur_context, &list);
+	if (level)
+		ret = get_ordered_context_list_with_level(user, level, cur_context, &list);
+	else
+		ret = get_ordered_context_list(user, cur_context, &list);
 	if(ret != -1) {
 		for (i = 0; list[i]; i++)
 			puts (list[i]);
Index: libselinux/include/selinux/get_context_list.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/get_context_list.h,v
retrieving revision 1.6
diff -u -p -r1.6 get_context_list.h
--- libselinux/include/selinux/get_context_list.h	30 Nov 2004 19:38:50 -0000	1.6
+++ libselinux/include/selinux/get_context_list.h	19 Sep 2005 14:43:40 -0000
@@ -21,6 +21,13 @@ extern int get_ordered_context_list(cons
 				    security_context_t fromcon,
 				    security_context_t **list);
 
+/* As above, but use the provided MLS level rather than the
+   default level for the user. */
+int get_ordered_context_list_with_level (const char *user, 
+					 const char *level, 
+					 security_context_t fromcon, 
+					 security_context_t **list);
+
 /* Get the default security context for a user session for 'user'
    spawned by 'fromcon' and set *newcon to refer to it.  The context
    will be one of those authorized by the policy, but the selection
@@ -32,6 +39,13 @@ extern int get_default_context(const cha
 			       security_context_t fromcon,
 			       security_context_t *newcon);
 
+/* As above, but use the provided MLS level rather than the
+   default level for the user. */
+int get_default_context_with_level(const char *user, 
+				   const char *level,
+				   security_context_t fromcon,
+				   security_context_t *newcon);
+
 /* Same as get_default_context, but only return a context
    that has the specified role.  If no reachable context exists
    for the user with that role, then return -1. */

--=-6q1o2iZhlYvVMUMwrj4R
Content-Disposition: attachment; filename=matchpathcon.diff
Content-Type: text/x-patch; name=matchpathcon.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.28
diff -u -p -r1.28 matchpathcon.c
--- libselinux/src/matchpathcon.c	23 Aug 2005 16:46:41 -0000	1.28
+++ libselinux/src/matchpathcon.c	19 Sep 2005 15:35:18 -0000
@@ -12,6 +12,7 @@
 #include <regex.h>
 #include <stdarg.h>
 #include "policy.h"
+#include <selinux/context.h>
 
 static void 
 #ifdef __GNUC__
@@ -25,6 +26,41 @@ default_printf(const char *fmt, ...) 
 	va_end(ap);
 }
 
+/* If MLS is disabled, strip any MLS level field from the context.
+   This allows file_contexts with MLS levels to be processed on
+   a non-MLS system that otherwise has the same policy. */
+static inline int STRIP_LEVEL(char **context, int mls_enabled)
+{
+	char *str;
+	context_t con;
+	int rc = -1;
+
+	if (mls_enabled)
+		return 0;
+
+	con = context_new(*context);
+	if (!con)
+		return rc;
+
+	if (context_range_set(con,NULL))
+		goto out;
+
+	str = context_str(con);
+	if (!str)
+		goto out;
+
+	str = strdup(str);
+	if (!str)
+		goto out;
+
+	free(*context);
+	*context = str;
+	rc = 0;
+out:
+	context_free(con);
+	return rc;
+}
+
 static void (*myprintf)(const char *fmt, ...) = &default_printf;
 
 void set_matchpathcon_printf(void (*f)(const char *fmt, ...))
@@ -415,7 +451,7 @@ static void spec_hasMetaChars(struct spe
 	}
 	return;
 }
-static int process_line( const char *path, char *line_buf, int pass, unsigned lineno) {
+static int process_line( const char *path, char *line_buf, int pass, unsigned lineno, int mls_enabled) {
 	int items, len, regerr;
 	char *buf_p;
 	char *regex, *type, *context;
@@ -510,9 +546,6 @@ static int process_line( const char *pat
 		}
 		
 	skip_type:
-		
-		spec_arr[nspec].context = context;
-		
 		if (strcmp(context, "<<none>>")) {
 			if (context_translations) {
 				if (raw_to_trans_context(context,
@@ -524,11 +557,16 @@ static int process_line( const char *pat
 				}
 				free(context);
 				context = spec_arr[nspec].context;
+			} else {
+				if (STRIP_LEVEL(&context, mls_enabled))
+					return -1;
 			}
 
 			if (myinvalidcon(path, lineno, context))
 				return 0;
 		}
+
+		spec_arr[nspec].context = context;
 		
 		/* Determine if specification has 
 		 * any meta characters in the RE */
@@ -557,6 +595,7 @@ int matchpathcon_init(const char *path)
 	unsigned int lineno, pass, i, j, maxnspec;
 	spec_t *spec_copy=NULL;
 	int status=-1;
+	int mls_enabled=is_selinux_mls_enabled();
 
 	/* Open the specification file. */
 	if (!path)
@@ -590,20 +629,20 @@ int matchpathcon_init(const char *path)
 		lineno = 0;
 		nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0 && nspec < maxnspec) {
-			if (process_line(path, line_buf, pass, ++lineno) != 0)
+			if (process_line(path, line_buf, pass, ++lineno, mls_enabled) != 0)
 				goto finish;
 		}
 		lineno = 0;
 		if (homedirfp) 
 			while (getline(&line_buf, &line_len, homedirfp) > 0 && nspec < maxnspec) {
-				if (process_line(homedir_path, line_buf, pass, ++lineno) != 0)
+				if (process_line(homedir_path, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 
 		lineno = 0;
 		if (localfp) 
 			while (getline(&line_buf, &line_len, localfp) > 0 && nspec < maxnspec) {
-				if (process_line(local_path, line_buf, pass, ++lineno) != 0)
+				if (process_line(local_path, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 

--=-6q1o2iZhlYvVMUMwrj4R--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
