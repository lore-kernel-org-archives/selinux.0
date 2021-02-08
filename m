Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4447C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428D260231
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 11:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhBHLbe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 06:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233109AbhBHL3Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 06:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612783666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hliLWDm8nlDXW//peq8LdkylOeqOMnt6Sz4j+pWvlzY=;
        b=Ajcq/kL+PwVtw66XyPm0c8mEMsCj1Vs7n+Ni1rTN2SE9N1q26YCEzt38G1faJMXb4yqM3O
        r7dp78HaO9uc5gcHaTyuGgMcKgr7PUHWNziMLjnAQfXmsBMrmJ8QUoCiZZ9E4uNUpg8qHJ
        QUXPIZDIPkIkxW3Wf9ZdKILZZoaohqE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-FxCLVc8wMb-uQRzHiOKJ9A-1; Mon, 08 Feb 2021 06:27:45 -0500
X-MC-Unique: FxCLVc8wMb-uQRzHiOKJ9A-1
Received: by mail-ed1-f71.google.com with SMTP id a1so5718501edt.8
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 03:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hliLWDm8nlDXW//peq8LdkylOeqOMnt6Sz4j+pWvlzY=;
        b=rPwssFE7SQSqU7ASrTki0nxAoSr5Qe6dkBjTwT5qIau6W3eb3wI9TKbJkjIx17INaK
         XO1sYA5KAjeEYrYJoPWNP6WbLaftAcgwrEMXvPlJGU7wmwd7TeOtaAeAQb4wd6l7WW3d
         FIskYE6UeE60YQ11AR35ZKAz52j6KDtvvG42xzWxwa8mHOyttnkZgIAtBZMaZ26q/YGS
         WR/F23vjzg1Jreefv40BsggDJcuyzLPNJ9KHXa1g5eDeOgOmcIbDMXVlOB0BrD9IBFbZ
         Af98cT17L05yw8bRjh8b0kAxUhlsC7hDu10xB0IoWrETxh40Dk2mbwyRbFyJgOfoyA8U
         X9mg==
X-Gm-Message-State: AOAM532pWn1II5LkUgBJkXm2JniRwyz7tYoG2IVqySasd4hImpxxCE1l
        TVaGPCggdiFMntWyrqj3rwoxVGkRA9tYP6yiSnYhzOQ72ZYO5sJu24eGp5GqPuRjlC8SvCQn0kg
        NtdXMHwLi7rSuj25Im075WB74nv5cCoXdp/oeAbzrn5BXfEnp4OCbHKB4v87BXUJ+oHwx/A==
X-Received: by 2002:a17:906:8252:: with SMTP id f18mr16481247ejx.418.1612783663328;
        Mon, 08 Feb 2021 03:27:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKE96bPM6nLKIxW8kW2FacpFCcp4w2O1pa6ECgjFkUHzXiyx0nc8xkioOm8XWj1/E+y+40hw==
X-Received: by 2002:a17:906:8252:: with SMTP id f18mr16481224ejx.418.1612783663049;
        Mon, 08 Feb 2021 03:27:43 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bf8sm9391602edb.34.2021.02.08.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:27:42 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix variable scope issue in live sidtab conversion
Date:   Mon,  8 Feb 2021 12:27:36 +0100
Message-Id: <20210208112736.247195-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 02a52c5c8c3b ("selinux: move policy commit after updating
selinuxfs") moved the selinux_policy_commit() call out of
security_load_policy() into sel_write_load(), which caused a subtle yet
rather serious bug.

The problem is that security_load_policy() passes a reference to the
convert_params local variable to sidtab_convert(), which stores it in
the sidtab, where it may be accessed until the policy is swapped over
and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
called directly from security_load_policy(), so the convert_params
pointer remained valid all the way until the old sidtab was destroyed,
but now that's no longer the case and calls to sidtab_context_to_sid()
on the old sidtab after security_load_policy() returns may cause invalid
memory accesses.

This can be easily triggered using the stress test from commit
ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
performance"):
```
function rand_cat() {
	echo $(( $RANDOM % 1024 ))
}

function do_work() {
	while true; do
		echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
			>/sys/fs/selinux/context 2>/dev/null || true
	done
}

do_work >/dev/null &
do_work >/dev/null &
do_work >/dev/null &

while load_policy; do echo -n .; sleep 0.1; done

kill %1
kill %2
kill %3
```

There are several ways to fix this:
1. Move the sidtab convert parameters to struct selinux_policy.
   Pros:
     * simple change
   Cons:
     * added fields not used during most of the object's lifetime
2. Move the sidtab convert params to sel_write_load().
   Pros:
     * (nothing specific)
   Cons:
     * layering violation, a lot of types would have to be exposed to
       selinuxfs.c
3. Merge policy load functions back into one and call
   sel_make_policy_nodes() as a callback.
   Pros:
     * results in simpler code
   Cons:
     * introduces an indirect call (not in hot path, so should be okay)

I chose to implement option (3.), because IMHO it results in the least
ugly code and has the least bad drawback.

Note that this commit also fixes the minor issue of logging a
MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
which case the new policy isn't actually loaded).

Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h |  10 +-
 security/selinux/selinuxfs.c        |  18 +---
 security/selinux/ss/services.c      | 159 ++++++++++++----------------
 3 files changed, 78 insertions(+), 109 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 765a258a899e..9b1bcecad6ef 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -221,12 +221,10 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
-			void *data, size_t len,
-			struct selinux_policy **newpolicyp);
-void selinux_policy_commit(struct selinux_state *state,
-			struct selinux_policy *newpolicy);
-void selinux_policy_cancel(struct selinux_state *state,
-			struct selinux_policy *policy);
+			 void *data, size_t len,
+			 int (*setup_func)(struct selinux_policy *newpolicy,
+					   void *args),
+			 void *args);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 01a7d50ed39b..1a9ef1a010e6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -533,9 +533,9 @@ static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
 	kfree(bool_values);
 }
 
-static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
-				struct selinux_policy *newpolicy)
+static int sel_make_policy_nodes(struct selinux_policy *newpolicy, void *args)
 {
+	struct selinux_fs_info *fsi = args;
 	int ret = 0;
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *old_dentry;
 	unsigned int tmp_bool_num, old_bool_num;
@@ -616,7 +616,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_policy *newpolicy;
 	ssize_t length;
 	void *data = NULL;
 
@@ -642,27 +641,20 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (copy_from_user(data, buf, count) != 0)
 		goto out;
 
-	length = security_load_policy(fsi->state, data, count, &newpolicy);
+	length = security_load_policy(fsi->state, data, count,
+				      sel_make_policy_nodes, fsi);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
 
-	length = sel_make_policy_nodes(fsi, newpolicy);
-	if (length) {
-		selinux_policy_cancel(fsi->state, newpolicy);
-		goto out1;
-	}
-
-	selinux_policy_commit(fsi->state, newpolicy);
-
 	length = count;
 
-out1:
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->state->policy_mutex);
 	vfree(data);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5e08ce2c5994..50124123d385 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2157,18 +2157,6 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
-void selinux_policy_cancel(struct selinux_state *state,
-			struct selinux_policy *policy)
-{
-	struct selinux_policy *oldpolicy;
-
-	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
-
-	sidtab_cancel_convert(oldpolicy->sidtab);
-	selinux_policy_free(policy);
-}
-
 static void selinux_notify_policy_change(struct selinux_state *state,
 					u32 seqno)
 {
@@ -2180,54 +2168,6 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 	selinux_xfrm_notify_policyload();
 }
 
-void selinux_policy_commit(struct selinux_state *state,
-			struct selinux_policy *newpolicy)
-{
-	struct selinux_policy *oldpolicy;
-	u32 seqno;
-
-	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
-
-	/* If switching between different policy types, log MLS status */
-	if (oldpolicy) {
-		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
-			pr_info("SELinux: Disabling MLS support...\n");
-		else if (!oldpolicy->policydb.mls_enabled && newpolicy->policydb.mls_enabled)
-			pr_info("SELinux: Enabling MLS support...\n");
-	}
-
-	/* Set latest granting seqno for new policy. */
-	if (oldpolicy)
-		newpolicy->latest_granting = oldpolicy->latest_granting + 1;
-	else
-		newpolicy->latest_granting = 1;
-	seqno = newpolicy->latest_granting;
-
-	/* Install the new policy. */
-	rcu_assign_pointer(state->policy, newpolicy);
-
-	/* Load the policycaps from the new policy */
-	security_load_policycaps(state, newpolicy);
-
-	if (!selinux_initialized(state)) {
-		/*
-		 * After first policy load, the security server is
-		 * marked as initialized and ready to handle requests and
-		 * any objects created prior to policy load are then labeled.
-		 */
-		selinux_mark_initialized(state);
-		selinux_complete_init();
-	}
-
-	/* Free the old policy */
-	synchronize_rcu();
-	selinux_policy_free(oldpolicy);
-
-	/* Notify others of the policy change */
-	selinux_notify_policy_change(state, seqno);
-}
-
 /**
  * security_load_policy - Load a security policy configuration.
  * @data: binary policy data
@@ -2239,12 +2179,15 @@ void selinux_policy_commit(struct selinux_state *state,
  * loading the new policy.
  */
 int security_load_policy(struct selinux_state *state, void *data, size_t len,
-			struct selinux_policy **newpolicyp)
+			 int (*setup_func)(struct selinux_policy *newpolicy,
+					   void *setup_args),
+			 void *setup_args)
 {
-	struct selinux_policy *newpolicy, *oldpolicy;
+	struct selinux_policy *newpolicy, *oldpolicy = NULL;
 	struct sidtab_convert_params convert_params;
-	struct convert_context_args args;
+	struct convert_context_args convert_args;
 	int rc = 0;
+	u32 seqno;
 	struct policy_file file = { data, len }, *fp = &file;
 
 	newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
@@ -2273,44 +2216,80 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err_mapping;
 	}
 
+	if (selinux_initialized(state)) {
+		oldpolicy = rcu_dereference_protected(state->policy,
+					lockdep_is_held(&state->policy_mutex));
 
-	if (!selinux_initialized(state)) {
-		/* First policy load, so no need to preserve state from old policy */
-		*newpolicyp = newpolicy;
-		return 0;
-	}
+		/* Preserve active boolean values from the old policy */
+		rc = security_preserve_bools(oldpolicy, newpolicy);
+		if (rc) {
+			pr_err("SELinux:  unable to preserve booleans\n");
+			goto err_free_isids;
+		}
 
-	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
+		/*
+		 * Convert the internal representations of contexts
+		 * in the new SID table.
+		 */
+		convert_args.state = state;
+		convert_args.oldp = &oldpolicy->policydb;
+		convert_args.newp = &newpolicy->policydb;
+
+		convert_params.func = convert_context;
+		convert_params.args = &convert_args;
+		convert_params.target = newpolicy->sidtab;
+
+		rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
+		if (rc) {
+			pr_err("SELinux:  unable to convert the internal representation of contexts in the new SID table\n");
+			goto err_free_isids;
+		}
+	}
 
-	/* Preserve active boolean values from the old policy */
-	rc = security_preserve_bools(oldpolicy, newpolicy);
+	rc = setup_func(newpolicy, setup_args);
 	if (rc) {
-		pr_err("SELinux:  unable to preserve booleans\n");
+		if (oldpolicy)
+			sidtab_cancel_convert(oldpolicy->sidtab);
 		goto err_free_isids;
 	}
 
-	/*
-	 * Convert the internal representations of contexts
-	 * in the new SID table.
-	 */
-	args.state = state;
-	args.oldp = &oldpolicy->policydb;
-	args.newp = &newpolicy->policydb;
+	/* If switching between different policy types, log MLS status */
+	if (oldpolicy) {
+		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
+			pr_info("SELinux: Disabling MLS support...\n");
+		else if (!oldpolicy->policydb.mls_enabled && newpolicy->policydb.mls_enabled)
+			pr_info("SELinux: Enabling MLS support...\n");
+	}
+
+	/* Set latest granting seqno for new policy. */
+	if (oldpolicy)
+		newpolicy->latest_granting = oldpolicy->latest_granting + 1;
+	else
+		newpolicy->latest_granting = 1;
+	seqno = newpolicy->latest_granting;
 
-	convert_params.func = convert_context;
-	convert_params.args = &args;
-	convert_params.target = newpolicy->sidtab;
+	/* Install the new policy. */
+	rcu_assign_pointer(state->policy, newpolicy);
 
-	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
-	if (rc) {
-		pr_err("SELinux:  unable to convert the internal"
-			" representation of contexts in the new SID"
-			" table\n");
-		goto err_free_isids;
+	/* Load the policycaps from the new policy */
+	security_load_policycaps(state, newpolicy);
+
+	if (!oldpolicy) {
+		/*
+		 * After first policy load, the security server is
+		 * marked as initialized and ready to handle requests and
+		 * any objects created prior to policy load are then labeled.
+		 */
+		selinux_mark_initialized(state);
+		selinux_complete_init();
 	}
 
-	*newpolicyp = newpolicy;
+	/* Free the old policy */
+	synchronize_rcu();
+	selinux_policy_free(oldpolicy);
+
+	/* Notify others of the policy change */
+	selinux_notify_policy_change(state, seqno);
 	return 0;
 
 err_free_isids:
-- 
2.29.2

