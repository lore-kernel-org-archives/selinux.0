Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DCC433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD5264F38
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCRVxl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231770AbhCRVx1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 17:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616104406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xuml6FX+QV3znNsmhXkEQUKuBbFZHIk7R0h/7PdbebI=;
        b=Mc2Yx6sipWXHw66IcGbCqwBE7THF6L7mcOUoAnu7LYMCnvk5+leOdqQUDwXQcMHQ9450RA
        djP4zdDYuuhfJlhfaYVLEmO1ckprtzSWI261wE9o4IEBlS4DrIbUvrNIbS75icvozf9bZ1
        ywaywMwsPHhT9c0nlHCjsFbGj5WzikA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-H5KPB4R9Mrm-KsC1tzWgug-1; Thu, 18 Mar 2021 17:53:10 -0400
X-MC-Unique: H5KPB4R9Mrm-KsC1tzWgug-1
Received: by mail-ej1-f72.google.com with SMTP id au15so17385315ejc.8
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 14:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xuml6FX+QV3znNsmhXkEQUKuBbFZHIk7R0h/7PdbebI=;
        b=ZczkLzhBGjeq0RW4nmWvP2p3jwUB1OVC5cgRdyA20Ilk149ayE92puE/tf3A6zg7OI
         0CalVKoF7tXjojsBRAZS2STVj/MlJkznZSTJoPKR034LlqF80tdAB28/7wupg/OkLuJx
         Z6nE8HCA6oq24Unt6BiGacaZEI0Tbo6IJvv6/mKR7bgworL80sy19A1dXfsMvNuWL9B2
         SpLMUyU0jIQq4GbXdWpgvKWbrV4Cxpa4Xc1bbfxb8ob/WBVb2CAVYmmIzX9s2mHXt2/b
         b3c+WvukemznZyD9h0w9yxFkyEFF/74abbfpnkRmfo5iege/lbupx4GmO1RDNl8Vw59Y
         By4g==
X-Gm-Message-State: AOAM530b5c4GVur3LpLqg3a3h6RUP9aRqOR3Ody2iaMYDK+69/Qobyey
        WBl5+ZwnN9LzkFkbrrxla5x9sJiaO+8df8F9mk0E7P/owkse/BfSax4Ug83DTCrOkwslatBVw8P
        xVEgncGYr8q/KWK9xgQUbjp7N4c9FzuN/8PT8/7HaEOCt3PVyZ6uCkODnkB9/KhsZm0R1ZQ==
X-Received: by 2002:a17:907:9862:: with SMTP id ko2mr728200ejc.222.1616104388717;
        Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4eqtdcZ7XbmuiyKvhLIb7WVbJgRqeaWisFCJWTZ3eaOe1XGxfBkTdm5BIuWs13xhiaUMhdA==
X-Received: by 2002:a17:907:9862:: with SMTP id ko2mr728185ejc.222.1616104388514;
        Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a17sm2620255ejf.20.2021.03.18.14.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [PATCH v3 2/3] selinux: fix variable scope issue in live sidtab conversion
Date:   Thu, 18 Mar 2021 22:53:02 +0100
Message-Id: <20210318215303.2578052-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318215303.2578052-1-omosnace@redhat.com>
References: <20210318215303.2578052-1-omosnace@redhat.com>
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

Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 15 +++++--
 security/selinux/selinuxfs.c        | 10 ++---
 security/selinux/ss/services.c      | 63 ++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7130c9648ad1..ac0ece01305a 100644
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
 int security_read_state_kernel(struct selinux_state *state,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 37b32b0035f6..dc7297abe4ea 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -619,7 +619,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_policy *newpolicy;
+	struct selinux_load_state load_state;
 	ssize_t length;
 	void *data = NULL;
 
@@ -645,19 +645,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
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
index f37375c9553f..08ac1d01c743 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -67,6 +67,17 @@
 #include "policycap_names.h"
 #include "ima.h"
 
+struct convert_context_args {
+	struct selinux_state *state;
+	struct policydb *oldp;
+	struct policydb *newp;
+};
+
+struct selinux_policy_convert_data {
+	struct convert_context_args args;
+	struct sidtab_convert_params sidtab_params;
+};
+
 /* Forward declaration. */
 static int context_struct_to_string(struct policydb *policydb,
 				    struct context *context,
@@ -1974,12 +1985,6 @@ static inline int convert_context_handle_invalid_context(
 	return 0;
 }
 
-struct convert_context_args {
-	struct selinux_state *state;
-	struct policydb *oldp;
-	struct policydb *newp;
-};
-
 /*
  * Convert the values in the security context
  * structure `oldc' from the values specified
@@ -2159,7 +2164,7 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
 }
 
 void selinux_policy_cancel(struct selinux_state *state,
-			struct selinux_policy *policy)
+			   struct selinux_load_state *load_state)
 {
 	struct selinux_policy *oldpolicy;
 
@@ -2167,7 +2172,8 @@ void selinux_policy_cancel(struct selinux_state *state,
 					lockdep_is_held(&state->policy_mutex));
 
 	sidtab_cancel_convert(oldpolicy->sidtab);
-	selinux_policy_free(policy);
+	selinux_policy_free(load_state->policy);
+	kfree(load_state->convert_data);
 }
 
 static void selinux_notify_policy_change(struct selinux_state *state,
@@ -2183,9 +2189,9 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 }
 
 void selinux_policy_commit(struct selinux_state *state,
-			struct selinux_policy *newpolicy)
+			   struct selinux_load_state *load_state)
 {
-	struct selinux_policy *oldpolicy;
+	struct selinux_policy *oldpolicy, *newpolicy = load_state->policy;
 	u32 seqno;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
@@ -2225,6 +2231,7 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Free the old policy */
 	synchronize_rcu();
 	selinux_policy_free(oldpolicy);
+	kfree(load_state->convert_data);
 
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
@@ -2241,11 +2248,10 @@ void selinux_policy_commit(struct selinux_state *state,
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
 
@@ -2275,10 +2281,10 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
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
 
@@ -2292,29 +2298,38 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
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
2.30.2

