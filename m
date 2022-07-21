Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF3C433EF
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 17:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiGUR3F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUR2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 13:28:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198508AB0B
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 10:28:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3281407fac.9
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XmM5ZEm+shFY9USkb0JIud5sKeKc0ztWjPwdUbLtVM=;
        b=VxN5mqJJldqCTmzCQx2+zgcmh2YQ/eQWRZOCH3SSk/wgcplWOs9zda4bzFvX0e/y3I
         w3O6v0xE9QlSb5O7mcwsd7nUKfGQMW+kAGmKMdQ3s/MptadnTYQWw5YHyzVxhn0Qdra7
         /HkKK7hh0AG+o5x79m4ZlAOsEEJPLxCywqt50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XmM5ZEm+shFY9USkb0JIud5sKeKc0ztWjPwdUbLtVM=;
        b=eGdJLeVwwhHiGjQNCvPJ5N5t/AyIKZve6lEhNwKkDHz8secxww1fjcFz1SG3GjiF8K
         tn+R+z3OluGgjuzUHjVkgoIBywjl4ke3MaszLzkuxh6G+MyQLJ+znRyLFXqr+buDKVq8
         it4ndjlQztvMXHeaTRTw0i3XTYdDiT1ED258dxHpbogoBOtWxpAkrQ9k1+xkxCqesDyL
         Bohqrh2mI/FRMORdffsd1U1mvOS+2x0XtZ1osrku/4e905lwosm6Gb0rKr8wT8eMO4BF
         etrxsSX8uiusmHy0OpfmlZC7SQCm/S6K0rDiOmITKggUI3QkI0zR+5kBnlL688FOF7cG
         mLCw==
X-Gm-Message-State: AJIora94ngHQcP4+EFHwVNk1LFUJRV4/W/I5moLSCkOGmcJ1kJ+DvCT0
        Xc9Jv72f087Xk5QKMQiK1aFx+w==
X-Google-Smtp-Source: AGRyM1szrijCIIxZinJ6E7J+5pSN+ES88nSt3CyPGl/JIMkRcNEV5/3s7Tb0OdikxMeqWkjS76rHQg==
X-Received: by 2002:a05:6870:709e:b0:10d:752a:9ce7 with SMTP id v30-20020a056870709e00b0010d752a9ce7mr5876067oae.233.1658424501678;
        Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 4/4] selinux: Implement userns_create hook
Date:   Thu, 21 Jul 2022 12:28:08 -0500
Message-Id: <20220721172808.585539-5-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721172808.585539-1-fred@cloudflare.com>
References: <20220721172808.585539-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unprivileged user namespace creation is an intended feature to enable
sandboxing, however this feature is often used to as an initial step to
perform a privilege escalation attack.

This patch implements a new user_namespace { create } access control
permission to restrict which domains allow or deny user namespace
creation. This is necessary for system administrators to quickly protect
their systems while waiting for vulnerability patches to be applied.

This permission can be used in the following way:

        allow domA_t domA_t : user_namespace { create };

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Introduce this patch
---
 security/selinux/hooks.c            | 9 +++++++++
 security/selinux/include/classmap.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index beceb89f68d9..afc9da0249e7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_userns_create(const struct cred *cred)
+{
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
+						USER_NAMESPACE__CREATE, NULL);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7117,6 +7125,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..0bff55bb9cde 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
 	  { "override_creds", "sqpoll", NULL } },
+	{ "user_namespace",
+	  { "create", NULL } },
 	{ NULL }
   };
 
-- 
2.30.2

