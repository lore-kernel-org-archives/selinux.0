Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85953C433F5
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BE861078
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 12:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhKLM7N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhKLM7M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 07:59:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A88C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 04:56:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bi37so17198154lfb.5
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 04:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbY7opURwXURiL7S5FgmoBSibPPoOskunP2PNzUchPQ=;
        b=Z5lEmeES+a563ImxlukvAs+xr65YyXOaWNnkd8bxco6qmvjI23xjd/xya3WssDiQPB
         sngskXB+3ycJ7SvqTCumBCJNoMydvknXb2Yq2lJm3eteRZzMNdtLDfBDTLuAIZpjSPEZ
         kRsJaEzifiW+wxmYoCd7skxB8LQ4KuP1ZUDp/cfujpufulliXeXSC1aVhxbpiocC+cup
         cVJ7OA3Zn42nC3hx2eptFXcyDG8Jej51LiEqmCsg0y+FQhO/W1YizjPCeuywmKS7uIEv
         Ja9RxEuiysWcoq2gSQKEBV3lT7qex9Vdq2d7zAtnjqFKa/Z2rti9mMLS7B2cIL3kmk25
         RXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbY7opURwXURiL7S5FgmoBSibPPoOskunP2PNzUchPQ=;
        b=AOmO5PmP0bqM/eRJKI/sjoukvaKCgDVMfMVUgvEWXzBAdTuYCac8vsuranocughfJK
         jgYk8fim/yK3Njoz1qZ8/Dv9rJmytPed8n0wtftiPdpx9uSFJaRg8s7aCu8SHTDOMD41
         VpHf2to8TU+Nqo1LxW2sDdv/WXyriY6R6wi61h7NTMgvvIjVZ6OQ2636IDV28WqmMC7W
         dy2d52Y6ulobuMgaA9Z9ODgc6T4jT3LWE4l1Q5lcssylxphCHO+LGyojiUNHWEOLLGQ6
         5KmmeF5HWB3iDv7Y2ufV4i0MI4hKjxc298bFOsbAjh1eZlkXJZWcHxx3nx5pGtC5cEpw
         eAww==
X-Gm-Message-State: AOAM532z9Xu0aJVg8kLZ1iPzwXoHMm3RF0CqSH4JHL0rAU6e1mEQ2bOV
        /5Ccwm4LpBxRJl8c71MTjyKzGzGrJeo=
X-Google-Smtp-Source: ABdhPJyntoPTtlX35xbALOW+p47feIAiG4Y6ns5ZXlQR6rfzaOc/E1s/rgEbjjVHaZpXIg2XCArlTQ==
X-Received: by 2002:a05:6512:1323:: with SMTP id x35mr14614930lfu.613.1636721779187;
        Fri, 12 Nov 2021 04:56:19 -0800 (PST)
Received: from localhost.localdomain (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id g6sm557484lfu.275.2021.11.12.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:56:18 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] selinux-notebook: New chapter: Hardening SELinux
Date:   Fri, 12 Nov 2021 14:56:05 +0200
Message-Id: <20211112125605.28915-1-toiwoton@gmail.com>
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
 src/hardening.md                 | 127 +++++++++++++++++++++++++++++++
 src/implementing_seaware_apps.md |   2 +-
 src/reference_policy.md          |   2 +-
 src/toc.md                       |   1 +
 4 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 src/hardening.md

diff --git a/src/hardening.md b/src/hardening.md
new file mode 100644
index 0000000..fa39776
--- /dev/null
+++ b/src/hardening.md
@@ -0,0 +1,127 @@
+# Hardening SELinux
+
+- [Reference Policy](#reference-policy)
+- [Custom Policy](#custom-policy)
+
+The Reference Policy sets a good basis for learning how to operate a
+system with SELinux. The policy allows the system administrators and
+users to continue using the working methods learned from time before
+familiarizing with SELinux, because of its "targeted" model and
+reasonable defaults.
+
+However, it's possible to tighten the policy considerably. The
+Reference Policy gives several options for hardening but for maximum
+control over the policy, it's possible to write custom modules or even
+replace the Reference Policy entirely.
+
+## Reference Policy
+
+The hardening suggestions are listed in the rough order of difficulty.
+
+### Booleans
+
+The Reference Policy uses booleans to control optional aspects of the
+policy. Changing the booleans is very easy way to tune the SELinux
+policy. The booleans can be also changed temporarily, without
+committing them yet to the on-disk policy, so changes are
+automatically reverted on next boot.
+
+For example, recent Firefox browsers can work with policy boolean
+`mozilla_execstack` set to `off`. This can reduce the surface to
+vulnerabilities which could use an executable stack.
+
+### Disabling Modules
+
+By default, the Reference Policy enables most policy modules to
+support any system. But when the system is known well by the
+administrator, it's possible to remove modules which aren't used.
+
+As an example, if Firefox isn't installed, module `mozilla` can be
+removed from the policy. The hardening effect comes from reducing the
+allow rules, some of which may apply to paths which aren't actively
+monitored because the corresponding application isn't installed.
+
+Care should be taken to never remove modules which actually are used,
+since this may weaken the policy instead, because the removed module
+could have contained an application more strictly than what the policy
+allows without the module.
+
+### Users and Roles
+
+In the "targeted" model, both unprivileged users and the system
+administrator (`root`) are unconfined and the TE rules are very
+relaxed. However, it's possible to change the SELinux user for these
+accounts to more confined variants.
+
+For the unprivileged users, the confined user in the Reference Policy
+is `user_u` with corresponding role `user_r`. There's also `staff_r`
+to allow transitioning to system administative roles.
+
+For the system administrator there are several options: `root` SELinux
+user, which is mostly unconfied and `sysadm_u`, which is more
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
+SELinux, the Reference Policy may need to supplemented and the
+administrators, even users, may need to be more aware of SELinux in
+order to be able to operate the system.
+
+### Network
+
+With network controls of SELinux, it's possible to enhance firewall
+rules with knowledge of SELinux types. Traditional firewall rules only
+affect the whole system by allowing certain ports and protocols but
+blocking others. With `nftables` and `iptables` it's also possible to
+make this more fine grained: certain users can access network but
+others may not. By using also SELinux controls it's possible to fine
+tune this to application level: `mozilla_t` can connect to the
+Internet but some other applications can't. SELinux packet controls
+can be also used to combine Deep Packet Inspection with SELinux TE
+rules.
+
+In an internal network of an organization, where all entities can
+agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
+allow further policy controls. In addition to SELinux domain of the
+source application, even the SELinux domain (or at least MCS/MLS
+category/sensitivity) of the target server can be used in TE rules.
+
+## Custom Policy
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
+As a minimum, it should be ensured that all continously running
+services and main user applications have a dedicated policy module or
+rules, instead of running in for example `init_t`, `initrc_t` or
+`unconfined_t` types which may offer low level of protection.
+
+It's also possible to write custom SELinux policies for an entire
+system with non-trivial effort.
+
+The rules can also be analyzed with various SELinux tools, such as
+`apol`, `sedta`, `sepolicy` and many more. With the tools it may be
+possible to find hardening opportunities or errors in the policy.
+
+The downside of making the SELinux rules as tight as possible is that
+when the applications (or hardware components or network
+configuration) are updated, there's a possibility that the rules may
+also need updating because of the changes. Less generic rules are also
+less generally useful for different configurations, so the rules may
+need tuning for each installation.
+
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

