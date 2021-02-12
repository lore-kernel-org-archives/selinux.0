Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A6C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F8864EA6
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBLTBN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhBLTBK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Feb 2021 14:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613156381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYEZvYVi3cg6wthd1SZp39yj7thCaiEbxkXnP0Z7jYI=;
        b=aOMZ779ubi46h7hDn9xvwi0raxHVieeS9kRF/cBOwL8VCeRmm/jDlOdwuer/FM/eaR7K12
        HdeGwPMPC4akYmq+Rak/80zz3Upb96WbLmL+7JzHITRKyya2qzTF5lcuHW/uAbNm7gBs2H
        4wDEmOnKDoeJBKJ2gBfbWn85a9sNmbs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-4NsbZp73PHWY0mywN1-FXw-1; Fri, 12 Feb 2021 13:59:39 -0500
X-MC-Unique: 4NsbZp73PHWY0mywN1-FXw-1
Received: by mail-ed1-f71.google.com with SMTP id ay16so520715edb.2
        for <selinux@vger.kernel.org>; Fri, 12 Feb 2021 10:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYEZvYVi3cg6wthd1SZp39yj7thCaiEbxkXnP0Z7jYI=;
        b=abwiRKDe8hplclTmBsikOc2Cq+JlekjM57byKGOZg6AquiSKuvEbitSM6wi3QP8qsy
         rnrrKDgn51cxLyPXE0Ke34UbK57N9cW9bXRLV1PB3bsEkdXyBPPNecgwjvFy/AedOpOa
         8GwywzYl0VYTWhTuJ7jZaH/3OOECehjKeastDk5cGAQqbInJPGr7dUz+ncAtBhCQTpid
         EMMjx0bqtxWVwSbtnHUGGhqdPg7zOmRAo7yeghFuWmDXHXkPAHsnVfupMESpyz+zA8aS
         s7KSL/SnBoTe7netVBw2dBCVc3jbruHpUzd440PbYTYlEhMWwIaVidYJMKeCnMt6PDDe
         FTzQ==
X-Gm-Message-State: AOAM531Ui+LvuG1iGB5kqJ+WLaZlOa1ph+QfcB2YURvzTg5G1uKTckBM
        8e1RJDwArbFjsPNvhvrRXN5XsXUltaVcDtV42XXaVkQlVrSwINOXMR2dZN1LQhE/8bhHJb3lQY+
        QyST8AfzZOP63GjnPJeRYzwNjnjiCcveIN1jScEqq4lGuPo8dIxw7vnxv5dpKF9mH1wWdjQ==
X-Received: by 2002:a50:9d4d:: with SMTP id j13mr4733432edk.83.1613156377956;
        Fri, 12 Feb 2021 10:59:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0cvP0KqfSNKO7BrJa1YnlFuw/guqUuCMSDOsHoPl8D3VKR2XicXdnnwba58tBmjG2+ifzgQ==
X-Received: by 2002:a50:9d4d:: with SMTP id j13mr4733414edk.83.1613156377727;
        Fri, 12 Feb 2021 10:59:37 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u23sm6351128edt.87.2021.02.12.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:59:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
Date:   Fri, 12 Feb 2021 19:59:30 +0100
Message-Id: <20210212185930.130477-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212185930.130477-1-omosnace@redhat.com>
References: <20210212185930.130477-1-omosnace@redhat.com>
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

Fix this by allocating the temporary sidtab convert structures
dynamically and passing them among the
selinux_policy_{load,cancel,commit} functions.

Note that this commit also fixes the minor issue of logging a
MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
which case the new policy isn't actually loaded).

Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 15 ++++++---
 security/selinux/selinuxfs.c        | 10 +++---
 security/selinux/ss/services.c      | 51 +++++++++++++++++++----------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 765a258a899e..25db66e0ac51 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -219,14 +219,21 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
 }
 
+struct selinux_policy_convert_data;
+
+struct selinux_load_state {
+	struct selinux_policy *policy;
+	struct selinux_policy_convert_data *convert_data;
+};
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
-			void *data, size_t len,
-			struct selinux_policy **newpolicyp);
+			 void *data, size_t len,
+			 struct selinux_load_state *load_state);
 void selinux_policy_commit(struct selinux_state *state,
-			struct selinux_policy *newpolicy);
+			   struct selinux_load_state *load_state);
 void selinux_policy_cancel(struct selinux_state *state,
-			struct selinux_policy *policy);
+			   struct selinux_load_state *load_state);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 340711e3dc9a..158d44ea93f4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -616,7 +616,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_policy *newpolicy;
+	struct selinux_load_state load_state;
 	ssize_t length;
 	void *data = NULL;
 
@@ -642,19 +642,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (copy_from_user(data, buf, count) != 0)
 		goto out;
 
-	length = security_load_policy(fsi->state, data, count, &newpolicy);
+	length = security_load_policy(fsi->state, data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
 
-	length = sel_make_policy_nodes(fsi, newpolicy);
+	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
-		selinux_policy_cancel(fsi->state, newpolicy);
+		selinux_policy_cancel(fsi->state, &load_state);
 		goto out;
 	}
 
-	selinux_policy_commit(fsi->state, newpolicy);
+	selinux_policy_commit(fsi->state, &load_state);
 
 	length = count;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5e08ce2c5994..fada4ebc7ef8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2157,8 +2157,13 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
+struct selinux_policy_convert_data {
+	struct convert_context_args args;
+	struct sidtab_convert_params sidtab_params;
+};
+
 void selinux_policy_cancel(struct selinux_state *state,
-			struct selinux_policy *policy)
+			   struct selinux_load_state *load_state)
 {
 	struct selinux_policy *oldpolicy;
 
@@ -2166,7 +2171,8 @@ void selinux_policy_cancel(struct selinux_state *state,
 					lockdep_is_held(&state->policy_mutex));
 
 	sidtab_cancel_convert(oldpolicy->sidtab);
-	selinux_policy_free(policy);
+	selinux_policy_free(load_state->policy);
+	kfree(load_state->convert_data);
 }
 
 static void selinux_notify_policy_change(struct selinux_state *state,
@@ -2181,9 +2187,9 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 }
 
 void selinux_policy_commit(struct selinux_state *state,
-			struct selinux_policy *newpolicy)
+			   struct selinux_load_state *load_state)
 {
-	struct selinux_policy *oldpolicy;
+	struct selinux_policy *oldpolicy, *newpolicy = load_state->policy;
 	u32 seqno;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
@@ -2223,6 +2229,7 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Free the old policy */
 	synchronize_rcu();
 	selinux_policy_free(oldpolicy);
+	kfree(load_state->convert_data);
 
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
@@ -2239,11 +2246,10 @@ void selinux_policy_commit(struct selinux_state *state,
  * loading the new policy.
  */
 int security_load_policy(struct selinux_state *state, void *data, size_t len,
-			struct selinux_policy **newpolicyp)
+			 struct selinux_load_state *load_state)
 {
 	struct selinux_policy *newpolicy, *oldpolicy;
-	struct sidtab_convert_params convert_params;
-	struct convert_context_args args;
+	struct selinux_policy_convert_data *convert_data;
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
@@ -2273,10 +2279,10 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err_mapping;
 	}
 
-
 	if (!selinux_initialized(state)) {
 		/* First policy load, so no need to preserve state from old policy */
-		*newpolicyp = newpolicy;
+		load_state->policy = newpolicy;
+		load_state->convert_data = NULL;
 		return 0;
 	}
 
@@ -2290,29 +2296,38 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err_free_isids;
 	}
 
+	convert_data = kmalloc(sizeof(*convert_data), GFP_KERNEL);
+	if (!convert_data) {
+		rc = -ENOMEM;
+		goto err_free_isids;
+	}
+
 	/*
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
 	 */
-	args.state = state;
-	args.oldp = &oldpolicy->policydb;
-	args.newp = &newpolicy->policydb;
+	convert_data->args.state = state;
+	convert_data->args.oldp = &oldpolicy->policydb;
+	convert_data->args.newp = &newpolicy->policydb;
 
-	convert_params.func = convert_context;
-	convert_params.args = &args;
-	convert_params.target = newpolicy->sidtab;
+	convert_data->sidtab_params.func = convert_context;
+	convert_data->sidtab_params.args = &convert_data->args;
+	convert_data->sidtab_params.target = newpolicy->sidtab;
 
-	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
+	rc = sidtab_convert(oldpolicy->sidtab, &convert_data->sidtab_params);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
 			" table\n");
-		goto err_free_isids;
+		goto err_free_convert_data;
 	}
 
-	*newpolicyp = newpolicy;
+	load_state->policy = newpolicy;
+	load_state->convert_data = convert_data;
 	return 0;
 
+err_free_convert_data:
+	kfree(convert_data);
 err_free_isids:
 	sidtab_destroy(newpolicy->sidtab);
 err_mapping:
-- 
2.29.2

