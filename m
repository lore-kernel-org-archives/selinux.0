Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6PN9IaG010239
 for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2017 19:09:18 -0400
Received: by mail-pf0-f179.google.com with SMTP id q85so63759651pfq.1
 for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2017 16:08:53 -0700 (PDT)
From: Tom Cherry <tomcherry@google.com>
To: selinux@tycho.nsa.gov
Date: Tue, 25 Jul 2017 15:59:44 -0700
Message-Id: <20170725225944.12336-1-tomcherry@google.com>
MIME-Version: 1.0
Subject: [PATCH] libselinux: fix thread safety issues with
 lookup_common()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are two problems with lookup_common() and therefore
selabel_lookup() and related functions that this patch fixes:

1) A race with the lazy compilation of regexes.  Since the struct
regex_data is allocated and assigned immediately to the parent struct
spec, it's possible for a second thread to see that this pointer is
non-NULL before the regex compilation has finished.  This typically
results in a -1 return from selabel_lookup() with ENOENT as errno.

This is fixed by adding synchronization in compile_regex().

2) A race with PCRE2 regex_match().  A struct pcre2_match_data is
created once and used for all regex matches for a given regex.  This
is problematic if two threads are attempting to evaluate the same
regex simultaneously.  This typically results in a successful return
from selabel_lookup() but with an erroneous selabel.

This is fixed by adding a pthread_mutex within regex_match() for
PCRE2.  Note, on my system, creating new matchdata takes roughly an
order of magnitude more time than locking a non-contended
pthread_mutex.  I don't believe programs will have enough contention
on this lock to justify that cost.

Bug: 63861738
Test: ueventd unit tests
Change-Id: I13bf782d81d0a0b896d444e396f307ad0dbacb6a
---
 libselinux/src/label_file.c       |  3 +++
 libselinux/src/label_file.h       | 32 ++++++++++++++++++++++++++++++--
 libselinux/src/regex.c            | 18 ++++++++++++++++--
 libselinux/src/selinux_internal.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index f84d470b..6300758e 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -393,6 +393,8 @@ end_arch_check:
 		if (rc < 0)
 			goto out;
=20
+		__pthread_mutex_init(&spec->regex_lock, NULL);
+		spec->regex_compiled =3D true;
 		data->nspec++;
 	}
=20
@@ -810,6 +812,7 @@ static void closef(struct selabel_handle *rec)
 		free(spec->lr.ctx_trans);
 		free(spec->lr.ctx_raw);
 		regex_data_free(spec->regex);
+		__pthread_mutex_destroy(&spec->regex_lock);
 		if (spec->from_mmap)
 			continue;
 		free(spec->regex_str);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index de804aed..aa576d8e 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -2,6 +2,7 @@
 #define _SELABEL_FILE_H_
=20
 #include <errno.h>
+#include <pthread.h>
 #include <string.h>
=20
 #include <sys/stat.h>
@@ -16,6 +17,7 @@
=20
 #include "callbacks.h"
 #include "label_internal.h"
+#include "selinux_internal.h"
=20
 #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
=20
@@ -42,6 +44,8 @@ struct spec {
 	char *regex_str;	/* regular expession string for diagnostics */
 	char *type_str;		/* type string for diagnostic messages */
 	struct regex_data * regex; /* backend dependent regular expression data=
 */
+	bool regex_compiled; /* bool to indicate if the regex is compiled */
+	pthread_mutex_t regex_lock; /* lock for lazy compilation of regex */
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
 	int stem_id;		/* indicates which stem-compression item */
@@ -339,9 +343,27 @@ static inline int compile_regex(struct saved_data *d=
ata, struct spec *spec,
 	struct stem *stem_arr =3D data->stem_arr;
 	size_t len;
 	int rc;
-
-	if (spec->regex)
+	bool regex_compiled;
+
+	/* We really want pthread_once() here, but since its
+	 * init_routine does not take a parameter, it's not possible
+	 * to use, so we generate the same effect with atomics and a
+	 * mutex */
+	regex_compiled =3D
+		__atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
+	if (regex_compiled) {
 		return 0; /* already done */
+	}
+
+	__pthread_mutex_lock(&spec->regex_lock);
+	/* Check if another thread compiled the regex while we waited
+	 * on the mutex */
+	regex_compiled =3D
+		__atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
+	if (regex_compiled) {
+		__pthread_mutex_unlock(&spec->regex_lock);
+		return 0;
+	}
=20
 	/* Skip the fixed stem. */
 	reg_buf =3D spec->regex_str;
@@ -354,6 +376,7 @@ static inline int compile_regex(struct saved_data *da=
ta, struct spec *spec,
 	if (!anchored_regex) {
 		if (errbuf)
 			*errbuf =3D "out of memory";
+		__pthread_mutex_unlock(&spec->regex_lock);
 		return -1;
 	}
=20
@@ -374,10 +397,13 @@ static inline int compile_regex(struct saved_data *=
data, struct spec *spec,
 					sizeof(regex_error_format_buffer));
 			*errbuf =3D &regex_error_format_buffer[0];
 		}
+		__pthread_mutex_unlock(&spec->regex_lock);
 		return -1;
 	}
=20
 	/* Done. */
+	__atomic_store_n(&spec->regex_compiled, true, __ATOMIC_RELEASE);
+	__pthread_mutex_unlock(&spec->regex_lock);
 	return 0;
 }
=20
@@ -439,6 +465,8 @@ static inline int process_line(struct selabel_handle =
*rec,
 	/* process and store the specification in spec. */
 	spec_arr[nspec].stem_id =3D find_stem_from_spec(data, regex);
 	spec_arr[nspec].regex_str =3D regex;
+	__pthread_mutex_init(&spec_arr[nspec].regex_lock, NULL);
+	spec_arr[nspec].regex_compiled =3D false;
=20
 	spec_arr[nspec].type_str =3D type;
 	spec_arr[nspec].mode =3D 0;
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index ec1b0c4a..97f0fdb0 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -1,10 +1,12 @@
 #include <assert.h>
+#include <pthread.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
=20
 #include "regex.h"
 #include "label_file.h"
+#include "selinux_internal.h"
=20
 #ifdef USE_PCRE2
 #define REGEX_ARCH_SIZE_T PCRE2_SIZE
@@ -63,6 +65,7 @@ struct regex_data {
 	 * pattern in pcre2
 	 */
 	pcre2_match_data *match_data;
+	pthread_mutex_t match_mutex;
 };
=20
 int regex_prepare_data(struct regex_data **regex, char const *pattern_st=
ring,
@@ -199,6 +202,7 @@ void regex_data_free(struct regex_data *regex)
 			pcre2_code_free(regex->regex);
 		if (regex->match_data)
 			pcre2_match_data_free(regex->match_data);
+		__pthread_mutex_destroy(&regex->match_mutex);
 		free(regex);
 	}
 }
@@ -206,9 +210,11 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int parti=
al)
 {
 	int rc;
+	__pthread_mutex_lock(&regex->match_mutex);
 	rc =3D pcre2_match(
 	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
 	    partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
+	__pthread_mutex_unlock(&regex->match_mutex);
 	if (rc > 0)
 		return REGEX_MATCH;
 	switch (rc) {
@@ -244,6 +250,14 @@ int regex_cmp(struct regex_data *regex1, struct rege=
x_data *regex2)
 	return SELABEL_EQUAL;
 }
=20
+struct regex_data *regex_data_create(void)
+{
+	struct regex_data *regex_data =3D
+		(struct regex_data *)calloc(1, sizeof(struct regex_data));
+	__pthread_mutex_init(&regex_data->match_mutex, NULL);
+	return regex_data;
+}
+
 #else // !USE_PCRE2
 char const *regex_arch_string(void)
 {
@@ -472,13 +486,13 @@ int regex_cmp(struct regex_data *regex1, struct reg=
ex_data *regex2)
 	return SELABEL_EQUAL;
 }
=20
-#endif
-
 struct regex_data *regex_data_create(void)
 {
 	return (struct regex_data *)calloc(1, sizeof(struct regex_data));
 }
=20
+#endif
+
 void regex_format_error(struct regex_error_data const *error_data, char =
*buffer,
 			size_t buf_size)
 {
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
index 54949c13..dfc421cc 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -144,6 +144,38 @@ extern int selinux_page_size hidden;
 			pthread_setspecific(KEY, VALUE);	\
 	} while (0)
=20
+/* selabel_lookup() is only thread safe if we're compiled with pthreads =
*/
+
+#pragma weak pthread_mutex_init
+#pragma weak pthread_mutex_destroy
+#pragma weak pthread_mutex_lock
+#pragma weak pthread_mutex_unlock
+
+#define __pthread_mutex_init(LOCK, ATTR) 			\
+	do {							\
+		if (pthread_mutex_init !=3D NULL)			\
+			pthread_mutex_init(LOCK, ATTR);		\
+	} while (0)
+
+#define __pthread_mutex_destroy(LOCK) 				\
+	do {							\
+		if (pthread_mutex_destroy !=3D NULL)		\
+			pthread_mutex_destroy(LOCK);		\
+	} while (0)
+
+#define __pthread_mutex_lock(LOCK) 				\
+	do {							\
+		if (pthread_mutex_lock !=3D NULL)			\
+			pthread_mutex_lock(LOCK);		\
+	} while (0)
+
+#define __pthread_mutex_unlock(LOCK) 				\
+	do {							\
+		if (pthread_mutex_unlock !=3D NULL)		\
+			pthread_mutex_unlock(LOCK);		\
+	} while (0)
+
+
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
=20
--=20
2.14.0.rc0.400.g1c36432dff-goog
