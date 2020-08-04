Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82524C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6420020781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DagEDq2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgHDBfD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBfC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:35:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAEC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:35:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so37044563qkk.7
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZY89rM2rO8pnp20lNV+4n3feqFHQvV+sidSJGkuwYfY=;
        b=DagEDq2I7Ll9FUdqU/cB26G+v9x5h94sRQLSAVHBDkobwdILpwUBHZnrYNGPSXbRDU
         LqdUl+ufLgOcPgIZEQdX9EPnlO27DxMaVS9OSDSPDsdUataVO9+sBoe7tbe/ypuSBTa0
         sL1hGNleJhNn62kdeRij8L86oR7gw5xde9hklFL263a8KIK2yMwqHZ19RcCEHnsssyZo
         jRoU0QUgVN39NlxMJ7NfQVlraiIaWyvgfiE63XwinHt7neoV/oHlNBtzXXx8QRvoTc6N
         iv8apHxWaXwfceoVWBqeOoVbJLkws4rjQEIPwc7PMOgDTvSnr5nWBioFJ6zHZ0Huh5yr
         0BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZY89rM2rO8pnp20lNV+4n3feqFHQvV+sidSJGkuwYfY=;
        b=iLuWegM591dRzNQyiDHaAew7J3glBmx1HO7cPcQmN7Fo81ZQ7KCHr+cLfaqoC1DTfB
         DhVGocvCu6hn08tW4K3/U3ButB8Ca53sgYPucvXZDdvciqQgtkZCddLtEZudfSzYJI55
         YNCvzKMT4kjanqCsKvxrNRtQL43y6vOlxwn8IciyBrHj4VndOHAkBIdAXEYscSE1/mWC
         cxO04sbMo40jRqwy1hjMTn/y+4zpupcGJ36DJbVAbugBVTYCnKaNvnGLzpDAIGT49b92
         jQN5qC1FBruOiQ0Do/mEGwVdZ+R4l+jEE227qVqEsTf9BgCUaXroxBF5O+5lqeA1Gd/J
         LyGA==
X-Gm-Message-State: AOAM532sDKPQYXvH/z2UDe99s2zcbmKmAxcMArsJmhsUnQAmhErzczJS
        rtElnG3+sc18fjmmFWyc40e2erdecIrc
X-Google-Smtp-Source: ABdhPJzJV2ynT8oMzHAs4TG3Ks+HzMDzywFOYjLE0UnSf0VI5FRlHGw8tWEvlqKT4A4L8hTmnIB/Wg==
X-Received: by 2002:a37:614a:: with SMTP id v71mr19237587qkb.31.1596504897396;
        Mon, 03 Aug 2020 18:34:57 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id b23sm20313392qtp.41.2020.08.03.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:56 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 15/18] all: consolidate multiple blank
 lines into one
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:55 -0400
Message-ID: <159650489559.8961.12208306588424867928.stgit@sifl>
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

This has zero impact on the rendered formats, but improves the
consistency of the raw markdown.  Done with the following script:

  for i in *.md; do
    sed -i 'N;/^\n$/D;P;D;' $i
  done

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/apache_support.md              |    5 ----
 src/auditing.md                    |    7 -----
 src/avc_rules.md                   |    6 ----
 src/bounds_rules.md                |    2 -
 src/cil_overview.md                |    2 -
 src/class_permission_statements.md |    5 ----
 src/computing_access_decisions.md  |    1 -
 src/computing_security_contexts.md |   15 -----------
 src/conditional_statements.md      |    3 --
 src/configuration_files.md         |    3 --
 src/constraint_statements.md       |    4 ---
 src/core_components.md             |    5 ----
 src/debug_policy_hints.md          |    4 ---
 src/default_rules.md               |    4 ---
 src/domain_object_transitions.md   |    4 ---
 src/file_labeling_statements.md    |    5 ----
 src/global_config_files.md         |    7 -----
 src/implementing_seaware_apps.md   |    6 ----
 src/infiniband_statements.md       |    3 --
 src/kernel_policy_language.md      |    8 ------
 src/libselinux_functions.md        |    1 -
 src/lsm_selinux.md                 |    9 ------
 src/mac.md                         |    3 --
 src/mls_mcs.md                     |    9 ------
 src/mls_statements.md              |   10 -------
 src/modes.md                       |    2 -
 src/modular_policy_statements.md   |    2 -
 src/network_statements.md          |    4 ---
 src/network_support.md             |    9 ------
 src/object_classes_permissions.md  |   24 -----------------
 src/objects.md                     |    5 ----
 src/pam_login.md                   |    2 -
 src/policy_config_files.md         |   43 -------------------------------
 src/policy_config_statements.md    |    1 -
 src/policy_languages.md            |    1 -
 src/policy_store_config_files.md   |   23 -----------------
 src/policy_validation_example.md   |    1 -
 src/polyinstantiation.md           |    8 ------
 src/rbac.md                        |    2 -
 src/reference_policy.md            |   50 ------------------------------------
 src/role_statements.md             |    6 ----
 src/seandroid.md                   |   18 -------------
 src/security_context.md            |    1 -
 src/selinux_cmds.md                |    2 -
 src/selinux_overview.md            |    2 -
 src/sid_statement.md               |    2 -
 src/subjects.md                    |    3 --
 src/terminology.md                 |    3 --
 src/title.md                       |    1 -
 src/toc.md                         |    1 -
 src/type_enforcement.md            |    4 ---
 src/types_of_policy.md             |   11 --------
 src/users.md                       |    2 -
 src/vm_support.md                  |    2 -
 54 files changed, 366 deletions(-)

diff --git a/src/apache_support.md b/src/apache_support.md
index 6b794c6..8e8df1c 100644
--- a/src/apache_support.md
+++ b/src/apache_support.md
@@ -52,7 +52,6 @@ the LAPP<a href="#fnap1" class="footnote-ref" id="fnaph1"><strong><sup>1</sup></
 The [A secure web application platform powered by SELinux](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf)
 document gives a good overview of the LAPP architecture.
 
-
 ## *mod_selinux* Overview
 
 What the *mod_selinux* module achieves is to allow a web application
@@ -77,7 +76,6 @@ itself, for example:
 3.  The web application exits, handing control back to the web server
     that replies with the HTTP response.
 
-
 ## Bounds Overview
 
 Because multiple threads share the same memory segment, SELinux was
@@ -122,15 +120,12 @@ operation will be denied and an *SELINUX_ERR* entry will be added to
 the audit log stating *op=security_compute_av reason=bounds* with
 the context strings and the denied class and permissions.
 
-
-
 <section class="footnotes">
 <ol>
 <li id="fnap1"><p>This is similar to the LAMP (Linux, Apache, MySQL, PHP/Perl/Python) stack, however MySQL is not SELinux-aware.<a href="#fnaph1" class="footnote-back">↩</a></p></li>
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/auditing.md b/src/auditing.md
index e07429a..56f2a00 100644
--- a/src/auditing.md
+++ b/src/auditing.md
@@ -40,7 +40,6 @@ Notes:
     ***selinux_set_callback**(3)* and specifying an alternative log
     handler.
 
-
 ## AVC Audit Events
 
 **Table 1** describes the general format of AVC audit
@@ -232,7 +231,6 @@ exe="/usr/move_file/move_file_c"
 subj=unconfined_u:unconfined_r:move_file_t key=(null)
 ```
 
-
 ## General SELinux Audit Events
 
 This section shows a selection of non-AVC SELinux-aware services audit
@@ -269,7 +267,6 @@ policyload notice (seqno=2) : exe="/usr/bin/Xorg" sauid=0 hostname=?
 addr=? terminal=?'
 ```
 
-
 Change enforcement mode - *MAC_STATUS* - This was generated when the
 SELinux enforcement mode was changed:
 
@@ -284,7 +281,6 @@ tty=pts0 ses=2 comm="setenforce" exe="/usr/sbin/setenforce"
 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
 ```
 
-
 Change boolean value - *MAC_CONFIG_CHANGE* - This event was generated
 when ***setsebool**(8)* was run to change a boolean. Note that the
 bolean name plus new and old values are shown in the
@@ -319,7 +315,6 @@ exe="/sbin/netlabelctl"
 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
 ```
 
-
 Labeled IPSec - *MAC_IPSEC_EVENT* - Generated when running
 ***setkey**(8)* to load IPSec configuration:
 
@@ -371,7 +366,6 @@ exe="/usr/sbin/httpd" subj=system_u:system_r:httpd_t:s0-s0:c0.c300
 key=(null)
 ```
 
-
 Role changes - *USER_ROLE_CHANGE* - Used ***newrole**(1)* to set a new
 role that was not valid.
 
@@ -385,7 +379,6 @@ new-context=?: exe="/usr/bin/newrole" hostname=? addr=?
 terminal=/dev/pts/0 res=failed'
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/avc_rules.md b/src/avc_rules.md
index c216fc8..7572302 100644
--- a/src/avc_rules.md
+++ b/src/avc_rules.md
@@ -79,7 +79,6 @@ rule_name source_type target_type : class perm_set;
 </tbody>
 </table>
 
-
 ## *allow*
 
 The allow rule checks whether the operations between the source\_type
@@ -139,7 +138,6 @@ allow bootloader_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow files_unconfined_type file_type:{ file chr_file } ~execmod;
 ```
 
-
 ## *dontaudit*
 
 The *dontaudit* rule stops the auditing of denial messages as it is known
@@ -158,7 +156,6 @@ also helps to manage the audit log by excluding known events.
 dontaudit traceroute_t { port_type -port_t }:tcp_socket name_bind;
 ```
 
-
 ## *auditallow*
 
 Audit the event as a record as it is useful for auditing purposes. Note
@@ -175,7 +172,6 @@ to grant permission.
 auditallow ada_t self:process execstack;
 ```
 
-
 ## *neverallow*
 
 This rule specifies that an *allow* rule must not be generated for the
@@ -205,7 +201,6 @@ neverallow ~can_read_shadow_passwords shadow_t:file read;
 neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 ```
 
-
 <section class="footnotes">
 <ol>
 <li id="fna1"><p><code>neverallow</code> statements are allowed in modules, however to detect these the <em>semanage.conf</em> file must have the 'expand-check=1' entry present.<a href="#fnavc1" class="footnote-back">↩</a></p></li>
@@ -213,7 +208,6 @@ neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/bounds_rules.md b/src/bounds_rules.md
index 2949bc2..55a793a 100644
--- a/src/bounds_rules.md
+++ b/src/bounds_rules.md
@@ -12,7 +12,6 @@ NOT enforced by the SELinux kernel services). The
 [**CIL Reference Guide**](notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
 gives details.
 
-
 ## *typebounds*
 
 The *typebounds* rule was added in version 24 of the policy. This
@@ -92,7 +91,6 @@ allow httpd_t etc_t : file { getattr read };
 allow httpd_child_t etc_t : file { read write };
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/cil_overview.md b/src/cil_overview.md
index c3e280f..aa22bff 100644
--- a/src/cil_overview.md
+++ b/src/cil_overview.md
@@ -35,7 +35,6 @@ language perspective it will:
 | *allow* (role)   | *roleallow*        |
 | *dominance*      | *sensitivityorder* |
 
-
 2.  Additional CIL statements have been defined to enhance
     functionality:
 
@@ -147,7 +146,6 @@ declarations with the order in which they are declared in the kernel.
 A module store is created by *semodule* to give easy access to the
 source and that allows for full control over the policy.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/class_permission_statements.md b/src/class_permission_statements.md
index a0a1379..4090fa0 100644
--- a/src/class_permission_statements.md
+++ b/src/class_permission_statements.md
@@ -16,7 +16,6 @@ There are two variants of the *class* statement for writing policy:
     [**Associating Permissions to a Class**](#associating-permissions-to-a-class)
     section.
 
-
 ## *class*
 
 Object classes are declared within a policy with the following statement
@@ -76,7 +75,6 @@ class class_id
 class db_tuple
 ```
 
-
 ### Associating Permissions to a Class
 
 Permissions can be defined within policy in two ways:
@@ -90,7 +88,6 @@ Permissions can be defined within policy in two ways:
 A list of classes and their permissions used by the **Reference Policy**
 can be found in the *./policy/flask/access_vectors* file.
 
-
 ## *common*
 
 Declare a *common* identifier and associate one or more *common* permissions.
@@ -155,7 +152,6 @@ common common_id { perm_set }
 common database { create drop getattr setattr relabelfrom relabelto }
 ```
 
-
 ## *class*
 
 Inherit and / or associate permissions to a perviously declared *class* identifier.
@@ -248,7 +244,6 @@ class db_blob inherits database
 class db_blob inherits database { read write import export }
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/computing_access_decisions.md b/src/computing_access_decisions.md
index ce4cf11..5ab9430 100644
--- a/src/computing_access_decisions.md
+++ b/src/computing_access_decisions.md
@@ -57,7 +57,6 @@ require kernel system call over-heads once set up. Note that these
 functions are only available from *libselinux* 2.0.99, with Linux kernel
 2.6.37 and above.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index 1d7c975..5849375 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -46,7 +46,6 @@ various kernel objects (also see the
 [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
 section.
 
-
 ### Process
 
 The initial task starts with the kernel security context, but the
@@ -73,7 +72,6 @@ Processes inherit their security context as follows:
     practice is generally discouraged - exec-based transitions are
     preferred.
 
-
 ### Files
 
 The default behavior for labeling files (actually inodes that consist of
@@ -111,12 +109,10 @@ SID, which is mapped to a context by the policy. This default may be
 overridden via the *defcontext=* mount option on a per-mount basis as
 described in ***mount**(8)*.
 
-
 ### File Descriptors
 
 Inherits the label of its creator/parent.
 
-
 ### Filesystems
 
 Filesystems are labeled using the appropriate *fs_use* kernel policy
@@ -164,14 +160,12 @@ Notes:
     *context=*, *fscontext=*, *defcontext=* and *rootcontext=*. They are
     fully described in the ***mount**(8)* man page.
 
-
 ### Network File System (nfsv4.2)
 
 If labeled NFS is implemented with *xattr* support, then the creation of
 inodes are treated as described in the [Files](#files)
 section.
 
-
 ### INET Sockets
 
 If a socket is created by the ***socket**(3)* call they are labeled as
@@ -204,12 +198,10 @@ Some sockets may be labeled with the kernel SID to reflect the fact that
 they are kernel-internal sockets that are not directly exposed to
 applications.
 
-
 ### IPC
 
 Inherits the label of its creator/parent.
 
-
 ### Message Queues
 
 Inherits the label of its sending process. However if sending a message
@@ -233,17 +225,14 @@ the message queue it will be stored in as follows:
     with the selected range being low, high or low-high to be defined
     for the message object class).
 
-
 ### Semaphores
 
 Inherits the label of its creator/parent.
 
-
 ### Shared Memory
 
 Inherits the label of its creator/parent.
 
-
 ### Keys
 
 Inherits the label of its creator/parent.
@@ -251,7 +240,6 @@ Inherits the label of its creator/parent.
 Security-aware applications may use ***setkeycreatecon**(3)* to
 explicitly label keys they create if permitted by policy.
 
-
 ## Using libselinux Functions
 
 ### *avc_compute_create* and *security_compute_create*
@@ -349,7 +337,6 @@ new context *newcon* (referenced by SIDs for
 
 **Table 1**
 
-
 ### *avc_compute_member* and *security_compute_member*
 
 **Table 2** shows how the components from the source context,
@@ -424,7 +411,6 @@ the new context *newcon* (referenced by SIDs for
 
 **Table 2**
 
-
 ### *security_compute_relabel*
 
 **Table 3** below shows how the components from the source context,
@@ -502,7 +488,6 @@ following notes also apply:
 
 **Table 3**
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/conditional_statements.md b/src/conditional_statements.md
index 7930b45..3cf07df 100644
--- a/src/conditional_statements.md
+++ b/src/conditional_statements.md
@@ -56,7 +56,6 @@ getsebool -a
 getsebool allow_daemons_use_tty
 ```
 
-
 ## bool
 
 The *bool* statement is used to specify a boolean identifier and its
@@ -134,7 +133,6 @@ bool allow_execheap false;
 bool allow_execstack true;
 ```
 
-
 ### if
 
 The if statement is used to form a 'conditional block' of statements and
@@ -260,7 +258,6 @@ if (read_untrusted_content) {
 }
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/configuration_files.md b/src/configuration_files.md
index 9cb97cd..3515f1b 100644
--- a/src/configuration_files.md
+++ b/src/configuration_files.md
@@ -33,7 +33,6 @@ as follows:
     viewing the currently loaded policy using tools such as
     ***apol**(1)* (e.g. *apol /sys/fs/selinux/policy*).
 
-
 ## The Policy Store
 
 Version 2.7 of *libsemanage*, *libsepol*, and *policycoreutils* had the
@@ -148,7 +147,6 @@ already available, the following message will be given: "*A higher
 priority &lt;name&gt; module exists at priority &lt;999&gt; and will
 override the module currently being installed at priority &lt;111&gt;*".
 
-
 ## Converting policy packages to CIL
 
 A component of the update is to add a facility that converts compiled
@@ -175,7 +173,6 @@ Options:
 -h, --help print this message and exit
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/constraint_statements.md b/src/constraint_statements.md
index 39f441e..4834f6b 100644
--- a/src/constraint_statements.md
+++ b/src/constraint_statements.md
@@ -172,7 +172,6 @@ constrain { dir file lnk_file sock_file fifo_file chr_file blk_file } { create r
 	(u1 == u2 or t1 == can_change_object_identity);
 ```
 
-
 ## *validatetrans*
 
 This statement is used to control the ability to change the objects
@@ -274,7 +273,6 @@ validatetrans class expression;
 validatetrans { file } { t1 == unconfined_t );
 ```
 
-
 ## *mlsconstrain*
 
 The mlsconstrain statement allows further restriction on permissions for
@@ -400,7 +398,6 @@ mlsconstrain dir search
 	( t2 == mlstrustedobject ));
 ```
 
-
 ## *mlsvalidatetrans*
 
 The *mlsvalidatetrans* is the MLS equivalent of the *validatetrans*
@@ -531,7 +528,6 @@ mlsvalidatetrans { dir file lnk_file chr_file blk_file sock_file fifo_file }
 	(( t3 == mlsfiledowngrade ) and ( h1 incomp h2 ))));
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/core_components.md b/src/core_components.md
index 0cc9e65..0bb9058 100644
--- a/src/core_components.md
+++ b/src/core_components.md
@@ -17,7 +17,6 @@ manage enforcement of the policy and comprise of the following:
 5.  An Access Vector Cache (AVC) that improves system performance by
     caching security server decisions.
 
-
 ![](./images/1-core.png)
 
 **Figure 1: High Level Core SELinux Components** - *Decisions by the
@@ -25,12 +24,10 @@ Security Server are cached in the AVC to enhance performance of future
 requests. Note that it is the kernel and userspace Object Managers that
 enforce the policy.*
 
-
 ![](./images/2-high-level-arch.png)
 
 **Figure 2: High Level SELinux Architecture** - *Showing the major supporting services*
 
-
 **Figure 2** shows a more complex diagram of kernel and userspace with a number of
 supporting services that are used to manage the SELinux environment.
 This diagram will be referenced a number of times to explain areas of
@@ -131,7 +128,6 @@ The [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module
 section goes into greater detail of the LSM / SELinux modules with a walk
 through of a ***fork**(2)* and ***exec**(2)* process.
 
-
 <section class="footnotes">
 <ol>
 <li id="fnc1"><p>When SELinux is enabled, the policy can be running in 'permissive mode' (<code>SELINUX=permissive</code>), where all accesses are allowed. The policy
@@ -145,7 +141,6 @@ statement that allows a domain to run in permissive mode while the others are st
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/debug_policy_hints.md b/src/debug_policy_hints.md
index 913a82a..1bdd8f4 100644
--- a/src/debug_policy_hints.md
+++ b/src/debug_policy_hints.md
@@ -2,10 +2,6 @@
 
 I'm sure there is more to add here !!!
 
-
-
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/default_rules.md b/src/default_rules.md
index b6e35d2..92ba272 100644
--- a/src/default_rules.md
+++ b/src/default_rules.md
@@ -79,7 +79,6 @@ default_user file target;
 default_user { x_selection x_property } source;
 ```
 
-
 ## *default_role*
 
 Allows the default role to be taken from the source or target context
@@ -155,7 +154,6 @@ default_role file target;
 default_role { x_selection x_property } source;
 ```
 
-
 ## *default_type*
 
 Allows the default type to be taken from the source or target context
@@ -231,7 +229,6 @@ default_type file target;
 default_type { x_selection x_property } source;
 ```
 
-
 ## *default_range*
 
 Allows the default range or level to be taken from the source or target
@@ -332,7 +329,6 @@ default_type { x_selection x_property } source low_high;
 default_range db_table glblub;
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/domain_object_transitions.md b/src/domain_object_transitions.md
index c7e74e0..030d866 100644
--- a/src/domain_object_transitions.md
+++ b/src/domain_object_transitions.md
@@ -8,7 +8,6 @@ This section discusses the *type_transition* statement that is used to:
 These transitions can also be achieved using the **libselinux** API
 functions for SELinux-aware applications.
 
-
 ## Domain Transition
 
 A domain transition is where a process in one domain starts a new
@@ -98,7 +97,6 @@ SELinux enabled kernel.
 within the *unconfined_t* domain and then transitioned to the *ext_gateway_t*
 domain.*
 
-
 ### Type Enforcement Rules
 
 When building the *ext_gateway.conf* and *int_gateway.conf* modules the
@@ -221,7 +219,6 @@ Other ways to resolve this issue are:
 It was decided to use runcon as it demonstrates the command usage better
 than reading the man pages.
 
-
 ## Object Transition
 
 An object transition is where a new object requires a different label to
@@ -295,7 +292,6 @@ drwxr-xr-x root root system_u:object_r:unconfined_t ..
 -rw-r--r-- root root unconfined_u:object_r:in_file_t Message-2
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/file_labeling_statements.md b/src/file_labeling_statements.md
index b28c1ff..34c2ca8 100644
--- a/src/file_labeling_statements.md
+++ b/src/file_labeling_statements.md
@@ -12,7 +12,6 @@ therefore if the policy supports MCS / MLS, then an *mls_range* is
 required as described in the
 [**MLS range Definition**](mls_statements.md#mls-range-definition) section.
 
-
 ## *fs_use_xattr*
 
 The *fs_use_xattr* statement is used to allocate a security context to
@@ -86,7 +85,6 @@ fs_use_xattr ext2 system_u:object_r:fs_t:s0;
 fs_use_xattr ext3 system_u:object_r:fs_t:s0;
 ```
 
-
 ## *fs_use_task*
 
 The *fs_use_task* statement is used to allocate a security context to
@@ -158,7 +156,6 @@ fs_use_task pipefs system_u:object_r:fs_t:s0;
 fs_use_task sockfs system_u:object_r:fs_t:s0;
 ```
 
-
 ## *fs_use_trans*
 
 The *fs_use_trans* statement is used to allocate a security context to
@@ -230,7 +227,6 @@ fs_use_trans tmpfs system_u:object_r:tmpfs_t:s0;
 fs_use_trans devpts system_u:object_r:devpts_t:s0;
 ```
 
-
 ## *genfscon*
 
 The *genfscon* statement is used to allocate a security context to
@@ -323,7 +319,6 @@ genfscon proc /fs/openafs system_u:object_r:proc_afs_t:s0
 genfscon proc /kmsg system_u:object_r:proc_kmsg_t:s15:c0.c255
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/global_config_files.md b/src/global_config_files.md
index 682b0fb..80e557b 100644
--- a/src/global_config_files.md
+++ b/src/global_config_files.md
@@ -9,7 +9,6 @@ important files are:
 -   */etc/selinux/semanage.conf* - This is used by the SELinux policy
     configuration subsystem for modular or CIL policies.
 
-
 ## */etc/selinux/config*
 
 If this file is missing or corrupt no SELinux policy will be loaded
@@ -82,7 +81,6 @@ SELINUX=permissive
 SELINUXTYPE=targeted
 ```
 
-
 ## */etc/selinux/semanage.conf*
 
 The ***semanage.config**(5)* file controls the configuration and actions
@@ -273,7 +271,6 @@ args = $@
 [end]
 ```
 
-
 ## */etc/selinux/restorecond.conf*
 ## *restorecond-user.conf*
 
@@ -316,13 +313,11 @@ directories).
 ~/public_html/*
 ```
 
-
 ## */etc/selinux/newrole_pam.conf*
 
 The optional *newrole\_pam.conf* file is used by ***newrole**(1)* and
 maps commands to ***PAM**(8)* service names.
 
-
 ## */etc/sestatus.conf*
 
 The ***sestatus.conf**(5)* file is used by the ***sestatus**(8)* command to
@@ -362,7 +357,6 @@ List of processes to display context
 /usr/sbin/sshd
 ```
 
-
 ## */etc/security/sepermit.conf*
 
 The ***sepermit.conf**(5)* file is used by the *pam_sepermit.so* module
@@ -407,7 +401,6 @@ example that describes the configuration:
 xguest:exclusive
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index 1aa1f90..13020c9 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -36,7 +36,6 @@ SELinux-aware applications do not (they rely on 'Object Managers' to do
 this e.g. the kernel based Object Managers such as those that manage
 filesystem, IPC and network labeling).
 
-
 ## Implementing SELinux-aware Applications
 
 This section puts forward various points that may be useful when
@@ -95,7 +94,6 @@ developing SELinux-aware applications and object managers using
     explained at:
 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=12b29f34558b9b45a2c6eabd4f3c6be939a3980f>
 
-
 ## Implementing Object Managers
 
 To implement object managers for applications, an understanding of the
@@ -155,7 +153,6 @@ classes/permissions.
     the [**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf), and for reference, the SE-PostgreSQL service also implements a similar
     interface.
 
-
 ## Reference Policy Changes
 
 When adding a new object manager to SELinux, it will require at least a
@@ -208,7 +205,6 @@ not require modification, and supplying the module files (*\*.te*,
 ## </required>
 ```
 
-
 ## Adding New Object Classes and Permissions
 
 Because userspace object managers do not require their new classes and
@@ -286,7 +282,6 @@ dynamic class/perm discovery:
     by the kernel. Then add allow rules as appropriate to the policy for
     the new permissions.
 
-
 <section class="footnotes">
 <ol>
 <li id="fni1"><p>The SELinux security server does not enforce a decision, it merely
@@ -298,7 +293,6 @@ applied to their objects as defined by policy.<a href="#fnisa1" class="footnote-
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/infiniband_statements.md b/src/infiniband_statements.md
index 2cb1529..492bdb6 100644
--- a/src/infiniband_statements.md
+++ b/src/infiniband_statements.md
@@ -8,7 +8,6 @@ overview of the SELinux IB implementation can be found at:
 
 Note that there are no terminating semi-colons ';' on these statements.
 
-
 ## *ibpkeycon*
 
 The *ibpkeycon* statement is used to label IB partition keys.
@@ -97,7 +96,6 @@ in the default *<SELINUXTYPE>* policy store and then activate the policy:
 ibpkeycon fe80:: 0xFFFF system_u:object_r:default_ibpkey_t:s0
 ```
 
-
 ## *ibendportcon*
 
 The *ibendportcon* statement is used to label IB end ports.
@@ -186,7 +184,6 @@ This command will produce the following file
 ibendportcon mlx4_0 2 system_u:object_r:opensm_ibendport_t:s0
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index e45311d..eba0564 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -33,7 +33,6 @@ extension. These files are compiled using the ***checkmodule**(8)* command.
 appear in source files with the mandatory statements that must be
 present.
 
-
 <table>
 <tbody>
 <tr style="background-color:#D3D3D3;">
@@ -205,7 +204,6 @@ Where:
 **Table 3** shows a cross reference matrix of statements
 and rules allowed in each type of policy source file.
 
-
 ## Conditional, Optional and Require Statement Rules
 
 The language grammar specifies what statements and rules can be included
@@ -260,7 +258,6 @@ Where:
 **Table 3** shows a cross reference matrix of statements
 and rules allowed in each of the above policy statements.
 
-
 ## MLS Statements and Optional MLS Components
 
 The [**MLS Statements**](mls_statements.md#mls-statements) section defines
@@ -270,7 +267,6 @@ context as an argument, (for example the
 [**Network Labeling Statements**](network_statements.md#network-labeling-statements)),
 therefore these statements show an example taken from the MLS **Reference Policy** build.
 
-
 ## General Statement Information
 
 1.  Identifiers can generally be any length but should be restricted to
@@ -480,7 +476,6 @@ same).
 
 **Table 2: Policy language reserved words**
 
-
 **Table 3** shows what policy language statements and rules are allowed
 within each type of policy source file, and whether the statement is valid
 within an *if/else* construct, *optional {rule_list}*, or
@@ -948,7 +943,6 @@ policy source file. The right hand side of the table shows whether the
 statement is valid within the *if/else* construct, *optional {rule_list}*,
 or *require {rule_list}* statement.*
 
-
 ## Section Contents
 
 The policy language statement and rule sections are as follows:
@@ -975,7 +969,6 @@ Note these are not kernel policy statements, but used by the Reference Policy
 to assist policy build:
 -   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 
-
 <section class="footnotes">
 <ol>
 <li id="fn1"><p>It is important to note that the <strong>Reference Policy</strong> builds policy using makefiles and m4 support macros within its own source file structure. However, the end result of the make process is that there can be three possible types of source file built (depending on the <strong>MONOLITHIC=Y/N</strong> build option). These files contain the policy language statements and rules that are finally complied into a binary policy.<a href="#fnker1" class="footnote-back">↩</a></p></li>
@@ -986,7 +979,6 @@ to assist policy build:
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/libselinux_functions.md b/src/libselinux_functions.md
index 34f9a06..9cae37a 100644
--- a/src/libselinux_functions.md
+++ b/src/libselinux_functions.md
@@ -1093,7 +1093,6 @@ The appropriate ***man**(3)* pages should consulted for detailed usage.
 </tbody>
 </table>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index 9c2aac4..e426f28 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -15,7 +15,6 @@ the SELinux kernel source code). The major areas covered are:
 4.  The SELinux filesystem */sys/fs/selinux*.
 5.  The */proc* filesystem area most applicable to SELinux.
 
-
 ## The LSM Module
 
 The LSM is the Linux security framework that allows 3<sup>rd</sup> party
@@ -95,7 +94,6 @@ inserted security hooks and structures to allow access control to be
 managed by 3<sup>rd</sup> party modules (see
 ./linux-3.14/include/linux/security.h).*
 
-
 | ***/proc/self/attr/*** **Permissions** |  **File Name**|     **Function**                              |
 | ------------ | ------------ | ------------------------------------------------------------------------ |
 | *current*    | *-rw-rw-rw-* | Contains the current process security context.                           |
@@ -149,7 +147,6 @@ hooks and structures.
 
 **Table 3:** *The core LSM source modules.*
 
-
 ## The SELinux Module
 
 This section does not go into detail of all the SELinux module
@@ -274,7 +271,6 @@ to see how some of these kernel source modules fit together.
 **Table 4: The core SELinux source modules** - *The .h files and those in
 the include directory have a number of useful comments.*
 
-
 ### Fork System Call Walk-thorough
 
 This section walks through the the ***fork**(2)* system call shown in
@@ -339,7 +335,6 @@ is valid):
 required to check access permissions for Object Class *process* and
 permission *fork*.*
 
-
 ### Process Transition Walk-thorough
 
 This section walks through the ***execve**(2)* and checking whether a
@@ -459,14 +454,12 @@ computed. This function will (assuming there are no errors):
 check if a transition is allowed from the *unconfined_t* domain to the
 *ext_gateway_t* domain.*
 
-
 ![](./images/12-lsm-selinux-arch.png)
 
 **Figure 12: The Main LSM / SELinux Modules** - *The fork and exec functions
 link to [**Figure 7**](domain_object_transitions.md#domain-transition)
 where the transition process is described.*
 
-
 #### SELinux Filesystem
 
 **Table 6: SELinux filesystem Information** shows the information contained
@@ -738,8 +731,6 @@ Notes:
     */proc/&lt;self|pid&gt;/task/&lt;tid&gt;/attr/&lt;attr&gt;*
     interfaces.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/mac.md b/src/mac.md
index 5c746f2..7b88c24 100644
--- a/src/mac.md
+++ b/src/mac.md
@@ -29,7 +29,6 @@ chain for DAC and MAC are shown in **Figure 3**.
 **Figure 3: Processing a System Call** - *The DAC checks are carried out
 first, if they pass then the Security Server is consulted for a decision.*
 
-
 SELinux supports two forms of MAC:
 
 **Type Enforcement** - Where processes run in domains and the actions on
@@ -61,8 +60,6 @@ application separation, for example SELinux enabled:
     by the same app running on behalf of another user (see the
     [**Security Enhancements for Android - Computing a Context**](seandroid.md#computing-process-context-examples) section).
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/mls_mcs.md b/src/mls_mcs.md
index 862196b..4b4c15c 100644
--- a/src/mls_mcs.md
+++ b/src/mls_mcs.md
@@ -111,7 +111,6 @@ The format used in the policy language statements is fully described in
 the [MLS Statements](mls_statements.md#mls-statements) section, however
 a brief overview follows.
 
-
 #### MLS / MCS Range Format
 
 The following components (shown in bold) are used to define the MLS /
@@ -145,7 +144,6 @@ user:role:type:sensitivity[:category,...]  -  sensitivity [:category,...]
 </tbody>
 </table>
 
-
 #### Translating Levels
 
 When writing policy for MLS / MCS security level components it is usual
@@ -161,7 +159,6 @@ command can be used to set up this translation and is shown in the
 [**setrans.conf**](policy_config_files.md#setrans.conf) configuration file
 section.
 
-
 ### Managing Security Levels via Dominance Rules
 
 As stated earlier, allowing a process access to an object is managed by
@@ -279,12 +276,10 @@ the *mlsconstrain* statement as illustrated in
 **Table 2: MLS Security Levels** - *Showing the scope of a process running
 at a security range of *s0 - s3:c1.c5*.*
 
-
 ![](./images/9-mls-constrain.png)
 
 **Figure 9: Showing the mlsconstrain Statements controlling Read Down & Write Up** - *This ties in with* **Table 2: MLS Security Levels** *that shows a process running with a security range of s0 - s3:c1.c5.*
 
-
 Using **Figure 9: *mlsconstrain* Statements controlling Read Down & Write Up**:
 
 1.  To allow write-up, the source level (l1) must be **dominated by**
@@ -309,7 +304,6 @@ read-down. The default is to use l1 eq l2 (i.e. the levels are equal).
 The reference policy MLS source file (policy/mls) shows these
 *mlsconstrain* statements.
 
-
 ### MLS Labeled Network and Database Support
 
 Networking for MLS is supported via the NetLabel CIPSO (commercial IP
@@ -322,7 +316,6 @@ PostgreSQL supports labeling for MLS database services as discussed in
 the [**SE-PostgreSQL Support**](postgresql.md#postgresql-selinux-support)
 section.
 
-
 ### Common Criteria Certification
 
 While the [*Common Criteria*](http://www.commoncriteriaportal.org/)
@@ -353,8 +346,6 @@ An interesting point:
     look at the protection profiles as they define what was actually
     evaluated.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/mls_statements.md b/src/mls_statements.md
index c2bb4f3..f61ced6 100644
--- a/src/mls_statements.md
+++ b/src/mls_statements.md
@@ -63,13 +63,11 @@ the circumstances, there can be one level defined or a
 **Table 1: Sensitivity and Category = Security Level** - *this table shows
 the meanings depending on the context being discussed.*
 
-
 To make the security levels more meaningful, it is possible to use the
 setransd daemon to translate these to human readable formats. The
 **semanage**(8) command will allow this mapping to be defined as discussed
 in the [**setrans.conf**](policy_config_files.md#setrans.conf) section.
 
-
 #### MLS range Definition
 
 The MLS range is appended to a number of statements and defines the lowest and
@@ -102,7 +100,6 @@ low_level [ - high_level ]
 </tbody>
 </table>
 
-
 ## *sensitivity*
 
 The sensitivity statement defines the MLS policy sensitivity identifies
@@ -182,7 +179,6 @@ sensitivity s15;
 sensitivity s0 alias secret wellmaybe ornot;
 ```
 
-
 ## *dominance*
 
 When more than one [*sensitivity*](#sensitivity)
@@ -246,7 +242,6 @@ The statement is valid in:
 dominance { s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 }
 ```
 
-
 ## *category*
 
 The *category* statement defines the MLS policy category
@@ -326,7 +321,6 @@ category c255;
 category c0 alias planning development benefits;
 ```
 
-
 ## *level*
 
 The *level* statement enables the previously declared sensitivity and
@@ -401,7 +395,6 @@ level s0:c0.c255;
 level s15:c0.c255;
 ```
 
-
 ## *range_transition*
 
 The *range_transition* statement is primarily used by the init process or
@@ -493,21 +486,18 @@ range_transition initrc_t auditd_exec_t:process s15:c0.c255;
 range_transition initrc_t cupsd_exec_t:process s15:c0.c255;
 ```
 
-
 ## *mlsconstrain*
 
 This is decribed in the
 [**Constraint Statements - *mlsconstrain***](constraint_statements.md#mlsconstrain)
 section.
 
-
 ## *mlsvalidatetrans*
 
 This is decribed in the
 [**Constraint Statements - *mlsvalidatetrans***](constraint_statements.md#mlsvalidatetrans)
 section.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/modes.md b/src/modes.md
index 2b23353..344b72f 100644
--- a/src/modes.md
+++ b/src/modes.md
@@ -42,8 +42,6 @@ The ***sestatus**(8)* command will show the current SELinux
 enforcement mode in its output, however it does not display individual
 domain or object manager enforcement modes.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index 5efe604..e829e32 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -3,7 +3,6 @@
 This section contains statements used to support policy modules. They are
 not part of the kernel policy language.
 
-
 ## *module*
 
 This statement is mandatory for loadable modules (non-base) and must be
@@ -269,7 +268,6 @@ optional {
 } # end optional
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/network_statements.md b/src/network_statements.md
index 171790d..a625c26 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -82,7 +82,6 @@ Or
 ::
 ```
 
-
 ## *netifcon*
 
 The *netifcon* statement is used to label network interface objects (e.g.
@@ -178,7 +177,6 @@ netifcon eth2 system_u:object_r:netif_t:s0
 system_u:object_r:netif_t:s0
 ```
 
-
 ## *nodecon*
 
 The *nodecon* statement is used to label network address objects for peer
@@ -280,7 +278,6 @@ This command will produce the following file in the default
 nodecon ipv4 127.0.0.2 255.255.255.255 system_u:object_r:node_t:s0
 ```
 
-
 ## *portcon*
 
 The *portcon* statement is used to label udp, tcp, dccp or sctp ports.
@@ -375,7 +372,6 @@ This command will produce the following file in the default
 portcon udp 1234 system_u:object_r:reserved_port_t:s0
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/network_support.md b/src/network_support.md
index b519fb7..62f87f2 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -69,7 +69,6 @@ the inode associated to the socket and not from the actual kernel socket
 structure (as currently there is no standard kernel/userspace interface
 to achieve this).
 
-
 ## SECMARK
 
 SECMARK makes use of the standard kernel NetFilter framework that
@@ -181,8 +180,6 @@ The following articles explain the SECMARK service:
 -   [*Transitioning to Secmark*](http://paulmoore.livejournal.com/4281.html)
 -   [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
 
-
-
 ## NetLabel - Fallback Peer Labeling
 
 Fallback labeling can optionally be implemented on a system if the
@@ -204,7 +201,6 @@ the policy capability *network_peer_controls* being set to 0 and 1.
 **Figure 14: Fallback Labeling** - *Showing the differences between the
 policy capability ***network_peer_controls*** set to 0 and 1.*
 
-
 The *selinux-testsuite inet_socket* and *sctp* tests have examples of
 fallback labeling, and the following are a set of ***netlabelctl**(8)*
 commands from the *sctp* test:
@@ -221,7 +217,6 @@ netlabelctl -p map list
 Note that the security contexts must be valid in the policy otherwise the
 commands will fail.
 
-
 ## NetLabel – CIPSO/CALIPSO
 
 To allow MLS [**security levels**](mls_mcs.md#security-levels) to be passed
@@ -291,7 +286,6 @@ netlabelctl -p map list
 The examples use the *nb_client*/*nb_server* from the Notebook examples
 section, plus the standard Fedora 'targeted' policy for the tests.
 
-
 ## Labeled IPSec
 
 Labeled IPSec has been built into the standard GNU / Linux IPSec
@@ -437,7 +431,6 @@ article and a good reference covering **Basic Labeled IPsec Configuration**
 available at:
 <http://www.redhat.com/archives/redhat-lspp/2006-November/msg00051.html>
 
-
 ## Labeled Network FileSystem (NFS)
 
 Version 4.2 of NFS supports labeling between client/server and requires
@@ -458,7 +451,6 @@ Labeled NFS clients must use a consistent security policy.
 
 The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 
-
 <section class="footnotes">
 <ol>
 <li id="fnn1"><p>For example, an ftp session where the server is listening on a specific port (the destination port) but the client will be assigned a random source port. The CONNSECMARK will ensure that all packets for the ftp session are marked with the same label.<a href="#fnnet1" class="footnote-back">↩</a></p></li>
@@ -467,7 +459,6 @@ The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 </ol>
 </section>
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index 7337ef0..c07027f 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -69,7 +69,6 @@ Language, and the
 [**CIL Reference Guide**](./notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
 specifies the CIL Policy Language.
 
-
 # Kernel Object Classes and Permissions
 
 ## Common Permissions
@@ -345,7 +344,6 @@ inherited by a number of object classes.
 </tbody>
 </table>
 
-
 ### Common Capability Permissions
 
 <table>
@@ -575,7 +573,6 @@ explains the objects, their permissions and how they should be used in detail.
 </tbody>
 </table>
 
-
 ### Common X_Device Permissions
 
 The following table describes the common *x_device* permissions that are
@@ -666,7 +663,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-
 ## File Object Classes
 
 ### *filesystem*
@@ -906,7 +902,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-
 ## Network Object Classes
 
 ### *node*
@@ -1131,7 +1126,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-
 ## IPSec Network Object Classes
 
 ### *association*
@@ -1211,7 +1205,6 @@ inherited by the X-Windows *x_keyboard* and *x_pointer* object classes.
 </tbody>
 </table>
 
-
 ## Netlink Object Classes
 
 Netlink sockets communicate between userspace and the kernel – also see
@@ -1611,7 +1604,6 @@ Netlink sockets communicate between userspace and the kernel – also see
 </tbody>
 </table>
 
-
 ## Miscellaneous Network Object Classes
 
 ### *peer*
@@ -1714,7 +1706,6 @@ Netlink sockets communicate between userspace and the kernel – also see
 </tbody>
 </table>
 
-
 ## Sockets via *extended_socket_class*
 
 These socket classes that were introduced by the
@@ -1901,7 +1892,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-
 ## BPF Object Class
 
 ### *bpf*
@@ -1939,7 +1929,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-
 ## Performance Event Object Class
 
 ### *perf_event*
@@ -1981,7 +1970,6 @@ These socket classes that were introduced by the
 </tbody>
 </table>
 
-
 ## Lockdown Object Class
 
 Note: If the *lockdown* LSM is enabled alongside SELinux, then the
@@ -2011,7 +1999,6 @@ implementation.
 </tbody>
 </table>
 
-
 ## IPC Object Classes
 
 ### *ipc* (Deprecated)
@@ -2121,7 +2108,6 @@ implementation.
 </tbody>
 </table>
 
-
 ## Process Object Class
 
 ### *process*
@@ -2286,7 +2272,6 @@ implementation.
 </tbody>
 </table>
 
-
 ## Security Object Class
 
 ### *security*
@@ -2356,7 +2341,6 @@ implementation.
 </tbody>
 </table>
 
-
 ## System Operation Object Class
 
 Note that while this is defined as a kernel object class, the userspace
@@ -2442,7 +2426,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-
 ## Miscellaneous Kernel Object Classes
 
 ### *kernel_service*
@@ -2562,7 +2545,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-
 ## Capability Object Classes
 
 ### *capability*
@@ -2641,7 +2623,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-
 ## InfiniBand Object Classes
 
 ### *infiniband_pkey*
@@ -2682,7 +2663,6 @@ Note that while this is defined as a kernel object class, the userspace
 </tbody>
 </table>
 
-
 **Userspace** Object Classes
 =============================
 
@@ -3321,7 +3301,6 @@ These are userspace objects managed by XSELinux.
 </tbody>
 </table>
 
-
 ## Database Object Classes
 
 These are userspace objects - The PostgreSQL database supports these
@@ -3652,7 +3631,6 @@ explains the objects, their permissions and how they should be used in detail.
 </tbody>
 </table>
 
-
 ## Miscellaneous Userspace Object Classes
 
 ### *passwd*
@@ -3865,8 +3843,6 @@ explains the objects, their permissions and how they should be used in detail.
 </tbody>
 </table>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/objects.md b/src/objects.md
index 9dff3fa..09c77f3 100644
--- a/src/objects.md
+++ b/src/objects.md
@@ -91,7 +91,6 @@ Where:
 </tbody>
 </table>
 
-
 ![](./images/6-allow-rule.png)
 
 **Figure 6: The *allow* rule** - *Showing that the subject (the processes
@@ -186,7 +185,6 @@ security.selinux="unconfined_u:object_r:user_home:s0
 # (or label) held for the file is displayed.
 ```
 
-
 #### Copying and Moving Files
 
 Assuming that the correct permissions have been granted by the policy,
@@ -321,7 +319,6 @@ process itself should clear or shred the information before releasing
 the object (which can be difficult in some cases unless the source code
 is available).
 
-
 <section class="footnotes">
 <ol>
 <li id="fno1"><p>These file systems store the security context in an attribute
@@ -330,8 +327,6 @@ associated with the file.<a href="#fnobj1" class="footnote-back">↩</a></p></li
 </ol>
 </section>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/pam_login.md b/src/pam_login.md
index 02878ab..08e1599 100644
--- a/src/pam_login.md
+++ b/src/pam_login.md
@@ -111,8 +111,6 @@ perform the following functions:
 -   ***pam_selinux.so close*** - This will reset the login programs context
     to the context defined in the policy.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 408d06d..b6ae69c 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -31,7 +31,6 @@ additional two files are required:
     SELinux.
 -   *./context/x_contexts* - To allow the X-Windows service to run under SELinux.
 
-
 ## *seusers*
 
 The ***seusers**(5)* file is used by login programs (normally via the
@@ -76,7 +75,6 @@ __default__:user_u:s0-s0
 -   ***getseuser**(3)*
 -   ***getseuserbyname**(3)*
 
-
 ## *booleans*
 ## *booleans.local*
 
@@ -125,7 +123,6 @@ Note that if *SETLOCALDEFS* is set in the SELinux
 in the ***selinux_booleans_path**(3)*, and also a *local.users* file
 in the ***selinux_users_path**(3)*.
 
-
 ## *booleans.subs_dist*
 
 The *booleans.subs_dist* file (if present) will allow new boolean names
@@ -171,7 +168,6 @@ Supporting libselinux API functions are:
 -   ***security_get_boolean_names**(3)*
 -   ***security_set_boolean**(3)*
 
-
 ## setrans.conf
 
 The ***setrans.conf**(8)* file is used by the ***mcstransd**(8)* daemon
@@ -230,7 +226,6 @@ Supporting libselinux API functions are:
 -   ***selinux_raw_to_trans_context**(3)*
 -   ***selinux_trans_to_raw_context**(3)*
 
-
 ## *secolor.conf*
 
 The **secolor.conf**(5) file controls the colour to be associated to the
@@ -322,7 +317,6 @@ user : role : type : range
 black white white black tan orange black green
 ```
 
-
 ## *policy/policy.&lt;ver&gt;*
 
 This is the binary policy file that is loaded into the kernel to enforce
@@ -338,7 +332,6 @@ discussed in the
 [**Types of SELinux Policy - Policy Versions**](types_of_policy.md#policy-versions)
 section.
 
-
 ## *contexts/customizable_types*
 
 The ***customizable_types**(5)* file contains a list of types that will
@@ -380,7 +373,6 @@ sysadm_untrusted_content_tmp_t
 -   ***selinux_customizable_types_path**(3)*
 -   ***selinux_context_path**(3)*
 
-
 ## *contexts/default_contexts*
 
 The ***default_contexts**(5)* file is used by SELinux-aware applications
@@ -442,7 +434,6 @@ these functions.
 -   ***query_user_context**(3)*
 -   ***manual_user_enter_context**(3)*
 
-
 An example use in this Notebook (to get over a small feature) is that
 when the initial **basic policy** was built, no default_contexts file
 entries were required as only one *role:type* of *unconfined_r:unconfined_t*
@@ -470,7 +461,6 @@ The login process could now set the context correctly to
 *contexts/users/unconfined_u* configuration file instead could also have
 achieved this.
 
-
 ## *contexts/dbus_contexts*
 
 This file is for the dbus messaging service daemon (a form of IPC) that
@@ -497,7 +487,6 @@ information at:
 
 -   ***selinux_context_path**(3)*
 
-
 ## *contexts/default_type*
 
 The **default_type**(5) file allows SELinux-aware applications such as
@@ -536,7 +525,6 @@ user_r:user_t
 -   ***selinux_default_type_path**(3)*
 -   ***get_default_type**(3)*
 
-
 ## *contexts/failsafe_context*
 
 The **failsafe_context**(5) is used when a login process cannot
@@ -579,7 +567,6 @@ sysadm_r:sysadm_t:s0
 -   ***get_ordered_context_list**(3)*
 -   ***get_ordered_context_list_with_level**(3)*
 
-
 ## *contexts/initrc_context*
 
 This is used by the ***run_init**(8)* command to allow system services to
@@ -605,7 +592,6 @@ user:role:type[:range]
 
 **Example file contents:**
 
-
 ```
 # Taken from the MLS policy
 # Note that the init process has full access via the range s0-s15:c0.c255.
@@ -617,7 +603,6 @@ system_u:system_r:initrc_t:s0-s15:c0.c255
 
 -   ***selinux_context_path**(3)*
 
-
 ## *contexts/lxc_contexts*
 
 This file supports labeling lxc containers within the *libvirt* library
@@ -672,7 +657,6 @@ sandbox_lxc_process = "system_u:system_r:container_t:s0"
 -   ***selinux_context_path**(3)*
 -   ***selinux_lxc_context_path**(3)*
 
-
 ## *contexts/netfilter_contexts* - Obsolete
 
 This file was to support the Secmark labeling for Netfilter / iptable rule
@@ -683,30 +667,25 @@ matching of network packets - Never been used.
 -   ***selinux_context_path**(3)*
 -   ***selinux_netfilter_context_path**(3)*
 
-
 ## *contexts/openrc_contexts*
 
 **To be determined**
 
 **The file format is as follows:**
 
-
 **Example file contents:**
 
-
 **Supporting libselinux API functions are:**
 
 -   ***selinux_context_path**(3)*
 -   ***selinux_openrc_contexts_path**(3)*
 
-
 ## *contexts/openssh_contexts*
 
 **To be determined**
 
 **The file format is as follows:**
 
-
 **Example file contents:**
 
 ```
@@ -718,7 +697,6 @@ privsep_preauth=sshd_net_t
 -   ***selinux_context_path**(3)*
 -   ***selinux_openssh_contexts_path**(3)*
 
-
 ## *contexts/removable_context*
 
 The **removable_context**(5) file contains a single default label that
@@ -752,7 +730,6 @@ system_u:object_r:removable_t:s0
 
 -   ***selinux_removable_context_path**(3)*
 
-
 ## *contexts/sepgsql_contexts*
 
 This file contains the default security contexts for SE-PostgreSQL
@@ -784,7 +761,6 @@ object_type object_name context
 </tbody>
 </table>
 
-
 **Example file contents:**
 
 ```
@@ -794,14 +770,12 @@ db_database        *        system_u:object_r:sepgsql_db_t:s0
 db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 ```
 
-
 ## *contexts/snapperd_contexts*
 
 **To be determined**
 
 **The file format is as follows:**
 
-
 **Example file contents:**
 
 ```
@@ -813,7 +787,6 @@ snapperd_data = system_u:object_r:snapperd_data_t:s0
 -   ***selinux_context_path**(3)*
 -   ***selinux_snapperd_contexts_path**(3)*
 
-
 ## *contexts/securetty_types*
 
 The ***securetty_types**(5)* file is used by the ***newrole**(1)* command
@@ -848,7 +821,6 @@ staff_tty_device_t
 
 -   ***selinux_securetty_types_path**(3)*
 
-
 ## *contexts/systemd_contexts*
 
 This file contains security contexts to be used by tasks run via ***systemd**(8)*.
@@ -885,7 +857,6 @@ runtime=system_u:object_r:systemd_runtime_unit_file_t:s0
 -   ***selinux_context_path**(3)*
 -   ***selinux_systemd_contexts_path**(3)*
 
-
 ## *contexts/userhelper_context*
 
 This file contains the default security context used by the
@@ -918,7 +889,6 @@ system_u:sysadm_r:sysadm_t:s0
 
 -   ***selinux_context_path**(3)*
 
-
 ## *contexts/virtual_domain_context*
 
 The ***virtual_domain_context**(5)* file is used by the virtulization
@@ -938,7 +908,6 @@ system_u:system_r:svirt_tcg_t:s0
 
 -   ***selinux_virtual_domain_context_path**(3)*
 
-
 ## *contexts/virtual_image_context*
 
 The ***virtual_image_context**(5)* file is used by the virtulization API
@@ -958,7 +927,6 @@ system_u:object_r:virt_content_t:s0
 
 -   ***selinux_virtual_image_context_path**(3)*
 
-
 ## *contexts/x_contexts*
 
 The ***x_contexts**(5)* file provides the default security contexts for
@@ -1002,7 +970,6 @@ selection      PRIMARY	   system_u:object_r:clipboard_xselection_t:s0
 -   ***selabel_lookup**(3)*
 -   ***selabel_stats**(3)*
 
-
 ## *contexts/files/file_contexts*
 
 The ***file_contexts**(5)* file is managed by the ***semodule**(8)* and
@@ -1035,7 +1002,6 @@ compatible regular expression (PCRE) internal format.
 -   ***selabel_lookup**(3)*
 -   ***selabel_stats**(3)*
 
-
 ## *contexts/files/file_contexts.local*
 
 This file is added by the ***semanage fcontext*** command as described in the
@@ -1047,7 +1013,6 @@ file section to allow locally defined files to be labeled correctly. The
 
 -   ***selinux_file_context_local_path**(3)*
 
-
 ## *contexts/files/file_contexts.homedirs*
 
 This file is managed by the ***semodule**(8)* and ***semanage**(8)* commands
@@ -1072,7 +1037,6 @@ Perl compatible regular expression (PCRE) internal format.
 -   ***selinux_file_context_homedir_path**(3)*
 -   ***selinux_homedir_context_path**(3)*
 
-
 ## contexts/files/file_contexts.subs
 ## contexts/files/file_contexts.subs_dist
 
@@ -1104,7 +1068,6 @@ with */var/www*, with the final result being:
 -   ***matchpathcon**(3)* (deprecated)
 -   ***matchpathcon_index**(3)* (deprecated)
 
-
 ## *contexts/files/media*
 
 The **media**(5)* file is used to map media types to a file context. If
@@ -1145,7 +1108,6 @@ disk system_u:object_r:fixed_disk_device_t:s0
 
 -   ***selinux_media_context_path**(3)*
 
-
 ## *contexts/users/[seuser_id]*
 
 These optional files are named after the SELinux user they represent.
@@ -1183,7 +1145,6 @@ system_r:init_t:s0		unconfined_r:unconfined_t:s0
 -   ***get_ordered_context_list**(3)*
 -   ***get_ordered_context_list_with_level**(3)*
 
-
 ## *logins/&lt;linuxuser_id&gt;*
 
 These optional files are used by SELinux-aware login applications such
@@ -1238,7 +1199,6 @@ another_service:unconfined_u:s0
 
 -   ***getseuser**(3)*
 
-
 ## users/local.users
 
 **NOTE: These were removed in libselinux 3.0**
@@ -1258,15 +1218,12 @@ Note that if *SETLOCALDEFS* is set in the SELinux
 in the ***selinux_booleans_path**(3)*, and also a *local.users* file
 in the ***selinux_users_path**(3)*.
 
-
 <section class="footnotes">
 <ol>
 <li id="fnp1"><p>As each module would have its own file_contexts component that is either added or removed from the policies overall /etc/selinux/&lt;SELINUXTYPE&gt;/contexts/ files/file_contexts file.<a href="#fnpcf1" class="footnote-back">↩</a></p></li>
 </ol>
 </section>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index b5cf10a..156b434 100644
--- a/src/policy_config_statements.md
+++ b/src/policy_config_statements.md
@@ -65,7 +65,6 @@ policycap capability;
 policycap network_peer_controls;
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/policy_languages.md b/src/policy_languages.md
index fe579fe..90c17fe 100644
--- a/src/policy_languages.md
+++ b/src/policy_languages.md
@@ -55,7 +55,6 @@ domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
 domain_entry_file(test_stat_domain, ls_exec_t)
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/policy_store_config_files.md b/src/policy_store_config_files.md
index c1337c7..3e7f8ab 100644
--- a/src/policy_store_config_files.md
+++ b/src/policy_store_config_files.md
@@ -54,7 +54,6 @@ The command types are:
 -   [***semanage user***](#activeusers.local) Manage  SELinux confined users
 (Roles and levels for an SELinux user)
 
-
 ## active/modules Directory Contents
 
 Under this directory are the respective priority directories containing
@@ -83,7 +82,6 @@ test_policy               400       pp
 ...
 ```
 
-
 ### *tmp* Policy Store (build failure)
 
 When adding/updating a policy module and it fails to  build for some reason,
@@ -95,13 +93,11 @@ message indicating the failing line number is:
 Failed to resolve mlsconstrain statement at /var/lib/selinux/targeted/tmp/modules/400/test_mlsconstrain/cil:1
 ```
 
-
 ## *active/commit_num*
 
 This is a binary file used by ***semanage*** for managing updates to the
 store. The format is not relevant to policy construction.
 
-
 ### *active/policy.kern*
 
 This is the binary policy file built by either the ***semanage**(8)* or
@@ -110,7 +106,6 @@ is then becomes the
 */etc/selinux/&lt;SELINUXTYPE&gt;/policy/policy.&lt;ver&gt;* binary policy
 that will be loaded into the kernel.
 
-
 ## *active/policy.linked*
 ## *active/seusers.linked*
 ## *active/seusers_extra.linked*
@@ -118,7 +113,6 @@ that will be loaded into the kernel.
 These are saved policy files prior to merging local changes to improve
 performance.
 
-
 ## *active/booleans.local*
 
 This file is created and updated by the ***semanage boolean*** command and
@@ -141,7 +135,6 @@ semanage boolean -m --on daemons_enable_cluster_mode
 daemons_enable_cluster_mode=1
 ```
 
-
 ## *disable_dontaudit*
 
 This file is only present when the ***semodule**(8)* '-D' flag is used to
@@ -149,7 +142,6 @@ to build the policy or ***semanage dontaudit***. It indicates that a policy
 has been built without the *dontaudit* rules. This allows utilities
 such as ***audit2allow**(8)* to list all denials to assist debugging policy.
 
-
 ## *active/file_contexts*
 
 This file becomes the policy
@@ -271,7 +263,6 @@ pathname_regexp [file_type] security_context | <<none>>
 </tbody>
 </table>
 
-
 Keywords that can be in policy source \*.fc files and then form the *file_contexts.template* file entries are:
 
 <table>
@@ -305,7 +296,6 @@ Keywords that can be in policy source \*.fc files and then form the *file_contex
 </tbody>
 </table>
 
-
 **Example policy source file from Reference Policy** *policy/modules/system/userdomain.fc*:
 
 ```
@@ -341,7 +331,6 @@ HOME_ROOT/lost\+found/.*	<<none>>
 /home		-l	gen_context(system_u:object_r:home_root_t,s0)
 ```
 
-
 ## *active/file_contexts.local*
 
 This file is created and updated by the ***semanage fcontext*** command. It is
@@ -371,7 +360,6 @@ The resulting *file_contexts.local* file will be:
 /usr/move_file    system_u:object_r:unlabeled_t:s0
 ```
 
-
 ## *active/homedir_template*
 
 This file is built as described in the
@@ -396,7 +384,6 @@ HOME_ROOT/\.journal	<<none>>
 HOME_DIR/.+	system_u:object_r:user_home_t:s0
 ```
 
-
 ### *active/file_contexts.homedirs*
 
 This file becomes the policy
@@ -432,7 +419,6 @@ libsepol library function.
 /home/[^/]+/.+	unconfined_u:object_r:user_home_t:s0
 ```
 
-
 ## active/seusers
 ## active/seusers.local
 
@@ -517,7 +503,6 @@ __default__:unconfined_u:s0-s0:c0.c1023
 rch:user_u:s0
 ```
 
-
 ## *active/users_extra*
 ## *active/users_extra.local*
 ## *active/users.local*
@@ -579,7 +564,6 @@ user seuser_id prefix prefix_id;
 </tbody>
 </table>
 
-
 **Example** *users_extra* **file contents:**
 
 ```
@@ -626,7 +610,6 @@ and the resulting *users.local* file will be:
 user test_u roles { staff_r } level s0 range s0;
 ```
 
-
 ## *active/interfaces.local*
 
 This file is created and updated by the ***semanage interface*** command to
@@ -651,7 +634,6 @@ semanage interface -a -t netif_t -r s0:c20.c250 enp7s0
 netifcon enp7s0 system_u:object_r:netif_t:s0:c20.c250 system_u:object_r:netif_t:s0:c20.c250
 ```
 
-
 ## *active/nodes.local*
 
 This file is created and updated by the ***semanage node*** command to hold
@@ -677,7 +659,6 @@ semanage node -a -M 255.255.255.255 -t node_t -r s0:c20.c250 -p ipv4 127.0.0.2
 nodecon ipv4 127.0.0.2 255.255.255.255 system_u:object_r:node_t:s0:c20.c250
 ```
 
-
 ## *active/ports.local*
 
 This file is created and updated by the ***semanage port*** command to hold
@@ -688,7 +669,6 @@ Each line of the file contains a *portcon* statement that is defined along
 with examples in the policy language
 [***portcon***](network_statements.md#portcon) section.
 
-
 **Example** ***semanage port*** **command:**
 
 ```
@@ -704,7 +684,6 @@ semanage port -a -t port_t -p tcp -r s0:c20.c350 8888
 portcon tcp 8888 system_u:object_r:port_t:s0:c20.c350
 ```
 
-
 ## Set domain permissive mode
 
 The ***semanage permissive*** command will either add or remove a policy
@@ -726,8 +705,6 @@ This will by default add a CIL policy module to
 Note that the CIL *typepermissive* statement is used, the equivalent kernel
 policy statement would be [***permissive***](type_statements.md#permissive).
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/policy_validation_example.md b/src/policy_validation_example.md
index 628ee7b..8b7513f 100644
--- a/src/policy_validation_example.md
+++ b/src/policy_validation_example.md
@@ -97,7 +97,6 @@ options as described in the
 [**Global Configuration Files** - *semanage.conf*](global_config_files.md#etcselinuxsemanage.conf)
 file section.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/polyinstantiation.md b/src/polyinstantiation.md
index cca439b..3a64918 100644
--- a/src/polyinstantiation.md
+++ b/src/polyinstantiation.md
@@ -23,7 +23,6 @@ To clarify polyinstantiation support:
     function of the XSELinux Object Manager and the supporting XACE
     service.
 
-
 ## Polyinstantiated Objects
 
 Determining a polyinstantiated context for an object is supported by
@@ -33,7 +32,6 @@ libselinux API functions. These are not limited to specific object
 classes, however only *dir*, *x_selection* and *x_property* objects are
 currently supported.
 
-
 ## Polyinstantiation support in PAM
 
 PAM supports polyinstantiation (namespaces) of directories at login time
@@ -102,7 +100,6 @@ instance, and the user name. If a new instance is being set up, the
 directory permissions are set and the ***restorecon**(8)* command is run
 to set the correct file contexts.
 
-
 #### *namespace.conf* Configuration File
 
 Each line in the namespace.conf file is formatted as follows:
@@ -139,7 +136,6 @@ Where:
 </tbody>
 </table>
 
-
 ### Example Configurations
 
 This section shows two sample *namespace.conf* configurations, the first
@@ -205,7 +201,6 @@ following polyinstantiated directories:
 /home/rch/rch.inst/unconfined_u:unconfined_r:unconfined_t_rch
 ```
 
-
 ## Polyinstantiation support in X-Windows
 
 The X-Windows SELinux object manager and XACE (X Access Control
@@ -214,7 +209,6 @@ objects as discussed in the
 [**SELinux X-Windows Support**](x_windows.md#x-windows-selinux-support)
 section.
 
-
 ## Polyinstantiation support in the Reference Policy
 
 The reference policy *files.te* and *files.if* modules (in the kernel
@@ -226,8 +220,6 @@ boolean is set *false* (off).
 The polyinstantiation of X-Windows objects (*x_selection* and
 *x_property*) are not currently supported by the reference policy.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/rbac.md b/src/rbac.md
index 7bb1b4f..4063e38 100644
--- a/src/rbac.md
+++ b/src/rbac.md
@@ -22,8 +22,6 @@ Some policies, for example Android, only make use of one role called *r*.
 **Figure 4: Role Based Access Control** - *Showing how SELinux controls
 access via user, role and domain type association.*
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/reference_policy.md b/src/reference_policy.md
index 760d154..7b7dd64 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -26,7 +26,6 @@ In most documentation the policy name is defined using the
 */etc/selinux/config* file entry **SELINUXTYPE=**. This part of the Notebook
 uses both forms.
 
-
 ### Reference Policy Overview
 
 Strictly speaking the 'Reference Policy' should refer to the policy
@@ -71,7 +70,6 @@ section explains a simple build from source.
 
 **Figure 26: The Reference Policy Source Tree** - *When building a modular policy, files are added to the policy store. For monolithic builds the policy store is not used.*
 
-
 The Reference Policy can be used to build two policy types:
 
 1.  **Loadable Module Policy** - A policy that has a
@@ -93,7 +91,6 @@ forming a single 'base' source file.
 The Reference Policy relies heavily on the ***m4**(1)* macro processor
 as the majority of supporting services are m4 macros.
 
-
 ### Distributing Policies
 
 It is possible to distribute the Reference Policy in two forms:
@@ -134,7 +131,6 @@ The selinux-policy-sandbox rpm contains the sandbox module for use by the
 *policycoreutils-sandbox* package. This will be installed as a module for
 one of the three main policies described above.
 
-
 ### Policy Functionality
 
 As can be seen from the policies distributed with Fedora above, they can
@@ -148,7 +144,6 @@ the *SELINUXTYPE* entry of the *build.conf* as shown in
     and can also confine other areas and users.
 -   mls - MLS policy for server based systems.
 
-
 ### Reference Policy Module Files
 
 The reference policy modules are constructed using a mixture of
@@ -310,7 +305,6 @@ interface(*ada_run',*
 /usr/libexec/gcc(/.*)?/gnat1	--	gen_context(system_u:object_r:ada_exec_t,s0)
 ```
 
-
 ### Reference Policy Documentation
 
 One of the advantages of the reference policy is that it is possible to
@@ -338,7 +332,6 @@ the ada module interfaces.
 
 **Figure 27: Example Documentation Screen Shot**
 
-
 ## Reference Policy Source
 
 This section explains the source layout and configuration files, with
@@ -351,7 +344,6 @@ updated with the authors comments as necessary). There is also a VERSION
 file that contains the Reference Policy release date, this can then be used to
 obtain a change list <https://github.com/SELinuxProject/refpolicy/releases>.
 
-
 ### Source Layout
 
 **Figure 26: The Reference Policy Source Tree** shows the layout of the
@@ -376,7 +368,6 @@ The
 section then describes how the initial source is installed and
 configured to allow a policy to be built.
 
-
 ### Reference Policy Files and Directories
 
 **Table 1: The Reference Policy Files and Directories** shows the major
@@ -535,13 +526,11 @@ modular policy is being built. This file is explained in the
 
 **Table 1: The Reference Policy Files and Directories**
 
-
 ### Source Configuration Files
 
 There are two major configuration files (build.conf and modules.conf)
 that define the policy to be built and are detailed in this section.
 
-
 #### Reference Policy Build Options - build.conf
 
 This file defines the policy type to be built that will influence its
@@ -550,7 +539,6 @@ An example file content is shown in the
 [**Installing and Building the Reference Policy Source**](#installing-and-building-the-reference-policy-source)
 section where it is used to install and then build the policy.
 
-
 **Table 2:** *build.conf* **Entries** explains the fields that can be defined within this file, however
 there are a number of *m4* macro parameters that are set up when this file is
 read by the build process makefiles. These macro definitions are shown
@@ -647,7 +635,6 @@ policy is built with examples shown in the
 
 **Table 2:** *build.conf* **Entries**
 
-
 <table>
 <tbody>
 <tr style="background-color:#F2F2F2;">
@@ -705,7 +692,6 @@ policy is built with examples shown in the
 
 **Table 3: m4 parameters set at build time** - *These have been extracted from the Reference Policy Makefile.*
 
-
 #### Reference Policy Build Options - policy/modules.conf
 
 This file will not be present until *make conf* is run and controls
@@ -908,7 +894,6 @@ reference policy are different)
 
 **Table 4: Mandatory modules.conf Entries**
 
-
 ##### Building the modules.conf File
 
 The file can be created by an editor, however it is generally built
@@ -921,7 +906,6 @@ As will be seen in the
 pre-configured files that are used to produce the required policy including
 multiple versions of the *modules.conf* file.
 
-
 ### Source Installation and Build Make Options
 
 This section explains the various make options available that have been
@@ -967,7 +951,6 @@ taken from the *README* file.
 
 **Table 5: General Build Make Targets**
 
-
 <table>
 <tbody>
 <tr style="background-color:#F2F2F2;">
@@ -1054,7 +1037,6 @@ taken from the *README* file.
 
 **Table 7: Monolithic Policy Build Make Targets**
 
-
 ### Booleans, Global Booleans and Tunable Booleans
 
 The three files *booleans.conf*, *global_booleans* and *global_tunables* are
@@ -1081,7 +1063,6 @@ built and used as follows:
 </tbody>
 </table>
 
-
 ### Modular Policy Build Structure
 
 This section explains the way a modular policy is constructed, this does
@@ -1209,7 +1190,6 @@ in **Table 9: Module Build**.
 
 **Table 8: Base Module Build** - *This shows the temporary build files used to build the base module 'base.conf' as a part of the 'make' process. Note that the modules marked as base in modules.conf are built here.*
 
-
 <table>
 <tbody>
 <tr style="background-color:#F2F2F2;">
@@ -1246,7 +1226,6 @@ in **Table 9: Module Build**.
 
 **Table 9: Module Build** - *This shows the module files and the temporary build files used to build each module as a part of the 'make' process (i.e. those modules marked as module in modules.conf).*
 
-
 ### Creating Additional Layers
 
 One objective of the reference policy is to separate the modules into
@@ -1271,7 +1250,6 @@ completed:
 <summary>ABC modules for the XYZ components.</summary>
 ```
 
-
 ## Installing and Building the Reference Policy Source
 
 This section will give a brief overview of how to build the Reference
@@ -1280,7 +1258,6 @@ the Fedora targeted policy. The Fedora version of the targeted
 policy build is discussed but building without using the rpm spec file
 is more complex.
 
-
 ### Building Standard Reference Policy
 
 This will run through a simple configuration process and build of a
@@ -1420,7 +1397,6 @@ WERROR = n
     as ***apol**(8)* or loaded by editing the */etc/selinux/config*
     file, running '*touch /.autorelabel*' and rebooting the system.
 
-
 ### Building the Fedora Policy
 
 Note, the Fedora [**selinux-policy**](https://github.com/fedora-selinux)
@@ -1591,7 +1567,6 @@ QUIET = n
     '*touch /.autorelabel*' and rebooting the system. It should have the
     same number of rules, types, classes etc. as the original release.
 
-
 ## Reference Policy Headers
 
 This method of building policy and adding new modules is used for
@@ -1627,7 +1602,6 @@ source two steps are required:
 -   Copy the module interface files (*.if*) to the relevant module
     directories at: */usr/share/selinux/&lt;SELINUXTYPE&gt;/include/modules*.
 
-
 ### Using the Reference Policy Headers
 
 Note that this section describes the standard Reference Policy headers,
@@ -1697,7 +1671,6 @@ modules built from headers.
 
 **Table 10: Header Policy Build Make Targets**
 
-
 ### Using Fedora Supplied Headers
 
 The Fedora distribution installs the headers in a slightly different
@@ -1712,7 +1685,6 @@ manner as Fedora installs:
 -   The documentation is installed in the
     */usr/share/doc/selinux-policy/html* directory.
 
-
 ## Reference Policy Support Macros
 
 This section explains some of the support macros used to build reference
@@ -1864,7 +1836,6 @@ Incorrect:
 policy_module (ftp, 1.7.0)
 ```
 
-
 ### Loadable Policy Macros
 
 The loadable policy module support macros are located in the
@@ -1950,7 +1921,6 @@ require {
 }
 ```
 
-
 #### *gen_require* Macro
 
 For use within module files to insert a *require* block.
@@ -2013,7 +1983,6 @@ require {
 }
 ```
 
-
 #### *optional_policy* Macro
 
 For use within module files to insert an *optional* block that will be
@@ -2180,7 +2149,6 @@ optional {
 } # end optional
 ```
 
-
 #### *gen_tunable* Macro
 
 This macro defines booleans that are global in scope. The corresponding
@@ -2336,7 +2304,6 @@ if (allow_ftpd_use_nfs && allow_ftpd_anon_write) {
 } # end allow_ftpd_use_nfs && allow_ftpd_anon_write
 ```
 
-
 #### *interface* Macro
 
 Access *interface* macros are defined in the interface module file (*.if*)
@@ -2456,7 +2423,6 @@ optional {
 } # end optional
 ```
 
-
 #### *template* Macro
 
 A template interface is used to help create a domain and set up the
@@ -2609,7 +2575,6 @@ template(*djbdns_daemontools_domain_template',*
 ##### end djbdns_daemontools_domain_template(dnscache) depth: 0
 ```
 
-
 ### Miscellaneous Macros
 
 These macros are in the *misc_macros.spt* file.
@@ -2679,7 +2644,6 @@ gen_context(context[,mls | mcs])
 /dev/\.tmp-block-.*  -c  system_u:object_r:fixed_disk_device_t:s15:c0.c1023
 ```
 
-
 #### *gen_user* Macro
 
 This macro is used to generate a valid [***user***](user_statements.md#user)
@@ -2758,7 +2722,6 @@ ifdef(*direct_sysadm_daemon',*
 ')
 ```
 
-
 **Expanded Macro:**
 
 ```
@@ -2777,7 +2740,6 @@ user root roles { sysadm_r staff_r secadm_r auditadm_r } level s0 range s0 - s15
 user root prefix sysadm;
 ```
 
-
 #### *gen_bool* Macro
 
 This macro defines a boolean and requires the following steps:
@@ -2912,7 +2874,6 @@ if( ! secure_mode_insmod ) {
 }
 ```
 
-
 ### MLS and MCS Macros
 
 These macros are in the *mls_mcs_macros.spt* file.
@@ -2986,7 +2947,6 @@ category c1;
 category c1023;
 ```
 
-
 #### *gen_sens* Macro
 
 This macro will generate a
@@ -3056,7 +3016,6 @@ sensitivity s1;
 sensitivity s15;
 ```
 
-
 #### *gen_levels* Macro
 
 This macro will generate a [*level*](mls_statements.md#level) for each level
@@ -3128,7 +3087,6 @@ level s1:c0.c1023;
 level s15:c0.c1023;
 ```
 
-
 #### System High/Low Parameters
 
 These macros define system high etc. as shown.
@@ -3183,13 +3141,11 @@ mcs_allcats
 c0.c1023
 ```
 
-
 ### *ifdef* / *ifndef* Parameters
 
 This section contains examples of the common *ifdef* / *ifndef*
 parameters that can be used in module source files.
 
-
 #### *hide_broken_symptoms*
 
 This is used within modules as shown in the example. The parameter is
@@ -3210,7 +3166,6 @@ ifdef(*hide_broken_symptoms',*
 ')
 ```
 
-
 #### *enable_mls* and *enable_mcs*
 
 These are used within modules as shown in the example. The parameters
@@ -3238,7 +3193,6 @@ ifdef(*enable_mcs',*
 ')
 ```
 
-
 #### *enable_ubac*
 
 This is used within the *./policy/constraints* configuration file to set
@@ -3268,7 +3222,6 @@ define(*basic_ubac_conditions',*
 ')
 ```
 
-
 #### *direct_sysadm_daemon*
 
 This is used within modules as shown in the example. The parameter is
@@ -3291,7 +3244,6 @@ ifndef(*direct_sysadm_daemon',*
 ')
 ```
 
-
 ## Module Expansion Process
 
 The objective of this section is to show how the modules are expanded by
@@ -3319,8 +3271,6 @@ section.
 
 **Figure 29: The expansion process**
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/role_statements.md b/src/role_statements.md
index ad73750..c11a01d 100644
--- a/src/role_statements.md
+++ b/src/role_statements.md
@@ -95,7 +95,6 @@ role user_r types user_t;
 role user_r types chfn_t;
 ```
 
-
 ## *attribute_role*
 
 The *attribute_role* statement declares a role attribute identifier that
@@ -160,7 +159,6 @@ attribute_role role_list_1;
 attribute_role srole_list_2;
 ```
 
-
 ## *roleattribute*
 
 The <code>roleattribute</code> statement allows the association of previously
@@ -232,7 +230,6 @@ role service_r;
 roleattribute service_r role_list_1;
 ```
 
-
 ## *allow*
 
 The role *allow* rule checks whether a request to change roles is allowed,
@@ -304,7 +301,6 @@ allow from_role_id to_role_id;
 allow sysadm_r secadm_r;
 ```
 
-
 ## *role_transition*
 
 The *role_transition* rule specifies that a role transition is required,
@@ -383,7 +379,6 @@ role_transition current_role_id type_id : class new_role_id;
 role_transition system_r unconfined_exec_t:process unconfined_r;
 ```
 
-
 ## *dominance* - Deprecated
 
 This rule has been deprecated and therefore should not be used. The role
@@ -465,7 +460,6 @@ Where:
 dominance { role message_filter_r { role unconfined_r };}
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/seandroid.md b/src/seandroid.md
index f3537c5..b1833eb 100644
--- a/src/seandroid.md
+++ b/src/seandroid.md
@@ -42,7 +42,6 @@ The sections that follow cover:
 8.  Logging and auditing
 9.  Configuration file formats
 
-
 ## SE for Android Project Updates
 
 This gives a high level view of the new and updated projects to support
@@ -128,7 +127,6 @@ Provides the policy build tool. Added support for MacOS X. Not available
 on the device as policy rebuilds are done in the development environment.
 There are no specific updates to support Android except an *Android.bp* file.
 
-
 ### ***bootable/recovery***
 
 Changes to manage file labeling on recovery using functions such as
@@ -197,7 +195,6 @@ Build information for each device that includes device specific policy as
 discussed in the [**The SELinux Policy**](#the-selinux-policy) and
 [**Managing Device Policy Files**](#managing-device-policy-files) sections.
 
-
 ## Kernel LSM / SELinux Support
 
 The paper "Security Enhanced (SE) Android: Bringing Flexible MAC to
@@ -220,7 +217,6 @@ Kernel 5.0+ supports Dynamically Allocated Binder Devices, therefore
 configuring specific devices (e.g. **CONFIG_ANDROID_BINDER_DEVICES="binder"**)
 is no longer required (use ***CONFIG_ANDROID_BINDERFS=y*** instead).
 
-
 ## Android Classes & Permissions
 
 Additional classes have been added to Android and are listed in the
@@ -463,7 +459,6 @@ not all are required for Android.
 </tbody>
 </table>
 
-
 ## SELinux Commands
 
 A subset of the Linux SELinux commands have been implemented in Android
@@ -527,7 +522,6 @@ adb shell pm list permissions -g
 </tbody>
 </table>
 
-
 ## SELinux Public Methods
 
 The public methods implemented are equivalent to *libselinux* functions
@@ -630,7 +624,6 @@ TV package *AboutFragment.java* calls **SELinux.isSELinuxEnabled()**.
 </tbody>
 </table>
 
-
 ## Android Init Language SELinux Extensions
 
 The Android init process language has been expanded to support SELinux
@@ -676,7 +669,6 @@ service ueventd /system/bin/ueventd
     restorecon --recursive --skip-ce /data
 ```
 
-
 ## The SELinux Policy
 
 This section covers the SELinux policy, its supporting configuration files
@@ -975,7 +967,6 @@ domains (not allowed) and *neverallow* assertions
 **version_policy** - Takes the given public platform policy, a private policy
 and a version number to produced a combined "versioned" policy file.
 
-
 ## Logging and Auditing
 
 Android supports auditing of SELinux events via the AOSP logger
@@ -1002,7 +993,6 @@ in the kernel buffers that can be read using ***dmesg**(1)*:
 adb shell dmesg
 ```
 
-
 ## Policy File Formats
 
 This section details the following Android policy files:
@@ -1118,7 +1108,6 @@ example taken from *device/generic/goldfish/fstab.ranchu*:
 /dev/block/pci/pci0000:00/0000:00:06.0/by-name/metadata /metadata ext4 .....
 ```
 
-
 ### ***seapp_contexts***
 
 The build process supports additional *seapp_contexts* files allowing
@@ -1367,7 +1356,6 @@ LABEL                                    USER    PID  PPID NAME
 u:r:untrusted_app:s0:c149,c256,c512,c768 u0_a149 1138 64   com.example.myapplication
 ```
 
-
 ### ***property_contexts***
 
 This file holds property service keys and their contexts that are
@@ -1386,7 +1374,6 @@ property_key security_context type value
 type = prefix or exact
 value = int, double, bool or string
 
-
 Example entries:
 
 ```
@@ -1411,7 +1398,6 @@ ro.telephony.call_ring.multiple   u:object_r:telephony_config_prop:s0 exact bool
 ro.telephony.default_cdma_sub     u:object_r:telephony_config_prop:s0 exact int
 ```
 
-
 ### ***service_contexts***
 
 This file holds binder service keys and their contexts that are matched
@@ -1462,7 +1448,6 @@ manager                 u:object_r:service_manager_vndservice:s0
 *                       u:object_r:default_android_vndservice:s0
 ```
 
-
 ### ***mac_permissions.xml***
 
 The *mac_permissions.xml* file is used to configure Run/Install-time MMAC
@@ -1549,7 +1534,6 @@ file:
      </signer>
 ```
 
-
 ### ***keys.conf***
 
 The *keys.conf* file is used by **insertkeys.py** for mapping the
@@ -1589,8 +1573,6 @@ USER      : $DEFAULT_SYSTEM_DEV_CERTIFICATE/testkey.x509.pem
 USERDEBUG : $DEFAULT_SYSTEM_DEV_CERTIFICATE/testkey.x509.pem
 ```
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/security_context.md b/src/security_context.md
index c002c81..3ca93a2 100644
--- a/src/security_context.md
+++ b/src/security_context.md
@@ -116,7 +116,6 @@ unconfined_u:object_r:out_file_t Message-11
 # (see the process example above). The role remained as object_r.
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/selinux_cmds.md b/src/selinux_cmds.md
index 077ffb6..918d4c1 100644
--- a/src/selinux_cmds.md
+++ b/src/selinux_cmds.md
@@ -152,8 +152,6 @@ has a page that details all the available tools and commands at:
 </tbody>
 </table>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/selinux_overview.md b/src/selinux_overview.md
index 0fa89b9..a71b762 100644
--- a/src/selinux_overview.md
+++ b/src/selinux_overview.md
@@ -43,7 +43,6 @@ locations as follows:
 </tbody>
 </table>
 
-
 ## Is SELinux useful
 
 There are many views on the usefulness of SELinux on Linux based
@@ -124,7 +123,6 @@ The following maybe useful in providing a practical view of SELinux:
 4.  Older NSA documentation at: <https://www.nsa.gov/what-we-do/research/selinux/documentation/>
     that is informative.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/sid_statement.md b/src/sid_statement.md
index dfe5684..07feb2c 100644
--- a/src/sid_statement.md
+++ b/src/sid_statement.md
@@ -73,7 +73,6 @@ sid unlabeled
 sid fs
 ```
 
-
 ## *sid context*
 
 The *sid context* statement is used to associate an initial security
@@ -151,7 +150,6 @@ sid unlabeled
 sid unlabeled system_u:object_r:unlabeled_t:s15:c0.c255
 ```
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/subjects.md b/src/subjects.md
index 38c7fe1..4f677cb 100644
--- a/src/subjects.md
+++ b/src/subjects.md
@@ -37,15 +37,12 @@ under *semanage_t*).
 
 **Untrusted** - Everything else.
 
-
 <section class="footnotes">
 <ol>
 <li id="fns1"><p>The object class and its associated permissions are explained in the <strong><a href="object_classes_permissions.md#process-object-class"> Appendix A - Object Classes and Permissions - Process Object Class</a></strong> section.<a href="#fnsub1" class="footnote-back">↩</a></p></li>
 </ol>
 </section>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/terminology.md b/src/terminology.md
index 59e9c0f..77eaade 100644
--- a/src/terminology.md
+++ b/src/terminology.md
@@ -37,7 +37,6 @@
 | UID     | User Identifier                                                                          |
 | XACE    | X (windows) Access Control Extension                                                     |
 
-
 ## Terminology
 
 These give a brief introduction to the major components that form the
@@ -116,8 +115,6 @@ core SELinux infrastructure.
 </tbody>
 </table>
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/title.md b/src/title.md
index 68a4eb1..b218559 100644
--- a/src/title.md
+++ b/src/title.md
@@ -80,7 +80,6 @@ Android.
 **Object Classes and Permissions** - Describes the SELinux object
 classes and permissions.
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/toc.md b/src/toc.md
index 2bd299b..d7a4a72 100644
--- a/src/toc.md
+++ b/src/toc.md
@@ -61,7 +61,6 @@
 -   [Appendix D - Debugging Policy - Hints and Tips](debug_policy_hints.md#appendix-d---debugging-policy---hints-and-tips)
 -   [Appendix E - Policy Validation Example](policy_validation_example.md#appendix-e---policy-validation-example)
 
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/type_enforcement.md b/src/type_enforcement.md
index 20f14af..d8d08be 100644
--- a/src/type_enforcement.md
+++ b/src/type_enforcement.md
@@ -54,7 +54,6 @@ any SELinux service (i.e. it is only used to identify the type
 component), although as explained above CIL with namespaces does make
 identification of types easier.
 
-
 ### Constraints
 
 It is possible to add constraints on users, roles, types and MLS ranges,
@@ -88,7 +87,6 @@ The kernel policy language constraints are defined in the
 [**Constraint Statements**](constraint_statements.md#constraint-statements)
 section.
 
-
 ### Bounds
 
 It is possible to add bounds to users, roles and types, however
@@ -103,8 +101,6 @@ services. The [**Bounds Rules**](bounds_rules.md#bounds-rules)
 section defines the *typebounds* rule and also gives a summary of the
 *userbounds* and *rolebounds* rules.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index 32b36f9..a55fdd0 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -31,7 +31,6 @@ The type of SELinux policy can described in a number of ways:
 As can be seen the description of a policy can vary depending on the
 context.
 
-
 ## Reference Policy
 
 Note that this section only gives an introduction to the Reference
@@ -56,7 +55,6 @@ number of RPMs.
 The Reference Policy can be built as a Monolithic policy or as a Modular policy
 that has a 'base module' with zero or more optional 'loadable modules'.
 
-
 ## Policy Functionality Based on Name or Type
 
 Generally a policy is installed with a given name such as *targeted*,
@@ -93,7 +91,6 @@ The *NAME* and *TYPE* entries are defined in the reference policy
 [**Source Configuration Files**](reference_policy.md#source-configuration-files)
 section.
 
-
 ## Custom Policy
 
 This generally refers to a policy source that is either:
@@ -118,7 +115,6 @@ classes/permissions (see kernel *Documentation/admin-guide/LSM/SELinux.rst*
 for build instructions, also the
 [**Notebook Sample Policy - README**](./notebook-examples/selinux-policy/README.md)).
 
-
 ## Monolithic Policy
 
 A Monolithic policy is an SELinux policy that is compiled from one
@@ -133,7 +129,6 @@ The Reference Policy supports building of monolithic policies.
 
 In some cases the kernel policy binary file is also called a monolithic policy.
 
-
 ## Loadable Module Policy
 
 The loadable module infrastructure allows policy to be managed on a
@@ -166,7 +161,6 @@ into the final [**binary policy**](#policy-versions) for loading into
 the kernel, see
 "[**SELinux Policy Module Primer**](http://securityblog.org/brindle/2006/07/05/selinux-policy-module-primer/)".
 
-
 ### Optional Policy
 
 The loadable module policy infrastructure supports an
@@ -174,7 +168,6 @@ The loadable module policy infrastructure supports an
 allows policy rules to be defined but only enabled in the binary policy once
 the conditions have been satisfied.
 
-
 ## Conditional Policy
 
 Conditional policies can be implemented in monolithic or loadable module
@@ -199,7 +192,6 @@ the state of the boolean value or values. See the
 [**Conditional Policy Statements**](conditional_statements.md#conditional-policy-statements)
 section.
 
-
 ## Binary Policy
 
 This is also know as the kernel policy and is the policy file that is
@@ -227,7 +219,6 @@ is supported by Fedora):
 
 */etc/selinux/targeted/policy/policy.32*
 
-
 ## Policy Versions
 
 SELinux has a policy database (defined in the libsepol library) that
@@ -373,8 +364,6 @@ quoted (some SELinux utilities give both version numbers).
 
 **Table 1: Policy version descriptions**
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/users.md b/src/users.md
index b1dec2f..a1a86b1 100644
--- a/src/users.md
+++ b/src/users.md
@@ -24,8 +24,6 @@ the [**Type Enforcement (TE)**](type_enforcement.md#type-enforcement) section.
 
 Some policies, for example Android, only make use of one user called *u*.
 
-
-
 <!-- %CUTHERE% -->
 
 ---
diff --git a/src/vm_support.md b/src/vm_support.md
index 07ad32f..80d5cd5 100644
--- a/src/vm_support.md
+++ b/src/vm_support.md
@@ -122,7 +122,6 @@ ls -Z /var/lib/libvirt/images
 system_u:object_r:svirt_image_t:s0:c585,c813 Dynamic_VM1.img
 system_u:object_r:svirt_image_t:s0:c535,c601 Dynamic_VM2.img
 
-
 ps -eZ | grep qemu
 system_u:system_r:svirt_tcg_t:s0:c585,c813 8707 ? 00:00:44 qemu-system-x86
 
@@ -228,7 +227,6 @@ initialisation process will take place:
     The following example shows each VM having the same file label but
     different process labels:
 
-
 | VM Image           | Object    | Security context                             |
 | -------------------| ----------| -------------------------------------------- |
 | Shareable_VM       | *process* | *system_u:system_r:svirt_tcg_t:s0:c231,c245* |

