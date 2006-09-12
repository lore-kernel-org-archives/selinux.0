Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8CGeBxf028991
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 12:40:11 -0400
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8CGdelE009438
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 16:39:41 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.8/8.13.8/Debian-2) with ESMTP id k8CGcQ4m001694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 11:38:26 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Latest libselinux and thread local storage
Date: Tue, 12 Sep 2006 11:38:25 -0500
Message-ID: <87hczdvy4e.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        On a number of architectures that are supported by , glibc 2.4
 is not yet stable enough for use in a production release -- at least,
 according to the maintainers and release managers of Debian (this is
 the case on mipsel, mips, arm, m68k and hppa). This is only of
 concern since glibc 2.4 is required to implement thread local
 storage.

        This means that thread local storage is not available on these
 architectures, and won't be included in the end-of-year stable
 release of Etch.  Given the glacial pace at which Debian releases,
 this would mean that we are looking at about two years out before we
 can have TLS in a stable release. I have created the following patch
 to work areound the TLS requirement; and present it here in the hope
 that it may be useful to someone else.

        A recent change in matchpathcon.c made a static file scoped
 variable (myflags) thread local -- the reason being, that the file
 local variable was temporarily modified by a couple of new calls
 (selinux_file_context_verify and selinux_lsetfilecon_default), and
 then reset back; and if any other threads used these variables, or
 worse, cached a local copy [which would save the modified version],
 modified it temporarily, and restored the cached version, the value
 would be corrupted.

	Simply changing the signatures of the calls to pass the
 variable along, instead of using the file scoped variable, was not
 viable, since this would change the API and thus the soname of the
 library.

        The solution in this patch is to keep the function calls as
 wrappers, and create _real versions of all functions that explicitly
 pass around the flag variable. All functions call the _real versions
 of the internal functions in the function body.  This makes the
 myflags variable thread safe again.

        I don't think this has much of a performance impact.

        The second place where thread local storage was being used was
 to implement a simple cache of security contexts in setrans_client.c;
 and here the caches do represent a critical region, and instead of
 using thread local variables, I just used POSIX mutexes to serialize
 the critical regions. 

        This will have a performance impact, but I am not sure it is
 perceptible.  These patches have been tested on my SELinux machines,
 and are known to compile on 11 different architectures that Debian
 supports.

        manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=libselinux-tls.patch
Content-Description: Patch to remove thread local storage requirements from
 libselinux


--- orig/src/matchpathcon.c
+++ mod/src/matchpathcon.c
@@ -76,7 +76,7 @@
 		mycanoncon = &default_canoncon;
 }
 
-static __thread unsigned int myflags;
+static unsigned int myflags;
 
 void set_matchpathcon_flags(unsigned int flags)
 {
@@ -440,8 +440,9 @@
 	}
 	return;
 }
-static int process_line(const char *path, const char *prefix, char *line_buf,
-			int pass, unsigned lineno)
+static int process_line_real(unsigned int local_flag, const char *path, 
+                             const char *prefix, char *line_buf, int pass, 
+                             unsigned lineno)
 {
 	int items, len, regerr;
 	char *buf_p;
@@ -591,7 +592,14 @@
 	return 0;
 }
 
-int matchpathcon_init_prefix(const char *path, const char *prefix)
+static int process_line(const char *path, const char *prefix, char *line_buf,
+			int pass, unsigned lineno)
+{
+  return process_line_real(myflags, path, prefix, line_buf,pass, lineno);
+}
+
+int matchpathcon_init_prefix_real(unsigned int local_flag, const char *path,
+                                   const char *prefix)
 {
 	FILE *fp;
 	FILE *localfp = NULL;
@@ -619,7 +627,7 @@
 		return -1;
 	}
 
-	if ((myflags & MATCHPATHCON_BASEONLY) == 0) {
+	if ((local_flag & MATCHPATHCON_BASEONLY) == 0) {
 		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs",
 			 path);
 		homedirfp = fopen(homedir_path, "r");
@@ -646,8 +654,8 @@
 		nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0
 		       && nspec < maxnspec) {
-			if (process_line(path, prefix, line_buf, pass, ++lineno)
-			    != 0)
+                  if (process_line_real(local_flag, path, prefix, line_buf,
+                                        pass, ++lineno) != 0)
 				goto finish;
 		}
 		lineno = 0;
@@ -664,9 +672,9 @@
 		if (localfp)
 			while (getline(&line_buf, &line_len, localfp) > 0
 			       && nspec < maxnspec) {
-				if (process_line
-				    (local_path, prefix, line_buf, pass,
-				     ++lineno) != 0)
+				if (process_line_real(local_flag, path, prefix,
+                                                      line_buf, pass, ++lineno)
+                                    != 0)
 					goto finish;
 			}
 
@@ -718,11 +726,22 @@
 	return status;
 }
 
+int matchpathcon_init_prefix(const char *path, const char *prefix)
+{
+  return matchpathcon_init_prefix_real(myflags, path, prefix);
+}
+
+
 hidden_def(matchpathcon_init_prefix)
 
+int matchpathcon_init_real(unsigned int local_flag, const char *path)
+{
+	return matchpathcon_init_prefix_real(local_flag, path, NULL);
+}
+
 int matchpathcon_init(const char *path)
 {
-	return matchpathcon_init_prefix(path, NULL);
+  return matchpathcon_init_prefix(path, NULL);
 }
 
 void matchpathcon_fini(void)
@@ -752,13 +771,14 @@
 	alloc_stems = 0;
 }
 
-static int matchpathcon_common(const char *name, mode_t mode)
+static int matchpathcon_common_real(unsigned int local_flag, const char *name,
+                                    mode_t mode)
 {
 	int i, ret, file_stem;
 	const char *buf = name;
 
 	if (!nspec) {
-		ret = matchpathcon_init_prefix(NULL, NULL);
+		ret = matchpathcon_init_prefix_real(local_flag, NULL, NULL);
 		if (ret < 0)
 			return ret;
 		if (!nspec) {
@@ -814,9 +834,16 @@
 
 }
 
-int matchpathcon(const char *name, mode_t mode, security_context_t * con)
+static int matchpathcon_common(const char *name, mode_t mode)
 {
-	int i = matchpathcon_common(name, mode);
+  return matchpathcon_common_real(myflags, name, mode);
+}
+
+
+int matchpathcon_real(unsigned int local_flag, const char *name, mode_t mode,
+                      security_context_t * con)
+{
+	int i = matchpathcon_common_real(local_flag, name, mode);
 
 	if (i < 0)
 		return -1;
@@ -860,10 +887,15 @@
 	errno = EINVAL;
 	return -1;
 }
+int matchpathcon(const char *name, mode_t mode, security_context_t * con)
+{
+  return matchpathcon_real(myflags, name, mode, con);
+}
 
-int matchpathcon_index(const char *name, mode_t mode, security_context_t * con)
+int matchpathcon_index_real(unsigned int local_flag, const char *name, 
+                            mode_t mode, security_context_t * con)
 {
-	int i = matchpathcon_common(name, mode);
+	int i = matchpathcon_common_real(local_flag, name, mode);
 
 	if (i < 0)
 		return -1;
@@ -875,6 +907,11 @@
 	return i;
 }
 
+int matchpathcon_index(const char *name, mode_t mode, security_context_t * con)
+{
+  return matchpathcon_index_real(myflags, name, mode, con);
+}
+
 void matchpathcon_checkmatches(char *str)
 {
 	unsigned int i;
@@ -922,7 +959,6 @@
 {
 	security_context_t con = NULL;
 	security_context_t fcontext = NULL;
-	unsigned int localflags = myflags;
 	int rc = 0;
 
 	rc = lgetfilecon_raw(path, &con);
@@ -932,16 +968,14 @@
 		else
 			return 0;
 	}
-
-	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
-	if (matchpathcon(path, mode, &fcontext) != 0) {
+        if (matchpathcon_real(myflags | MATCHPATHCON_NOTRANS, path, mode,
+                              &fcontext) != 0) {
 		if (errno != ENOENT)
 			rc = 1;
 		else
 			rc = 0;
 	} else
 		rc = (selinux_file_context_cmp(fcontext, con) == 0);
-	set_matchpathcon_flags(localflags);
 	freecon(con);
 	freecon(fcontext);
 	return rc;
@@ -952,21 +986,18 @@
 	struct stat st;
 	int rc = -1;
 	security_context_t scontext = NULL;
-	unsigned int localflags = myflags;
 	if (lstat(path, &st) != 0)
 		return rc;
 
-	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
-
 	/* If there's an error determining the context, or it has none, 
 	   return to allow default context */
-	if (matchpathcon(path, st.st_mode, &scontext)) {
+        if (matchpathcon_real(myflags | MATCHPATHCON_NOTRANS, path, st.st_mode,
+                              &scontext)) {
 		if (errno == ENOENT)
 			rc = 0;
 	} else {
 		rc = lsetfilecon_raw(path, scontext);
 		freecon(scontext);
 	}
-	set_matchpathcon_flags(localflags);
 	return rc;
 }


--- orig/src/setrans_client.c
+++ mod/src/setrans_client.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "dso.h"
 #include "selinux_internal.h"
 #include "setrans_internal.h"
@@ -19,10 +20,10 @@
 static int mls_enabled = -1;
 
 // Simple cache
-static __thread security_context_t prev_t2r_trans = NULL;
-static __thread security_context_t prev_t2r_raw = NULL;
-static __thread security_context_t prev_r2t_trans = NULL;
-static __thread security_context_t prev_r2t_raw = NULL;
+static security_context_t prev_t2r_trans = NULL;
+static security_context_t prev_t2r_raw = NULL;
+static security_context_t prev_r2t_trans = NULL;
+static security_context_t prev_r2t_raw = NULL;
 
 int cache_trans hidden = 1;
 
@@ -200,13 +201,20 @@
 	return ret;
 }
 
+static pthread_mutex_t trans_to_raw_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t raw_to_trans_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 hidden void fini_context_translations(void)
 {
 	if (cache_trans) {
+                pthread_mutex_lock(&trans_to_raw_mutex);
+                pthread_mutex_lock(&raw_to_trans_mutex);
 		free(prev_r2t_trans);
 		free(prev_r2t_raw);
 		free(prev_t2r_trans);
 		free(prev_t2r_raw);
+                pthread_mutex_unlock(&raw_to_trans_mutex);
+                pthread_mutex_unlock(&trans_to_raw_mutex);
 	}
 }
 
@@ -251,6 +259,7 @@
 	}
 
 	if (cache_trans) {
+                pthread_mutex_lock(&trans_to_raw_mutex);
 		if (prev_t2r_trans && strcmp(prev_t2r_trans, trans) == 0) {
 			*rawp = strdup(prev_t2r_raw);
 		} else {
@@ -271,6 +280,7 @@
 				}
 			}
 		}
+                pthread_mutex_unlock(&trans_to_raw_mutex);
 	} else if (trans_to_raw_context(trans, rawp))
 		*rawp = strdup(trans);
       out:
@@ -293,6 +303,7 @@
 	}
 
 	if (cache_trans) {
+                pthread_mutex_lock(&raw_to_trans_mutex);
 		if (prev_r2t_raw && strcmp(prev_r2t_raw, raw) == 0) {
 			*transp = strdup(prev_r2t_trans);
 		} else {
@@ -313,6 +324,7 @@
 				}
 			}
 		}
+                pthread_mutex_unlock(&raw_to_trans_mutex);
 	} else if (raw_to_trans_context(raw, transp))
 		*transp = strdup(raw);
       out:




--=-=-=


-- 
The qotc (quote of the con) was Liz's: "My brain is paged out to my
liver."
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
