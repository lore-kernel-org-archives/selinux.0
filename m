Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E0401A37
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005225; cv=none; b=aOLne25+qZyug5ew4yj/xG2RZkDF6CLFQi7JOX1mJb9Zd8VlXapZohvlAmI4bCTBWrrlGTlFk3ApaQiGQdU1qHbek+xm54hFq2a2x04bh+8PIko9t/Elgh3E/oXAYDVwr02uwmDCho4vphmsHOOwyaMDa1MiUIx7l4sYH2z95VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005225; c=relaxed/simple;
	bh=AzpkeUuyTXZFmNRP0ZYAfit+2ydgvKsGIfRSR8CLDQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D+PAcDUXiO6zzDTqP4eWtTdK2Xtjk98Pe55/20rXtGvoEDx25Lg+UWafD4IeYD0qCL3H2GZLr3ghAPsHlMB6cyrJugORXQFUEVgWXuSJ3wjia/BnhxBD+r6kIBi9Gm7Z+4z5/op3gyM8q/lTtv04Me6LoUSBhET+LW0HpGZ6ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CiYE/Vht; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CiYE/Vht"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1781005213;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=d4tsWOto+r+2h/eHtiQ0lu8lm7jtSxOYsqlUmqsQbVw=;
	b=CiYE/VhtGHGsw1MECz3tmFzUZu0n/u0ObgRGcBstYbUMfBEey6O6+H+I5ZPhGtFVhXHDmr
	z+m/Wc5jjLm39sx4/XeBH7KpLwartHq9KgZQS1b0tQE9El/iSH1R+9aN9hJJdBJlVGw0Eg
	1LoK4mGmXEskhCrk6ijzpqwA5eEQwB/ykxl9gIh40bwvGqtJYa8dDXBtwpqDR+KAvR6Ggb
	vSBaGFlcRz90M0TtfIR0695OJCCcDZXnOkoMfkEjiKSirXV+RHOo5WaqjyFDx1A2k88B4m
	88A1XaUKm/ePGe7iw1nmi8SRybj7xM3wvixCJLiAwGx1hw83XJ9M+quVpcx4PA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] Consistently use NULL as pointer constant
Date: Tue,  9 Jun 2026 13:40:01 +0200
Message-ID: <20260609114002.930486-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Utilize the GCC warning -Wzero-as-null-pointer-constant to enforce NULL
is used as pointer value constant instead of the integer 0.
This enhances readability what variable is actually a pointer and not
an integer.
Don't enable the warning in the top-level Makefile used for development
and CI though, since GCC 13, used by GitHub's ubuntu-latest images,
does not support it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: drop warning flag from top-level Makefile
---
 checkpolicy/checkpolicy.c             |  2 +-
 checkpolicy/policy_define.c           | 34 +++++++++++++--------------
 checkpolicy/policy_parse.y            | 16 ++++++-------
 libselinux/src/avc.c                  | 23 +++++++++---------
 libselinux/src/context.c              | 14 +++++------
 libselinux/src/get_context_list.c     |  6 ++---
 libselinux/src/load_policy.c          | 10 ++++----
 libsemanage/src/compressed_file.c     |  6 ++---
 libsepol/cil/src/cil_verify.c         |  4 ++--
 libsepol/src/avrule_block.c           |  2 +-
 libsepol/src/conditional.c            |  4 ++--
 libsepol/src/ebitmap.c                |  4 ++--
 libsepol/src/policydb.c               | 26 ++++++++++----------
 libsepol/src/services.c               | 12 +++++-----
 policycoreutils/newrole/newrole.c     |  9 ++++---
 policycoreutils/setsebool/setsebool.c |  2 +-
 restorecond/restorecond.c             |  6 ++---
 sandbox/seunshare.c                   | 10 ++++----
 secilc/secil2conf.c                   | 14 +++++------
 secilc/secil2tree.c                   | 14 +++++------
 secilc/secilc.c                       | 34 +++++++++++++--------------
 secilc/secilcheck.c                   | 10 ++++----
 22 files changed, 133 insertions(+), 129 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b499ac49..c1b33869 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -956,7 +956,7 @@ menu:
 			}
 			break;
 		case '6':
-			sepol_sidtab_map(&sidtab, print_sid, 0);
+			sepol_sidtab_map(&sidtab, print_sid, NULL);
 			break;
 		case '7':
 			printf("pathname?  ");
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index e36b97c9..63bf5245 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -63,7 +63,7 @@ __attribute__((format(printf, 1, 2))) extern void yyerror2(const char *fmt,
 							   ...);
 
 policydb_t *policydbp;
-queue_t id_queue = 0;
+queue_t id_queue = NULL;
 unsigned int pass;
 int mlspol = 0;
 
@@ -112,9 +112,9 @@ int insert_separator(int push)
 	int error;
 
 	if (push)
-		error = queue_push(id_queue, 0);
+		error = queue_push(id_queue, NULL);
 	else
-		error = queue_insert(id_queue, 0);
+		error = queue_insert(id_queue, NULL);
 
 	if (error) {
 		yyerror("queue overflow");
@@ -125,7 +125,7 @@ int insert_separator(int push)
 
 int insert_id(const char *id, int push)
 {
-	char *newid = 0;
+	char *newid = NULL;
 	int error;
 
 	newid = strdup(id);
@@ -300,7 +300,7 @@ out:
 
 int define_polcap(void)
 {
-	char *id = 0;
+	char *id = NULL;
 	int capnum;
 
 	if (pass == 2) {
@@ -338,8 +338,8 @@ bad:
 
 int define_initial_sid(void)
 {
-	char *id = 0;
-	ocontext_t *newc = 0, *c, *head;
+	char *id = NULL;
+	ocontext_t *newc = NULL, *c, *head;
 
 	if (pass == 2) {
 		id = queue_remove(id_queue);
@@ -561,9 +561,9 @@ int define_default_range(int which)
 
 int define_common_perms(void)
 {
-	char *id = 0, *perm = 0;
-	common_datum_t *comdatum = 0;
-	perm_datum_t *perdatum = 0;
+	char *id = NULL, *perm = NULL;
+	common_datum_t *comdatum = NULL;
+	perm_datum_t *perdatum = NULL;
 	int ret;
 
 	if (pass == 2) {
@@ -653,7 +653,7 @@ int define_av_perms(int inherits)
 	char *id;
 	class_datum_t *cladatum;
 	common_datum_t *comdatum;
-	perm_datum_t *perdatum = 0, *perdatum2 = 0;
+	perm_datum_t *perdatum = NULL, *perdatum2 = NULL;
 	int ret;
 
 	if (pass == 2) {
@@ -767,8 +767,8 @@ bad:
 int define_sens(void)
 {
 	char *id;
-	mls_level_t *level = 0;
-	level_datum_t *datum = 0, *aliasdatum = 0;
+	mls_level_t *level = NULL;
+	level_datum_t *datum = NULL, *aliasdatum = NULL;
 	int ret;
 	uint32_t value; /* dummy variable -- its value is never used */
 
@@ -961,7 +961,7 @@ int define_dominance(void)
 int define_category(void)
 {
 	char *id;
-	cat_datum_t *datum = 0, *aliasdatum = 0;
+	cat_datum_t *datum = NULL, *aliasdatum = NULL;
 	int ret;
 	uint32_t value;
 
@@ -3408,7 +3408,7 @@ bad:
 int define_role_allow(void)
 {
 	char *id;
-	struct role_allow_rule *ra = 0;
+	struct role_allow_rule *ra = NULL;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue)))
@@ -4122,7 +4122,7 @@ int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_list)
 		/* Invert */
 		t_list = f_list;
 		f_list = NULL;
-		expr = define_cond_expr(COND_NOT, expr, 0);
+		expr = define_cond_expr(COND_NOT, expr, NULL);
 		if (!expr) {
 			yyerror("unable to invert conditional expression");
 			return -1;
@@ -6143,7 +6143,7 @@ int define_genfs_context(int has_type)
 int define_range_trans(int class_specified)
 {
 	char *id;
-	level_datum_t *levdatum = 0;
+	level_datum_t *levdatum = NULL;
 	class_datum_t *cladatum;
 	range_trans_rule_t *rule;
 	int l, add = 1;
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 27e52d05..969055b9 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -379,28 +379,28 @@ cond_else		: ELSE '{' cond_pol_list '}'
 cond_expr               : '(' cond_expr ')'
 			{ $$ = $2;}
 			| NOT cond_expr
-			{ $$ = define_cond_expr(COND_NOT, $2, 0);
-			  if ($$ == 0) YYABORT; }
+			{ $$ = define_cond_expr(COND_NOT, $2, NULL);
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr AND cond_expr
 			{ $$ = define_cond_expr(COND_AND, $1, $3);
-			  if ($$ == 0) YYABORT; }
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr OR cond_expr
 			{ $$ = define_cond_expr(COND_OR, $1, $3);
-			  if ($$ == 0) YYABORT; }
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr XOR cond_expr
 			{ $$ = define_cond_expr(COND_XOR, $1, $3);
-			  if ($$ == 0) YYABORT; }
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr EQUALS cond_expr
 			{ $$ = define_cond_expr(COND_EQ, $1, $3);
-			  if ($$ == 0) YYABORT; }
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr NOTEQUAL cond_expr
 			{ $$ = define_cond_expr(COND_NEQ, $1, $3);
-			  if ($$ == 0) YYABORT; }
+			  if ($$ == NULL) YYABORT; }
 			| cond_expr_prim
 			{ $$ = $1; }
 			;
 cond_expr_prim          : identifier
-                        { $$ = define_cond_expr(COND_BOOL,0, 0);
+                        { $$ = define_cond_expr(COND_BOOL, NULL, NULL);
 			  if ($$ == COND_ERR) YYABORT; }
                         ;
 cond_pol_list           : cond_pol_list cond_rule_def 
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 1f6d2416..d6556bc9 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -166,7 +166,7 @@ static int avc_init_internal(const char *prefix,
 	memset(&cache_stats, 0, sizeof(cache_stats));
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++)
-		avc_cache.slots[i] = 0;
+		avc_cache.slots[i] = NULL;
 	avc_cache.lru_hint = 0;
 	avc_cache.active_nodes = 0;
 	avc_cache.latest_notif = 0;
@@ -514,7 +514,7 @@ int avc_reset(void)
 			avc_node_freelist = tmp;
 			avc_cache.active_nodes--;
 		}
-		avc_cache.slots[i] = 0;
+		avc_cache.slots[i] = NULL;
 	}
 	avc_cache.lru_hint = 0;
 
@@ -524,7 +524,8 @@ int avc_reset(void)
 
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
-			ret = c->callback(AVC_CALLBACK_RESET, 0, 0, 0, 0, 0);
+			ret = c->callback(AVC_CALLBACK_RESET, NULL, NULL, 0, 0,
+					  NULL);
 			if (ret && !rc) {
 				rc = ret;
 				errsave = errno;
@@ -766,7 +767,7 @@ int avc_has_perm_noaudit(security_id_t ssid, security_id_t tsid,
 			ae->used = 1;
 		} else {
 			avc_cache_stats_incr(entry_discards);
-			ae = 0;
+			ae = NULL;
 		}
 	}
 
@@ -977,7 +978,7 @@ static int avc_update_cache(uint32_t event, security_id_t ssid,
 		}
 	} else {
 		/* apply to one node */
-		node = avc_search_node(ssid, tsid, tclass, 0);
+		node = avc_search_node(ssid, tsid, tclass, NULL);
 		if (node) {
 			avc_update_node(event, node, perms);
 		}
@@ -1055,7 +1056,7 @@ int avc_ss_grant(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t perms, uint32_t seqno)
 {
 	return avc_control(AVC_CALLBACK_GRANT, ssid, tsid, tclass, perms, seqno,
-			   0);
+			   NULL);
 }
 
 /**
@@ -1095,7 +1096,7 @@ int avc_ss_revoke(security_id_t ssid, security_id_t tsid,
 		  uint32_t seqno)
 {
 	return avc_control(AVC_CALLBACK_REVOKE, ssid, tsid, tclass, perms,
-			   seqno, 0);
+			   seqno, NULL);
 }
 
 /**
@@ -1131,10 +1132,10 @@ int avc_ss_set_auditallow(security_id_t ssid, security_id_t tsid,
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITALLOW_ENABLE, ssid, tsid,
-				   tclass, perms, seqno, 0);
+				   tclass, perms, seqno, NULL);
 	else
 		return avc_control(AVC_CALLBACK_AUDITALLOW_DISABLE, ssid, tsid,
-				   tclass, perms, seqno, 0);
+				   tclass, perms, seqno, NULL);
 }
 
 /**
@@ -1152,8 +1153,8 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITDENY_ENABLE, ssid, tsid,
-				   tclass, perms, seqno, 0);
+				   tclass, perms, seqno, NULL);
 	else
 		return avc_control(AVC_CALLBACK_AUDITDENY_DISABLE, ssid, tsid,
-				   tclass, perms, seqno, 0);
+				   tclass, perms, seqno, NULL);
 }
diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index ffbc8b72..cd1cd431 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -32,11 +32,11 @@ context_t context_new(const char *str)
 		result->ptr = n;
 	else
 		free(n);
-	if (n == 0 || result == 0) {
+	if (n == NULL || result == NULL) {
 		goto err;
 	}
 	n->current_str = n->component[0] = n->component[1] = n->component[2] =
-		n->component[3] = 0;
+		n->component[3] = NULL;
 	for (count = 0, p = str; *p; p++) {
 		switch (*p) {
 		case ':':
@@ -59,7 +59,7 @@ context_t context_new(const char *str)
 		goto err;
 	}
 
-	n->component[3] = 0;
+	n->component[3] = NULL;
 	for (i = 0, tok = str; *tok; i++) {
 		if (i < 3)
 			for (p = tok; *p && *p != ':'; p++) { /* empty */
@@ -70,7 +70,7 @@ context_t context_new(const char *str)
 			}
 		}
 		n->component[i] = strndup(tok, p - tok);
-		if (n->component[i] == 0)
+		if (n->component[i] == NULL)
 			goto err;
 		tok = *p ? p + 1 : p;
 	}
@@ -79,7 +79,7 @@ err:
 	if (errno == 0)
 		errno = EINVAL;
 	context_free(result);
-	return 0;
+	return NULL;
 }
 
 static void conditional_free(char **v)
@@ -87,7 +87,7 @@ static void conditional_free(char **v)
 	if (*v) {
 		free(*v);
 	}
-	*v = 0;
+	*v = NULL;
 }
 
 /*
@@ -126,7 +126,7 @@ const char *context_str(context_t context)
 		}
 	}
 	n->current_str = malloc(total);
-	if (n->current_str != 0) {
+	if (n->current_str != NULL) {
 		char *cp = n->current_str;
 
 		cp = stpcpy(cp, n->component[0]);
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index bad93fa1..01419b07 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -276,7 +276,7 @@ static int get_context_user(FILE *fp, context_t fromcon, const char *user,
 			*reachable = new_reachable;
 			new_reachable[*nreachable] = usercon_str2;
 			usercon_str2 = NULL;
-			new_reachable[*nreachable + 1] = 0;
+			new_reachable[*nreachable + 1] = NULL;
 			*nreachable += 1;
 		}
 		free(usercon_str2);
@@ -317,7 +317,7 @@ static int get_failsafe_context(const char *user, char **newcon)
 	rc = snprintf(*newcon, nlen, "%s:%s", user, ptr);
 	if (rc < 0 || (size_t)rc >= nlen) {
 		free(*newcon);
-		*newcon = 0;
+		*newcon = NULL;
 		return -1;
 	}
 
@@ -328,7 +328,7 @@ static int get_failsafe_context(const char *user, char **newcon)
 	   selinuxfs isn't mounted. */
 	if (security_check_context(*newcon) && errno != ENOENT) {
 		free(*newcon);
-		*newcon = 0;
+		*newcon = NULL;
 		return -1;
 	}
 
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 95c9a851..4337cedc 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -249,7 +249,7 @@ int selinux_init_load_policy(int *enforce)
 	selinux_getenforcemode(&seconfig);
 
 	/* Check for an override of the mode via the kernel command line. */
-	rc = mount("proc", "/proc", "proc", 0, 0);
+	rc = mount("proc", "/proc", "proc", 0, NULL);
 	cfg = fopen("/proc/cmdline", "re");
 	if (cfg) {
 		buf = malloc(selinux_page_size);
@@ -300,16 +300,16 @@ int selinux_init_load_policy(int *enforce)
 	 */
 	const char *mntpoint = NULL;
 	/* First make sure /sys is mounted */
-	(void)mount("sysfs", "/sys", "sysfs", 0, 0);
+	(void)mount("sysfs", "/sys", "sysfs", 0, NULL);
 
 	/* MS_NODEV can't be set because of /sys/fs/selinux/null device, used by Android */
-	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID, 0) ==
-		    0 ||
+	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID,
+		  NULL) == 0 ||
 	    errno == EBUSY) {
 		mntpoint = SELINUXMNT;
 	} else {
 		/* check old mountpoint */
-		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 ||
+		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, NULL) == 0 ||
 		    errno == EBUSY) {
 			mntpoint = OLDSELINUXMNT;
 		}
diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 6af81bb5..6032c1f3 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -64,7 +64,7 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 
 	b = BZ2_bzWriteOpen(&bzerror, f, sh->conf->bzip_blocksize, 0, 0);
 	if (bzerror != BZ_OK) {
-		BZ2_bzWriteClose(&bzerror, b, 1, 0, 0);
+		BZ2_bzWriteClose(&bzerror, b, 1, NULL, NULL);
 		fclose(f);
 		return -1;
 	}
@@ -77,14 +77,14 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 		}
 		BZ2_bzWrite(&bzerror, b, (uint8_t *)data + total, len);
 		if (bzerror == BZ_IO_ERROR) {
-			BZ2_bzWriteClose(&bzerror, b, 1, 0, 0);
+			BZ2_bzWriteClose(&bzerror, b, 1, NULL, NULL);
 			fclose(f);
 			return -1;
 		}
 		total += len;
 	}
 
-	BZ2_bzWriteClose(&bzerror, b, 0, 0, 0);
+	BZ2_bzWriteClose(&bzerror, b, 0, NULL, NULL);
 	fclose(f);
 	if (bzerror == BZ_IO_ERROR) {
 		return -1;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 34de8da8..67b98b09 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1790,8 +1790,8 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished,
 	int rc = SEPOL_ERR;
 	int *handleunknown;
 	int *mls;
-	int *nseuserdflt = 0;
-	int *pass = 0;
+	int *nseuserdflt = NULL;
+	int *pass = NULL;
 	struct cil_args_verify *args = extra_args;
 	struct cil_complex_symtab *csymtab = NULL;
 	struct cil_db *db = NULL;
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 7de4bd6b..60f637ff 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -190,7 +190,7 @@ int is_perm_existent(const class_datum_t *cladatum, const char *perm_id)
 	const perm_datum_t *perm;
 
 	perm = hashtab_search(cladatum->permissions.table, perm_id);
-	if (perm == NULL && cladatum->comdatum != 0) {
+	if (perm == NULL && cladatum->comdatum != NULL) {
 		/* permission was not in this class.  before giving
 		 * up, check the class's parent */
 		perm = hashtab_search(cladatum->comdatum->permissions.table,
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 7243893d..a8070a6a 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -568,7 +568,7 @@ static int bool_isvalid(cond_bool_datum_t *b)
 
 int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	cond_bool_datum_t *booldatum;
 	uint32_t buf[3], len;
 	int rc;
@@ -605,7 +605,7 @@ int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp)
 
 	return 0;
 err:
-	cond_destroy_bool(key, booldatum, 0);
+	cond_destroy_bool(key, booldatum, NULL);
 	return -1;
 }
 
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 618e2630..ea819616 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -378,7 +378,7 @@ int ebitmap_set_bit(ebitmap_t *e, unsigned int bit, int value)
 		return -EINVAL;
 	}
 
-	prev = 0;
+	prev = NULL;
 	n = e->node;
 	while (n && n->startbit <= bit) {
 		if ((n->startbit + MAPSIZE) > bit) {
@@ -527,7 +527,7 @@ void ebitmap_destroy(ebitmap_t *e)
 	}
 
 	e->highbit = 0;
-	e->node = 0;
+	e->node = NULL;
 	return;
 }
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5b004326..a42fdf98 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -817,7 +817,7 @@ void avrule_list_destroy(avrule_t *x)
  */
 static int roles_init(policydb_t *p)
 {
-	char *key = 0;
+	char *key = NULL;
 	int rc;
 	role_datum_t *role;
 
@@ -1368,7 +1368,7 @@ static int common_destroy(hashtab_key_t key, hashtab_datum_t datum,
 	if (key)
 		free(key);
 	comdatum = (common_datum_t *)datum;
-	(void)hashtab_map(comdatum->permissions.table, perm_destroy, 0);
+	(void)hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
 	hashtab_destroy(comdatum->permissions.table);
 	free(datum);
 	return 0;
@@ -1386,7 +1386,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum,
 	if (cladatum == NULL) {
 		return 0;
 	}
-	(void)hashtab_map(cladatum->permissions.table, perm_destroy, 0);
+	(void)hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
 	hashtab_destroy(cladatum->permissions.table);
 	constraint = cladatum->constraints;
 	while (constraint) {
@@ -1577,7 +1577,7 @@ void policydb_destroy(policydb_t *p)
 	free(p->decl_val_to_struct);
 
 	for (i = 0; i < SYM_NUM; i++) {
-		(void)hashtab_map(p->scope[i].table, scope_destroy, 0);
+		(void)hashtab_map(p->scope[i].table, scope_destroy, NULL);
 		hashtab_destroy(p->scope[i].table);
 	}
 	avrule_block_list_destroy(p->global);
@@ -1651,7 +1651,7 @@ void symtabs_destroy(symtab_t *symtab)
 {
 	int i;
 	for (i = 0; i < SYM_NUM; i++) {
-		(void)hashtab_map(symtab[i].table, destroy_f[i], 0);
+		(void)hashtab_map(symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(symtab[i].table);
 	}
 }
@@ -2115,7 +2115,7 @@ static int context_read_and_validate(context_struct_t *c, policydb_t *p,
 static int perm_read(policydb_t *p __attribute__((unused)), hashtab_t h,
 		     struct policy_file *fp, uint32_t nprim)
 {
-	char *key = 0;
+	char *key = NULL;
 	perm_datum_t *perdatum;
 	uint32_t buf[2];
 	size_t len;
@@ -2149,7 +2149,7 @@ bad:
 
 static int common_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	common_datum_t *comdatum;
 	uint32_t buf[4];
 	size_t len, nel;
@@ -2292,7 +2292,7 @@ static int read_cons_helper(policydb_t *p, constraint_node_t **nodep,
 
 static int class_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	class_datum_t *cladatum;
 	uint32_t buf[6];
 	size_t len, len2, ncons, nel;
@@ -2394,7 +2394,7 @@ bad:
 
 static int role_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	role_datum_t *role;
 	uint32_t buf[3];
 	size_t len;
@@ -2466,7 +2466,7 @@ bad:
 
 static int type_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	type_datum_t *typdatum;
 	uint32_t buf[5];
 	size_t len;
@@ -3326,7 +3326,7 @@ bad:
 
 static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	user_datum_t *usrdatum;
 	uint32_t buf[3];
 	size_t len;
@@ -3407,7 +3407,7 @@ bad:
 static int sens_read(policydb_t *p __attribute__((unused)), hashtab_t h,
 		     struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	level_datum_t *levdatum;
 	uint32_t buf[2], len;
 	int rc;
@@ -3445,7 +3445,7 @@ bad:
 static int cat_read(policydb_t *p __attribute__((unused)), hashtab_t h,
 		    struct policy_file *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	cat_datum_t *catdatum;
 	uint32_t buf[3], len;
 	int rc;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index f504060a..e8f0e622 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -298,7 +298,7 @@ static char *get_class_info(sepol_security_class_t tclass,
 				     "mlsconstrain ", /* 1 */
 				     "validatetrans ", /* 2 */
 				     "mlsvalidatetrans ", /* 3 */
-				     0 };
+				     NULL };
 	size_t class_buf_len = 0;
 	size_t new_class_buf_len;
 	size_t buf_used;
@@ -830,7 +830,7 @@ mls_ops:
 		* These contain the constraint components that are added to the
 		* callers reason buffer.
 		*/
-		const char *buffers[] = { class_buf, a, "); ", tmp_buf, 0 };
+		const char *buffers[] = { class_buf, a, "); ", tmp_buf, NULL };
 
 		for (x = 0; buffers[x] != NULL; x++) {
 			while (1) {
@@ -1127,7 +1127,7 @@ int sepol_compute_av_reason(sepol_security_id_t ssid, sepol_security_id_t tsid,
 			    sepol_access_vector_t requested,
 			    struct sepol_av_decision *avd, unsigned int *reason)
 {
-	context_struct_t *scontext = 0, *tcontext = 0;
+	context_struct_t *scontext = NULL, *tcontext = NULL;
 	int rc = 0;
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
@@ -1162,7 +1162,7 @@ int sepol_compute_av_reason_buffer(sepol_security_id_t ssid,
 				   unsigned int *reason, char **reason_buf,
 				   unsigned int flags)
 {
-	context_struct_t *scontext = 0, *tcontext = 0;
+	context_struct_t *scontext = NULL, *tcontext = NULL;
 	int rc = 0;
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
@@ -1371,8 +1371,8 @@ static int sepol_compute_sid(sepol_security_id_t ssid, sepol_security_id_t tsid,
 			     sepol_security_id_t *out_sid)
 {
 	struct class_datum *cladatum = NULL;
-	context_struct_t *scontext = 0, *tcontext = 0, newcontext;
-	struct role_trans *roletr = 0;
+	context_struct_t *scontext = NULL, *tcontext = NULL, newcontext;
+	struct role_trans *roletr = NULL;
 	avtab_key_t avkey;
 	avtab_datum_t *avdatum;
 	avtab_ptr_t node;
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 4bb4793a..19271c2a 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -847,9 +847,12 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 	char *tty_con = NULL;
 	context_t context = NULL; /* manipulatable form of new_context */
 	const struct option long_options[] = {
-		{ "role", 1, 0, 'r' },	  { "type", 1, 0, 't' },
-		{ "level", 1, 0, 'l' },	  { "preserve-environment", 0, 0, 'p' },
-		{ "version", 0, 0, 'V' }, { NULL, 0, 0, 0 }
+		{ "role", 1, NULL, 'r' },
+		{ "type", 1, NULL, 't' },
+		{ "level", 1, NULL, 'l' },
+		{ "preserve-environment", 0, NULL, 'p' },
+		{ "version", 0, NULL, 'V' },
+		{ NULL, 0, NULL, 0 }
 	};
 
 	*preserve_environment = 0;
diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index e019e43b..d85b2a33 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -66,7 +66,7 @@ int main(int argc, char **argv)
 	/* Check to see which way we are being called. If a '=' is passed,
 	   we'll enforce the list syntax. If not we'll enforce the original
 	   syntax for backward compatibility. */
-	if (strchr(argv[optind], '=') == 0) {
+	if (strchr(argv[optind], '=') == NULL) {
 		int len;
 		char *bool_list[1];
 
diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 421b992c..b8ca4b21 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -96,13 +96,13 @@ static int write_pid_file(void)
 	len = snprintf(val, sizeof(val), "%u\n", getpid());
 	if (len < 0) {
 		syslog(LOG_ERR, "Pid error (%s)", strerror(errno));
-		pidfile = 0;
+		pidfile = NULL;
 		return 1;
 	}
 	pidfd = open(pidfile, O_CREAT | O_TRUNC | O_NOFOLLOW | O_WRONLY, 0644);
 	if (pidfd < 0) {
 		syslog(LOG_ERR, "Unable to set pidfile (%s)", strerror(errno));
-		pidfile = 0;
+		pidfile = NULL;
 		return 1;
 	}
 	if (write(pidfd, val, (unsigned int)len) != len) {
@@ -222,7 +222,7 @@ int main(int argc, char **argv)
 			exitApp("daemon");
 		write_pid_file();
 	} else {
-		pidfile = 0;
+		pidfile = NULL;
 	}
 
 	while (watch(master_fd, watch_file) == 0) {
diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 0e046398..58baa7ff 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -775,11 +775,11 @@ int main(int argc, char **argv)
 	int fd;
 
 	const struct option long_options[] = {
-		{ "homedir", 1, 0, 'h' },      { "tmpdir", 1, 0, 't' },
-		{ "runuserdir", 1, 0, 'r' },   { "kill", 0, 0, 'k' },
-		{ "verbose", 0, 0, 'v' },      { "context", 1, 0, 'Z' },
-		{ "capabilities", 0, 0, 'C' }, { "wayland", 1, 0, 'W' },
-		{ "pipewire", 1, 0, 'P' },     { NULL, 0, 0, 0 }
+		{ "homedir", 1, NULL, 'h' },	  { "tmpdir", 1, NULL, 't' },
+		{ "runuserdir", 1, NULL, 'r' },	  { "kill", 0, NULL, 'k' },
+		{ "verbose", 0, NULL, 'v' },	  { "context", 1, NULL, 'Z' },
+		{ "capabilities", 0, NULL, 'C' }, { "wayland", 1, NULL, 'W' },
+		{ "pipewire", 1, NULL, 'P' },	  { NULL, 0, NULL, 0 }
 	};
 
 	uid_t uid = getuid();
diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 3a012d76..4046e603 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -76,13 +76,13 @@ int main(int argc, char *argv[])
 	int opt_index = 0;
 	enum cil_log_level log_level = CIL_ERR;
 	static struct option long_opts[] = {
-		{ "help", no_argument, 0, 'h' },
-		{ "verbose", no_argument, 0, 'v' },
-		{ "mls", required_argument, 0, 'M' },
-		{ "preserve-tunables", no_argument, 0, 'P' },
-		{ "qualified-names", no_argument, 0, 'Q' },
-		{ "output", required_argument, 0, 'o' },
-		{ 0, 0, 0, 0 }
+		{ "help", no_argument, NULL, 'h' },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "mls", required_argument, NULL, 'M' },
+		{ "preserve-tunables", no_argument, NULL, 'P' },
+		{ "qualified-names", no_argument, NULL, 'Q' },
+		{ "output", required_argument, NULL, 'o' },
+		{ NULL, 0, NULL, 0 }
 	};
 	int i;
 
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index dc12490d..f0f02eb3 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -81,13 +81,13 @@ int main(int argc, char *argv[])
 	int opt_index = 0;
 	enum cil_log_level log_level = CIL_ERR;
 	static struct option long_opts[] = {
-		{ "help", no_argument, 0, 'h' },
-		{ "verbose", no_argument, 0, 'v' },
-		{ "preserve-tunables", no_argument, 0, 'P' },
-		{ "qualified-names", no_argument, 0, 'Q' },
-		{ "output", required_argument, 0, 'o' },
-		{ "ast-phase", required_argument, 0, 'A' },
-		{ 0, 0, 0, 0 }
+		{ "help", no_argument, NULL, 'h' },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "preserve-tunables", no_argument, NULL, 'P' },
+		{ "qualified-names", no_argument, NULL, 'Q' },
+		{ "output", required_argument, NULL, 'o' },
+		{ "ast-phase", required_argument, NULL, 'A' },
+		{ NULL, 0, NULL, 0 }
 	};
 	int i;
 
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 1c922afc..70359b75 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -110,23 +110,23 @@ int main(int argc, char *argv[])
 	size_t fc_size;
 	enum cil_log_level log_level = CIL_ERR;
 	static struct option long_opts[] = {
-		{ "help", no_argument, 0, 'h' },
-		{ "verbose", no_argument, 0, 'v' },
-		{ "target", required_argument, 0, 't' },
-		{ "mls", required_argument, 0, 'M' },
-		{ "policyversion", required_argument, 0, 'c' },
-		{ "handle-unknown", required_argument, 0, 'U' },
-		{ "disable-dontaudit", no_argument, 0, 'D' },
-		{ "multiple-decls", no_argument, 0, 'm' },
-		{ "disable-neverallow", no_argument, 0, 'N' },
-		{ "preserve-tunables", no_argument, 0, 'P' },
-		{ "qualified-names", no_argument, 0, 'Q' },
-		{ "output", required_argument, 0, 'o' },
-		{ "filecontexts", required_argument, 0, 'f' },
-		{ "expand-generated", no_argument, 0, 'G' },
-		{ "expand-size", required_argument, 0, 'X' },
-		{ "optimize", no_argument, 0, 'O' },
-		{ 0, 0, 0, 0 }
+		{ "help", no_argument, NULL, 'h' },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "target", required_argument, NULL, 't' },
+		{ "mls", required_argument, NULL, 'M' },
+		{ "policyversion", required_argument, NULL, 'c' },
+		{ "handle-unknown", required_argument, NULL, 'U' },
+		{ "disable-dontaudit", no_argument, NULL, 'D' },
+		{ "multiple-decls", no_argument, NULL, 'm' },
+		{ "disable-neverallow", no_argument, NULL, 'N' },
+		{ "preserve-tunables", no_argument, NULL, 'P' },
+		{ "qualified-names", no_argument, NULL, 'Q' },
+		{ "output", required_argument, NULL, 'o' },
+		{ "filecontexts", required_argument, NULL, 'f' },
+		{ "expand-generated", no_argument, NULL, 'G' },
+		{ "expand-size", required_argument, NULL, 'X' },
+		{ "optimize", no_argument, NULL, 'O' },
+		{ NULL, 0, NULL, 0 }
 	};
 	int i;
 
diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
index 86e95649..45176df4 100644
--- a/secilc/secilcheck.c
+++ b/secilc/secilcheck.c
@@ -213,11 +213,11 @@ int main(int argc, char *argv[])
 	int opt_index = 0;
 	enum cil_log_level log_level = CIL_ERR;
 	static struct option long_opts[] = {
-		{ "help", no_argument, 0, 'h' },
-		{ "verbose", no_argument, 0, 'v' },
-		{ "multiple-decls", no_argument, 0, 'm' },
-		{ "qualified-names", no_argument, 0, 'Q' },
-		{ 0, 0, 0, 0 }
+		{ "help", no_argument, NULL, 'h' },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "multiple-decls", no_argument, NULL, 'm' },
+		{ "qualified-names", no_argument, NULL, 'Q' },
+		{ NULL, 0, NULL, 0 }
 	};
 
 	while (1) {
-- 
2.53.0

