Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B178C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD8420781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VWmg8VaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgHDBeq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBeq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:46 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDABC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 2so32951518qkf.10
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=pDdF886iwjKBG/bGOWLC/P/3s/YzgDNofqWOtZJ8w9I=;
        b=VWmg8VaPgK0sFcQyiQRp/P3Ee2H7ibjF5A+GXP4ZZtplAdGyKhqCbafEDYWl8J8t1E
         SMk6k/UNnz+Jy+8e8EavMWw0bkIAsipM9r0Ci/gpEoYvaNh5trK1yCh6iDDyddOA7M+W
         iXvsZ13Uz+nQBS6EKoP9gRGaUUagHzQWPkTBMqB8bkYicXnm0z/yGuYvAjurxb1vCQjY
         VLH6nGAv6HBs7va19dxVrYmLVI2lCT2MIa4WXhy9SDVMhKi4QuM6WyAb35OWg5IEsid1
         VU/Dujg3LD2Zm3EN4C3k7yO+wCAB1EWis89vZo2a02IkKZG5Z7NbtuwOU8PMCfP1OWAy
         MTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pDdF886iwjKBG/bGOWLC/P/3s/YzgDNofqWOtZJ8w9I=;
        b=d0baws/3ci7wjSBOXwjtrGvt9QAlgWNwkxgrYA0vSNnxa/HnzuqmDG0yFq12w64zGH
         aAl3pChmWiB5a6jbTsMCa2PAED2AHy+ggiU0Q6dlwfPy8QKLPU3UJ2QwJvuCyBwAqAea
         /h5I7wwfVtxtf/O85qpj1KrrQFBuyxx+we//mF0kVAfU5kVqnpdlxsMYFaLyvjkouFJd
         PXi2MpwEfXfoWBhEKMCBoPpL+KLaWHd1IA7QWhNrhxjtrNz/kUdCCo42D1Naa/cU8dyd
         xtG9uKK49SFuEP86r8TnE5mQdMgepiF1DHSzqschhzLxzOyUbZ3u7JJtJwniBhwZVeHl
         GKSg==
X-Gm-Message-State: AOAM531mnln0WfAn2wCvzKdfffmkQODKvdwai0AONrPCdmnCPuW23tVU
        YZTX4W/YgHJ3GgP6jwcki5wmDWhcrzpH
X-Google-Smtp-Source: ABdhPJziltZjfAjfM98rkia9dEWF773jUCQltOUPcHfCyZz7ZL8pwJvXGy7SiTPx5OwN2Rg+/TowSg==
X-Received: by 2002:a37:b647:: with SMTP id g68mr17643788qkf.70.1596504882898;
        Mon, 03 Aug 2020 18:34:42 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id t8sm25123620qtc.50.2020.08.03.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:42 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 13/18] all: unify example formatting
 (scripts, code, policy, etc) in markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:41 -0400
Message-ID: <159650488135.8961.8180818265945682261.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While the impact to the rendered markdown, HTML, and PDF is minimal,
this provides a more consistent look-and-feel when reading the raw
markdown.

The following script was used to do the conversion:

  for i in *.md; do
    sed 's/^[ \t]*`\([^`]\+\)`[ \t]*$/```\n\1\n```/p' -i $i
  done

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/apache_support.md              |    4 +-
 src/avc_rules.md                   |    4 +-
 src/bounds_rules.md                |    4 +-
 src/class_permission_statements.md |   12 ++++-
 src/computing_security_contexts.md |    4 +-
 src/conditional_statements.md      |    8 +++-
 src/configuration_files.md         |    4 +-
 src/constraint_statements.md       |   20 +++++++--
 src/default_rules.md               |   16 +++++--
 src/domain_object_transitions.md   |   44 +++++++++++++++-----
 src/file_labeling_statements.md    |   16 +++++--
 src/implementing_seaware_apps.md   |    4 +-
 src/infiniband_statements.md       |   16 +++++--
 src/lsm_selinux.md                 |   12 ++++-
 src/mls_statements.md              |   32 +++++++++++---
 src/modular_policy_statements.md   |   12 ++++-
 src/network_statements.md          |   52 ++++++++++++++++++-----
 src/network_support.md             |   28 +++++++++----
 src/pam_login.md                   |    4 +-
 src/policy_config_files.md         |   80 +++++++++++++++++++++++++++---------
 src/policy_config_statements.md    |    4 +-
 src/policy_store_config_files.md   |   52 ++++++++++++++++++-----
 src/policy_validation_example.md   |    8 +++-
 src/polyinstantiation.md           |    4 +-
 src/postgresql.md                  |    4 +-
 src/reference_policy.md            |   80 +++++++++++++++++++++++++++---------
 src/role_statements.md             |   36 ++++++++++++----
 src/seandroid.md                   |   28 +++++++++----
 src/security_context.md            |    4 +-
 src/sid_statement.md               |    8 +++-
 src/type_enforcement.md            |    8 +++-
 src/type_statements.md             |   36 ++++++++++++----
 src/types_of_policy.md             |    4 +-
 src/user_statements.md             |    8 +++-
 src/userspace_libraries.md         |    8 +++-
 src/vm_support.md                  |   12 ++++-
 src/x_windows.md                   |    4 +-
 src/xen_statements.md              |   32 +++++++++++---
 src/xperm_rules.md                 |    8 +++-
 39 files changed, 543 insertions(+), 181 deletions(-)

diff --git a/src/apache_support.md b/src/apache_support.md
index 22ce966..d74695a 100644
--- a/src/apache_support.md
+++ b/src/apache_support.md
@@ -7,7 +7,9 @@ library and policy that will allow finer grained access control when
 using Apache with threads. The additional Apache module is called
 `mod_selinux.so` and has a supporting policy module called `mod_selinux.pp`.
 
-`dnf install mod_selinux`
+```
+dnf install mod_selinux
+```
 
 The `mod_selinux` policy module makes use of the `typebounds` statement that
 was introduced into version 24 of the policy (requires a minimum kernel of
diff --git a/src/avc_rules.md b/src/avc_rules.md
index de8e9c3..d200caf 100644
--- a/src/avc_rules.md
+++ b/src/avc_rules.md
@@ -20,7 +20,9 @@ section.
 
 **The common format for Access Vector Rules are:**
 
-`rule_name source_type target_type : class perm_set;`
+```
+rule_name source_type target_type : class perm_set;
+```
 
 **Where:**
 
diff --git a/src/bounds_rules.md b/src/bounds_rules.md
index e890955..4aa68c4 100644
--- a/src/bounds_rules.md
+++ b/src/bounds_rules.md
@@ -23,7 +23,9 @@ context associated to threads in multi-threaded applications.
 
 **The statement definition is:**
 
-`typebounds bounding_domain bounded_domain;`
+```
+typebounds bounding_domain bounded_domain;
+```
 
 **Where:**
 
diff --git a/src/class_permission_statements.md b/src/class_permission_statements.md
index eb42b1f..29cf855 100644
--- a/src/class_permission_statements.md
+++ b/src/class_permission_statements.md
@@ -22,7 +22,9 @@ There are two variants of the `class` statement for writing policy:
 Object classes are declared within a policy with the following statement
 definition:
 
-`class class_id`
+```
+class class_id
+```
 
 **Where:**
 
@@ -95,7 +97,9 @@ Declare a `common` identifier and associate one or more `common` permissions.
 
 The statement definition is:
 
-`common common_id { perm_set }`
+```
+common common_id { perm_set }
+```
 
 **Where:**
 
@@ -158,7 +162,9 @@ Inherit and / or associate permissions to a perviously declared `class` identifi
 
 **The statement definition is:**
 
-`class class_id [ inherits common_set ] [ { perm_set } ]`
+```
+class class_id [ inherits common_set ] [ { perm_set } ]
+```
 
 **Where:**
 
diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index 100a8cf..807c4f7 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -124,7 +124,9 @@ language statement as they are mounted, they are based on the filesystem
 type name (e.g. `ext4`) and their behaviour (e.g. `xattr`). For example
 if the policy specifies the following:
 
-`fs_use_task pipefs system_u:object_r:fs_t:s0`
+```
+fs_use_task pipefs system_u:object_r:fs_t:s0
+```
 
 then as the `pipefs` filesystem is being mounted, the SELinux LSM
 security hook `selinux_set_mnt_opts` will call `security_fs_use`
diff --git a/src/conditional_statements.md b/src/conditional_statements.md
index 00159b6..218e1fc 100644
--- a/src/conditional_statements.md
+++ b/src/conditional_statements.md
@@ -66,7 +66,9 @@ initial state (`true` or `false`) that can then be used with the
 
 **The statement definition is:**
 
-`bool bool_id default_value;`
+```
+bool bool_id default_value;
+```
 
 **Where:**
 
@@ -148,7 +150,9 @@ are:
 
 **The statement definition is:**
 
-`if (conditional_expression) { true_list } [ else { false_list } ]`
+```
+if (conditional_expression) { true_list } [ else { false_list } ]
+```
 
 **Where:**
 
diff --git a/src/configuration_files.md b/src/configuration_files.md
index 10092c6..9cb97cd 100644
--- a/src/configuration_files.md
+++ b/src/configuration_files.md
@@ -157,7 +157,9 @@ format. This is achieved via a *pp* to CIL high level language
 conversion utility located at */usr/libexec/selinux/hll/pp*. This
 utility can be used manually as follows:
 
-	`cat module_name.pp | /usr/libexec/selinux/hll/pp > module_name.cil`
+```
+cat module_name.pp | /usr/libexec/selinux/hll/pp > module_name.cil
+```
 
 There is no man page for '*pp*', however the help text is as follows:
 
diff --git a/src/constraint_statements.md b/src/constraint_statements.md
index 9708306..e2c088f 100644
--- a/src/constraint_statements.md
+++ b/src/constraint_statements.md
@@ -8,7 +8,9 @@ source and target types, roles and users as described in the examples.
 
 **The statement definition is:**
 
-`constrain class perm_set expression;`
+```
+constrain class perm_set expression;
+```
 
 **Where:**
 
@@ -185,7 +187,9 @@ Note there are no `validatetrans` statements specified within the
 
 **The statement definition is:**
 
-`validatetrans class expression;`
+```
+validatetrans class expression;
+```
 
 **Where:**
 
@@ -266,7 +270,9 @@ Note there are no `validatetrans` statements specified within the
 
 **Example:**
 
-`validatetrans { file } { t1 == unconfined_t );`
+```
+validatetrans { file } { t1 == unconfined_t );
+```
 
 
 ## `mlsconstrain`
@@ -278,7 +284,9 @@ in the examples.
 
 **The statement definition is:**
 
-`mlsconstrain class perm_set expression;`
+```
+mlsconstrain class perm_set expression;
+```
 
 **Where:**
 
@@ -405,7 +413,9 @@ third `u3.r3.t3` is the context of the process performing the transition.
 
 **The statement definition is:**
 
-`mlsvalidatetrans class expression;`
+```
+mlsvalidatetrans class expression;
+```
 
 **Where:**
 
diff --git a/src/default_rules.md b/src/default_rules.md
index e759a84..336d161 100644
--- a/src/default_rules.md
+++ b/src/default_rules.md
@@ -12,7 +12,9 @@ Requires policy version 27.
 
 **The statement definition is:**
 
-`default_user class default;`
+```
+default_user class default;
+```
 
 **Where:**
 
@@ -86,7 +88,9 @@ Requires policy version 27.
 
 **The statement definition is:**
 
-`default_role class default;`
+```
+default_role class default;
+```
 
 **Where:**
 
@@ -160,7 +164,9 @@ Requires policy version 28.
 
 **The statement definition is:**
 
-`default_type class default;`
+```
+default_type class default;
+```
 
 **Where:**
 
@@ -240,7 +246,9 @@ greater of the low sensitivities and the lower of the high sensitivities.
 
 **The statement definition is:**
 
-`default_range class [default range] | [glblub];`
+```
+default_range class [default range] | [glblub];
+```
 
 **Where:**
 
diff --git a/src/domain_object_transitions.md b/src/domain_object_transitions.md
index 2c5e45a..8882da9 100644
--- a/src/domain_object_transitions.md
+++ b/src/domain_object_transitions.md
@@ -20,14 +20,18 @@ two ways a process can define a domain transition:
     themselves SELinux-aware. This is the most common method and would
     be in the form of the following statement:
 
-`type_transition unconfined_t secure_services_exec_t : process ext_gateway_t;`
+```
+type_transition unconfined_t secure_services_exec_t : process ext_gateway_t;
+```
 
 1.  SELinux-aware applications can specify the domain of the new process
     using the **libselinux** API call ***setexeccon**(3)*. To achieve
     this the SELinux-aware application must also have the setexec
     permission, for example:
 
-`allow crond_t self:process setexec;`
+```
+allow crond_t self:process setexec;
+```
 
 However, before any domain transition can take place the policy must
 specify that:
@@ -63,18 +67,24 @@ bullet numbers correspond to the numbers shown in **Figure 7: Domain Transition*
 1.  The *domain* needs permission to *transition* into the
     `ext_gateway_t` (target) domain:
 
-`allow unconfined_t ext_gateway_t : process transition;`
+```
+allow unconfined_t ext_gateway_t : process transition;
+```
 
 2.  The executable file needs to be *executable* in the `unconfined_t`
     (source) domain, and therefore also requires that the file is
     readable:
 
-`allow unconfined_t secure_services_exec_t : file { execute read getattr };`
+```
+allow unconfined_t secure_services_exec_t : file { execute read getattr };
+```
 
 3.  The executable file needs an *entry point* into the
     `ext_gateway_t` (target) domain:
 
-`allow ext_gateway_t secure_services_exec_t : file entrypoint;`
+```
+allow ext_gateway_t secure_services_exec_t : file entrypoint;
+```
 
 These are shown in **Figure 7: Domain Transition** where `unconfined_t` forks
 a child process, that then exec's the new program into a new domain
@@ -96,11 +106,15 @@ intention was to have both of these transition to their respective
 domains via `type_transition` statements. The `ext_gateway_t` statement
 would be:
 
-`type_transition unconfined_t secure_services_exec_t : process ext_gateway_t;`
+```
+type_transition unconfined_t secure_services_exec_t : process ext_gateway_t;
+```
 
 and the `int_gateway_t` statement would be:
 
-`type_transition unconfined_t secure_services_exec_t : process int_gateway_t;`
+```
+type_transition unconfined_t secure_services_exec_t : process int_gateway_t;
+```
 
 However, when linking these two loadable modules into the policy, the
 following error was given:
@@ -215,7 +229,9 @@ that of its parent. For example a file is being created that requires a
 different label to that of its parent directory. This can be achieved
 automatically using a `type_transition` statement as follows:
 
-`type_transition ext_gateway_t in_queue_t:file in_file_t;`
+```
+type_transition ext_gateway_t in_queue_t:file in_file_t;
+```
 
 The following details an object transition used in n example
 *ext_gateway.conf* loadable module where by default, files would be labeled
@@ -251,16 +267,22 @@ rules, where:
 1.  The source domain needs permission to *add file entries into the
     directory*:
 
-`allow ext_gateway_t in_queue_t : dir { write search add_name };`
+```
+allow ext_gateway_t in_queue_t : dir { write search add_name };
+```
 
 2.  The source domain needs permission to *create file entries*:
 
-`allow ext_gateway_t in_file_t : file { write create getattr };`
+```
+allow ext_gateway_t in_file_t : file { write create getattr };
+```
 
 3.  The policy can then ensure (via the SELinux kernel services) that
     files created in the `in_queue` are relabeled:
 
-`type_transition ext_gateway_t in_queue_t : file in_file_t;`
+```
+type_transition ext_gateway_t in_queue_t : file in_file_t;
+```
 
 An example output from a directory listing shows the resulting file
 labels:
diff --git a/src/file_labeling_statements.md b/src/file_labeling_statements.md
index dad3361..cd6bd55 100644
--- a/src/file_labeling_statements.md
+++ b/src/file_labeling_statements.md
@@ -25,7 +25,9 @@ section.
 
 **The statement definition is:**
 
-`fs_use_xattr fs_name fs_context;`
+```
+fs_use_xattr fs_name fs_context;
+```
 
 **Where:**
 
@@ -93,7 +95,9 @@ sockets.
 
 **The statement definition is:**
 
-`fs_use_task fs_name fs_context;`
+```
+fs_use_task fs_name fs_context;
+```
 
 **Where:**
 
@@ -164,7 +168,9 @@ filesystem type based on transition rules.
 
 **The statement definition is:**
 
-`fs_use_trans fs_name fs_context;`
+```
+fs_use_trans fs_name fs_context;
+```
 
 **Where:**
 
@@ -239,7 +245,9 @@ semi-colon on this statement.
 
 **The statement definition is:**
 
-`genfscon fs_name partial_path fs_context`
+```
+genfscon fs_name partial_path fs_context
+```
 
 **Where:**
 
diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index 244d3ac..d2cd9c4 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -224,7 +224,9 @@ The class configuration file is at:
 and each entry must be added to the end of the file in the following
 format:
 
-`class object_name   # userspace`
+```
+class object_name   # userspace
+```
 
 Where ***class*** is the class keyword and *object_name* is the name of
 the object. The `# userspace` is used by build scripts to detect userspace
diff --git a/src/infiniband_statements.md b/src/infiniband_statements.md
index 79c29da..6d46d37 100644
--- a/src/infiniband_statements.md
+++ b/src/infiniband_statements.md
@@ -19,7 +19,9 @@ the policy using the ***semanage ibpkey*** command that will associate the
 
 **The statement definition is:**
 
-`ibpkeycon subnet pkey pkey_context`
+```
+ibpkeycon subnet pkey pkey_context
+```
 
 **Where:**
 
@@ -80,7 +82,9 @@ ibpkeycon fe80:: 0-0x10 system_u:object_r:public_ibpkey_t:s0
 
 ***semanage**(8)* **Command example:**
 
-`semanage ibpkey -a -t default_ibpkey_t -x fe80:: 0xFFFF`
+```
+semanage ibpkey -a -t default_ibpkey_t -x fe80:: 0xFFFF
+```
 
 The above command will produce the following file:
 */var/lib/selinux/&lt;SELINUXTYPE&gt;/active/ibpkeys.local*
@@ -104,7 +108,9 @@ end port to a security context.
 
 **The statement definition is:**
 
-`ibendportcon device_id port_number port_context`
+```
+ibendportcon device_id port_number port_context
+```
 
 **Where:**
 
@@ -165,7 +171,9 @@ ibendportcon mlx5_0 1 system_u:object_r:opensm_ibendport_t:s0
 
 ***semanage**(8)* **Command example:**
 
-`semanage ibendport -a -t opensm_ibendport_t -z mlx4_0 2`
+```
+semanage ibendport -a -t opensm_ibendport_t -z mlx4_0 2
+```
 
 This command will produce the following file
 */var/lib/selinux/&lt;SELINUXTYPE&gt;/active/ibendports.local* in the default
diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index d4be834..ffb4214 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -53,9 +53,13 @@ The basic idea behind LSM is to:
     services by extending the */proc* filesystem with a security
     namespace as shown in . These are located at:
 
-	`/proc/<self|pid>/attr/<attr>`
+```
+/proc/<self|pid>/attr/<attr>
+```
 
-	`/proc/<self|pid>/task/<tid>/attr/<attr>`
+```
+/proc/<self|pid>/task/<tid>/attr/<attr>
+```
 
 Where `<pid>` is the process id, `<tid>` is the thread id, and `<attr>` is the
 entry described in **Table 2: /proc Filesystem attribute files**.
@@ -67,7 +71,9 @@ entry described in **Table 2: /proc Filesystem attribute files**.
 -   Later kernels (ver ?) allow 'module stacking' where the LSM modules
     can be called in a predifined order, for example:
 
-	`lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf`
+```
+lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
+```
 
 It should be noted that the LSM does not provide any security services
 itself, only the hooks and structures for supporting 3<sup>rd</sup>
diff --git a/src/mls_statements.md b/src/mls_statements.md
index d4a0c7f..1cc5733 100644
--- a/src/mls_statements.md
+++ b/src/mls_statements.md
@@ -3,7 +3,9 @@
 The optional MLS policy extension adds an additional security context
 component that consists of the following highlighted entries:
 
-`user:role:type:sensitivity[:category,...]- sensitivity [:category,...]`
+```
+user:role:type:sensitivity[:category,...]- sensitivity [:category,...]
+```
 
 These consist of a mandatory hierarchical
 [**sensitivity**](#sensitivity) and optional
@@ -76,7 +78,9 @@ discussed at the start of the [**MLS section**](#mls-statements).
 
 **The definition is:**
 
-`low_level [ - high_level ]`
+```
+low_level [ - high_level ]
+```
 
 **Where:**
 
@@ -106,7 +110,9 @@ and optional alias identifiers.
 
 **The statement definition is:**
 
-`sensitivity sens_id [alias sensitivityalias_id ...];`
+```
+sensitivity sens_id [alias sensitivityalias_id ...];
+```
 
 **Where:**
 
@@ -185,7 +191,9 @@ required to define the actual hierarchy between all sensitivities.
 
 **The statement definition is:**
 
-`dominance { sensitivity_id ... }`
+```
+dominance { sensitivity_id ... }
+```
 
 **Where:**
 
@@ -246,7 +254,9 @@ identifiers and optional alias identifiers.
 
 **The statement definition is:**
 
-`category category_id [alias categoryalias_id ...];`
+```
+category category_id [alias categoryalias_id ...];
+```
 
 **Where:**
 
@@ -327,7 +337,9 @@ Note there must only be one `level` statement for each
 
 **The statement definition is:**
 
-`level sensitivity_id [ :category_id ];`
+```
+level sensitivity_id [ :category_id ];
+```
 
 **Where:**
 
@@ -400,11 +412,15 @@ enhanced in Policy version 21 to accept other object classes.
 
 **The statement definition is (for pre-policy version 21):**
 
-`range_transition source_type target_type new_range;`
+```
+range_transition source_type target_type new_range;
+```
 
 **or (for policy version 21 and greater):**
 
-`range_transition source_type target_type : class new_range;`
+```
+range_transition source_type target_type : class new_range;
+```
 
 **Where:**
 
diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index 2918010..564c2be 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -15,7 +15,9 @@ modules within the policy.
 
 **The statement definition is:**
 
-`module module_name version_number;`
+```
+module module_name version_number;
+```
 
 **Where:**
 
@@ -88,7 +90,9 @@ The require statement is used for two reasons:
 
 **The statement definition is:**
 
-`require { rule_list }`
+```
+require { rule_list }
+```
 
 **Where:**
 
@@ -174,7 +178,9 @@ a [**`require`**](#require) statement at the start of the list.
 
 **The statement definition is:**
 
-`optional { rule_list } [ else { rule_list } ]`
+```
+optional { rule_list } [ else { rule_list } ]
+```
 
 **Where:**
 
diff --git a/src/network_statements.md b/src/network_statements.md
index da66612..8049aa7 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -33,14 +33,18 @@ sid port system_u:object_r:port_t:s0
 IPv4 addresses are represented in dotted-decimal notation (four
 numbers, each ranging from 0 to 255, separated by dots as shown:
 
-`192.77.188.166`
+```
+192.77.188.166
+```
 
 ### IPv6 Address Formats
 
 IPv6 addresses are written as eight groups of four hexadecimal digits,
 where each group is separated by a colon ':' as follows:
 
-`2001:0db8:85a3:0000:0000:8a2e:0370:7334`
+```
+2001:0db8:85a3:0000:0000:8a2e:0370:7334
+```
 
 To shorten the writing and presentation of addresses, the following
 rules apply:
@@ -48,25 +52,35 @@ rules apply:
 1.  Any leading zeros in a group may be replaced with a single '0' as
     shown:
 
-`2001:db8:85a3:0:0:8a2e:370:7334`
+```
+2001:db8:85a3:0:0:8a2e:370:7334
+```
 
 2.  Any leading zeros in a group may be omitted and be replaced with two
     colons '::', however this is only allowed once in an address as
     follows:
 
-`2001:db8:85a3::8a2e:370:7334`
+```
+2001:db8:85a3::8a2e:370:7334
+```
 
 3.  The *localhost* (loopback) address can be written as:
 
-`0000:0000:0000:0000:0000:0000:0000:0001`
+```
+0000:0000:0000:0000:0000:0000:0000:0001
+```
 
 Or
 
-`::1`
+```
+::1
+```
 
 4.  An undetermined IPv6 address i.e. all bits are zero is written as:
 
-`::`
+```
+::
+```
 
 
 ## `netifcon`
@@ -80,7 +94,9 @@ the interface to a security context.
 
 **The statement definition is:**
 
-`netifcon netif_id netif_context packet_context`
+```
+netifcon netif_id netif_context packet_context
+```
 
 **Where:**
 
@@ -145,7 +161,9 @@ netifcon lo system_u:object_r:lo_netif_t:s0 - s15:c0.c255 system_u:object_r:unla
 
 ***semanage**(8)* **Command example:**
 
-`semanage interface -a -t netif_t eth2`
+```
+semanage interface -a -t netif_t eth2
+```
 
 This command will produce the following file in the default
 &lt;SELINUXTYPE&gt; policy store and then activate the policy:
@@ -174,7 +192,9 @@ context.
 
 **The statement definition is:**
 
-`nodecon subnet netmask node_context`
+```
+nodecon subnet netmask node_context
+```
 
 **Where:**
 
@@ -244,7 +264,9 @@ nodecon ff00:: ff00:: system_u:object_r:multicast_node_t:s0 - s15:c0.c255
 
 ***semanage**(8)* **Command example:**
 
-`semanage node -a -t node_t -p ipv4 -M 255.255.255.255 127.0.0.2`
+```
+semanage node -a -t node_t -p ipv4 -M 255.255.255.255 127.0.0.2
+```
 
 This command will produce the following file in the default
 &lt;SELINUXTYPE&gt; policy store and then activate the policy:
@@ -269,7 +291,9 @@ policy using the ***semanage**(8)* 'port' command that will associate the port
 
 **The statement definition is:**
 
-`portcon protocol port_number port_context`
+```
+portcon protocol port_number port_context
+```
 
 **Where:**
 
@@ -335,7 +359,9 @@ portcon udp 1-599 system_u:object_r:reserved_port_t:s0
 
 ***semanage**(8)* **Command example:**
 
-`semanage port -a -t reserved_port_t -p udp 1234`
+```
+semanage port -a -t reserved_port_t -p udp 1234
+```
 
 This command will produce the following file in the default
 &lt;SELINUXTYPE&gt; policy store and then activate the policy:
diff --git a/src/network_support.md b/src/network_support.md
index b207247..63df855 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -40,16 +40,22 @@ SELinux filesystem as shown in the
 To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
 be installed:
 
-`dnf install netlabel_tools`
+```
+dnf install netlabel_tools
+```
 
 To support Labeled IPSec the IPSec tools need to be installed:
 
-`dnf install ipsec-tools`
+```
+dnf install ipsec-tools
+```
 
 It is also possible to use an alternative Labeled IPSec service that was
 OpenSwan but is now distributed as LibreSwan:
 
-`dnf install libreswan`
+```
+dnf install libreswan
+```
 
 It is important to note that the kernel must be configured to support
 these services. The Fedora kernels are configured to handle all the above
@@ -246,7 +252,9 @@ the LSM infrastructure. The implementation supports:
     show in **Figure 15**).
 -   Note that CALIPSO only supports this option, and an example
     ***netlabelctl**(8)* command setting a DOI of 16 is:
-    `netlabelctl calipso add pass doi:16`
+```
+netlabelctl calipso add pass doi:16
+```
 
 ![](./images/15-mls1.png)
 
@@ -395,7 +403,9 @@ echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
 By default Fedora does not enable IPSEC via its default firewall configuration,
 therefore the server side requires the following command:
 
-`firewall-cmd --add-service ipsec`
+```
+firewall-cmd --add-service ipsec
+```
 
 There are two simple examples in the
 [***notebook-examples/network/ipsec***](notebook-examples/network/README.md)
@@ -434,11 +444,15 @@ Version 4.2 of NFS supports labeling between client/server and requires
 the ***exports**(5)* / ***exportfs**(8)* '*security_label*' option to
 be set:
 
-`exportfs -o rw,no_root_squash,security_label localhost:$MOUNT`
+```
+exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
+```
 
 Labeled NFS requires kernel 3.14 and the following package installed:
 
-`dnf install nfs-utils`
+```
+dnf install nfs-utils
+```
 
 Labeled NFS clients must use a consistent security policy.
 
diff --git a/src/pam_login.md b/src/pam_login.md
index 8d3a831..02878ab 100644
--- a/src/pam_login.md
+++ b/src/pam_login.md
@@ -37,7 +37,9 @@ section and also the ***sepermit.conf**(5)*.
 The main login service related PAM configuration files (e.g. *gdm*)
 consist of multiple lines of information that are formatted as follows:
 
-`service type control module-path arguments`
+```
+service type control module-path arguments
+```
 
 **Where:**
 
diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 6ce2020..aa4f1d1 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -3,7 +3,9 @@
 Each file discussed in this section is relative to the policy name as
 follows:
 
-`/etc/selinux/<SELINUXTYPE>`
+```
+/etc/selinux/<SELINUXTYPE>
+```
 
 All files under this area form the 'running policy' once the
 [*/etc/selinux/config*](global_config_files.md#etcselinuxconfig) files
@@ -97,7 +99,9 @@ Both files have the same format and contain one or more boolean names.
 
 **The format is:**
 
-`boolean_name value`
+```
+boolean_name value
+```
 
 **Where:**
 
@@ -136,7 +140,9 @@ the translated name.
 
 Each line within the substitution file *booleans.subs_dist* is:
 
-`policy_bool_name new_name`
+```
+policy_bool_name new_name
+```
 
 **Where:**
 
@@ -181,7 +187,9 @@ The daemon will not load unless a valid MCS or MLS policy is active.
 
 The translations can be disabled by adding the following line to the file:
 
-`disable = 1`
+```
+disable = 1
+```
 
 This file will also support the display of information in colour. The
 configuration file that controls this is called *secolor.conf* and is
@@ -340,7 +348,9 @@ list unless the -F flag is used (see the man pages).
 
 **The file format is as follows:**
 
-`type`
+```
+type
+```
 
 **Where:**
 
@@ -388,7 +398,9 @@ login applications) where:
 
 **The file format is as follows:**
 
-`role:type[:range] role:type[:range] ...`
+```
+role:type[:range] role:type[:range] ...
+```
 
 **Where:**
 
@@ -449,7 +461,9 @@ The end result was that as soon as enforcing mode was set, the system
 got bitter and twisted. To resolve this the *default_contexts* file
 entries were set to:
 
-`unconfined_r:unconfined_t unconfined_r:unconfined_t`
+```
+unconfined_r:unconfined_t unconfined_r:unconfined_t
+```
 
 The login process could now set the context correctly to
 `unconfined_r:unconfined_t`. Note that adding the same entry to the
@@ -491,7 +505,9 @@ The **default_type**(5) file allows SELinux-aware applications such as
 
 **The file format is as follows:**
 
-`role:type`
+```
+role:type
+```
 
 **Where:**
 
@@ -529,7 +545,9 @@ to allow an administrator access to the system.
 
 **The file format is as follows:**
 
-`role:type[:range]`
+```
+role:type[:range]
+```
 
 **Where:**
 
@@ -570,7 +588,9 @@ used by other SELinux-aware applications for the same purpose.
 
 **The file format is as follows:**
 
-`user:role:type[:range]`
+```
+user:role:type[:range]
+```
 
 **Where:**
 
@@ -689,7 +709,9 @@ matching of network packets - Never been used.
 
 **Example file contents:**
 
-`privsep_preauth=sshd_net_t`
+```
+privsep_preauth=sshd_net_t
+```
 
 **Supporting libselinux API functions are:**
 
@@ -705,7 +727,9 @@ should be used for removable devices that are not defined in the
 
 **The file format is as follows:**
 
-`user:role:type[:range]`
+```
+user:role:type[:range]
+```
 
 **Where:**
 
@@ -736,7 +760,9 @@ database objects and is descibed in ***selabel_db**(5)*.
 
 **The file format is as follows:**
 
-`object_type object_name context`
+```
+object_type object_name context
+```
 
 **Where:**
 
@@ -778,7 +804,9 @@ db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 
 **Example file contents:**
 
-`snapperd_data = system_u:object_r:snapperd_data_t:s0`
+```
+snapperd_data = system_u:object_r:snapperd_data_t:s0
+```
 
 **Supporting libselinux API functions are:**
 
@@ -793,7 +821,9 @@ to find the type to use with tty devices when changing roles or levels.
 
 **The file format is as follows:**
 
-`type`
+```
+type
+```
 
 **Where:**
 
@@ -825,7 +855,9 @@ This file contains security contexts to be used by tasks run via ***systemd**(8)
 
 **The file format is as follows:**
 
-`service_class = security_context`
+```
+service_class = security_context
+```
 
 **Where:**
 
@@ -861,7 +893,9 @@ system-config-* applications when running from root.
 
 **The file format is as follows:**
 
-`security_context`
+```
+security_context
+```
 
 **Where:**
 
@@ -1058,7 +1092,9 @@ Then (for example), when ***selabel_lookup**(3)* is passed a path
 */myweb/index.html* the functions will substitute the */myweb* component
 with */var/www*, with the final result being:
 
-`/var/www/index.html`
+```
+/var/www/index.html
+```
 
 **Supporting libselinux API functions are:**
 
@@ -1078,7 +1114,9 @@ is used instead.
 
 **The file format is as follows:**
 
-`media_id file_context`
+```
+media_id file_context
+```
 
 **Where:**
 
@@ -1165,7 +1203,9 @@ used to retrieve default information.
 
 **The file format is as follows:**
 
-`service_name:seuser_id:level`
+```
+service_name:seuser_id:level
+```
 
 **Where:**
 
diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index 4289136..351513c 100644
--- a/src/policy_config_statements.md
+++ b/src/policy_config_statements.md
@@ -10,7 +10,9 @@ continue to use the original functionality.
 
 **The statement definition is:**
 
-`policycap capability;`
+```
+policycap capability;
+```
 
 **Where:**
 
diff --git a/src/policy_store_config_files.md b/src/policy_store_config_files.md
index 45ff3fa..de7e9dc 100644
--- a/src/policy_store_config_files.md
+++ b/src/policy_store_config_files.md
@@ -91,7 +91,9 @@ the *tmp* directory (*/var/lib/selinux&lt;SELINUXTYPE&gt;/tmp*) will contain
 a copy of the failed policy for inspection. An example ***semodule*** failure
 message indicating the failing line number is:
 
-`Failed to resolve mlsconstrain statement at /var/lib/selinux/targeted/tmp/modules/400/test_mlsconstrain/cil:1`
+```
+Failed to resolve mlsconstrain statement at /var/lib/selinux/targeted/tmp/modules/400/test_mlsconstrain/cil:1
+```
 
 
 ## *active/commit_num*
@@ -126,7 +128,9 @@ the new value) if requested.
 
 **Example** ***semanage boolean*** **command to modify a boolean value:**
 
-`semanage boolean -m --on daemons_enable_cluster_mode`
+```
+semanage boolean -m --on daemons_enable_cluster_mode
+```
 
 **The resulting** *booleans.local* **file will be:**
 
@@ -235,7 +239,9 @@ files.*
 
 **The format of these files is:**
 
-`pathname_regexp [file_type] security_context | <<none>>`
+```
+pathname_regexp [file_type] security_context | <<none>>
+```
 
 **Where:**
 
@@ -352,7 +358,9 @@ The format of the *file_contexts.local* file is the same as the
 
 Example ***semanage fcontext*** command to add a new entry:
 
-`semanage fcontext -a -t unlabeled_t /usr/move_file`
+```
+semanage fcontext -a -t unlabeled_t /usr/move_file
+```
 
 The resulting *file_contexts.local* file will be:
 
@@ -452,7 +460,9 @@ The *seusers* file is built or modified when:
 
 **The format of the** *seusers* & *seusers.local* **files are as follows:**
 
-`[%]user_id:seuser_id[:range]`
+```
+[%]user_id:seuser_id[:range]
+```
 
 **Where:**
 
@@ -483,7 +493,9 @@ __default__:unconfined_u:s0-s0:c0.c1023
 
 now use ***semanage login*** command to add a Linux user:
 
-`semanage login -a -s user_u rch`
+```
+semanage login -a -s user_u rch
+```
 
 the resulting *seusers.local* file will be:
 
@@ -540,7 +552,9 @@ follows:
 
 **The format of the** *users_extra* & *users_extra.local* **files are:**
 
-`user seuser_id prefix prefix_id;`
+```
+user seuser_id prefix prefix_id;
+```
 
 **Where:**
 
@@ -577,7 +591,9 @@ user root prefix user;
 
 **Example** ***semanage user*** **command to add a new SELinux user:**
 
-`semanage user -a -R staff_r -P staff test_u`
+```
+semanage user -a -R staff_r -P staff test_u
+```
 
 the resulting *users_extra.local* file is as follows:
 
@@ -622,7 +638,9 @@ in the [**`netifcon`**](network_statements.md#netifcon) section.
 
 **Example** ***semanage interface*** **command:**
 
-`semanage interface -a -t netif_t -r s0:c20.c250 enp7s0`
+```
+semanage interface -a -t netif_t -r s0:c20.c250 enp7s0
+```
 
 **The resulting** *interfaces.local* **file will be:**
 
@@ -646,7 +664,9 @@ with examples in the policy language
 
 **Example** ***semanage node*** **command:**
 
-`semanage node -a -M 255.255.255.255 -t node_t -r s0:c20.c250 -p ipv4 127.0.0.2`
+```
+semanage node -a -M 255.255.255.255 -t node_t -r s0:c20.c250 -p ipv4 127.0.0.2
+```
 
 **The resulting** *nodes.local* **file will be:**
 
@@ -671,7 +691,9 @@ with examples in the policy language
 
 **Example** ***semanage port*** **command:**
 
-`semanage port -a -t port_t -p tcp -r s0:c20.c350 8888`
+```
+semanage port -a -t port_t -p tcp -r s0:c20.c350 8888
+```
 
 **The resulting** *ports.local* **file will be:**
 
@@ -690,12 +712,16 @@ module that sets the requested domain in permissive mode.
 
 **Example** ***semanage permissive*** **command to set permissive mode:**
 
-`semanage permissive -a tabrmd_t`
+```
+semanage permissive -a tabrmd_t
+```
 
 This will by default add a CIL policy module to
 *active/modules/400/permissive_tabrmd_t*, that if expanded will contain:
 
-`(typepermissive tabrmd_t)`
+```
+(typepermissive tabrmd_t)
+```
 
 Note that the CIL `typepermissive` statement is used, the equivalent kernel
 policy statement would be [**`permissive`**](type_statements.md#permissive).
diff --git a/src/policy_validation_example.md b/src/policy_validation_example.md
index 19a380d..857a2a5 100644
--- a/src/policy_validation_example.md
+++ b/src/policy_validation_example.md
@@ -50,7 +50,9 @@ args = $@
 
 Next try rebuilding the policy with no changes:
 
-`semodule -B`
+```
+semodule -B
+```
 
 It should succeed, therefore build a module that would violate this rule:
 
@@ -86,7 +88,9 @@ semodule: Failed!
 
 Now run ***sesearch*** to ensure that there is no matching rule:
 
-`sesearch --allow -s user_t -t shadow_t -c file`
+```
+sesearch --allow -s user_t -t shadow_t -c file
+```
 
 Note that there are also a **\[verify module\]** and **\[verify linked\]**
 options as described in the
diff --git a/src/polyinstantiation.md b/src/polyinstantiation.md
index cf2b889..bd3579c 100644
--- a/src/polyinstantiation.md
+++ b/src/polyinstantiation.md
@@ -107,7 +107,9 @@ to set the correct file contexts.
 
 Each line in the namespace.conf file is formatted as follows:
 
-`polydir instance_prefix method list_of_uids`
+```
+polydir instance_prefix method list_of_uids
+```
 
 Where:
 
diff --git a/src/postgresql.md b/src/postgresql.md
index f7ab1e6..8e69f3f 100644
--- a/src/postgresql.md
+++ b/src/postgresql.md
@@ -147,7 +147,9 @@ enable and manage SE-PostgreSQL:
 1.  This entry is mandatory to enable the *sepgsql* extension to be
     loaded:
 
-`shared_preload_libraries = 'sepgsql'`
+```
+shared_preload_libraries = 'sepgsql'
+```
 
 2.  These entries are optional and default to '*off*'.
 
diff --git a/src/reference_policy.md b/src/reference_policy.md
index 4d4fd5d..73e2990 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -56,7 +56,9 @@ can be found at: <https://github.com/fedora-selinux/selinux-policy>
 
 **Figure 26: The Reference Policy Source Tree** shows the layout of the
 reference policy source tree, that once installed would be located at
-`/etc/selinux/<SELINUXTYPE>/src/policy`
+```
+/etc/selinux/<SELINUXTYPE>/src/policy
+```
 
 Where the **&lt;SELINUXTYPE&gt;** entry is taken from the *build.conf* file
 as discussed in the
@@ -740,7 +742,9 @@ ddcprobe = off
 
 The only active lines (those without comments) contain:
 
-`<module_name> = base | module | off`
+```
+<module_name> = base | module | off
+```
 
 However note that the comments are important as they form part of the
 documentation when it is generated by the *make html* target.
@@ -1263,7 +1267,9 @@ completed:
     will be used as a part of the documentation. An example is as
     follows:
 
-`<summary>ABC modules for the XYZ components.</summary>`
+```
+<summary>ABC modules for the XYZ components.</summary>
+```
 
 
 ## Installing and Building the Reference Policy Source
@@ -1432,7 +1438,9 @@ Note: The following steps were tested on Fedora 31 with no problems.
 
 Install the source as follows:
 
-`rpm -Uvh selinux-policy-<version>.src.rpm`
+```
+rpm -Uvh selinux-policy-<version>.src.rpm
+```
 
 The *rpmbuild/SOURCES* directory contents that will be used to build a copy
 of the **targeted** policy are as follows (there are other files, however
@@ -1637,7 +1645,9 @@ directory. This *Makefile* can be used to build the example modules by
 using makes *-f* option as follows (assuming that the example module
 files are in the local directory):
 
-`make -f /usr/share/selinux/<NAME>/include/Makefile`
+```
+make -f /usr/share/selinux/<NAME>/include/Makefile
+```
 
 However there is another *Makefile* (*./policy/doc Makefile.example*)that can
 be installed in the users home directory (*$HOME*) that will call the master
@@ -1844,11 +1854,15 @@ with examples shown in the [*ifdef*](#ifdef-ifndef-parameters) section.
 
 Correct:
 
-`policy_module(ftp, 1.7.0)`
+```
+policy_module(ftp, 1.7.0)
+```
 
 Incorrect:
 
-`policy_module (ftp, 1.7.0)`
+```
+policy_module (ftp, 1.7.0)
+```
 
 
 ### Loadable Policy Macros
@@ -1867,7 +1881,9 @@ classes and permissions, and optionally MCS / MLS information
 
 ****The macro definition is:****
 
-`policy_module(module_name,version)`
+```
+policy_module(module_name,version)
+```
 
 **Where:**
 
@@ -2181,7 +2197,9 @@ used to describe the function and are extracted for the
 
 **The macro definition is:**
 
-`gen_tunable(boolean_name,boolean_value)`
+```
+gen_tunable(boolean_name,boolean_value)
+```
 
 **Where:**
 
@@ -2604,7 +2622,9 @@ where it is used to set the files security context.
 
 **The macro definition is:**
 
-`gen_context(context[,mls | mcs])`
+```
+gen_context(context[,mls | mcs])
+```
 
 **Where:**
 
@@ -2669,7 +2689,9 @@ configuration file if it exists.
 
 **The macro definition is:**
 
-`gen_user(username, prefix, role_set, mls_defaultlevel, mls_range, [mcs_categories])`
+```
+gen_user(username, prefix, role_set, mls_defaultlevel, mls_range, [mcs_categories])
+```
 
 **Where:**
 
@@ -2772,7 +2794,9 @@ used to describe the function and are extracted for the
 
 **The macro definition is:**
 
-`gen_bool(name,default_value)`
+```
+gen_bool(name,default_value)
+```
 
 **Where:**
 
@@ -2905,7 +2929,9 @@ in the current reference policy.
 
 **The macro definition is:**
 
-`gen_cats(mcs_num_cats | mls_num_cats)`
+```
+gen_cats(mcs_num_cats | mls_num_cats)
+```
 
 **Where:**
 
@@ -2974,7 +3000,9 @@ in the current reference policy (note that the *mcs* file has
 
 **The macro definition is:**
 
-`gen_sens(mls_num_sens)`
+```
+gen_sens(mls_num_sens)
+```
 
 **Where:**
 
@@ -3038,7 +3066,9 @@ that contain this macro in the current reference policy.
 
 **The macro definition is:**
 
-`gen_levels(mls_num_sens,mls_num_cats)`
+```
+gen_levels(mls_num_sens,mls_num_cats)
+```
 
 **Where:**
 
@@ -3103,7 +3133,9 @@ level s15:c0.c1023;
 
 These macros define system high etc. as shown.
 
-`mls_systemlow`
+```
+mls_systemlow
+```
 
 ```
 # gives:
@@ -3111,7 +3143,9 @@ These macros define system high etc. as shown.
 s0
 ```
 
-`mls_systemhigh`
+```
+mls_systemhigh
+```
 
 ```
 # gives:
@@ -3119,7 +3153,9 @@ s0
 s15:c0.c1023
 ```
 
-`mcs_systemlow`
+```
+mcs_systemlow
+```
 
 ```
 # gives:
@@ -3127,7 +3163,9 @@ s15:c0.c1023
 s0
 ```
 
-`mcs_systemhigh`
+```
+mcs_systemhigh
+```
 
 ```
 # gives:
@@ -3135,7 +3173,9 @@ s0
 s0:c0.c1023
 ```
 
-`mcs_allcats`
+```
+mcs_allcats
+```
 
 ```
 # gives:
diff --git a/src/role_statements.md b/src/role_statements.md
index 36fe4c3..c61d9d7 100644
--- a/src/role_statements.md
+++ b/src/role_statements.md
@@ -15,11 +15,15 @@ types with the role.
 
 **The statement definition to declare a role is:**
 
-`role role_id;`
+```
+role role_id;
+```
 
 **The statement definition to associate a role to one or more types is:**
 
-`role role_id types type_id;`
+```
+role role_id types type_id;
+```
 
 **Where:**
 
@@ -99,7 +103,9 @@ can then be used to refer to a group of roles.
 
 **The statement definition is:**
 
-`attribute_role attribute_id;`
+```
+attribute_role attribute_id;
+```
 
 **Where:**
 
@@ -162,7 +168,9 @@ declared roles to one or more previously declared <code>attribute_roles</code>.
 
 **The statement definition is:**
 
-`roleattribute role_id attribute_id;`
+```
+roleattribute role_id attribute_id;
+```
 
 **Where:**
 
@@ -235,7 +243,9 @@ Note that the role allow rule has the same keyword as the allow AV rule.
 
 **The statement definition is:**
 
-`allow from_role_id to_role_id;`
+```
+allow from_role_id to_role_id;
+```
 
 **Where:**
 
@@ -303,11 +313,15 @@ version 25, the `class` can now be defined.
 
 **The statement definition is:**
 
-`role_transition current_role_id type_id new_role_id;`
+```
+role_transition current_role_id type_id new_role_id;
+```
 
 Or from Policy version 25:
 
-`role_transition current_role_id type_id : class new_role_id;`
+```
+role_transition current_role_id type_id : class new_role_id;
+```
 
 **Where:**
 
@@ -365,7 +379,9 @@ Or from Policy version 25:
 
 **Example:**
 
-`role_transition system_r unconfined_exec_t:process unconfined_r;`
+```
+role_transition system_r unconfined_exec_t:process unconfined_r;
+```
 
 
 ## `dominance` - Deprecated
@@ -386,7 +402,9 @@ Notes:
 
 **The statement definition is:**
 
-`dominance { role dom_role_id { role role_id; } }`
+```
+dominance { role dom_role_id { role role_id; } }
+```
 
 Where:
 
diff --git a/src/seandroid.md b/src/seandroid.md
index d9a184c..db0de4f 100644
--- a/src/seandroid.md
+++ b/src/seandroid.md
@@ -471,7 +471,9 @@ and are listed in . Some are available as Toolbox or Toybox commands (see
 *system/core/shell_and_utilities/README.md*) and can be run via *adb shell*,
 for example:
 
-`adb shell pm list permissions -g`
+```
+adb shell pm list permissions -g
+```
 
 ### SELinux enabled commands
 
@@ -854,7 +856,9 @@ will help sort out ordering issues.
 Example *BoardConfig.mk* usage from the Tuna device
 *device/samsung/tuna/BoardConfig.mk*:
 
-`BOARD_VENDOR_SEPOLICY_DIRS += device/samsung/tuna/sepolicy`
+```
+BOARD_VENDOR_SEPOLICY_DIRS += device/samsung/tuna/sepolicy
+```
 
 Additionally, OEMs can specify BOARD_SEPOLICY_M4DEFS to pass arbitrary m4
 definitions during the build. A definition consists of a string in the form
@@ -977,7 +981,9 @@ and a version number to produced a combined "versioned" policy file.
 Android supports auditing of SELinux events via the AOSP logger
 service that can be viewed using *logcat*, for example:
 
-`adb logcat > logcat.log`
+```
+adb logcat > logcat.log
+```
 
 Example SELinux audit events (avc denials) are:
 
@@ -992,7 +998,9 @@ dmesg   : type=1400 audit(0.0:198): avc: denied { syslog_read } for scontext=u:r
 Note that before the auditing daemon is loaded, messages will be logged
 in the kernel buffers that can be read using ***dmesg**(1)*:
 
-`adb shell dmesg`
+```
+adb shell dmesg
+```
 
 
 ## Policy File Formats
@@ -1018,7 +1026,9 @@ devices to specify their entries as described in the
 
 Each line within the file consists of the following:
 
-`pathname_regexp [file_type] security_context`
+```
+pathname_regexp [file_type] security_context
+```
 
 Where:
 
@@ -1369,7 +1379,9 @@ allowing vendors to specify their entries.
 
 The file format is:
 
-`property_key security_context type value`
+```
+property_key security_context type value
+```
 
 type = prefix or exact
 value = int, double, bool or string
@@ -1413,7 +1425,9 @@ devices to specify their entries.
 
 The file format is:
 
-`service_key security_context`
+```
+service_key security_context
+```
 
 Example *service_contexts* Entries:
 
diff --git a/src/security_context.md b/src/security_context.md
index bb219cb..11d2387 100644
--- a/src/security_context.md
+++ b/src/security_context.md
@@ -14,7 +14,9 @@ Linux user id is mapped to the SELinux user id by configuration files),
 their role, a type identifier and an optional MCS / MLS security range or
 level as follows:
 
-`user:role:type[:range]`
+```
+user:role:type[:range]
+```
 
 **Where:**
 
diff --git a/src/sid_statement.md b/src/sid_statement.md
index cbb3ec9..132adb0 100644
--- a/src/sid_statement.md
+++ b/src/sid_statement.md
@@ -14,7 +14,9 @@ the start of a policy source file.
 
 **The statement definition is:**
 
-`sid sid_id`
+```
+sid sid_id
+```
 
 **Where:**
 
@@ -79,7 +81,9 @@ context to the SID.
 
 **The statement definition is:**
 
-`sid sid_id context`
+```
+sid sid_id context
+```
 
 **Where:**
 
diff --git a/src/type_enforcement.md b/src/type_enforcement.md
index 898dae7..02fb100 100644
--- a/src/type_enforcement.md
+++ b/src/type_enforcement.md
@@ -61,7 +61,9 @@ It is possible to add constraints on users, roles, types and MLS ranges,
 for example within a TE environment, the way that subjects are allowed
 to access an object is via a TE [**`allow`**](avc_rules.md#allow), for example:
 
-`allow unconfined_t ext_gateway_t : process transition;`
+```
+allow unconfined_t ext_gateway_t : process transition;
+```
 
 This states that a process running in the `unconfined_t` domain has
 permission to transition a process to the `ext_gateway_t` domain.
@@ -71,7 +73,9 @@ domain is the same as the role of the target domain. To achieve this a
 constraint can be imposed using a
 [**`constrain`**](constraint_statements.md#constrain) statement:
 
-`constrain process transition ( r1 == r2 );`
+```
+constrain process transition ( r1 == r2 );
+```
 
 This states that a process transition can only occur if the source role
 is the same as the target role, therefore a constraint is a condition
diff --git a/src/type_statements.md b/src/type_statements.md
index 76dedab..fb7ec83 100644
--- a/src/type_statements.md
+++ b/src/type_statements.md
@@ -21,7 +21,9 @@ component of the [**Security Context**](security_context.md#security-context).
 
 **The statement definition is:**
 
-`type type_id [alias alias_id] [, attribute_id];`
+```
+type type_id [alias alias_id] [, attribute_id];
+```
 
 **Where:**
 
@@ -126,7 +128,9 @@ refer to a group of *type* identifiers.
 
 **The statement definition is:**
 
-`attribute attribute_id;`
+```
+attribute attribute_id;
+```
 
 **Where:**
 
@@ -171,7 +175,9 @@ declared types to one or more previously declared attributes.
 
 **The statement definition is:**
 
-`typeattribute type_id attribute_id;`
+```
+typeattribute type_id attribute_id;
+```
 
 **Where:**
 
@@ -243,7 +249,9 @@ The *typealias* statement allows the association of a previously declared
 
 **The statement definition is:**
 
-`typealias type_id alias alias_id;`
+```
+typealias type_id alias alias_id;
+```
 
 **Where:**
 
@@ -311,7 +319,9 @@ policy denial.
 
 **The statement definition is:**
 
-`permissive type_id;`
+```
+permissive type_id;
+```
 
 **Where:**
 
@@ -381,12 +391,16 @@ the transition.
 
 **The statement definitions are:**
 
-`type_transition source_type target_type : class default_type;`
+```
+type_transition source_type target_type : class default_type;
+```
 
 Policy versions 25 and above also support a 'name transition' rule
 however, this is only appropriate for the file classes:
 
-`type_transition source_type target_type : class default_type object_name;`
+```
+type_transition source_type target_type : class default_type object_name;
+```
 
 **Where:**
 
@@ -510,7 +524,9 @@ section for more details.
 
 **The statement definition is:**
 
-`type_change source_type target_type : class change_type;`
+```
+type_change source_type target_type : class change_type;
+```
 
 **Where:**
 
@@ -579,7 +595,9 @@ section for more details.
 
 **The statement definition is:**
 
-`member_type source_type target_type : class member_type;`
+```
+member_type source_type target_type : class member_type;
+```
 
 **Where:**
 
diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index dcbe573..01ff1d6 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -188,7 +188,9 @@ The boolean flag status is held in kernel and can be changed using the
 temporarily (i.e. only valid until a re-boot). The following example
 shows a persistent conditional policy change:
 
-`setsebool -P ext_gateway_audit false`
+```
+setsebool -P ext_gateway_audit false
+```
 
 The conditional policy language statements are the `bool` Statement
 that defines the boolean flag identifier and its initial status, and the
diff --git a/src/user_statements.md b/src/user_statements.md
index 46f2846..7a5ff8a 100644
--- a/src/user_statements.md
+++ b/src/user_statements.md
@@ -11,11 +11,15 @@ previously declared within the policy.
 
 **The statement definition is:**
 
-`user seuser_id roles role_id;`
+```
+user seuser_id roles role_id;
+```
 
 Or for MCS/MLS Policy:
 
-`user seuser_id roles role_id level mls_level range mls_range;`
+```
+user seuser_id roles role_id level mls_level range mls_range;
+```
 
 Where:
 
diff --git a/src/userspace_libraries.md b/src/userspace_libraries.md
index 6db6bb7..8939246 100644
--- a/src/userspace_libraries.md
+++ b/src/userspace_libraries.md
@@ -123,7 +123,9 @@ SELinux sub-system:
 
 There is a static version of the library that is not installed by default:
 
-`dnf install libselinux-static`
+```
+dnf install libselinux-static
+```
 
 ## libsepol Library
 
@@ -132,7 +134,9 @@ binary policy files.
 
 There is a static version of the library that is not installed by default:
 
-`dnf install libsepol-static`
+```
+dnf install libsepol-static
+```
 
 This is used by commands such as ***audit2allow**(8)* and ***checkpolicy**(8)*
 as they require access to functions that are not available in the dynamic
diff --git a/src/vm_support.md b/src/vm_support.md
index 09321ed..07ad32f 100644
--- a/src/vm_support.md
+++ b/src/vm_support.md
@@ -20,7 +20,9 @@ to configure VMs, then an overview of the Xen implementation follows.
 
 To ensure all dependencies are installed run:
 
-`dnf install libvirt qemu virt-manager`
+```
+dnf install libvirt qemu virt-manager
+```
 
 ## KVM / QEMU Support
 
@@ -205,7 +207,9 @@ To overcome this error, the following boolean needs to be enabled with
 ***setsebool**(8)* to allow access to shared memory (the *-P* option
 will set the boolean across reboots):
 
-`setsebool -P virt_use_execmem on`
+```
+setsebool -P virt_use_execmem on
+```
 
 Now that the image has been configured as shareable, the following
 initialisation process will take place:
@@ -274,7 +278,9 @@ enforcing mode (just so all errors are flagged during the build):
 1.  To set the required security context requires editing the
     *Static_VM1* configuration file using ***virsh**(1)* as follows:
 
-`virsh edit Static_VM1`
+```
+virsh edit Static_VM1
+```
 
 Then add the following at the end of the file:
 
diff --git a/src/x_windows.md b/src/x_windows.md
index 86f966e..898123c 100644
--- a/src/x_windows.md
+++ b/src/x_windows.md
@@ -121,7 +121,9 @@ following command will enable the boolean, however it will be necessary
 to reload X-Windows to initialise the extension (i.e. run the **init 3**
 and then **init 5** commands):
 
-`setsebool -P xserver_object_manager true`
+```
+setsebool -P xserver_object_manager true
+```
 
 If the boolean is set to *false*, the x-server log will indicate
 that "SELinux: Disabled by boolean". Important note - If the boolean is
diff --git a/src/xen_statements.md b/src/xen_statements.md
index 5688893..e2c4cc3 100644
--- a/src/xen_statements.md
+++ b/src/xen_statements.md
@@ -20,7 +20,9 @@ Label i/o memory. This may be a single memory location or a range.
 
 **The statement definition is:**
 
-`iomemcon addr context`
+```
+iomemcon addr context
+```
 
 **Where:**
 
@@ -64,7 +66,9 @@ Label i/o ports. This may be a single port or a range.
 
 **The statement definition is:**
 
-`ioportcon port context`
+```
+ioportcon port context
+```
 
 **Where:**
 
@@ -108,7 +112,9 @@ Label a PCI device.
 
 **The statement definition is:**
 
-`pcidevicecon pci_id context`
+```
+pcidevicecon pci_id context
+```
 
 **Where:**
 
@@ -140,7 +146,9 @@ Conditional Policy Statements
 
 **Example:**
 
-`pcidevicecon 0xc800 system_u:object_r:nicP_t`
+```
+pcidevicecon 0xc800 system_u:object_r:nicP_t
+```
 
 ## *pirqcon*
 
@@ -148,7 +156,9 @@ Label an interrupt level.
 
 **The statement definition is:**
 
-`pirqcon irq context`
+```
+pirqcon irq context
+```
 
 **Where:**
 
@@ -180,7 +190,9 @@ Conditional Policy Statements
 
 **Example:**
 
-`pirqcon 33 system_u:object_r:nicP_t`
+```
+pirqcon 33 system_u:object_r:nicP_t
+```
 
 ## *devicetreecon*
 
@@ -188,7 +200,9 @@ Label device tree nodes.
 
 **The statement definition is:**
 
-`devicetreecon path context`
+```
+devicetreecon path context
+```
 
 **Where:**
 
@@ -221,7 +235,9 @@ Conditional Policy Statements
 
 **Example:**
 
-`devicetreecon "/this is/a/path" system_u:object_r:arm_path`
+```
+devicetreecon "/this is/a/path" system_u:object_r:arm_path
+```
 
 <!-- %CUTHERE% -->
 
diff --git a/src/xperm_rules.md b/src/xperm_rules.md
index 21878ea..7f8744b 100644
--- a/src/xperm_rules.md
+++ b/src/xperm_rules.md
@@ -12,7 +12,9 @@ libsepol 2.7 minimum is required).
 
 **The common format for Extended Access Vector Rules are:**
 
-`rule_name source_type target_type : class operation xperm_set;`
+```
+rule_name source_type target_type : class operation xperm_set;
+```
 
 **Where:**
 
@@ -82,7 +84,9 @@ versions &lt; 30 only controls whether an *ioctl* permission is allowed
 or not, for example this rule allows the object class *tcp_socket* the
 *ioctl* permission:
 
-`allow src_t tgt_t : tcp_socket ioctl;`
+```
+allow src_t tgt_t : tcp_socket ioctl;
+```
 
 From Policy version 30 it is possible to control ***ioctl**(2)*
 '*request*' parameters provided the *ioctl* permission is also allowed,

