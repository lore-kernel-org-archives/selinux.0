Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE56C433EF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C1461BFB
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 10:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhKPK4i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhKPK4i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 05:56:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C928C061570
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 02:53:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c32so52061798lfv.4
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 02:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJeW0KfbTH5HcgcaQ1E6IJwfDIDtkEQuy0SE1LD1itA=;
        b=jdWUL68P3Lz+r65SVVxZqnqA/CYhGaY5yeIOoQWvwKSvtsP27m7pwFMpYLMSuPSYoe
         70po8QkEHUUJZ4MkXalwKZQpeJcH960HmbIziu2yEs1jIWF1Y28VOovtxBi0JGnIS0pE
         NsDAmWf/XNpf5V4iefk0y3T9zcRZ7d77BNuRJkcIPb5EN7O/VTTGWRv+1RSTTaFH4OSv
         Lp1qrFAyZwCa23prnqitwRZ1j9HosHS+Dqim20xLMh7tTRjy5XXEqb0geR37dvgIJSsD
         Ylq0ctMbMAN2OOB+mzm5c8SXW7hTMtNV0uhzXqaIW/AEB/q/szPWxU8gSBw7ewHVoK96
         PSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJeW0KfbTH5HcgcaQ1E6IJwfDIDtkEQuy0SE1LD1itA=;
        b=UX4A+QtzWXZRDGrQTwa/+FFZFp4t5VZVIvEM2oU7sMqGjl5+Ku7L+UImQxg4Qlbtic
         V9t2rokODFhc321cgGCANGPf0u09lQzcgvuCF+FCDB2Hb9L2FjIocC2zgq/ld0Zz8P/a
         Go5kx85MEaL/aEMK8ciN21ytt+gPAjRJqwfgSfxnmFtz6PFpf+8wCBLwfggIBoih/rUx
         hrNhMX8uzou0mGJd0kH079BD2/I5g6t3eYdeRbt+opWSrrBKkxjqCoIWh0me7nYXkMWR
         KxLOsudQMSi/bQW8tRcJ9LhhMQUTMmJNTJIJJYhHKtXw9dMNfLinXtsZeJVHbV4vMTwy
         QU+Q==
X-Gm-Message-State: AOAM530Ax3kS7qjWCbpR4VqRw9XLKP2ziGMkzEoMG1dbHxXHR3mOlgto
        /Lh6MYdD+a/EMrTsrnaknzxS7H+w240=
X-Google-Smtp-Source: ABdhPJz6WWe8QhhD4zE6hdrUOO/WUgGQNI4ZsrMWoMfa5KwR+OqUVGWP2ukzepaVjLV3Rb4+2WpsyA==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr5601656lfb.276.1637060018913;
        Tue, 16 Nov 2021 02:53:38 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id x5sm1723062ljm.101.2021.11.16.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:53:38 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3] selinux-notebook: New chapter: Hardening SELinux
Date:   Tue, 16 Nov 2021 12:53:35 +0200
Message-Id: <20211116105335.21864-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describe some easy and more difficult methods to harden SELinux
policies.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

---
v3:
 - Updated with comments from Daniel Burgener and Dominick Grift

v2: https://lore.kernel.org/selinux/20211113095547.19406-1-toiwoton@gmail.com/
 - Updated with comments from Daniel Burgener
 - Fixed issues with PDF generation

v1: https://lore.kernel.org/selinux/20211112125605.28915-1-toiwoton@gmail.com/
---
 src/hardening.md                 | 205 +++++++++++++++++++++++++++++++
 src/implementing_seaware_apps.md |   2 +-
 src/reference_policy.md          |   2 +-
 src/section_list.txt             |   1 +
 src/toc.md                       |   1 +
 5 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 src/hardening.md

diff --git a/src/hardening.md b/src/hardening.md
new file mode 100644
index 0000000..56023f6
--- /dev/null
+++ b/src/hardening.md
@@ -0,0 +1,205 @@
+# Hardening SELinux
+
+- [Tuning Booleans](#tuning-booleans)
+- [Disabling Modules](#disabling-modules)
+- [Users and Roles](#users-and-roles)
+- [Network Controls](#network-controls)
+- [Custom Policy Modules](#custom-policy-modules)
+- [Fine Grained Network Controls](#fine-grained-network-controls)
+- [Fully Custom Policy](#fully-custom-policy)
+
+The Reference Policy sets a good basis for learning how to operate a
+system with SELinux. The policy allows system administrators and users
+to continue using working methods that they learned before becoming
+familiar with SELinux, because of its "targeted" model and reasonable
+defaults.
+
+However, it's possible to tighten the policy considerably. The
+Reference Policy gives several options for hardening but for maximum
+control over the policy, it's possible to write custom modules or even
+replace the Reference Policy entirely.
+
+The hardening suggestions are listed in the rough order of difficulty.
+
+## Tuning Booleans
+
+The Reference Policy uses booleans to control optional aspects of the
+policy. Changing the booleans is a very easy way to tune the SELinux
+policy. The booleans can be also changed temporarily, without
+committing them yet to the on-disk policy, so changes are
+automatically reverted on next boot.
+
+For example, recent Firefox browsers can work with policy boolean
+`mozilla_execstack` set to `off`. This can reduce the surface to
+vulnerabilities which could use an executable stack. The boolean can
+be changed using ***setsebool**(8)*:
+
+```
+# Check current status:
+getsebool mozilla_execstack
+mozilla_execstack --> on
+
+# Change temporarily:
+setsebool mozilla_execstack=off
+
+# Write to persistent policy on disk:
+setsebool -P mozilla_execstack=off
+
+```
+
+## Disabling Modules
+
+By default, the Reference Policy enables most policy modules to
+support any system. But when the system is known well by the
+administrator, it's possible to disable modules which aren't used.
+
+As an example, if Firefox isn't installed, the module `mozilla` can be
+disabled in the policy. The hardening effect comes from reducing the
+allow rules, some of which may apply to paths which aren't actively
+monitored because the corresponding application isn't installed.
+
+Care should be taken to never disable modules which actually are used,
+since this may weaken the policy instead, because the disabled module
+could have contained an application more strictly than what the policy
+allows without the module. Disabling critical modules can also result
+in system breakage. It's also possible to remove modules, but on
+package upgrade they are typically reinstalled.
+
+Examples:
+```
+# Disable Firefox module
+semodule --disable=mozilla
+# Remove the module entirely
+semodule --remove=mozilla
+```
+
+## Users and Roles
+
+In the "targeted" model, both unprivileged users and the system
+administrator (`root`) are unconfined and the TE rules are very
+relaxed. However, it's possible to change the SELinux user for these
+accounts to more confined variants.
+
+For the unprivileged users, the confined user in the Reference Policy
+is `user_u` with corresponding role `user_r`. There's also `staff_u`
+and `staff_r` to allow transitioning to system administrative roles by
+logging in as `staff_u:staff_r` and escalating to `staff_u:sysadm_r`
+or another role for administrative tasks with ***newrole**(1)*.
+
+For the system administrator there are several options: `root` SELinux
+user, which is mostly unconfined and `sysadm_u`, which is more
+confined. The role for both is `sysadm_r`.
+
+It's also possible to divide the powers of the system administrator to
+several roles, `sysadm_r`, `auditadm_r`, `logadm_r`, `dbadm_r` and
+`secadm_r`. This can be useful when an organization wants to ensure
+that even the system administrators can be held accountable for their
+actions. The roles can be also useful for management of labor, for
+example having dedicated persons for managing databases or SELinux
+policies.
+
+It should be noted that since this isn't the default way of operating
+SELinux, the Reference Policy may need to be supplemented and the
+administrators, even users, may need to be more aware of SELinux in
+order to be able to operate the system.
+
+Example:
+```
+# User `test` has beed added earlier with `adduser` or `useradd`.
+semanage login --add --seuser user_u --range 's0' test
+```
+
+## Network Controls
+
+With network controls of SELinux, it's possible to enhance firewall
+rules with knowledge of SELinux types. Traditional firewall rules only
+affect the whole system by allowing certain ports and protocols but
+blocking others. With `nftables` and `iptables` it's also possible to
+make this more fine grained: certain users can access the network but
+others may not. By also using SELinux controls it's possible to fine
+tune this to the application level: `mozilla_t` can connect to the
+Internet but some other applications can't. SELinux packet controls
+can be also used to combine Deep Packet Inspection with SELinux TE
+rules.
+
+Chapter [Networking Support](network_support.md#selinux-networking-support)
+presents the controls with examples.
+
+## Custom Policy Modules
+
+Further hardening can be achieved by replacing policy modules from the
+Reference Policy with custom modules. Typically the modules in the
+Reference Policy are written to allow all possible modes of operation
+for an application or its users, since the writers of the policy don't
+know the specifics of each installation. Thus the SELinux rules may be
+more relaxed than what could be optimal for a specific case. When the
+exact environment and usage patterns are known, it's possible to write
+replacement policy modules to remove excess rules and hence reduce
+attack surface.
+
+As a minimum, it should be ensured that all continuously running
+services and main user applications have a dedicated policy module or
+rules, instead of running in for example `init_t`, `initrc_t` or
+`unconfined_t` types which may offer low level of protection.
+
+## Fine Grained Network Controls
+
+In an internal network of an organization, where all entities can
+agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
+allow further policy controls. In addition to SELinux domain of the
+source application, even the SELinux domain (or at least MCS/MLS
+category/sensitivity) of the target server can be used in TE rules.
+
+## Fully Custom Policy
+
+It's also possible to write custom SELinux policies for an entire
+system with non-trivial effort.
+
+The rules can also be analyzed with various SELinux tools, such as
+`apol`, `sedta`, `seinfo`, `sepolicy`, `sesearch` and many more. With
+the tools it may be possible to find hardening opportunities or errors
+in the policy.
+
+```
+# Find out which domains can transition to custom domain
+# `my_thunderbird_t` and what are the rules affecting the transition:
+sedta --source my_thunderbird_t --reverse
+Transition 1: user_t -> my_thunderbird_t
+
+Domain transition rule(s):
+allow user_t my_app_ta:process { sigkill signal signull transition };
+
+Entrypoint my_thunderbird_exec_t:
+        Domain entrypoint rule(s):
+        allow my_thunderbird_t my_thunderbird_exec_t:file { entrypoint execute getattr map read };
+
+        File execute rule(s):
+        allow user_t my_app_exec_ta:file { execute getattr open read };
+
+        Type transition rule(s):
+        type_transition user_t my_thunderbird_exec_t:process my_thunderbird_t;
+
+
+1 domain transition(s) found.
+```
+
+```
+# Check ports to which domain `mozilla_t` can connect:
+sepolicy network -d mozilla_t
+
+mozilla_t: tcp name_connect
+        443, 80 (my_http_port_t)
+        1080 (my_socks_port_t)
+```
+
+The downside of making the SELinux rules as tight as possible is that
+when the applications (or hardware components or network
+configuration) are updated, there's a possibility that the rules may
+also need updating because of the changes. Less generic rules are also
+less generally useful for different configurations, so the rules may
+need tuning for each installation.
+
+<!-- %CUTHERE% -->
+
+---
+**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index 74833f8..2351421 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -297,4 +297,4 @@ applied to their objects as defined by policy.
 <!-- %CUTHERE% -->
 
 ---
-**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
+**[[ PREV ]](hardening.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
diff --git a/src/reference_policy.md b/src/reference_policy.md
index 45e4145..ebb516f 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -3060,4 +3060,4 @@ section.
 <!-- %CUTHERE% -->
 
 ---
-**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
+**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](hardening.md)**
diff --git a/src/section_list.txt b/src/section_list.txt
index dcca883..b67f65e 100644
--- a/src/section_list.txt
+++ b/src/section_list.txt
@@ -52,6 +52,7 @@ infiniband_statements.md
 xen_statements.md
 modular_policy_statements.md
 reference_policy.md
+hardening.md
 implementing_seaware_apps.md
 embedded_systems.md
 seandroid.md
diff --git a/src/toc.md b/src/toc.md
index f5778bd..20a87f0 100644
--- a/src/toc.md
+++ b/src/toc.md
@@ -53,6 +53,7 @@
     - [XEN Statements](xen_statements.md#xen-statements)
     - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 - [The Reference Policy](reference_policy.md#the-reference-policy)
+- [Hardening SELinux](hardening.md#hardening-selinux)
 - [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
 - [Embedded Systems](embedded_systems.md#embedded-systems)
 - [SE for Android](seandroid.md#security-enhancements-for-android)
-- 
2.33.0

