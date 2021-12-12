Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18E5C433F5
	for <selinux@archiver.kernel.org>; Sun, 12 Dec 2021 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhLLSmF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhLLSmF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Dec 2021 13:42:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F266C061714
        for <selinux@vger.kernel.org>; Sun, 12 Dec 2021 10:42:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi37so27128752lfb.5
        for <selinux@vger.kernel.org>; Sun, 12 Dec 2021 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrDxLjeindPnyHDV+2ZvtMIZ7upoadNULIqIhsjxDBs=;
        b=dJBSLtjtnZNsSv5acwz269nqrZw87EGdRbVUxRkY4DnPXPcM0bT5kY+54Za1pr4WzE
         ELZv4b0tk7sTmCj6tyf9Tmh8S8J3o5fZAGoLwl1+G/kW8kK9LjgyWJoFz+68FuD0fb+y
         RBGdEk77Qtpct0pCUCP/FI6ZFbQyIDJGMnMrx0G1N1h+kGBtgaK66ojYV/TRzQp/r+oi
         VcQnl1Dk98Mf6T6D8tX1OQEQDsRNS87DO1lyVvJVLtkGc0J5gmcrzoxOzo1lZkXlYlLE
         HhUotsBJ8IGnIwJFM9fz3KtMvRGQA9NywHRQO2kllhEYMSZPwOA+BAbGZY/yj1ebmieT
         WUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrDxLjeindPnyHDV+2ZvtMIZ7upoadNULIqIhsjxDBs=;
        b=GQRX63twW+OinafRADZHp9lDrx+5sH6E05qv4ecmBJK/ujwIphnW0YfCfIzSQBEuVa
         F/Bgja1veM+zEFM/laNio9nS6W5G+kf2+DxHV6Iq34mHNY1qWlgYzZiNdWSLJqp0S2DN
         qN1CoaVMwTBvxArAQ94HHFN4UG2nI3D3D84yTl3fazGHXyFrikKkao9Otok7+3z/5BKq
         gvos39mjpRbQHf2DJYdUfRGpf98D63K150yvLNCw2q54cY0DFtNn0GQFg/KGjOasUcLO
         oAa8FGcbAN5vST+98qFkIhZPLKuXGLCaiVSrGHARk1HfdkfmVnIyi28OiNas6PkTJGfI
         37Pw==
X-Gm-Message-State: AOAM530GwzePTedUtanARar6QkiIzr+UZ5IL6ilzelKEh/CTXLOtm35j
        mo80gCAthtbRu8tr1adxgyjlBc6vsy5p9w==
X-Google-Smtp-Source: ABdhPJzdVu635KyTnWAN3+KkxUWgNMUOEL9kFKu/o7NmNdk0aPUNkfzA0D05mLGSqg/1P0M6mBLqwA==
X-Received: by 2002:a19:9109:: with SMTP id t9mr24082717lfd.214.1639334521871;
        Sun, 12 Dec 2021 10:42:01 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id u16sm1124151lfu.42.2021.12.12.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:42:01 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Daniel Burgener <dburgener@linux.microsoft.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v4] selinux-notebook: New chapter: Hardening SELinux
Date:   Sun, 12 Dec 2021 20:41:42 +0200
Message-Id: <20211212184142.7896-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describe some easy and more difficult methods to harden SELinux
policies.

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
Reviewed-by: Dominick Grift <dominick.grift@defensec.nl>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v4:
 - Fixed typo
 - Added Reviewed-Bys

v3: https://lore.kernel.org/selinux/20211116105335.21864-1-toiwoton@gmail.com/
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
index 0000000..4b035d9
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
+# User `test` has been added earlier with `adduser` or `useradd`.
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

base-commit: 613a3b51c643cdd433029fb6337db121235f9240
-- 
2.33.0

