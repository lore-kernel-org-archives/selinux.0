Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CD3B9D91
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792024; cv=none; b=OZYB5Nmc9HAqTyrMa2BE5epssDsOMloQQNs0gACphbgd0+r8FvlvmYsD5HflbSfNlmsEoxa0sV+yYQk1P0PXjRA5d+/3pp6lYqP9g6F/R1IfKodv4nikixB/oS1HYesieYrEBWnPFLxfGIY8xgTG0MqXucACpngmKUuFpEFX1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792024; c=relaxed/simple;
	bh=5izcdqvgc59Y1e/i5pAs6Srg4cSgwOfYkERMnZo8+dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utF7zDEmeJqLIlOiHFkHr5mg6gbx5//0i8Yyoufvfl0mtZZHL07lKGSpYod5B7Ui2yceMv2/EcqRMtLF1F5YZpT+ccCuGFMyQ48ZdvwKRlms+cVhGgjcNAAZCbHh/zKISfPSZvh+4AWZNVS9ELWXB85F+jCdB5WMrZwPPPVC8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P97PoZ6t; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P97PoZ6t"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c25b661d37dso491756666b.0
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792020; x=1789396820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTWkRZt8lAzu+1t2iKd31BGBx4FVQs8R9m4myB3Rlv8=;
        b=P97PoZ6tOhACwNQUKDzCpKrvDJBjys0cKWRwE7yC1xVPmXZTQTkF9Iek97+gcbIe6g
         d0sXC8l6hzBB+xje8beXzPMS32/09+kQUNX3MKvYFjDeTa3KIOc/CYVd7KautHehDGuD
         9YTirqSZ5Y2ipCg6jZpn+L0VegUu17f5rClyNYb3hb340nPVDQ2mChHkXgpslBdAgKnu
         efvRPCgs3+avNPe63p3WQeThjVm28LFu1MenIgJzOoRHoTYRLwYaQjaiC2/stBTsq4pt
         OtIz5817owMTciZpIk4CdP9NvOrfMGNo8XsvR7ZIAXyM8h7C6s9RGdvaWSfa8PpTGPYa
         PdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792020; x=1789396820;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTWkRZt8lAzu+1t2iKd31BGBx4FVQs8R9m4myB3Rlv8=;
        b=AlK2NC79CoKleGY767L5+8EOtUiakgYjuKTfPMlbJ+i1IgrCUbSx5v+mm55PYWhqHb
         l5mnfuXP/e2Fas40yYiA0jNw6g7fOb+1HRi9obaK4zNShD0ZHRlt57ImXPz2M6K8tcfJ
         EhhJ8kcUn5HAc6RRM695YSUFqhmfYsQm+FdF8qswv4kI69sdshgQ/mZ6XKVSU3DJ0Ly7
         HnpjNox9ZaPv7Yz7L/O509qf0bO76DUY+wtJtCPfutjbRQhoTJJ8wFl5nNp1rIGlhPPY
         svZbHOJxjMHQ/l0YdqMBdi1LEfxRC96jQB4Oj3HGmUO0vBKSycAfzvaY9n1lS2/LIOlS
         VFjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyeFx5IZ8seuaS68WZNWoiFoXsyX3V9nmekn3CRQsZWzOovYwbhwwwxEd0O8ylfBWs9i7aZoA0@vger.kernel.org
X-Gm-Message-State: AFuF++knHyHKhzLDyNe7s5VYz5UWeIo/R3L2cTSypipryVbpsUTCmYzk
	Eh1KpsIsIUsCdgYEWZBn1o09EAzrj+DIIqfJhdcj3H7tI2JSMlZQecAC
X-Gm-Gg: AYBFou1rKySY+ckHQ+uiEZjrf4RutjI/EC3RYDoM7/zR47HmUTOSK+L1uU2baFQUk28
	LA+eU2SH1iMFD+88C4GftHcdOlgW5Rt2y5lLd/B0Zf2vPRYbKVBXvrLTz+dd788qjcea2k5NSG6
	cYKuNSK31b0Q8A5eNH8scZcTwA9syjCEZa6Jtj3WAjmcdtkHoGVHDPSu7zBUeV7aH2xAJTD9w2C
	EzgaaVA0Pn4FGbp2fcmPp7SRw5zTRv3XrRz217OhPyhcrwPSfCxCQVsyYqCJnDj8fBF4Po6w9mI
	hxs07wtlA+/57lAAt7fTnBO/F3Rvkjim6aEpjVHQN/BDPcGzGnObne5Awxf1NpGKeG2xTZBrhd9
	tXkoW6hgfZ/l7q5YwzwW1un4opNVImMu+1+oquuNtxG4/CTaJynLMcl6n6TMawcwYpAqWQ+420R
	XUpYnWYX1/r3k8EtDoDFIGEfiPr2PoE6TcWfyuxjgHn0DhXek54CxrpbrqOrmp76J/mYq55JVDQ
	DT/XBySmA==
X-Received: by 2002:a17:907:3c92:b0:c25:9102:ed with SMTP id a640c23a62f3a-c260c65c166mr868252466b.5.1788792019863;
        Mon, 07 Sep 2026 07:40:19 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4438279a12.31.2026.09.07.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:40:19 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5.10/5.15/6.1] selinux: avoid implicit conversions in services code
Date: Mon,  7 Sep 2026 17:39:54 +0300
Message-ID: <20260907144009.162239-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907144009.162239-1-alexevgmart@gmail.com>
References: <20260907144009.162239-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

commit c50e125d057152bc68dfd5669b73611343653eb7 upstream.

Use u32 as the output parameter type in security_get_classes() and
security_get_permissions(), based on the type of the symtab nprim
member.

Declare the read-only class string parameter of
security_get_permissions() const.

Avoid several implicit conversions by using the identical type for the
destination.

Use the type identical to the source for local variables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: cleanup extra whitespace in subject]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80912
 security/selinux/include/security.h |  4 ++--
 security/selinux/selinuxfs.c        |  7 ++++---
 security/selinux/ss/services.c      | 23 ++++++++++++-----------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 393aff41d3ef..4176326ca4f5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -379,9 +379,9 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 *peer_sid);
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses);
+			 char ***classes, u32 *nclasses);
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms);
+			     char *class, char ***perms, u32 *nperms);
 int security_get_reject_unknown(struct selinux_state *state);
 int security_get_allow_unknown(struct selinux_state *state);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ab804d4ea911..f74fdabaa541 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1874,7 +1874,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 			char *objclass, int classvalue,
 			struct dentry *dir)
 {
-	int i, rc, nperms;
+	u32 i, nperms;
+	int rc;
 	char **perms;
 
 	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
@@ -1944,8 +1945,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino)
 {
-
-	int rc, nclasses, i;
+	u32 i, nclasses;
+	int rc;
 	char **classes;
 
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 48d67b26110b..80340bc0ee6a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -869,7 +869,7 @@ int security_bounded_transition(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
 	struct type_datum *type;
-	int index;
+	u32 index;
 	int rc;
 
 	if (!selinux_initialized(state))
@@ -1537,7 +1537,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		return -ENOMEM;
 
 	if (!selinux_initialized(state)) {
-		int i;
+		u32 i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
 			const char *s = initial_sid_to_string[i];
@@ -2886,7 +2886,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	int len;
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -2908,7 +2907,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
-		len = strlen(c->u.name);
+		size_t len = strlen(c->u.name);
 		if ((!c->v.sclass || sclass == c->v.sclass) &&
 		    (strncmp(c->u.name, path, len) == 0))
 			break;
@@ -3402,7 +3401,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
@@ -3412,7 +3411,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 }
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses)
+			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
 	int rc;
@@ -3428,7 +3427,8 @@ int security_get_classes(struct selinux_policy *policy,
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
 	if (rc) {
-		int i;
+		u32 i;
+
 		for (i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
 		kfree(*classes);
@@ -3442,7 +3442,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 {
 	struct perm_datum *datum = d;
 	char *name = k, **perms = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	perms[value] = kstrdup(name, GFP_ATOMIC);
 	if (!perms[value])
@@ -3452,10 +3452,11 @@ static int get_permissions_callback(void *k, void *d, void *args)
 }
 
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms)
+			     char *class, char ***perms, u32 *nperms)
 {
 	struct policydb *policydb;
-	int rc, i;
+	u32 i;
+	int rc;
 	struct class_datum *match;
 
 	policydb = &policy->policydb;
@@ -3675,7 +3676,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 /* Check to see if the rule contains any selinux fields */
 int selinux_audit_rule_known(struct audit_krule *rule)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
-- 
2.43.0

