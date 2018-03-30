Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2U0Hcw7029205
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 20:17:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID10.oob.disa.mil (Postfix) with SMTP id 40C2Hz6BhSz2L92Y
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 00:17:35 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID10.oob.disa.mil (Postfix) with ESMTP id 40C2Hz4Kxqz2L92X
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 00:17:35 +0000 (UTC)
Received: by mail-qk0-f196.google.com with SMTP id o64so7782262qkl.7
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 17:17:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id i11sm5824682qtc.30.2018.03.29.17.17.31
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Mar 2018 17:17:31 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Thu, 29 Mar 2018 17:16:41 -0700
Message-Id: <20180330001642.2374-2-ykhodo@gmail.com>
In-Reply-To: <20180330001642.2374-1-ykhodo@gmail.com>
References: <20180330001642.2374-1-ykhodo@gmail.com>
Subject: [PATCH v3 1/2] libselinux: verify file_contexts when using restorecon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In permissive mode, calling restorecon with a bad label in file_contexts
does not verify the label's existence in the loaded policy. This
results in any label successfully applying to a file, as long as the
file exists.

This issue has two assumptions:

1) file_contexts must be manually updated with the invalid label.
Running `semanage fcontext` will error when attempting to add
an invalid label to file_contexts.
2) the system must be in permissive. Although applying an invalid label
in enforcing gives an error and fails, successfully labeling a file with a
bad label could cause issues during policy development in permissive.

Instead, as each context is used, verify it is valid before blindly
applying the label. If an error with validation occurs in restorecon,
application of remaining valid labels will be uninterrupted as before.

Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
---
 libselinux/src/label.c                  | 7 +++----
 libselinux/src/label_backends_android.c | 2 +-
 libselinux/src/label_file.c             | 2 +-
 libselinux/src/label_file.h             | 2 +-
 libselinux/src/label_internal.h         | 6 ++----
 libselinux/src/matchpathcon.c           | 5 ++---
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 48f4d2d6..c510edc1 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -121,12 +121,11 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 	return 0;
 }
 
-int selabel_validate(struct selabel_handle *rec,
-		     struct selabel_lookup_rec *contexts)
+int selabel_validate(struct selabel_lookup_rec *contexts)
 {
 	int rc = 0;
 
-	if (!rec->validating || contexts->validated)
+	if (contexts->validated)
 		goto out;
 
 	rc = selinux_validate(&contexts->ctx_raw);
@@ -143,7 +142,7 @@ static int selabel_fini(struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    int translating)
 {
-	if (compat_validate(rec, lr, rec->spec_file, 0))
+	if (compat_validate(lr, rec->spec_file, 0))
 		return -1;
 
 	if (translating && !lr->ctx_trans &&
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cb8aae26..49e39ec8 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -122,7 +122,7 @@ static int process_line(struct selabel_handle *rec,
 		spec_arr[nspec].lr.ctx_raw = context;
 
 		if (rec->validating) {
-			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
+			if (selabel_validate(&spec_arr[nspec].lr) < 0) {
 				selinux_log(SELINUX_ERROR,
 					    "%s:  line %u has invalid context %s\n",
 					    path, lineno, spec_arr[nspec].lr.ctx_raw);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 560d8c3d..169fed70 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -328,7 +328,7 @@ end_arch_check:
 		spec->lr.ctx_raw = str_buf;
 
 		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
-			if (selabel_validate(rec, &spec->lr) < 0) {
+			if (selabel_validate(&spec->lr) < 0) {
 				selinux_log(SELINUX_ERROR,
 					    "%s: context %s is invalid\n",
 					    path, spec->lr.ctx_raw);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index aa576d8e..9e52a3c4 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -506,7 +506,7 @@ static inline int process_line(struct selabel_handle *rec,
 	spec_hasMetaChars(&spec_arr[nspec]);
 
 	if (strcmp(context, "<<none>>") && rec->validating)
-		return compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
+		return compat_validate(&spec_arr[nspec].lr, path, lineno);
 
 	return 0;
 }
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index c55efb75..75451858 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -111,8 +111,7 @@ struct selabel_handle {
  * Validation function
  */
 extern int
-selabel_validate(struct selabel_handle *rec,
-		 struct selabel_lookup_rec *contexts) hidden;
+selabel_validate(struct selabel_lookup_rec *contexts) hidden;
 
 /*
  * Compatibility support
@@ -127,8 +126,7 @@ extern void __attribute__ ((format(printf, 1, 2)))
 		selinux_log(type, fmt);
 
 extern int
-compat_validate(struct selabel_handle *rec,
-		struct selabel_lookup_rec *contexts,
+compat_validate(struct selabel_lookup_rec *contexts,
 		const char *path, unsigned lineno) hidden;
 
 /*
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 58b4144a..c66739af 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -35,8 +35,7 @@ void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
 	myprintf_compat = 1;
 }
 
-int compat_validate(struct selabel_handle *rec,
-		    struct selabel_lookup_rec *contexts,
+int compat_validate(struct selabel_lookup_rec *contexts,
 		    const char *path, unsigned lineno)
 {
 	int rc;
@@ -47,7 +46,7 @@ int compat_validate(struct selabel_handle *rec,
 	else if (mycanoncon)
 		rc = mycanoncon(path, lineno, ctx);
 	else {
-		rc = selabel_validate(rec, contexts);
+		rc = selabel_validate(contexts);
 		if (rc < 0) {
 			if (lineno) {
 				COMPAT_LOG(SELINUX_WARNING,
-- 
2.14.3
