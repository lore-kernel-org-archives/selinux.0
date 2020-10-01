Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECE7C4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 20:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2327207DE
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sinkyhti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJAUFj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUFj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 16:05:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D66C0613D0
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 13:05:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so5715997ljg.9
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2+Q5rA4P/s4Bkr83m2VRdsMViFGUSodXkOcpyFy/Ps=;
        b=SinkyhtizFHzrox4BC/HiwdPul0zWMuGqkY9sLLqcIRREl5T84N3pBKIMwRlIR4Snw
         X0UC14DdxT8OTH6D/GsOSTPZ6a9GSHdokbo4mISFfzLwc6zLleHnsWQUzOrSQUf9bmKu
         j6RqnPONzK0DeMb/263ogZHbOBa7SGs55tDQmMRTUr8KjZA9HhONXv4oxqAkPPXzsxY2
         rYJMOxii/X/3Oaafx6mP2neW8Z+IUglfM+Q0n6u/Aoq1ksmPOmcMntOPRipa+rZwCbcf
         4R5BZcTe5L+cPlW4aTT56oRoCvB9nVsvtY1hAi8J/uc1ac8NjtWVHV5NIfgyYJFWP+QT
         VHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2+Q5rA4P/s4Bkr83m2VRdsMViFGUSodXkOcpyFy/Ps=;
        b=JQv8lUltPVVg9n+Dy+rjlB6xLZAa4RZu7uQUvu2K/em1ZX53zIJfzy49vM9xKo3rLP
         sKrcRHFEl44uvolMFfVV6tdspOXQIaBVMxC8au5RK2ShulL3v6Ck2LEhwkPcr1qn0zJA
         GLk0dZBQPLN2ed1cLSefP7lFUYzkvSDXBiRtSazRZ4fo8qGao4TelODIc0znxKOrn895
         r+ju5nFegO69O6Wy5n7Fe5lIe77xRlVo2DTzKUgcVddvXi45XTAkCLy1TESg1mKcx5i3
         7dB2CzLWsqxS/Ivj3uOGIfMRDKGgzIwo42Cb/RKDorQyiaa7/XHbIcw/FIWDDGEydGpI
         B2Cg==
X-Gm-Message-State: AOAM530NJfth2b5fNY7YRwZ+elLnKIZ4YLTVl2tjpLkcpVa5wpqERDZZ
        aOpG4m+A8uIVJletc6fJOIo6Bp24TiQ=
X-Google-Smtp-Source: ABdhPJzkKen1J8y4+KvjhhB1NUG7nIxp3FC3RvqwlwG2ghKox+pk7Q7ybNRN/R2JuO24zWpgTEA0Kg==
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr3030117ljp.378.1601582736428;
        Thu, 01 Oct 2020 13:05:36 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m186sm677016lfd.166.2020.10.01.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 13:05:35 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH][selinux-notebook] Link to Reference policy
Date:   Thu,  1 Oct 2020 23:05:27 +0300
Message-Id: <20201001200527.13226-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use links to https://github.com/SELinuxProject/refpolicy where useful.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 src/class_permission_statements.md | 13 ++--
 src/constraint_statements.md       | 18 +++---
 src/reference_policy.md            | 98 +++++++++++++++---------------
 3 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/src/class_permission_statements.md b/src/class_permission_statements.md
index b1ef36a..264e022 100644
--- a/src/class_permission_statements.md
+++ b/src/class_permission_statements.md
@@ -9,8 +9,10 @@ For those who write or manager SELinux policy, there is no need to
 define new objects and their associated permissions as these would be
 done by those who actually design and/or write object managers.
 
-A list of object classes used by the **Reference Policy** can be found
-in the *./policy/flask/security\_classes* file.
+A list of object classes used by the [**Reference
+Policy**](https://github.com/SELinuxProject/refpolicy) can be found in the
+[*./policy/flask/security\_classes*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/flask/security_classes)
+file.
 
 There are two variants of the *class* statement for writing policy:
 
@@ -72,8 +74,11 @@ Permissions can be defined within policy in two ways:
    declared for a specific object class only (i.e. the permission is
    not inherited by any other object class).
 
-A list of classes and their permissions used by the **Reference Policy**
-can be found in the *./policy/flask/access_vectors* file.
+A list of classes and their permissions used by the [**Reference
+Policy**](https://github.com/SELinuxProject/refpolicy) can be found in
+the
+[*./policy/flask/access\_vectors*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/flask/access_vectors)
+file.
 
 ## *common*
 
diff --git a/src/constraint_statements.md b/src/constraint_statements.md
index 4c9a621..5ac1253 100644
--- a/src/constraint_statements.md
+++ b/src/constraint_statements.md
@@ -80,8 +80,10 @@ Conditional Policy Statements
 
 **Examples:**
 
-These examples have been taken from the **Reference Policy** source
-*./policy/constraints* file.
+These examples have been taken from the [**Reference
+Policy**](https://github.com/SELinuxProject/refpolicy) source
+[*./policy/constraints*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/constraints)
+file.
 
 ```
 # This constrain statement is the "SELinux process identity
@@ -327,9 +329,11 @@ Conditional Policy Statements
 
 **Example:**
 
-This example has been taken from the **Reference Policy** source
-*./policy/mls* constraints file. These are built into the policy at build
-time and add constraints to many of the object classes.
+This example has been taken from the [**Reference
+Policy**](https://github.com/SELinuxProject/refpolicy) source
+[**./policy/mls*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/mls)
+constraints file.  These are built into the policy at build time and
+add constraints to many of the object classes.
 
 ```
 # The MLS Reference Policy mlsconstrain statement for searching
@@ -439,8 +443,8 @@ Conditional Policy Statements
 
 **Example:**
 
-This example has been taken from the **Reference Policy** source
-*./policy/mls* file.
+This example has been taken from the [**Reference Policy**](https://github.com/SELinuxProject/refpolicy) source
+[*./policy/mls*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/mls) file.
 
 ```
 # The MLS Reference Policy mlsvalidatetrans statement for
diff --git a/src/reference_policy.md b/src/reference_policy.md
index cec6470..dd2de00 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -48,12 +48,13 @@
     - [*direct_sysadm_daemon*](#direct_sysadm_daemon)
 - [Module Expansion Process](#module-expansion-process)
 
-The Reference Policy is now the standard policy source used to build
-Linux SELinux policies. This provides a single source tree with
-supporting documentation that can be used to build policies for
-different purposes such as: confining important daemons, supporting MLS
-/ MCS type policies and locking down systems so that all processes are
-under SELinux control.
+The [**Reference Policy**](https://github.com/SELinuxProject/refpolicy)
+is now the standard policy source used to build Linux SELinux
+policies. This provides a single source tree with supporting
+documentation that can be used to build policies for different
+purposes such as: confining important daemons, supporting MLS / MCS
+type policies and locking down systems so that all processes are under
+SELinux control.
 
 This section details how the Reference Policy is:
 
@@ -418,7 +419,8 @@ configured to allow a policy to be built.
 The **Reference Policy Files and Directories** list shows the major
 files and their directories with a description of each taken from the
 README file (with comments added). All directories are relative to the root of
-the Reference Policy source directory *./policy*.
+the [Reference Policy](https://github.com/SELinuxProject/refpolicy) source directory
+[*./policy*](https://github.com/SELinuxProject/refpolicy/tree/master/policy).
 
 The *build.conf* and *modules.conf* configuration files are further detailed
 in the [**Source Configuration Files**](#source-configuration-files)
@@ -431,26 +433,26 @@ modular policy is being built. This file is explained in the
 
 **Reference Policy Files and Directories:**
 
-*Makefile*
+[*Makefile*](https://github.com/SELinuxProject/refpolicy/tree/master/Makefile)
 
 - General rules for building the policy.
 
-*Rules.modular*
+[*Rules.modular*](https://github.com/SELinuxProject/refpolicy/tree/master/Rules.modular)
 
 - Makefile rules specific to building loadable module policies.
 
-*Rules.monolithic*
+[*Rules.monolithic*](https://github.com/SELinuxProject/refpolicy/tree/master/Rules.monolithic)
 
 - Makefile rules specific to building monolithic policies.
 
-*build.conf*
+[*build.conf*](https://github.com/SELinuxProject/refpolicy/tree/master/build.conf)
 
 - Options which influence the building of the policy, such as the policy type
   and distribution. This file is described in the
   [**Reference Policy Build Options - build.conf**](#reference-policy-build-options---build.conf)
   section.
 
-*config/appconfig-\<type\>*
+[*config*](https://github.com/SELinuxProject/refpolicy/tree/master/config)*/appconfig-\<type\>*
 
 - Application configuration files for all configurations of the Reference
   Policy where *\<type\>* is taken from the *build.conf* **TYPE** entry that
@@ -459,64 +461,64 @@ modular policy is being built. This file is explained in the
   [**SELinux Configuration Files**](policy_config_files.md#policy-configuration-files)
   section.
 
-*config/file_contexts.subs_dist*
+[*config/file_contexts.subs_dist*](https://github.com/SELinuxProject/refpolicy/tree/master/config/file_contexts.subs_dist)
 
 - Used to configure file context aliases (see the
   [**contexts/files/file_contexts.subs and file_contexts.subs_dist File**](policy_config_files.md#contextsfilesfile_contexts.subs)
   section).
 
-*config/local.users*
+[*config/local.users*](https://github.com/SELinuxProject/refpolicy/tree/master/config/local.users)
 
 - The file read by load policy for adding SELinux users to the policy on
   the fly. Note that this file is not used in the modular policy build.
 
-*doc/html/\**
+[*doc/html*](https://github.com/SELinuxProject/refpolicy/tree/master/doc/html)*/\**
 
 - When *make html* has been executed, contains the in-policy XML
   documentation, presented in web page form.
 
-*doc/policy.dtd*
+[*doc/policy.dtd*](https://github.com/SELinuxProject/refpolicy/tree/master/doc/policy.dtd)
 
 - The *doc/policy.xml* file is validated against this DTD.
 
-*doc/policy.xml*
+[*doc/policy.xml*](https://github.com/SELinuxProject/refpolicy/tree/master/doc/policy.xml)
 
 - This file is generated/updated by the conf and html make targets.
   It contains the complete XML documentation included in the policy.
 
-*doc/templates/\**
+[*doc/templates*](https://github.com/SELinuxProject/refpolicy/tree/master/doc/templates)*/\**
 
 - Templates used for documentation web pages.
 
-*man/\**
+[*man*](https://github.com/SELinuxProject/refpolicy/tree/master/man)*/\**
 
 - Various man pages for modules (ftp, http etc.)
 
-*support/\**
+[*support*](https://github.com/SELinuxProject/refpolicy/tree/master/support)*/\**
 
 - Tools used in the build process.
 
-*policy/flask/initial_sids*
+[*policy/flask/initial_sids*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/flask/initial_sids)
 
 - This file has declarations for each initial SID. The file usage in policy
   generation is described in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure)
   section.
 
-*policy/flask/security_classes*
+[*policy/flask/security_classes*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/flask/security_classes)
 
 - This file has declarations for each security class. The file usage in
   policy generation is described in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure)
   section.
 
-*policy/flask/access_vectors*
+[*policy/flask/access_vectors*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/flask/access_vectors)
 
 - This file defines the common permissions and class specific permissions
   and is described in the [**Modular Policy Build Structure**](#modular-policy-build-structure)
   section.
 
-*policy/modules/\**
+[*policy/modules*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/modules)*/\**
 
 - Each directory represents a layer in Reference Policy. All of the modules
   are contained in one of these layers. The *contrib* modules are supplied
@@ -528,13 +530,13 @@ modular policy is being built. This file is explained in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure)
   section.
 
-*policy/support/\**
+[*policy/support*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support)*/\**
 
 - Reference Policy support macros are described in the
   [**Reference Policy support Macros**](#reference-policy-support-macros)
   section.
 
-*policy/booleans.conf*
+[*policy/booleans.conf*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/booleans.conf)
 
 - This file is generated/updated by *make conf*. It contains the booleans in
   the policy and their default values. If tunables are implemented as
@@ -544,7 +546,7 @@ modular policy is being built. This file is explained in the
   [**Booleans, Global Booleans and Tunable Booleans**](#booleans-global-booleans-and-tunable-booleans)
   section).
 
-*policy/constraints*
+[*policy/constraints*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/constraints)
 
 - This file defines constraints on permissions in the form of boolean
   expressions that must be satisfied in order for specified permissions to
@@ -556,33 +558,33 @@ modular policy is being built. This file is explained in the
   generation is described in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure) section.
 
-*policy/context_defaults*
+[*policy/context_defaults*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/context_defaults)
 
 - This would contain any specific *default_user*, *default_role*,
   *default_type* and/or *default_range* rules required by the policy.
 
-*policy/global_booleans*
+[*policy/global_booleans*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/global_booleans)
 
 - This file defines all booleans that have a global scope, their default
   value, and documentation. See the
   [**Booleans, Global Booleans and Tunable Booleans**](#booleans-global-booleans-and-tunable-booleans)
   section.
 
-*policy/global_tunables*
+[*policy/global_tunables*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/global_tunables)
 
 - This file defines all tunables that have a global scope, their default
   value, and documentation.
   See the [**Booleans, Global Booleans and Tunable Booleans**](#booleans-global-booleans-and-tunable-booleans)
   section.
 
-*policy/mcs*
+[*policy/mcs*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/mcs)
 
 - This contains information used to generate the *sensitivity*, *category*,
   *level* and *mlsconstraint* statements used to define the MCS configuration.
   The file usage in policy generation is described in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure) section.
 
-*policy/mls*
+[*policy/mls*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/mls)
 
 - This contains information used to generate the *sensitivity*, *category*,
   *level* and *mlsconstraint* statements used to define the MLS configuration.
@@ -600,13 +602,13 @@ modular policy is being built. This file is explained in the
   [**Reference Policy Build Options - policy/modules.conf**](#reference-policy-build-options---policymodules.conf)
   section.
 
-*policy/policy_capabilities*
+[*policy/policy_capabilities*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/policy_capabilities)
 
 - This file defines the policy capabilities that can be enabled in the policy.
   The file usage in policy generation is described in the
   [**Modular Policy Build Structure**](#modular-policy-build-structure) section.
 
-*policy/users*
+[*policy/users*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/users)
 
 - This file defines the users included in the policy. The file usage in policy
   generation is described in the
@@ -619,10 +621,10 @@ modular policy is being built. This file is explained in the
 
 ### Source Configuration Files
 
-There are two major configuration files (*build.conf* and *modules.conf*)
+There are two major configuration files ([*build.conf*](https://github.com/SELinuxProject/refpolicy/tree/master/build.conf) and *modules.conf*)
 that define the policy to be built and are detailed in this section.
 
-#### Reference Policy Build Options - build.conf
+#### Reference Policy Build Options - [build.conf](https://github.com/SELinuxProject/refpolicy/tree/master/build.conf)
 
 This file defines the policy type to be built that will influence its
 name and where the source will be located once it is finally installed.
@@ -636,7 +638,7 @@ process to set *m4* macro parameters. These macro definitions are also used
 within the module source files to control how the policy is built with examples
 shown in the [***ifdef***](#ifdef-ifndef-parameters) section.
 
-***build.conf* Entries:**
+**[*build.conf*](https://github.com/SELinuxProject/refpolicy/tree/master/build.conf) Entries:**
 
 *TYPE*
 
@@ -1685,22 +1687,22 @@ semodule -i ipsec_test_policy.pp
 This section explains some of the support macros used to build reference
 policy source modules. These macros are located at:
 
-- *./policy/support* for the reference policy source.
+- [*./policy/support*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support) for the reference policy source.
 - */usr/share/selinux/\<NAME\>/include/support* for Reference
   Policy installed header files.
 - */usr/share/selinux/devel/support* for Fedora installed header files.
 
 The following support macro file contents are explained:
 
-- *loadable_module.spt* - Loadable module support.
-- *misc_macros.spt* - Generate users, bools and security contexts.
-- *mls_mcs_macros.spt* - MLS / MCS support.
-- *file_patterns.spt* - Sets up allow rules via parameters for files and
+- [*loadable_module.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/loadable_module.spt) - Loadable module support.
+- [*misc_macros.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/misc_macros.spt) - Generate users, bools and security contexts.
+- [*mls_mcs_macros.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/mls_mcs_macros.spt) - MLS / MCS support.
+- [*file_patterns.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/file_patterns.spt) - Sets up allow rules via parameters for files and
   directories.
-- *ipc_patterns.spt* - Sets up allow rules via parameters for Unix domain
+- [*ipc_patterns.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/ipc_patterns.spt) - Sets up allow rules via parameters for Unix domain
   sockets.
-- *misc_patterns.spt* - Domain and process transitions.
-- *obj_perm_sets.spt* - Object classes and permissions.
+- [*misc_patterns.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/misc_patterns.spt) - Domain and process transitions.
+- [*obj_perm_sets.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/obj_perm_sets.spt) - Object classes and permissions.
 
 When the header files are installed the *all_perms.spt* support macro
 file is also installed that describes all classes and permissions
@@ -1708,7 +1710,7 @@ configured in the original source policy.
 
 **Support Macros described in this section:**
 
-*loadable_module.spt*
+[*loadable_module.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/loadable_module.spt)
 
 - [*policy_module* Macro](#policy_module-macro)
   - For adding the *module* statement and mandatory *require* block entries.
@@ -1731,7 +1733,7 @@ configured in the original source policy.
 - [*template* Macro](#template-macro)
   - Generate *template* interface block.
 
-*misc_macros.spt*
+[*misc_macros.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/misc_macros.spt)
 
 - [*gen_context* Macro](#gen_context-macro)
   - Generate a security context.
@@ -1742,7 +1744,7 @@ configured in the original source policy.
 - [*gen_bool* Macro](#gen_bool-macro)
   - Generate a boolean.
 
-*mls_mcs_macros.spt*
+[*mls_mcs_macros.spt*](https://github.com/SELinuxProject/refpolicy/tree/master/policy/support/mls_mcs_macros.spt)
 
 - [*gen_cats* Macro](#gen_cats-macro)
   - Declares categories c0 to c(N-1).
-- 
2.28.0

