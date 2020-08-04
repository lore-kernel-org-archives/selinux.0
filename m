Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CEC433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADBA20781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dptBOWjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHDBek (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBej (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88884C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l13so11954348qvt.10
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=GrU7H9Y0OErMqYLuGeNNZ6xbLnS1xeFSeQpf7f18GFo=;
        b=dptBOWjTJPMd9W1sisM5tYL5q/xsz+J6V4hNKrDkEnkgEoXUbXkhXNL1p9WJg1PaoM
         jtREClr5oBvonWh/n4kYtBc6m+xlJS96slnkyxmtxLcKVglOahxNoykKjQdG2jaXVaoJ
         2lc4RWbmuMYlhd+90QLLwCcoWqyGoH7dsn34HgH3bT6IIZYMUTZkMXpnOlsJoj++h7p1
         kWd4xRRgczuTrBz/mp3CQqR5wBHIsWNtIYQoVp9tVGELetAnyy1l3uILAOIDkcOOWRoJ
         UYECd8DYuqh3XddptKItfK2XjeBuX/hDptoUEgD1/mcx943pYPDp5FjupndWSh9SqqO9
         plLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GrU7H9Y0OErMqYLuGeNNZ6xbLnS1xeFSeQpf7f18GFo=;
        b=UreyaYIiHzgD34LuuLy33zzJ/0XayuAc1zQ6oBr0Tgy4of1yc3krGnN1NJO3JY5hhA
         Ujic+kpsOOla8B3A+2wBVoG6bSYCbZ5GJY8s7MpdaCqve7w3AsIH0bHBQ9aKcPxram4E
         RJZUvRGrvqJcI0PF7iAhoqqrUkSZrqOjsWqx+gVaJDTwljzZURWjKxDYvpZ+NGcpZb7O
         je8vBVQfsXHZ6MgVUmI5Ysm93EPcuvWrDG/nPw6SZg6vcKNHvEQFL6DaimJAVfKE5imL
         WZ+USVYH50l4ImGgZzi5aS0WuU0cYtCHKGf/AtVWr8MQaTnVJfBd8Qs760U0AvRK0vZV
         gZ6g==
X-Gm-Message-State: AOAM530+bDuXe52oB/qZHugJZUGkPsHlx1MQTa2OKdXlC9PtMLJTPr1h
        nZsAi4JHvyGjXoe3KF5MzjuwpRLZg3R+
X-Google-Smtp-Source: ABdhPJx0ICOXfKg9WDl97nFBUU4LXNTNc3Vs8GMf0NTk2cK/0paKUpXCuK/us2vZSUF8rxGFO3UNeA==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr19676925qve.71.1596504876177;
        Mon, 03 Aug 2020 18:34:36 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id f7sm21431559qkj.32.2020.08.03.18.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:35 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 12/18] all: remove all the <br> tags we
 haven't gotten to yet
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:34 -0400
Message-ID: <159650487464.8961.11767629431550973827.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was done with the following script:

  for i in *.md; do
    sed '/^[ \t]*<br>[ \t]*$/d' -i $i
  done

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/apache_support.md              |    4 ---
 src/auditing.md                    |    7 -----
 src/avc_rules.md                   |    6 -----
 src/bounds_rules.md                |    2 --
 src/cil_overview.md                |    1 -
 src/class_permission_statements.md |    5 ----
 src/computing_access_decisions.md  |    1 -
 src/computing_security_contexts.md |   15 -----------
 src/conditional_statements.md      |    3 --
 src/configuration_files.md         |    3 --
 src/constraint_statements.md       |    4 ---
 src/core_components.md             |    5 ----
 src/debug_policy_hints.md          |    1 -
 src/default_rules.md               |    4 ---
 src/domain_object_transitions.md   |    4 ---
 src/file_labeling_statements.md    |    5 ----
 src/global_config_files.md         |    7 -----
 src/implementing_seaware_apps.md   |    6 -----
 src/infiniband_statements.md       |    3 --
 src/kernel_policy_language.md      |    7 -----
 src/libselinux_functions.md        |    1 -
 src/lsm_selinux.md                 |    8 ------
 src/mac.md                         |    2 --
 src/mls_mcs.md                     |    6 -----
 src/mls_statements.md              |   10 --------
 src/modes.md                       |    1 -
 src/modular_policy_statements.md   |    4 ---
 src/network_statements.md          |    4 ---
 src/network_support.md             |    7 -----
 src/object_classes_permissions.md  |   21 ----------------
 src/objects.md                     |    3 --
 src/pam_login.md                   |    1 -
 src/policy_config_files.md         |   35 ---------------------------
 src/policy_config_statements.md    |    1 -
 src/policy_languages.md            |    1 -
 src/policy_store_config_files.md   |   20 ---------------
 src/policy_validation_example.md   |    1 -
 src/polyinstantiation.md           |    7 -----
 src/rbac.md                        |    1 -
 src/reference_policy.md            |   47 ------------------------------------
 src/role_statements.md             |    6 -----
 src/seandroid.md                   |   15 -----------
 src/security_context.md            |    1 -
 src/selinux_cmds.md                |    1 -
 src/selinux_overview.md            |    2 --
 src/sid_statement.md               |    2 --
 src/subjects.md                    |    2 --
 src/terminology.md                 |    2 --
 src/title.md                       |    1 -
 src/toc.md                         |    1 -
 src/type_enforcement.md            |    3 --
 src/types_of_policy.md             |   10 --------
 src/users.md                       |    1 -
 53 files changed, 321 deletions(-)

diff --git a/src/apache_support.md b/src/apache_support.md
index 60f09d9..22ce966 100644
--- a/src/apache_support.md
+++ b/src/apache_support.md
@@ -50,7 +50,6 @@ the LAPP<a href="#fnap1" class="footnote-ref" id="fnaph1"><strong><sup>1</sup></
 The [A secure web application platform powered by SELinux](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf)
 document gives a good overview of the LAPP architecture.
 
-<br>
 
 ## `mod_selinux` Overview
 
@@ -76,7 +75,6 @@ itself, for example:
 3.  The web application exits, handing control back to the web server
     that replies with the HTTP response.
 
-<br>
 
 ## Bounds Overview
 
@@ -122,7 +120,6 @@ operation will be denied and an `SELINUX_ERR` entry will be added to
 the audit log stating `op=security_compute_av reason=bounds` with
 the context strings and the denied class and permissions.
 
-<br>
 
 
 <section class="footnotes">
@@ -131,7 +128,6 @@ the context strings and the denied class and permissions.
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/auditing.md b/src/auditing.md
index 295373a..17cc2e6 100644
--- a/src/auditing.md
+++ b/src/auditing.md
@@ -40,7 +40,6 @@ Notes:
     ***selinux_set_callback**(3)* and specifying an alternative log
     handler.
 
-<br>
 
 ## AVC Audit Events
 
@@ -233,7 +232,6 @@ exe="/usr/move_file/move_file_c"
 subj=unconfined_u:unconfined_r:move_file_t key=(null)
 ```
 
-<br>
 
 ## General SELinux Audit Events
 
@@ -271,7 +269,6 @@ policyload notice (seqno=2) : exe="/usr/bin/Xorg" sauid=0 hostname=?
 addr=? terminal=?'
 ```
 
-<br>
 
 Change enforcement mode - `MAC_STATUS` - This was generated when the
 SELinux enforcement mode was changed:
@@ -287,7 +284,6 @@ tty=pts0 ses=2 comm="setenforce" exe="/usr/sbin/setenforce"
 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
 ```
 
-<br>
 
 Change boolean value - `MAC_CONFIG_CHANGE` - This event was generated
 when ***setsebool**(8)* was run to change a boolean. Note that the
@@ -323,7 +319,6 @@ exe="/sbin/netlabelctl"
 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
 ```
 
-<br>
 
 Labeled IPSec - `MAC_IPSEC_EVENT` - Generated when running
 ***setkey**(8)* to load IPSec configuration:
@@ -376,7 +371,6 @@ exe="/usr/sbin/httpd" subj=system_u:system_r:httpd_t:s0-s0:c0.c300
 key=(null)
 ```
 
-<br>
 
 Role changes - `USER_ROLE_CHANGE` - Used ***newrole**(1)* to set a new
 role that was not valid.
@@ -391,7 +385,6 @@ new-context=?: exe="/usr/bin/newrole" hostname=? addr=?
 terminal=/dev/pts/0 res=failed'
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/avc_rules.md b/src/avc_rules.md
index 5c2a491..de8e9c3 100644
--- a/src/avc_rules.md
+++ b/src/avc_rules.md
@@ -77,7 +77,6 @@ section.
 </tbody>
 </table>
 
-<br>
 
 ## `allow`
 
@@ -138,7 +137,6 @@ allow bootloader_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow files_unconfined_type file_type:{ file chr_file } ~execmod;
 ```
 
-<br>
 
 ## `dontaudit`
 
@@ -158,7 +156,6 @@ also helps to manage the audit log by excluding known events.
 dontaudit traceroute_t { port_type -port_t }:tcp_socket name_bind;
 ```
 
-<br>
 
 ## `auditallow`
 
@@ -176,7 +173,6 @@ to grant permission.
 auditallow ada_t self:process execstack;
 ```
 
-<br>
 
 ## `neverallow`
 
@@ -207,7 +203,6 @@ neverallow ~can_read_shadow_passwords shadow_t:file read;
 neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 ```
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -216,7 +211,6 @@ neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/bounds_rules.md b/src/bounds_rules.md
index 08393dd..e890955 100644
--- a/src/bounds_rules.md
+++ b/src/bounds_rules.md
@@ -12,7 +12,6 @@ NOT enforced by the SELinux kernel services). The
 [**CIL Reference Guide**](notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
 gives details.
 
-<br>
 
 ## `typebounds`
 
@@ -91,7 +90,6 @@ allow httpd_t etc_t : file { getattr read };
 allow httpd_child_t etc_t : file { read write };
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/cil_overview.md b/src/cil_overview.md
index 1403666..e0364d7 100644
--- a/src/cil_overview.md
+++ b/src/cil_overview.md
@@ -147,7 +147,6 @@ declarations with the order in which they are declared in the kernel.
 A module store is created by `semodule` to give easy access to the
 source and that allows for full control over the policy.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/class_permission_statements.md b/src/class_permission_statements.md
index 65f2bed..eb42b1f 100644
--- a/src/class_permission_statements.md
+++ b/src/class_permission_statements.md
@@ -16,7 +16,6 @@ There are two variants of the `class` statement for writing policy:
     [**Associating Permissions to a Class**](#associating-permissions-to-a-class)
     section.
 
-<br>
 
 ## `class`
 
@@ -75,7 +74,6 @@ definition:
 class db_tuple
 ```
 
-<br>
 
 ### Associating Permissions to a Class
 
@@ -90,7 +88,6 @@ Permissions can be defined within policy in two ways:
 A list of classes and their permissions used by the **Reference Policy**
 can be found in the *./policy/flask/access_vectors* file.
 
-<br>
 
 ## `common`
 
@@ -154,7 +151,6 @@ The statement definition is:
 common database { create drop getattr setattr relabelfrom relabelto }
 ```
 
-<br>
 
 ## `class`
 
@@ -246,7 +242,6 @@ class db_blob inherits database
 class db_blob inherits database { read write import export }
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/computing_access_decisions.md b/src/computing_access_decisions.md
index 0670240..ce4cf11 100644
--- a/src/computing_access_decisions.md
+++ b/src/computing_access_decisions.md
@@ -57,7 +57,6 @@ require kernel system call over-heads once set up. Note that these
 functions are only available from *libselinux* 2.0.99, with Linux kernel
 2.6.37 and above.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index ca7ba5d..100a8cf 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -46,7 +46,6 @@ various kernel objects (also see the
 [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
 section.
 
-<br>
 
 ### Process
 
@@ -74,7 +73,6 @@ Processes inherit their security context as follows:
     practice is generally discouraged - exec-based transitions are
     preferred.
 
-<br>
 
 ### Files
 
@@ -113,13 +111,11 @@ SID, which is mapped to a context by the policy. This default may be
 overridden via the `defcontext=` mount option on a per-mount basis as
 described in ***mount**(8)*.
 
-<br>
 
 ### File Descriptors
 
 Inherits the label of its creator/parent.
 
-<br>
 
 ### Filesystems
 
@@ -166,7 +162,6 @@ Notes:
     `context=`, `fscontext=`, `defcontext=` and `rootcontext=`. They are
     fully described in the ***mount**(8)* man page.
 
-<br>
 
 ### Network File System (nfsv4.2)
 
@@ -174,7 +169,6 @@ If labeled NFS is implemented with `xattr` support, then the creation of
 inodes are treated as described in the [Files](#files)
 section.
 
-<br>
 
 ### INET Sockets
 
@@ -208,13 +202,11 @@ Some sockets may be labeled with the kernel SID to reflect the fact that
 they are kernel-internal sockets that are not directly exposed to
 applications.
 
-<br>
 
 ### IPC
 
 Inherits the label of its creator/parent.
 
-<br>
 
 ### Message Queues
 
@@ -239,19 +231,16 @@ the message queue it will be stored in as follows:
     with the selected range being low, high or low-high to be defined
     for the message object class).
 
-<br>
 
 ### Semaphores
 
 Inherits the label of its creator/parent.
 
-<br>
 
 ### Shared Memory
 
 Inherits the label of its creator/parent.
 
-<br>
 
 ### Keys
 
@@ -260,7 +249,6 @@ Inherits the label of its creator/parent.
 Security-aware applications may use ***setkeycreatecon**(3)* to
 explicitly label keys they create if permitted by policy.
 
-<br>
 
 ## Using libselinux Functions
 
@@ -359,7 +347,6 @@ new context `newcon` (referenced by SIDs for
 
 **Table 1**
 
-<br>
 
 ### *avc_compute_member* and *security_compute_member*
 
@@ -435,7 +422,6 @@ the new context `newcon` (referenced by SIDs for
 
 **Table 2**
 
-<br>
 
 ### *security_compute_relabel*
 
@@ -514,7 +500,6 @@ following notes also apply:
 
 **Table 3**
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/conditional_statements.md b/src/conditional_statements.md
index e7254cc..00159b6 100644
--- a/src/conditional_statements.md
+++ b/src/conditional_statements.md
@@ -56,7 +56,6 @@ getsebool -a
 getsebool allow_daemons_use_tty
 ```
 
-<br>
 
 ## bool
 
@@ -133,7 +132,6 @@ bool allow_execheap false;
 bool allow_execstack true;
 ```
 
-<br>
 
 ### if
 
@@ -258,7 +256,6 @@ if (read_untrusted_content) {
 }
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/configuration_files.md b/src/configuration_files.md
index 6738ec4..10092c6 100644
--- a/src/configuration_files.md
+++ b/src/configuration_files.md
@@ -33,7 +33,6 @@ as follows:
     viewing the currently loaded policy using tools such as
     ***apol**(1)* (e.g. *apol /sys/fs/selinux/policy*).
 
-<br>
 
 ## The Policy Store
 
@@ -149,7 +148,6 @@ already available, the following message will be given: "*A higher
 priority &lt;name&gt; module exists at priority &lt;999&gt; and will
 override the module currently being installed at priority &lt;111&gt;*".
 
-<br>
 
 ## Converting policy packages to CIL
 
@@ -175,7 +173,6 @@ Options:
 -h, --help print this message and exit
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/constraint_statements.md b/src/constraint_statements.md
index 50733b1..9708306 100644
--- a/src/constraint_statements.md
+++ b/src/constraint_statements.md
@@ -170,7 +170,6 @@ constrain { dir file lnk_file sock_file fifo_file chr_file blk_file } { create r
 	(u1 == u2 or t1 == can_change_object_identity);
 ```
 
-<br>
 
 ## `validatetrans`
 
@@ -269,7 +268,6 @@ Note there are no `validatetrans` statements specified within the
 
 `validatetrans { file } { t1 == unconfined_t );`
 
-<br>
 
 ## `mlsconstrain`
 
@@ -394,7 +392,6 @@ mlsconstrain dir search
 	( t2 == mlstrustedobject ));
 ```
 
-<br>
 
 ## `mlsvalidatetrans`
 
@@ -524,7 +521,6 @@ mlsvalidatetrans { dir file lnk_file chr_file blk_file sock_file fifo_file }
 	(( t3 == mlsfiledowngrade ) and ( h1 incomp h2 ))));
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/core_components.md b/src/core_components.md
index dde17a1..0cc9e65 100644
--- a/src/core_components.md
+++ b/src/core_components.md
@@ -17,7 +17,6 @@ manage enforcement of the policy and comprise of the following:
 5.  An Access Vector Cache (AVC) that improves system performance by
     caching security server decisions.
 
-<br>
 
 ![](./images/1-core.png)
 
@@ -26,13 +25,11 @@ Security Server are cached in the AVC to enhance performance of future
 requests. Note that it is the kernel and userspace Object Managers that
 enforce the policy.*
 
-<br>
 
 ![](./images/2-high-level-arch.png)
 
 **Figure 2: High Level SELinux Architecture** - *Showing the major supporting services*
 
-<br>
 
 **Figure 2** shows a more complex diagram of kernel and userspace with a number of
 supporting services that are used to manage the SELinux environment.
@@ -134,7 +131,6 @@ The [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module
 section goes into greater detail of the LSM / SELinux modules with a walk
 through of a ***fork**(2)* and ***exec**(2)* process.
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -149,7 +145,6 @@ statement that allows a domain to run in permissive mode while the others are st
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/debug_policy_hints.md b/src/debug_policy_hints.md
index edccce9..913a82a 100644
--- a/src/debug_policy_hints.md
+++ b/src/debug_policy_hints.md
@@ -5,7 +5,6 @@ I'm sure there is more to add here !!!
 
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/default_rules.md b/src/default_rules.md
index a5ea085..e759a84 100644
--- a/src/default_rules.md
+++ b/src/default_rules.md
@@ -77,7 +77,6 @@ default_user file target;
 default_user { x_selection x_property } source;
 ```
 
-<br>
 
 ## `default_role`
 
@@ -152,7 +151,6 @@ default_role file target;
 default_role { x_selection x_property } source;
 ```
 
-<br>
 
 ## `default_type`
 
@@ -227,7 +225,6 @@ default_type file target;
 default_type { x_selection x_property } source;
 ```
 
-<br>
 
 ## `default_range`
 
@@ -327,7 +324,6 @@ default_type { x_selection x_property } source low_high;
 default_range db_table glblub;
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/domain_object_transitions.md b/src/domain_object_transitions.md
index c4cf83b..2c5e45a 100644
--- a/src/domain_object_transitions.md
+++ b/src/domain_object_transitions.md
@@ -8,7 +8,6 @@ This section discusses the `type_transition` statement that is used to:
 These transitions can also be achieved using the **libselinux** API
 functions for SELinux-aware applications.
 
-<br>
 
 ## Domain Transition
 
@@ -89,7 +88,6 @@ SELinux enabled kernel.
 within the `unconfined_t` domain and then transitioned to the `ext_gateway_t`
 domain.*
 
-<br>
 
 ### Type Enforcement Rules
 
@@ -209,7 +207,6 @@ Other ways to resolve this issue are:
 It was decided to use runcon as it demonstrates the command usage better
 than reading the man pages.
 
-<br>
 
 ## Object Transition
 
@@ -276,7 +273,6 @@ drwxr-xr-x root root system_u:object_r:unconfined_t ..
 -rw-r--r-- root root unconfined_u:object_r:in_file_t Message-2
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/file_labeling_statements.md b/src/file_labeling_statements.md
index ad0036b..dad3361 100644
--- a/src/file_labeling_statements.md
+++ b/src/file_labeling_statements.md
@@ -12,7 +12,6 @@ therefore if the policy supports MCS / MLS, then an `mls_range` is
 required as described in the
 [**MLS range Definition**](mls_statements.md#mls-range-definition) section.
 
-<br>
 
 ## `fs_use_xattr`
 
@@ -85,7 +84,6 @@ fs_use_xattr ext2 system_u:object_r:fs_t:s0;
 fs_use_xattr ext3 system_u:object_r:fs_t:s0;
 ```
 
-<br>
 
 ## `fs_use_task`
 
@@ -156,7 +154,6 @@ fs_use_task pipefs system_u:object_r:fs_t:s0;
 fs_use_task sockfs system_u:object_r:fs_t:s0;
 ```
 
-<br>
 
 ## `fs_use_trans`
 
@@ -227,7 +224,6 @@ fs_use_trans tmpfs system_u:object_r:tmpfs_t:s0;
 fs_use_trans devpts system_u:object_r:devpts_t:s0;
 ```
 
-<br>
 
 ## `genfscon`
 
@@ -319,7 +315,6 @@ genfscon proc /fs/openafs system_u:object_r:proc_afs_t:s0
 genfscon proc /kmsg system_u:object_r:proc_kmsg_t:s15:c0.c255
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/global_config_files.md b/src/global_config_files.md
index 2897e1b..3cc3bbd 100644
--- a/src/global_config_files.md
+++ b/src/global_config_files.md
@@ -9,7 +9,6 @@ important files are:
 -   */etc/selinux/semanage.conf* - This is used by the SELinux policy
     configuration subsystem for modular or CIL policies.
 
-<br>
 
 ## */etc/selinux/config*
 
@@ -83,7 +82,6 @@ SELINUX=permissive
 SELINUXTYPE=targeted
 ```
 
-<br>
 
 ## */etc/selinux/semanage.conf*
 
@@ -275,7 +273,6 @@ args = $@
 [end]
 ```
 
-<br>
 
 ## */etc/selinux/restorecond.conf*
 ## *restorecond-user.conf*
@@ -319,14 +316,12 @@ directories).
 ~/public_html/*
 ```
 
-<br>
 
 ## */etc/selinux/newrole_pam.conf*
 
 The optional *newrole\_pam.conf* file is used by ***newrole**(1)* and
 maps commands to ***PAM**(8)* service names.
 
-<br>
 
 ## */etc/sestatus.conf*
 
@@ -367,7 +362,6 @@ List of processes to display context
 /usr/sbin/sshd
 ```
 
-<br>
 
 ## */etc/security/sepermit.conf*
 
@@ -413,7 +407,6 @@ example that describes the configuration:
 xguest:exclusive
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index dbdbae4..244d3ac 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -36,7 +36,6 @@ SELinux-aware applications do not (they rely on 'Object Managers' to do
 this e.g. the kernel based Object Managers such as those that manage
 filesystem, IPC and network labeling).
 
-<br>
 
 ## Implementing SELinux-aware Applications
 
@@ -96,7 +95,6 @@ developing SELinux-aware applications and object managers using
     explained at:
 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=12b29f34558b9b45a2c6eabd4f3c6be939a3980f>
 
-<br>
 
 ## Implementing Object Managers
 
@@ -157,7 +155,6 @@ classes/permissions.
     the [**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf), and for reference, the SE-PostgreSQL service also implements a similar
     interface.
 
-<br>
 
 ## Reference Policy Changes
 
@@ -211,7 +208,6 @@ not require modification, and supplying the module files (*\*.te*,
 ## </required>
 ```
 
-<br>
 
 ## Adding New Object Classes and Permissions
 
@@ -288,7 +284,6 @@ dynamic class/perm discovery:
     by the kernel. Then add allow rules as appropriate to the policy for
     the new permissions.
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -301,7 +296,6 @@ applied to their objects as defined by policy.<a href="#fnisa1" class="footnote-
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/infiniband_statements.md b/src/infiniband_statements.md
index 9b13206..79c29da 100644
--- a/src/infiniband_statements.md
+++ b/src/infiniband_statements.md
@@ -8,7 +8,6 @@ overview of the SELinux IB implementation can be found at:
 
 Note that there are no terminating semi-colons ';' on these statements.
 
-<br>
 
 ## `ibpkeycon`
 
@@ -94,7 +93,6 @@ in the default `<SELINUXTYPE>` policy store and then activate the policy:
 ibpkeycon fe80:: 0xFFFF system_u:object_r:default_ibpkey_t:s0
 ```
 
-<br>
 
 ## `ibendportcon`
 
@@ -180,7 +178,6 @@ This command will produce the following file
 ibendportcon mlx4_0 2 system_u:object_r:opensm_ibendport_t:s0
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index 96214a7..7a74255 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -205,7 +205,6 @@ Where:
 **Table 3** shows a cross reference matrix of statements
 and rules allowed in each type of policy source file.
 
-<br>
 
 ## Conditional, Optional and Require Statement Rules
 
@@ -261,7 +260,6 @@ Where:
 **Table 3** shows a cross reference matrix of statements
 and rules allowed in each of the above policy statements.
 
-<br>
 
 ## MLS Statements and Optional MLS Components
 
@@ -272,7 +270,6 @@ context as an argument, (for example the
 [**Network Labeling Statements**](network_statements.md#network-labeling-statements)),
 therefore these statements show an example taken from the MLS **Reference Policy** build.
 
-<br>
 
 ## General Statement Information
 
@@ -483,7 +480,6 @@ same).
 
 **Table 2: Policy language reserved words**
 
-<br>
 
 **Table 3** shows what policy language statements and rules are allowed
 within each type of policy source file, and whether the statement is valid
@@ -952,7 +948,6 @@ policy source file. The right hand side of the table shows whether the
 statement is valid within the `if/else` construct, `optional {rule_list}`,
 or `require {rule_list}` statement.*
 
-<br>
 
 ## Section Contents
 
@@ -980,7 +975,6 @@ Note these are not kernel policy statements, but used by the Reference Policy
 to assist policy build:
 -   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -992,7 +986,6 @@ to assist policy build:
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/libselinux_functions.md b/src/libselinux_functions.md
index 52232aa..d3dd2f1 100644
--- a/src/libselinux_functions.md
+++ b/src/libselinux_functions.md
@@ -1093,7 +1093,6 @@ The appropriate ***man**(3)* pages should consulted for detailed usage.
 </tbody>
 </table>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index f762614..d4be834 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -15,7 +15,6 @@ the SELinux kernel source code). The major areas covered are:
 4.  The SELinux filesystem */sys/fs/selinux*.
 5.  The */proc* filesystem area most applicable to SELinux.
 
-<br>
 
 ## The LSM Module
 
@@ -90,7 +89,6 @@ inserted security hooks and structures to allow access control to be
 managed by 3<sup>rd</sup> party modules (see
 ./linux-3.14/include/linux/security.h).*
 
-<br>
 
 | ***/proc/self/attr/*** **Permissions** |  **File Name**|     **Function**                              |
 | ------------ | ------------ | ------------------------------------------------------------------------ |
@@ -145,7 +143,6 @@ hooks and structures.
 
 **Table 3:** *The core LSM source modules.*
 
-<br>
 
 ## The SELinux Module
 
@@ -271,7 +268,6 @@ to see how some of these kernel source modules fit together.
 **Table 4: The core SELinux source modules** - *The .h files and those in
 the include directory have a number of useful comments.*
 
-<br>
 
 ### Fork System Call Walk-thorough
 
@@ -337,7 +333,6 @@ is valid):
 required to check access permissions for Object Class `process` and
 permission `fork`.*
 
-<br>
 
 ### Process Transition Walk-thorough
 
@@ -458,7 +453,6 @@ computed. This function will (assuming there are no errors):
 check if a transition is allowed from the `unconfined_t` domain to the
 `ext_gateway_t` domain.*
 
-<br>
 
 ![](./images/12-lsm-selinux-arch.png)
 
@@ -466,7 +460,6 @@ check if a transition is allowed from the `unconfined_t` domain to the
 link to [**Figure 7**](domain_object_transitions.md#domain-transition)
 where the transition process is described.*
 
-<br>
 
 #### SELinux Filesystem
 
@@ -740,7 +733,6 @@ Notes:
     interfaces.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/mac.md b/src/mac.md
index cfdc0e0..5c746f2 100644
--- a/src/mac.md
+++ b/src/mac.md
@@ -29,7 +29,6 @@ chain for DAC and MAC are shown in **Figure 3**.
 **Figure 3: Processing a System Call** - *The DAC checks are carried out
 first, if they pass then the Security Server is consulted for a decision.*
 
-<br>
 
 SELinux supports two forms of MAC:
 
@@ -63,7 +62,6 @@ application separation, for example SELinux enabled:
     [**Security Enhancements for Android - Computing a Context**](seandroid.md#computing-process-context-examples) section).
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/mls_mcs.md b/src/mls_mcs.md
index 2f80ac6..59ff4a0 100644
--- a/src/mls_mcs.md
+++ b/src/mls_mcs.md
@@ -111,7 +111,6 @@ The format used in the policy language statements is fully described in
 the [MLS Statements](mls_statements.md#mls-statements) section, however
 a brief overview follows.
 
-<br>
 
 #### MLS / MCS Range Format
 
@@ -146,7 +145,6 @@ user:role:type:sensitivity[:category,...]  -  sensitivity [:category,...]
 </tbody>
 </table>
 
-<br>
 
 #### Translating Levels
 
@@ -163,7 +161,6 @@ command can be used to set up this translation and is shown in the
 [**setrans.conf**](policy_config_files.md#setrans.conf) configuration file
 section.
 
-<br>
 
 ### Managing Security Levels via Dominance Rules
 
@@ -282,13 +279,11 @@ the `mlsconstrain` statement as illustrated in
 **Table 2: MLS Security Levels** - *Showing the scope of a process running
 at a security range of `s0 - s3:c1.c5`.*
 
-<br>
 
 ![](./images/9-mls-constrain.png)
 
 **Figure 9: Showing the mlsconstrain Statements controlling Read Down & Write Up** - *This ties in with* **Table 2: MLS Security Levels** *that shows a process running with a security range of s0 - s3:c1.c5.*
 
-<br>
 
 Using **Figure 9: `mlsconstrain` Statements controlling Read Down & Write Up**:
 
@@ -359,7 +354,6 @@ An interesting point:
     evaluated.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/mls_statements.md b/src/mls_statements.md
index 5731df8..d4a0c7f 100644
--- a/src/mls_statements.md
+++ b/src/mls_statements.md
@@ -61,14 +61,12 @@ the circumstances, there can be one level defined or a
 **Table 1: Sensitivity and Category = Security Level** - *this table shows
 the meanings depending on the context being discussed.*
 
-<br>
 
 To make the security levels more meaningful, it is possible to use the
 setransd daemon to translate these to human readable formats. The
 **semanage**(8) command will allow this mapping to be defined as discussed
 in the [**setrans.conf**](policy_config_files.md#setrans.conf) section.
 
-<br>
 
 #### MLS range Definition
 
@@ -100,7 +98,6 @@ discussed at the start of the [**MLS section**](#mls-statements).
 </tbody>
 </table>
 
-<br>
 
 ## `sensitivity`
 
@@ -179,7 +176,6 @@ sensitivity s15;
 sensitivity s0 alias secret wellmaybe ornot;
 ```
 
-<br>
 
 ## `dominance`
 
@@ -242,7 +238,6 @@ The statement is valid in:
 dominance { s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 }
 ```
 
-<br>
 
 ## `category`
 
@@ -321,7 +316,6 @@ category c255;
 category c0 alias planning development benefits;
 ```
 
-<br>
 
 ## `level`
 
@@ -395,7 +389,6 @@ level s0:c0.c255;
 level s15:c0.c255;
 ```
 
-<br>
 
 ## `range_transition`
 
@@ -484,7 +477,6 @@ range_transition initrc_t auditd_exec_t:process s15:c0.c255;
 range_transition initrc_t cupsd_exec_t:process s15:c0.c255;
 ```
 
-<br>
 
 ## `mlsconstrain`
 
@@ -492,7 +484,6 @@ This is decribed in the
 [**Constraint Statements - `mlsconstrain`**](constraint_statements.md#mlsconstrain)
 section.
 
-<br>
 
 ## `mlsvalidatetrans`
 
@@ -500,7 +491,6 @@ This is decribed in the
 [**Constraint Statements - `mlsvalidatetrans`**](constraint_statements.md#mlsvalidatetrans)
 section.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/modes.md b/src/modes.md
index 0f714e4..f5ceaef 100644
--- a/src/modes.md
+++ b/src/modes.md
@@ -43,7 +43,6 @@ enforcement mode in its output, however it does not display individual
 domain or object manager enforcement modes.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index 30ac4e0..2918010 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -3,7 +3,6 @@
 This section contains statements used to support policy modules. They are
 not part of the kernel policy language.
 
-<br>
 
 ## `module`
 
@@ -72,7 +71,6 @@ modules within the policy.
 
 module bind 1.0.0;
 ```
-<br>
 
 ## `require`
 
@@ -165,7 +163,6 @@ require {
 	shmemhost shmemserv };
 }
 ```
-<br>
 
 ## `optional`
 
@@ -266,7 +263,6 @@ optional {
 } # end optional
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/network_statements.md b/src/network_statements.md
index ef1c873..da66612 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -68,7 +68,6 @@ Or
 
 `::`
 
-<br>
 
 ## `netifcon`
 
@@ -161,7 +160,6 @@ netifcon eth2 system_u:object_r:netif_t:s0
 system_u:object_r:netif_t:s0
 ```
 
-<br>
 
 ## `nodecon`
 
@@ -260,7 +258,6 @@ This command will produce the following file in the default
 nodecon ipv4 127.0.0.2 255.255.255.255 system_u:object_r:node_t:s0
 ```
 
-<br>
 
 ## `portcon`
 
@@ -352,7 +349,6 @@ This command will produce the following file in the default
 portcon udp 1234 system_u:object_r:reserved_port_t:s0
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/network_support.md b/src/network_support.md
index 309e863..b207247 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -63,7 +63,6 @@ the inode associated to the socket and not from the actual kernel socket
 structure (as currently there is no standard kernel/userspace interface
 to achieve this).
 
-<br>
 
 ## SECMARK
 
@@ -177,7 +176,6 @@ The following articles explain the SECMARK service:
 -   [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
 
 
-<br>
 
 ## NetLabel - Fallback Peer Labeling
 
@@ -217,7 +215,6 @@ netlabelctl -p map list
 Note that the security contexts must be valid in the policy otherwise the
 commands will fail.
 
-<br>
 
 ## NetLabel – CIPSO/CALIPSO
 
@@ -286,7 +283,6 @@ netlabelctl -p map list
 The examples use the *nb_client*/*nb_server* from the Notebook examples
 section, plus the standard Fedora 'targeted' policy for the tests.
 
-<br>
 
 ## Labeled IPSec
 
@@ -431,7 +427,6 @@ article and a good reference covering **Basic Labeled IPsec Configuration**
 available at:
 <http://www.redhat.com/archives/redhat-lspp/2006-November/msg00051.html>
 
-<br>
 
 ## Labeled Network FileSystem (NFS)
 
@@ -449,7 +444,6 @@ Labeled NFS clients must use a consistent security policy.
 
 The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -459,7 +453,6 @@ The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 </ol>
 </section>
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index 498d872..833d4d6 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -69,7 +69,6 @@ Language, and the
 [**CIL Reference Guide**](./notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
 specifies the CIL Policy Language.
 
-<br>
 
 # Kernel Object Classes and Permissions
 
@@ -667,7 +666,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-<br>
 
 ## File Object Classes
 
@@ -908,7 +906,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-<br>
 
 ## Network Object Classes
 
@@ -1134,7 +1131,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-<br>
 
 ## IPSec Network Object Classes
 
@@ -1215,7 +1211,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-<br>
 
 ## Netlink Object Classes
 
@@ -1616,7 +1611,6 @@ Netlink sockets communicate between userspace and the kernel – also see
 </tbody>
 </table>
 
-<br>
 
 ## Miscellaneous Network Object Classes
 
@@ -1720,7 +1714,6 @@ Netlink sockets communicate between userspace and the kernel – also see
 </tbody>
 </table>
 
-<br>
 
 ## Sockets via *extended_socket_class*
 
@@ -1908,7 +1901,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-<br>
 
 ## BPF Object Class
 
@@ -1947,7 +1939,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-<br>
 
 ## Performance Event Object Class
 
@@ -1990,7 +1981,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-<br>
 
 ## Lockdown Object Class
 
@@ -2021,7 +2011,6 @@ implementation.
 </tbody>
 </table>
 
-<br>
 
 ## IPC Object Classes
 
@@ -2132,7 +2121,6 @@ implementation.
 </tbody>
 </table>
 
-<br>
 
 ## Process Object Class
 
@@ -2298,7 +2286,6 @@ implementation.
 </tbody>
 </table>
 
-<br>
 
 ## Security Object Class
 
@@ -2369,7 +2356,6 @@ implementation.
 </tbody>
 </table>
 
-<br>
 
 ## System Operation Object Class
 
@@ -2456,7 +2442,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-<br>
 
 ## Miscellaneous Kernel Object Classes
 
@@ -2577,7 +2562,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-<br>
 
 ## Capability Object Classes
 
@@ -2657,7 +2641,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-<br>
 
 ## InfiniBand Object Classes
 
@@ -2699,7 +2682,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-<br>
 
 **Userspace** Object Classes
 =============================
@@ -3339,7 +3321,6 @@ These are userspace objects managed by XSELinux.
 </tbody>
 </table>
 
-<br>
 
 ## Database Object Classes
 
@@ -3671,7 +3652,6 @@ explains the objects, their permissions and how they should be used in detail.
 </tbody>
 </table>
 
-<br>
 
 ## Miscellaneous Userspace Object Classes
 
@@ -3886,7 +3866,6 @@ explains the objects, their permissions and how they should be used in detail.
 </table>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/objects.md b/src/objects.md
index 4ddac6e..e39e1b3 100644
--- a/src/objects.md
+++ b/src/objects.md
@@ -91,7 +91,6 @@ Where:
 </tbody>
 </table>
 
-<br>
 
 ![](./images/6-allow-rule.png)
 
@@ -322,7 +321,6 @@ process itself should clear or shred the information before releasing
 the object (which can be difficult in some cases unless the source code
 is available).
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -333,7 +331,6 @@ associated with the file.<a href="#fnobj1" class="footnote-back">↩</a></p></li
 </section>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/pam_login.md b/src/pam_login.md
index 213a9f3..8d3a831 100644
--- a/src/pam_login.md
+++ b/src/pam_login.md
@@ -110,7 +110,6 @@ perform the following functions:
     to the context defined in the policy.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 3178b08..6ce2020 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -29,7 +29,6 @@ additional two files are required:
     SELinux.
 -   *./context/x_contexts* - To allow the X-Windows service to run under SELinux.
 
-<br>
 
 ## *seusers*
 
@@ -75,7 +74,6 @@ __default__:user_u:s0-s0
 -   ***getseuser**(3)*
 -   ***getseuserbyname**(3)*
 
-<br>
 
 ## *booleans*
 ## *booleans.local*
@@ -123,7 +121,6 @@ Note that if *SETLOCALDEFS* is set in the SELinux
 in the ***selinux_booleans_path**(3)*, and also a *local.users* file
 in the ***selinux_users_path**(3)*.
 
-<br>
 
 ## *booleans.subs_dist*
 
@@ -168,7 +165,6 @@ Supporting libselinux API functions are:
 -   ***security_get_boolean_names**(3)*
 -   ***security_set_boolean**(3)*
 
-<br>
 
 ## setrans.conf
 
@@ -226,7 +222,6 @@ Supporting libselinux API functions are:
 -   ***selinux_raw_to_trans_context**(3)*
 -   ***selinux_trans_to_raw_context**(3)*
 
-<br>
 
 ## *secolor.conf*
 
@@ -319,7 +314,6 @@ user : role : type : range
 black white white black tan orange black green
 ```
 
-<br>
 
 ## *policy/policy.&lt;ver&gt;*
 
@@ -336,7 +330,6 @@ discussed in the
 [**Types of SELinux Policy - Policy Versions**](types_of_policy.md#policy-versions)
 section.
 
-<br>
 
 ## *contexts/customizable_types*
 
@@ -377,7 +370,6 @@ sysadm_untrusted_content_tmp_t
 -   ***selinux_customizable_types_path**(3)*
 -   ***selinux_context_path**(3)*
 
-<br>
 
 ## *contexts/default_contexts*
 
@@ -464,7 +456,6 @@ The login process could now set the context correctly to
 *contexts/users/unconfined_u* configuration file instead could also have
 achieved this.
 
-<br>
 
 ## *contexts/dbus_contexts*
 
@@ -492,7 +483,6 @@ information at:
 
 -   ***selinux_context_path**(3)*
 
-<br>
 
 ## *contexts/default_type*
 
@@ -530,7 +520,6 @@ user_r:user_t
 -   ***selinux_default_type_path**(3)*
 -   ***get_default_type**(3)*
 
-<br>
 
 ## *contexts/failsafe_context*
 
@@ -572,7 +561,6 @@ sysadm_r:sysadm_t:s0
 -   ***get_ordered_context_list**(3)*
 -   ***get_ordered_context_list_with_level**(3)*
 
-<br>
 
 ## *contexts/initrc_context*
 
@@ -609,7 +597,6 @@ system_u:system_r:initrc_t:s0-s15:c0.c255
 
 -   ***selinux_context_path**(3)*
 
-<br>
 
 ## *contexts/lxc_contexts*
 
@@ -665,7 +652,6 @@ sandbox_lxc_process = "system_u:system_r:container_t:s0"
 -   ***selinux_context_path**(3)*
 -   ***selinux_lxc_context_path**(3)*
 
-<br>
 
 ## *contexts/netfilter_contexts* - Obsolete
 
@@ -677,7 +663,6 @@ matching of network packets - Never been used.
 -   ***selinux_context_path**(3)*
 -   ***selinux_netfilter_context_path**(3)*
 
-<br>
 
 ## *contexts/openrc_contexts*
 
@@ -694,7 +679,6 @@ matching of network packets - Never been used.
 -   ***selinux_context_path**(3)*
 -   ***selinux_openrc_contexts_path**(3)*
 
-<br>
 
 ## *contexts/openssh_contexts*
 
@@ -712,7 +696,6 @@ matching of network packets - Never been used.
 -   ***selinux_context_path**(3)*
 -   ***selinux_openssh_contexts_path**(3)*
 
-<br>
 
 ## *contexts/removable_context*
 
@@ -745,7 +728,6 @@ system_u:object_r:removable_t:s0
 
 -   ***selinux_removable_context_path**(3)*
 
-<br>
 
 ## *contexts/sepgsql_contexts*
 
@@ -786,7 +768,6 @@ db_database        *        system_u:object_r:sepgsql_db_t:s0
 db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 ```
 
-<br>
 
 ## *contexts/snapperd_contexts*
 
@@ -804,7 +785,6 @@ db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 -   ***selinux_context_path**(3)*
 -   ***selinux_snapperd_contexts_path**(3)*
 
-<br>
 
 ## *contexts/securetty_types*
 
@@ -838,7 +818,6 @@ staff_tty_device_t
 
 -   ***selinux_securetty_types_path**(3)*
 
-<br>
 
 ## *contexts/systemd_contexts*
 
@@ -874,7 +853,6 @@ runtime=system_u:object_r:systemd_runtime_unit_file_t:s0
 -   ***selinux_context_path**(3)*
 -   ***selinux_systemd_contexts_path**(3)*
 
-<br>
 
 ## *contexts/userhelper_context*
 
@@ -906,7 +884,6 @@ system_u:sysadm_r:sysadm_t:s0
 
 -   ***selinux_context_path**(3)*
 
-<br>
 
 ## *contexts/virtual_domain_context*
 
@@ -927,7 +904,6 @@ system_u:system_r:svirt_tcg_t:s0
 
 -   ***selinux_virtual_domain_context_path**(3)*
 
-<br>
 
 ## *contexts/virtual_image_context*
 
@@ -948,7 +924,6 @@ system_u:object_r:virt_content_t:s0
 
 -   ***selinux_virtual_image_context_path**(3)*
 
-<br>
 
 ## *contexts/x_contexts*
 
@@ -993,7 +968,6 @@ selection      PRIMARY	   system_u:object_r:clipboard_xselection_t:s0
 -   ***selabel_lookup**(3)*
 -   ***selabel_stats**(3)*
 
-<br>
 
 ## *contexts/files/file_contexts*
 
@@ -1027,7 +1001,6 @@ compatible regular expression (PCRE) internal format.
 -   ***selabel_lookup**(3)*
 -   ***selabel_stats**(3)*
 
-<br>
 
 ## *contexts/files/file_contexts.local*
 
@@ -1040,7 +1013,6 @@ file section to allow locally defined files to be labeled correctly. The
 
 -   ***selinux_file_context_local_path**(3)*
 
-<br>
 
 ## *contexts/files/file_contexts.homedirs*
 
@@ -1066,7 +1038,6 @@ Perl compatible regular expression (PCRE) internal format.
 -   ***selinux_file_context_homedir_path**(3)*
 -   ***selinux_homedir_context_path**(3)*
 
-<br>
 
 ## contexts/files/file_contexts.subs
 ## contexts/files/file_contexts.subs_dist
@@ -1097,7 +1068,6 @@ with */var/www*, with the final result being:
 -   ***matchpathcon**(3)* (deprecated)
 -   ***matchpathcon_index**(3)* (deprecated)
 
-<br>
 
 ## *contexts/files/media*
 
@@ -1137,7 +1107,6 @@ disk system_u:object_r:fixed_disk_device_t:s0
 
 -   ***selinux_media_context_path**(3)*
 
-<br>
 
 ## *contexts/users/[seuser_id]*
 
@@ -1176,7 +1145,6 @@ system_r:init_t:s0		unconfined_r:unconfined_t:s0
 -   ***get_ordered_context_list**(3)*
 -   ***get_ordered_context_list_with_level**(3)*
 
-<br>
 
 ## *logins/&lt;linuxuser_id&gt;*
 
@@ -1230,7 +1198,6 @@ another_service:unconfined_u:s0
 
 -   ***getseuser**(3)*
 
-<br>
 
 ## users/local.users
 
@@ -1251,7 +1218,6 @@ Note that if *SETLOCALDEFS* is set in the SELinux
 in the ***selinux_booleans_path**(3)*, and also a *local.users* file
 in the ***selinux_users_path**(3)*.
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -1260,7 +1226,6 @@ in the ***selinux_users_path**(3)*.
 </section>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index a69fbc0..4289136 100644
--- a/src/policy_config_statements.md
+++ b/src/policy_config_statements.md
@@ -63,7 +63,6 @@ continue to use the original functionality.
 policycap network_peer_controls;
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/policy_languages.md b/src/policy_languages.md
index 9bd4247..fe579fe 100644
--- a/src/policy_languages.md
+++ b/src/policy_languages.md
@@ -55,7 +55,6 @@ domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
 domain_entry_file(test_stat_domain, ls_exec_t)
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/policy_store_config_files.md b/src/policy_store_config_files.md
index fe857d1..45ff3fa 100644
--- a/src/policy_store_config_files.md
+++ b/src/policy_store_config_files.md
@@ -54,7 +54,6 @@ The command types are:
 -   [***semanage user***](#activeusers.local) Manage  SELinux confined users
 (Roles and levels for an SELinux user)
 
-<br>
 
 ## active/modules Directory Contents
 
@@ -84,7 +83,6 @@ test_policy               400       pp
 ...
 ```
 
-<br>
 
 ### *tmp* Policy Store (build failure)
 
@@ -95,14 +93,12 @@ message indicating the failing line number is:
 
 `Failed to resolve mlsconstrain statement at /var/lib/selinux/targeted/tmp/modules/400/test_mlsconstrain/cil:1`
 
-<br>
 
 ## *active/commit_num*
 
 This is a binary file used by ***semanage*** for managing updates to the
 store. The format is not relevant to policy construction.
 
-<br>
 
 ### *active/policy.kern*
 
@@ -112,7 +108,6 @@ is then becomes the
 */etc/selinux/&lt;SELINUXTYPE&gt;/policy/policy.&lt;ver&gt;* binary policy
 that will be loaded into the kernel.
 
-<br>
 
 ## *active/policy.linked*
 ## *active/seusers.linked*
@@ -121,7 +116,6 @@ that will be loaded into the kernel.
 These are saved policy files prior to merging local changes to improve
 performance.
 
-<br>
 
 ## *active/booleans.local*
 
@@ -143,7 +137,6 @@ the new value) if requested.
 daemons_enable_cluster_mode=1
 ```
 
-<br>
 
 ## *disable_dontaudit*
 
@@ -152,7 +145,6 @@ to build the policy or ***semanage dontaudit***. It indicates that a policy
 has been built without the `dontaudit` rules. This allows utilities
 such as ***audit2allow**(8)* to list all denials to assist debugging policy.
 
-<br>
 
 ## *active/file_contexts*
 
@@ -216,7 +208,6 @@ section.
 /var/run -dsystem_u:object_r:var_run_t:s0-s15:c0.c255
 /usr/tmp -dsystem_u:object_r:tmp_t:s0-s15:c0.c255
 ```
-<br>
 
 ### Building the File Labeling Support Files
 
@@ -274,7 +265,6 @@ files.*
 </tbody>
 </table>
 
-<br>
 
 Keywords that can be in policy source \*.fc files and then form the *file_contexts.template* file entries are:
 
@@ -345,7 +335,6 @@ HOME_ROOT/lost\+found/.*	<<none>>
 /home		-l	gen_context(system_u:object_r:home_root_t,s0)
 ```
 
-<br>
 
 ## *active/file_contexts.local*
 
@@ -374,7 +363,6 @@ The resulting *file_contexts.local* file will be:
 /usr/move_file    system_u:object_r:unlabeled_t:s0
 ```
 
-<br>
 
 ## *active/homedir_template*
 
@@ -400,7 +388,6 @@ HOME_ROOT/\.journal	<<none>>
 HOME_DIR/.+	system_u:object_r:user_home_t:s0
 ```
 
-<br>
 
 ### *active/file_contexts.homedirs*
 
@@ -437,7 +424,6 @@ libsepol library function.
 /home/[^/]+/.+	unconfined_u:object_r:user_home_t:s0
 ```
 
-<br>
 
 ## active/seusers
 ## active/seusers.local
@@ -519,7 +505,6 @@ __default__:unconfined_u:s0-s0:c0.c1023
 rch:user_u:s0
 ```
 
-<br>
 
 ## *active/users_extra*
 ## *active/users_extra.local*
@@ -625,7 +610,6 @@ and the resulting *users.local* file will be:
 user test_u roles { staff_r } level s0 range s0;
 ```
 
-<br>
 
 ## *active/interfaces.local*
 
@@ -649,7 +633,6 @@ in the [**`netifcon`**](network_statements.md#netifcon) section.
 netifcon enp7s0 system_u:object_r:netif_t:s0:c20.c250 system_u:object_r:netif_t:s0:c20.c250
 ```
 
-<br>
 
 ## *active/nodes.local*
 
@@ -674,7 +657,6 @@ with examples in the policy language
 nodecon ipv4 127.0.0.2 255.255.255.255 system_u:object_r:node_t:s0:c20.c250
 ```
 
-<br>
 
 ## *active/ports.local*
 
@@ -700,7 +682,6 @@ with examples in the policy language
 portcon tcp 8888 system_u:object_r:port_t:s0:c20.c350
 ```
 
-<br>
 
 ## Set domain permissive mode
 
@@ -720,7 +701,6 @@ Note that the CIL `typepermissive` statement is used, the equivalent kernel
 policy statement would be [**`permissive`**](type_statements.md#permissive).
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/policy_validation_example.md b/src/policy_validation_example.md
index 50375ab..19a380d 100644
--- a/src/policy_validation_example.md
+++ b/src/policy_validation_example.md
@@ -93,7 +93,6 @@ options as described in the
 [**Global Configuration Files** - *semanage.conf*](global_config_files.md#etcselinuxsemanage.conf)
 file section.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/polyinstantiation.md b/src/polyinstantiation.md
index cd740fa..cf2b889 100644
--- a/src/polyinstantiation.md
+++ b/src/polyinstantiation.md
@@ -23,7 +23,6 @@ To clarify polyinstantiation support:
     function of the XSELinux Object Manager and the supporting XACE
     service.
 
-<br>
 
 ## Polyinstantiated Objects
 
@@ -34,7 +33,6 @@ libselinux API functions. These are not limited to specific object
 classes, however only `dir`, `x_selection` and `x_property` objects are
 currently supported.
 
-<br>
 
 ## Polyinstantiation support in PAM
 
@@ -104,7 +102,6 @@ instance, and the user name. If a new instance is being set up, the
 directory permissions are set and the ***restorecon**(8)* command is run
 to set the correct file contexts.
 
-<br>
 
 #### *namespace.conf* Configuration File
 
@@ -140,7 +137,6 @@ Where:
 </tbody>
 </table>
 
-<br>
 
 ### Example Configurations
 
@@ -207,7 +203,6 @@ following polyinstantiated directories:
 /home/rch/rch.inst/unconfined_u:unconfined_r:unconfined_t_rch
 ```
 
-<br>
 
 ## Polyinstantiation support in X-Windows
 
@@ -217,7 +212,6 @@ objects as discussed in the
 [**SELinux X-Windows Support**](x_windows.md#x-windows-selinux-support)
 section.
 
-<br>
 
 ## Polyinstantiation support in the Reference Policy
 
@@ -231,7 +225,6 @@ The polyinstantiation of X-Windows objects (*x_selection* and
 *x_property*) are not currently supported by the reference policy.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/rbac.md b/src/rbac.md
index 25a4e07..b051d09 100644
--- a/src/rbac.md
+++ b/src/rbac.md
@@ -23,7 +23,6 @@ Some policies, for example Android, only make use of one role called `r`.
 access via user, role and domain type association.*
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/reference_policy.md b/src/reference_policy.md
index b51f4b1..4d4fd5d 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -26,7 +26,6 @@ In most documentation the policy name is defined using the
 */etc/selinux/config* file entry **SELINUXTYPE=**. This part of the Notebook
 uses both forms.
 
-<br>
 
 ### Reference Policy Overview
 
@@ -70,7 +69,6 @@ section explains a simple build from source.
 
 **Figure 26: The Reference Policy Source Tree** - *When building a modular policy, files are added to the policy store. For monolithic builds the policy store is not used.*
 
-<br>
 
 The Reference Policy can be used to build two policy types:
 
@@ -93,7 +91,6 @@ forming a single 'base' source file.
 The Reference Policy relies heavily on the ***m4**(1)* macro processor
 as the majority of supporting services are m4 macros.
 
-<br>
 
 ### Distributing Policies
 
@@ -135,7 +132,6 @@ The selinux-policy-sandbox rpm contains the sandbox module for use by the
 *policycoreutils-sandbox* package. This will be installed as a module for
 one of the three main policies described above.
 
-<br>
 
 ### Policy Functionality
 
@@ -150,7 +146,6 @@ the *SELINUXTYPE* entry of the *build.conf* as shown in
     and can also confine other areas and users.
 -   mls - MLS policy for server based systems.
 
-<br>
 
 ### Reference Policy Module Files
 
@@ -313,7 +308,6 @@ interface(`ada_run',`
 /usr/libexec/gcc(/.*)?/gnat1	--	gen_context(system_u:object_r:ada_exec_t,s0)
 ```
 
-<br>
 
 ### Reference Policy Documentation
 
@@ -342,7 +336,6 @@ the ada module interfaces.
 
 **Figure 27: Example Documentation Screen Shot**
 
-<br>
 
 ## Reference Policy Source
 
@@ -356,7 +349,6 @@ updated with the authors comments as necessary). There is also a VERSION
 file that contains the Reference Policy release date, this can then be used to
 obtain a change list <https://github.com/SELinuxProject/refpolicy/releases>.
 
-<br>
 
 ### Source Layout
 
@@ -382,7 +374,6 @@ The
 section then describes how the initial source is installed and
 configured to allow a policy to be built.
 
-<br>
 
 ### Reference Policy Files and Directories
 
@@ -542,14 +533,12 @@ modular policy is being built. This file is explained in the
 
 **Table 1: The Reference Policy Files and Directories**
 
-<br>
 
 ### Source Configuration Files
 
 There are two major configuration files (build.conf and modules.conf)
 that define the policy to be built and are detailed in this section.
 
-<br>
 
 #### Reference Policy Build Options - build.conf
 
@@ -656,7 +645,6 @@ policy is built with examples shown in the
 
 **Table 2:** *build.conf* **Entries**
 
-<br>
 
 <table>
 <tbody>
@@ -715,7 +703,6 @@ policy is built with examples shown in the
 
 **Table 3: m4 parameters set at build time** - *These have been extracted from the Reference Policy Makefile.*
 
-<br>
 
 #### Reference Policy Build Options - policy/modules.conf
 
@@ -917,7 +904,6 @@ reference policy are different)
 
 **Table 4: Mandatory modules.conf Entries**
 
-<br>
 
 ##### Building the modules.conf File
 
@@ -931,7 +917,6 @@ As will be seen in the
 pre-configured files that are used to produce the required policy including
 multiple versions of the *modules.conf* file.
 
-<br>
 
 ### Source Installation and Build Make Options
 
@@ -1065,7 +1050,6 @@ taken from the *README* file.
 
 **Table 7: Monolithic Policy Build Make Targets**
 
-<br>
 
 ### Booleans, Global Booleans and Tunable Booleans
 
@@ -1093,7 +1077,6 @@ built and used as follows:
 </tbody>
 </table>
 
-<br>
 
 ### Modular Policy Build Structure
 
@@ -1222,7 +1205,6 @@ in **Table 9: Module Build**.
 
 **Table 8: Base Module Build** - *This shows the temporary build files used to build the base module 'base.conf' as a part of the 'make' process. Note that the modules marked as base in modules.conf are built here.*
 
-<br>
 
 <table>
 <tbody>
@@ -1260,7 +1242,6 @@ in **Table 9: Module Build**.
 
 **Table 9: Module Build** - *This shows the module files and the temporary build files used to build each module as a part of the 'make' process (i.e. those modules marked as module in modules.conf).*
 
-<br>
 
 ### Creating Additional Layers
 
@@ -1284,7 +1265,6 @@ completed:
 
 `<summary>ABC modules for the XYZ components.</summary>`
 
-<br>
 
 ## Installing and Building the Reference Policy Source
 
@@ -1294,7 +1274,6 @@ the Fedora targeted policy. The Fedora version of the targeted
 policy build is discussed but building without using the rpm spec file
 is more complex.
 
-<br>
 
 ### Building Standard Reference Policy
 
@@ -1435,7 +1414,6 @@ WERROR = n
     as ***apol**(8)* or loaded by editing the */etc/selinux/config*
     file, running '*touch /.autorelabel*' and rebooting the system.
 
-<br>
 
 ### Building the Fedora Policy
 
@@ -1605,7 +1583,6 @@ QUIET = n
     '*touch /.autorelabel*' and rebooting the system. It should have the
     same number of rules, types, classes etc. as the original release.
 
-<br>
 
 ## Reference Policy Headers
 
@@ -1642,7 +1619,6 @@ source two steps are required:
 -   Copy the module interface files (*.if*) to the relevant module
     directories at: */usr/share/selinux/&lt;SELINUXTYPE&gt;/include/modules*.
 
-<br>
 
 ### Using the Reference Policy Headers
 
@@ -1711,7 +1687,6 @@ modules built from headers.
 
 **Table 10: Header Policy Build Make Targets**
 
-<br>
 
 ### Using Fedora Supplied Headers
 
@@ -1727,7 +1702,6 @@ manner as Fedora installs:
 -   The documentation is installed in the
     */usr/share/doc/selinux-policy/html* directory.
 
-<br>
 
 ## Reference Policy Support Macros
 
@@ -1876,7 +1850,6 @@ Incorrect:
 
 `policy_module (ftp, 1.7.0)`
 
-<br>
 
 ### Loadable Policy Macros
 
@@ -1961,7 +1934,6 @@ require {
 }
 ```
 
-<br>
 
 #### `gen_require` Macro
 
@@ -2025,7 +1997,6 @@ require {
 }
 ```
 
-<br>
 
 #### `optional_policy` Macro
 
@@ -2193,7 +2164,6 @@ optional {
 } # end optional
 ```
 
-<br>
 
 #### `gen_tunable` Macro
 
@@ -2271,7 +2241,6 @@ gen_tunable(allow_ftpd_use_nfs, false)
 
 bool allow_ftpd_use_nfs false;
 ```
-<br>
 
 #### `tunable_policy` Macro
 
@@ -2349,7 +2318,6 @@ if (allow_ftpd_use_nfs && allow_ftpd_anon_write) {
 } # end allow_ftpd_use_nfs && allow_ftpd_anon_write
 ```
 
-<br>
 
 #### `interface` Macro
 
@@ -2470,7 +2438,6 @@ optional {
 } # end optional
 ```
 
-<br>
 
 #### `template` Macro
 
@@ -2624,7 +2591,6 @@ template(`djbdns_daemontools_domain_template',`
 ##### end djbdns_daemontools_domain_template(dnscache) depth: 0
 ```
 
-<br>
 
 ### Miscellaneous Macros
 
@@ -2693,7 +2659,6 @@ where it is used to set the files security context.
 /dev/\.tmp-block-.*  -c  system_u:object_r:fixed_disk_device_t:s15:c0.c1023
 ```
 
-<br>
 
 #### `gen_user` Macro
 
@@ -2790,7 +2755,6 @@ user root roles { sysadm_r staff_r secadm_r auditadm_r } level s0 range s0 - s15
 user root prefix sysadm;
 ```
 
-<br>
 
 #### `gen_bool` Macro
 
@@ -2924,7 +2888,6 @@ if( ! secure_mode_insmod ) {
 }
 ```
 
-<br>
 
 ### MLS and MCS Macros
 
@@ -2997,7 +2960,6 @@ category c1;
 category c1023;
 ```
 
-<br>
 
 #### `gen_sens` Macro
 
@@ -3066,7 +3028,6 @@ sensitivity s1;
 sensitivity s15;
 ```
 
-<br>
 
 #### `gen_levels` Macro
 
@@ -3137,7 +3098,6 @@ level s1:c0.c1023;
 level s15:c0.c1023;
 ```
 
-<br>
 
 #### System High/Low Parameters
 
@@ -3183,14 +3143,12 @@ s0:c0.c1023
 c0.c1023
 ```
 
-<br>
 
 ### `ifdef` / `ifndef` Parameters
 
 This section contains examples of the common `ifdef` / `ifndef`
 parameters that can be used in module source files.
 
-<br>
 
 #### `hide_broken_symptoms`
 
@@ -3212,7 +3170,6 @@ ifdef(`hide_broken_symptoms',`
 ')
 ```
 
-<br>
 
 #### `enable_mls` and `enable_mcs`
 
@@ -3241,7 +3198,6 @@ ifdef(`enable_mcs',`
 ')
 ```
 
-<br>
 
 #### `enable_ubac`
 
@@ -3272,7 +3228,6 @@ define(`basic_ubac_conditions',`
 ')
 ```
 
-<br>
 
 #### `direct_sysadm_daemon`
 
@@ -3296,7 +3251,6 @@ ifndef(`direct_sysadm_daemon',`
 ')
 ```
 
-<br>
 
 ## Module Expansion Process
 
@@ -3326,7 +3280,6 @@ section.
 **Figure 29: The expansion process**
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/role_statements.md b/src/role_statements.md
index de86c8b..36fe4c3 100644
--- a/src/role_statements.md
+++ b/src/role_statements.md
@@ -91,7 +91,6 @@ role user_r types user_t;
 role user_r types chfn_t;
 ```
 
-<br>
 
 ## `attribute_role`
 
@@ -155,7 +154,6 @@ attribute_role role_list_1;
 attribute_role srole_list_2;
 ```
 
-<br>
 
 ## `roleattribute`
 
@@ -226,7 +224,6 @@ role service_r;
 roleattribute service_r role_list_1;
 ```
 
-<br>
 
 ## `allow`
 
@@ -297,7 +294,6 @@ Note that the role allow rule has the same keyword as the allow AV rule.
 allow sysadm_r secadm_r;
 ```
 
-<br>
 
 ## `role_transition`
 
@@ -371,7 +367,6 @@ Or from Policy version 25:
 
 `role_transition system_r unconfined_exec_t:process unconfined_r;`
 
-<br>
 
 ## `dominance` - Deprecated
 
@@ -452,7 +447,6 @@ Where:
 dominance { role message_filter_r { role unconfined_r };}
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/seandroid.md b/src/seandroid.md
index 6cfa960..d9a184c 100644
--- a/src/seandroid.md
+++ b/src/seandroid.md
@@ -42,7 +42,6 @@ The sections that follow cover:
 8.  Logging and auditing
 9.  Configuration file formats
 
-<br>
 
 ## SE for Android Project Updates
 
@@ -198,7 +197,6 @@ Build information for each device that includes device specific policy as
 discussed in the [**The SELinux Policy**](#the-selinux-policy) and
 [**Managing Device Policy Files**](#managing-device-policy-files) sections.
 
-<br>
 
 ## Kernel LSM / SELinux Support
 
@@ -222,7 +220,6 @@ Kernel 5.0+ supports Dynamically Allocated Binder Devices, therefore
 configuring specific devices (e.g. **CONFIG_ANDROID_BINDER_DEVICES="binder"**)
 is no longer required (use ***CONFIG_ANDROID_BINDERFS=y*** instead).
 
-<br>
 
 ## Android Classes & Permissions
 
@@ -466,7 +463,6 @@ not all are required for Android.
 </tbody>
 </table>
 
-<br>
 
 ## SELinux Commands
 
@@ -529,7 +525,6 @@ for example:
 </tbody>
 </table>
 
-<br>
 
 ## SELinux Public Methods
 
@@ -633,7 +628,6 @@ TV package *AboutFragment.java* calls **SELinux.isSELinuxEnabled()**.
 </tbody>
 </table>
 
-<br>
 
 ## Android Init Language SELinux Extensions
 
@@ -680,7 +674,6 @@ service ueventd /system/bin/ueventd
     restorecon --recursive --skip-ce /data
 ```
 
-<br>
 
 ## The SELinux Policy
 
@@ -978,7 +971,6 @@ domains (not allowed) and `neverallow` assertions
 **version_policy** - Takes the given public platform policy, a private policy
 and a version number to produced a combined "versioned" policy file.
 
-<br>
 
 ## Logging and Auditing
 
@@ -1002,7 +994,6 @@ in the kernel buffers that can be read using ***dmesg**(1)*:
 
 `adb shell dmesg`
 
-<br>
 
 ## Policy File Formats
 
@@ -1117,7 +1108,6 @@ example taken from *device/generic/goldfish/fstab.ranchu*:
 /dev/block/pci/pci0000:00/0000:00:06.0/by-name/metadata /metadata ext4 .....
 ```
 
-<br>
 
 ### ***seapp_contexts***
 
@@ -1367,7 +1357,6 @@ LABEL                                    USER    PID  PPID NAME
 u:r:untrusted_app:s0:c149,c256,c512,c768 u0_a149 1138 64   com.example.myapplication
 ```
 
-<br>
 
 ### ***property_contexts***
 
@@ -1410,7 +1399,6 @@ ro.telephony.call_ring.multiple   u:object_r:telephony_config_prop:s0 exact bool
 ro.telephony.default_cdma_sub     u:object_r:telephony_config_prop:s0 exact int
 ```
 
-<br>
 
 ### ***service_contexts***
 
@@ -1460,7 +1448,6 @@ manager                 u:object_r:service_manager_vndservice:s0
 *                       u:object_r:default_android_vndservice:s0
 ```
 
-<br>
 
 ### ***mac_permissions.xml***
 
@@ -1548,7 +1535,6 @@ file:
      </signer>
 ```
 
-<br>
 
 ### ***keys.conf***
 
@@ -1590,7 +1576,6 @@ USERDEBUG : $DEFAULT_SYSTEM_DEV_CERTIFICATE/testkey.x509.pem
 ```
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/security_context.md b/src/security_context.md
index 936e6a5..bb219cb 100644
--- a/src/security_context.md
+++ b/src/security_context.md
@@ -114,7 +114,6 @@ unconfined_u:object_r:out_file_t Message-11
 # (see the process example above). The role remained as object_r.
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/selinux_cmds.md b/src/selinux_cmds.md
index 9bbeb32..077ffb6 100644
--- a/src/selinux_cmds.md
+++ b/src/selinux_cmds.md
@@ -153,7 +153,6 @@ has a page that details all the available tools and commands at:
 </table>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/selinux_overview.md b/src/selinux_overview.md
index 10de4dc..0fa89b9 100644
--- a/src/selinux_overview.md
+++ b/src/selinux_overview.md
@@ -43,7 +43,6 @@ locations as follows:
 </tbody>
 </table>
 
-<br>
 
 ## Is SELinux useful
 
@@ -125,7 +124,6 @@ The following maybe useful in providing a practical view of SELinux:
 4.  Older NSA documentation at: <https://www.nsa.gov/what-we-do/research/selinux/documentation/>
     that is informative.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/sid_statement.md b/src/sid_statement.md
index 4e64b68..cbb3ec9 100644
--- a/src/sid_statement.md
+++ b/src/sid_statement.md
@@ -71,7 +71,6 @@ sid unlabeled
 sid fs
 ```
 
-<br>
 
 ## `sid context`
 
@@ -148,7 +147,6 @@ sid unlabeled
 sid unlabeled system_u:object_r:unlabeled_t:s15:c0.c255
 ```
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/subjects.md b/src/subjects.md
index c3a3338..99459a1 100644
--- a/src/subjects.md
+++ b/src/subjects.md
@@ -37,7 +37,6 @@ under `semanage_t`).
 
 **Untrusted** - Everything else.
 
-<br>
 
 <section class="footnotes">
 <ol>
@@ -46,7 +45,6 @@ under `semanage_t`).
 </section>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/terminology.md b/src/terminology.md
index c180633..59e9c0f 100644
--- a/src/terminology.md
+++ b/src/terminology.md
@@ -37,7 +37,6 @@
 | UID     | User Identifier                                                                          |
 | XACE    | X (windows) Access Control Extension                                                     |
 
-<br>
 
 ## Terminology
 
@@ -118,7 +117,6 @@ core SELinux infrastructure.
 </table>
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/title.md b/src/title.md
index a686d52..68a4eb1 100644
--- a/src/title.md
+++ b/src/title.md
@@ -80,7 +80,6 @@ Android.
 **Object Classes and Permissions** - Describes the SELinux object
 classes and permissions.
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/toc.md b/src/toc.md
index 5595512..70ffc9c 100644
--- a/src/toc.md
+++ b/src/toc.md
@@ -61,7 +61,6 @@
 -   [Appendix D - Debugging Policy - Hints and Tips](debug_policy_hints.md#appendix-d---debugging-policy---hints-and-tips)
 -   [Appendix E - Policy Validation Example](policy_validation_example.md#appendix-e---policy-validation-example)
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/type_enforcement.md b/src/type_enforcement.md
index 6828404..898dae7 100644
--- a/src/type_enforcement.md
+++ b/src/type_enforcement.md
@@ -54,7 +54,6 @@ any SELinux service (i.e. it is only used to identify the type
 component), although as explained above CIL with namespaces does make
 identification of types easier.
 
-<br>
 
 ### Constraints
 
@@ -85,7 +84,6 @@ The kernel policy language constraints are defined in the
 [**Constraint Statements**](constraint_statements.md#constraint-statements)
 section.
 
-<br>
 
 ### Bounds
 
@@ -102,7 +100,6 @@ section defines the `typebounds` rule and also gives a summary of the
 `userbounds` and `rolebounds` rules.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index cbb755a..dcbe573 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -31,7 +31,6 @@ The type of SELinux policy can described in a number of ways:
 As can be seen the description of a policy can vary depending on the
 context.
 
-<br>
 
 ## Reference Policy
 
@@ -57,7 +56,6 @@ number of RPMs.
 The Reference Policy can be built as a Monolithic policy or as a Modular policy
 that has a 'base module' with zero or more optional 'loadable modules'.
 
-<br>
 
 ## Policy Functionality Based on Name or Type
 
@@ -95,7 +93,6 @@ The *NAME* and *TYPE* entries are defined in the reference policy
 [**Source Configuration Files**](reference_policy.md#source-configuration-files)
 section.
 
-<br>
 
 ## Custom Policy
 
@@ -121,7 +118,6 @@ classes/permissions (see kernel *Documentation/admin-guide/LSM/SELinux.rst*
 for build instructions, also the
 [**Notebook Sample Policy - README**](./notebook-examples/selinux-policy/README.md)).
 
-<br>
 
 ## Monolithic Policy
 
@@ -137,7 +133,6 @@ The Reference Policy supports building of monolithic policies.
 
 In some cases the kernel policy binary file is also called a monolithic policy.
 
-<br>
 
 ## Loadable Module Policy
 
@@ -171,7 +166,6 @@ into the final [**binary policy**](#policy-versions) for loading into
 the kernel, see
 "[**SELinux Policy Module Primer**](http://securityblog.org/brindle/2006/07/05/selinux-policy-module-primer/)".
 
-<br>
 
 ### Optional Policy
 
@@ -180,7 +174,6 @@ The loadable module policy infrastructure supports an
 allows policy rules to be defined but only enabled in the binary policy once
 the conditions have been satisfied.
 
-<br>
 
 ## Conditional Policy
 
@@ -204,7 +197,6 @@ the state of the boolean value or values. See the
 [**Conditional Policy Statements**](conditional_statements.md#conditional-policy-statements)
 section.
 
-<br>
 
 ## Binary Policy
 
@@ -233,7 +225,6 @@ is supported by Fedora):
 
 */etc/selinux/targeted/policy/policy.32*
 
-<br>
 
 ## Policy Versions
 
@@ -381,7 +372,6 @@ quoted (some SELinux utilities give both version numbers).
 **Table 1: Policy version descriptions**
 
 
-<br>
 
 <!-- %CUTHERE% -->
 
diff --git a/src/users.md b/src/users.md
index 44ffb7b..48ffa36 100644
--- a/src/users.md
+++ b/src/users.md
@@ -25,7 +25,6 @@ the [**Type Enforcement (TE)**](type_enforcement.md#type-enforcement) section.
 Some policies, for example Android, only make use of one user called `u`.
 
 
-<br>
 
 <!-- %CUTHERE% -->
 

