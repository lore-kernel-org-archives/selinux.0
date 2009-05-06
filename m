Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n46AdZFG008555
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 06:39:35 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n46AdX1c002566
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 10:39:34 GMT
Subject: Re: Problems with freeing thread local storage in libselinux
From: Tomas Mraz <tmraz@redhat.com>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov, 505920-forwarded@bgs.debian.org,
        Kees Cook <kees@debian.org>, 505920-submitter@bugs.debian.org,
        selinux-devel-owner@lists.alioth.debian.org
In-Reply-To: <8763geivwy.fsf@anzu.internal.golden-gryphon.com>
References: <8763geivwy.fsf@anzu.internal.golden-gryphon.com>
Content-Type: multipart/mixed; boundary="=-/svSu3QYFG4G7DtvV2F+"
Date: Wed, 06 May 2009 12:38:35 +0200
Message-Id: <1241606316.25946.182.camel@vespa.frost.loc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/svSu3QYFG4G7DtvV2F+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2009-05-06 at 01:32 -0500, Manoj Srivastava wrote:
> Hi folks,
> 
>         There have been numerous reports in Debian and derivatives of
>  programs linked with libselinux intermittently getting segfaults.
>  There is, for instance, the Debian report 505920[0], and Ubuntu
>  reports[1], [3] and [5], and Gnome [2]. I have not been able to
>  reproduce the error myself, though I have run the test cases a number
>  of times.
> 
>         The common thread in unclutter, libavg, gst-inspect et al. is a
>  segmentation fault in libselinux1, in the 'fini' destructor functions,
>  referencing the thread local variables.
> 
>         The Ubuntu bug log reference my old patch for libselinux from
>  1.X days, where I replaced the thread local storage with regular
>  variables and mutexes, and people report success with that.  I suspect
>  that something is corrupting the thread local storage. From the ubuntu
>  report:
> --8<---------------cut here---------------start------------->8---
> Valgrind reports:
> =29183== Invalid read of size 8
> ==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
> ==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
> ==29183== by 0xE29D040: (within /lib/libselinux.so.1)
> ==29183== by 0x570010F: exit (exit.c:75)
> 505920==29183== by 0x56E91CA: (below main) (libc-start.c:252)
> ==29183== Address 0x80 is not stack'd, malloc'd or (recently) free'd
> ==29183==
> ==29183== Process terminating with default action of signal 11 (SIGSEGV): dumping core
> ==29183== Access not within mapped region at address 0x80
> ==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
> ==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
> ==29183== by 0xE29D040: (within /lib/libselinux.so.1)==29183== by 0x570010F: exit (exit.c:75)
> ==29183== by 0x56E91CA: (below main) (libc-start.c:252)
> 
> 
> (gdb) bt
> #0 0x00007f3ae812a9dd in fini_context_translations () at setrans_client.c:211
> #1 0x00007f3ae811e1f2 in __do_global_dtors_aux () from /lib/libselinux.so.1
> #2 0x00007ffff9097700 in ?? ()
> #3 0x00007f3ae812c041 in _fini () from /lib/libselinux.so.1
> #4 0x00007ffff9097700 in ?? ()
> #5 0x00007f3af0e88796 in _dl_fini () from /lib64/ld-linux-x86-64.so.2
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> --8<---------------cut here---------------end--------------->8---
> 
>         There have been two sets of patches proposed for this; first one
>  merely initializes the variables in the init function, and this works
>  for a number of people, but at least one person has reported a second
>  segfault even with the patch installed[6]
> 
>         The second patch below converts a thread local cache to a
>  process wide cache, with mutex guards, which makes the cache slower,
>  and non-thread local caches means that cache misses are more likely.
> 
>         I'll try and follow up with people who can reproduce the
>  problems to see if either one of the patches solve their problems
>  without triggering other segmentation faults, but I'd appreciate
>  comments if anyone has insight into the issue.

The problem is with freeing storage referenced by TLS variables in
destructors. The destructor is called only in one of the threads and the
variables might not be even properly initialized in that thread. One
possibility is to not free the storage at all but that will leak memory
if the libselinux is loaded/unloaded multiple times in a process.

The only proper way is to use TSD (pthread_key_create,
pthread_setspecific etc.) to store the pointers to the cached contexts.

The attached patch implements this. I did not test it thoroughly though.

-- 
Tomas Mraz
No matter how far down the wrong road you've gone, turn back.
                                              Turkish proverb

--=-/svSu3QYFG4G7DtvV2F+
Content-Disposition: attachment; filename="libselinux-2.0.80-tsd.patch"
Content-Type: text/x-patch; name="libselinux-2.0.80-tsd.patch"; charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit

diff -up libselinux-2.0.80/src/Makefile.tsd libselinux-2.0.80/src/Makefile
--- libselinux-2.0.80/src/Makefile.tsd	2009-05-06 12:33:57.000000000 +0200
+++ libselinux-2.0.80/src/Makefile	2009-05-06 12:33:57.000000000 +0200
@@ -79,7 +79,7 @@ $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -lpthread -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 selinuxswig_exception.i: ../include/selinux/selinux.h
diff -up libselinux-2.0.80/src/setrans_client.c.tsd libselinux-2.0.80/src/setrans_client.c
--- libselinux-2.0.80/src/setrans_client.c.tsd	2009-04-08 15:06:24.000000000 +0200
+++ libselinux-2.0.80/src/setrans_client.c	2009-05-06 12:37:08.000000000 +0200
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "dso.h"
 #include "selinux_internal.h"
 #include "setrans_internal.h"
@@ -26,12 +27,13 @@
 static int mls_enabled = -1;
 
 // Simple cache
-static __thread security_context_t prev_t2r_trans = NULL;
-static __thread security_context_t prev_t2r_raw = NULL;
-static __thread security_context_t prev_r2t_trans = NULL;
-static __thread security_context_t prev_r2t_raw = NULL;
-static __thread char *prev_r2c_trans = NULL;
-static __thread security_context_t prev_r2c_raw = NULL;
+static pthread_key_t prev_t2r_trans_key;
+static pthread_key_t prev_t2r_raw_key;
+static pthread_key_t prev_r2t_trans_key;
+static pthread_key_t prev_r2t_raw_key;
+static pthread_key_t prev_r2c_trans_key;
+static pthread_key_t prev_r2c_raw_key;
+static pthread_once_t make_keys_once = PTHREAD_ONCE_INIT;
 
 /*
  * setransd_open
@@ -238,22 +240,89 @@ out:
 	return ret;
 }
 
+static void delete_value(void *value)
+{
+	free(value);
+}
+
+static void drop_cached_value(pthread_key_t cache_key)
+{
+	void *value;
+	value = pthread_getspecific(cache_key);
+	if (value) {
+		pthread_setspecific(cache_key, NULL);
+		delete_value(value);
+	}
+}
+
 hidden void fini_context_translations(void)
 {
-	free(prev_r2t_trans);
-	free(prev_r2t_raw);
-	free(prev_t2r_trans);
-	free(prev_t2r_raw);
-	free(prev_r2c_trans);
-	free(prev_r2c_raw);
+/* this is not necessary but if we are single threaded
+   we can free the data earlier than on exit */
+	drop_cached_value(prev_r2t_trans_key);
+	drop_cached_value(prev_r2t_raw_key);
+	drop_cached_value(prev_t2r_trans_key);
+	drop_cached_value(prev_t2r_raw_key);
+	drop_cached_value(prev_r2c_trans_key);
+	drop_cached_value(prev_r2c_raw_key);
+}
+
+static void make_keys(void)
+{
+	(void)pthread_key_create(&prev_t2r_trans_key, delete_value);
+	(void)pthread_key_create(&prev_t2r_raw_key, delete_value);
+	(void)pthread_key_create(&prev_r2t_trans_key, delete_value);
+	(void)pthread_key_create(&prev_r2t_raw_key, delete_value);
+	(void)pthread_key_create(&prev_r2c_trans_key, delete_value);
+	(void)pthread_key_create(&prev_r2c_raw_key, delete_value);
 }
 
 hidden int init_context_translations(void)
 {
 	mls_enabled = is_selinux_mls_enabled();
+	(void)pthread_once(&make_keys_once, make_keys);
 	return 0;
 }
 
+static void *match_cached_value(pthread_key_t cache_from,
+			 pthread_key_t cache_to,
+			 const char *match_from)
+{
+	void *from, *to;
+
+	from = pthread_getspecific(cache_from);
+	to = pthread_getspecific(cache_to);
+	if (from && strcmp(from, match_from) == 0) {
+		return strdup(to);
+	} else {
+		pthread_setspecific(cache_from, NULL);
+		delete_value(from);
+		pthread_setspecific(cache_to, NULL);
+		delete_value(to);
+		errno = 0;
+		return NULL;
+	}
+}
+
+void set_cached_value(pthread_key_t cache_from,
+		      pthread_key_t cache_to,
+		      void *from,
+		      void *to)
+{
+	from = strdup(from);
+	if (from == NULL)
+		return;
+
+	to = strdup(to);
+	if (to == NULL) {
+		free(from);
+		return;
+	}
+
+	pthread_setspecific(cache_from, from);
+	pthread_setspecific(cache_to, to);
+}
+
 int selinux_trans_to_raw_context(security_context_t trans,
 				 security_context_t * rawp)
 {
@@ -267,24 +336,13 @@ int selinux_trans_to_raw_context(securit
 		goto out;
 	}
 
-	if (prev_t2r_trans && strcmp(prev_t2r_trans, trans) == 0) {
-		*rawp = strdup(prev_t2r_raw);
-	} else {
-		free(prev_t2r_trans);
-		prev_t2r_trans = NULL;
-		free(prev_t2r_raw);
-		prev_t2r_raw = NULL;
+	if ((*rawp = match_cached_value(prev_t2r_trans_key, prev_t2r_raw_key, trans)) == NULL
+	    && errno == 0) {
 		if (trans_to_raw_context(trans, rawp))
 			*rawp = strdup(trans);
 		if (*rawp) {
-			prev_t2r_trans = strdup(trans);
-			if (!prev_t2r_trans)
-				goto out;
-			prev_t2r_raw = strdup(*rawp);
-			if (!prev_t2r_raw) {
-				free(prev_t2r_trans);
-				prev_t2r_trans = NULL;
-			}
+			set_cached_value(prev_t2r_trans_key, prev_t2r_raw_key,
+					 trans, *rawp);
 		}
 	}
       out:
@@ -306,24 +364,13 @@ int selinux_raw_to_trans_context(securit
 		goto out;
 	}
 
-	if (prev_r2t_raw && strcmp(prev_r2t_raw, raw) == 0) {
-		*transp = strdup(prev_r2t_trans);
-	} else {
-		free(prev_r2t_raw);
-		prev_r2t_raw = NULL;
-		free(prev_r2t_trans);
-		prev_r2t_trans = NULL;
+	if ((*transp = match_cached_value(prev_r2t_raw_key, prev_r2t_trans_key, raw)) == NULL
+	    && errno == 0) {
 		if (raw_to_trans_context(raw, transp))
 			*transp = strdup(raw);
 		if (*transp) {
-			prev_r2t_raw = strdup(raw);
-			if (!prev_r2t_raw)
-				goto out;
-			prev_r2t_trans = strdup(*transp);
-			if (!prev_r2t_trans) {
-				free(prev_r2t_raw);
-				prev_r2t_raw = NULL;
-			}
+			set_cached_value(prev_r2t_raw_key, prev_r2t_trans_key,
+					 raw, *transp);
 		}
 	}
       out:
@@ -339,27 +386,15 @@ int selinux_raw_context_to_color(securit
 		return -1;
 	}
 
-	if (prev_r2c_raw && strcmp(prev_r2c_raw, raw) == 0) {
-		*transp = strdup(prev_r2c_trans);
-	} else {
-		free(prev_r2c_raw);
-		prev_r2c_raw = NULL;
-		free(prev_r2c_trans);
-		prev_r2c_trans = NULL;
+	if ((*transp = match_cached_value(prev_r2c_raw_key, prev_r2c_trans_key, raw)) == NULL
+	    && errno == 0) {
 		if (raw_context_to_color(raw, transp))
 			return -1;
 		if (*transp) {
-			prev_r2c_raw = strdup(raw);
-			if (!prev_r2c_raw)
-				goto out;
-			prev_r2c_trans = strdup(*transp);
-			if (!prev_r2c_trans) {
-				free(prev_r2c_raw);
-				prev_r2c_raw = NULL;
-			}
+			set_cached_value(prev_r2c_raw_key, prev_r2c_trans_key,
+					 raw, *transp);
 		}
 	}
-      out:
 	return *transp ? 0 : -1;
 }
 

--=-/svSu3QYFG4G7DtvV2F+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
