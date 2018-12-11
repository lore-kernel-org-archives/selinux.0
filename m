Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD32BC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9833A20851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xaal2R0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9833A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLKWsV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:48:21 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:40209
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbeLKWn1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568205; bh=VJZNFIuLL4H2JkAHwCSyDFPs69oaOEs8ePiJG4WExE4=; h=From:To:Cc:Subject:Date:From:Subject; b=Xaal2R0ughXtbJZx1b1eJx5aR1BSC1h0bKrw7BRGvZ/lUiuS2/moeY2sqjofnF66odkWeQuGHTbWMG+pKz4TNBVI/B9V+lMDWTdwy0pFu0XnqW/33JRlray9+BwDdHwAhKjHTW1kVDGChTEarueVylmHbdvNao930Q9HOzafyeS4R5WgwQs69u44av7rqPSt6ZRMvWnhR4Wghr8X/88zxyv81ElRRzql1tzCWpIYUY50rR31M4kZNm2m93OlnI6G3x+K9s9dnb2zFggw/tKA4O5VMNpOOW36ZJCeUs0Awe/ROJseFozY0iJrLeTKBBmO2B0fl7hhePZHrNydCX+QrQ==
X-YMail-OSG: V0vh_m8VM1mUXJ.Ew9RkxkEd8BrAhag.7dsT.Wd7w0vgTaddLU.rNtCq1oMaseK
 Q5W4s7aCqALcG3uvrpOL6UZ.XnJljZKaKSgE1hQWkPWun1SIDoiOVHQvC.MVsc8Mgs7xX8dlzMuj
 yTe8XVgDsC.uJ_B2q7MeTFtpwNKGL6sp1IsQr67rOkWyseB9S8GrnT0u61AF47XDcqQgekEelxxc
 38C1zw62vgeI3FWQDMWh0uw4wIs5eVLIVNd4np83X2ZG3ZTyPsHcgb0W383oL5NVikJikFBeeSjc
 KYLGmkD24SFYNp857_13ib7Tvdj2NTL4XeTBPUUNEE491muKkJ.ShzQdkeHkn16tJyePWO6PBOI6
 FHEJC7CaVjZ61SPCooT.AaQmY1ZTrqpND5DI7Y9dZACKOMQP7wPMKiuwnvbeVWTe.N2JV_ORWuuk
 aWPc4YwIYFEBz4mnXKl3m50mJo9_xI3TTdY6WAULKtVt_kp26xVAinVsVlQ6eMFZt4djQOp5uFfj
 sNwkADjgHA5xAnVwa9R.fWhcMTBe7Hc1BXNFlRZdYSB4uDny.CTxi5gv9l2S5jDg60B7YzQ9Dh6X
 a.6S2tJY5LuNhXDU.JurbSupgqKgl3jyqxBE_ZffNvTMd7WlW0HclInBUd02KUnT9NUu7gzG70oP
 lFyG8qYGSBXVK63yBpDG336W0DS8LKWI8ahUDS0SMzttZpQn1.mO9fakDY506IM8mixGwciC2SjR
 H0XbVHlSQYqtLgfxuHL92z9q9wpq64_UiPqJrBOLikbDvDNFWoNiU89uAU5Mi8P.MQUx566SSAQ8
 jecM02FYgYWfMsxJLT3U33r4Q5jrjBOTLzJkOEF7D_EmyCqdZ5Ig8aME8g5dNfbirrmxLXBahHR8
 RvhZQ0_GPvtc35Kmc0rMljLlzCywiJyj.Orv21SwjPvM4VwketNVQeFNii7JbGwVMfsv2gX3oQNw
 ZBW2e9HXu6iCLy_pwyXz5ShoywKV9TJgTdeEgmy._aeMApmAIF76oOUyHzvobvob8WS2ez1yLXLD
 dENGDL5GeZhFXnuBY7Y5svWd2kBU9AewZ6veLk19okQyxwsQiS7yhsdJu.RiePDj8Wrlp94nn5xi
 pBBd9eDolxwplZ4f0sW4zph3t_kxipSQJV8aAPOsRbOZdi2z1ExqnMHru.g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
Date:   Tue, 11 Dec 2018 14:42:36 -0800
Message-Id: <20181211224314.22412-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a re-send using git-send-email instead of
the (flawwed) manual process.

v5: Include Kees Cook's rework of the lsm command
    line interface.
v4: Finer granularity in the patches and other
    cleanups suggested by Kees Cook.
    Removed dead code created by the removal of SELinux
    credential blob poisoning.
v3: Add ipc blob for SARA and task blob for Landlock.
    Removing the SELinux cred blob pointer poisoning
    results selinux_is_enabled() being unused, so it and
    all it's overhead has been removed.
    Broke up the cred infrastructure patch.
v2: Reduce the patchset to what is required to support
    the proposed SARA and LandLock security modules

The SARA security module is intended to be used
in conjunction with other security modules. It requires
state to be maintained for the credential, which
in turn requires a mechanism for sharing the credential
security blob. It also uses the ipc security blob. The
module also requires mechanism for user space manipulation
of the credential information, hence an additional
subdirectory in /proc/.../attr.

The LandLock security module provides user configurable
policy in the secmark mechanism. It requires data in
the credential, file, inode and task security blobs. For
this to be used along side the existing "major" security
modules mechanism for sharing these blobs are provided.

A side effect of providing sharing of the crendential
security blob is that the TOMOYO module can be used at
the same time as the other "major" modules.

The mechanism for configuring which security modules are
enabled has to change when stacking in enabled. Any
module that uses just the security blobs that are shared
can be selected. Additionally, one other "major" module
can be selected.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, SARA and LandLock.

git://github.com/cschaufler/lsm-stacking.git#blob-4.20-rc2

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst         |  13 +-
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 fs/proc/base.c                                  |  64 ++-
 fs/proc/internal.h                              |   1 +
 include/linux/cred.h                            |   1 -
 include/linux/lsm_hooks.h                       |  40 +-
 include/linux/security.h                        |  15 +-
 include/linux/selinux.h                         |  35 --
 kernel/cred.c                                   |  13 -
 security/Kconfig                                |  41 +-
 security/apparmor/Kconfig                       |  16 -
 security/apparmor/domain.c                      |   2 +-
 security/apparmor/include/cred.h                |  16 +-
 security/apparmor/include/file.h                |   5 +-
 security/apparmor/include/lib.h                 |   4 +
 security/apparmor/include/task.h                |  18 +-
 security/apparmor/lsm.c                         |  65 ++-
 security/apparmor/task.c                        |   6 +-
 security/commoncap.c                            |   9 +-
 security/loadpin/loadpin.c                      |   8 +-
 security/security.c                             | 635 +++++++++++++++++++++---
 security/selinux/Kconfig                        |  15 -
 security/selinux/Makefile                       |   2 +-
 security/selinux/exports.c                      |  23 -
 security/selinux/hooks.c                        | 345 ++++---------
 security/selinux/include/audit.h                |   3 -
 security/selinux/include/objsec.h               |  38 +-
 security/selinux/selinuxfs.c                    |   4 +-
 security/selinux/ss/services.c                  |   1 -
 security/selinux/xfrm.c                         |   4 +-
 security/smack/smack.h                          |  44 +-
 security/smack/smack_access.c                   |   4 +-
 security/smack/smack_lsm.c                      | 316 ++++--------
 security/smack/smackfs.c                        |  18 +-
 security/tomoyo/common.h                        |  22 +-
 security/tomoyo/domain.c                        |   4 +-
 security/tomoyo/securityfs_if.c                 |  15 +-
 security/tomoyo/tomoyo.c                        |  49 +-
 security/yama/yama_lsm.c                        |   8 +-
 39 files changed, 1133 insertions(+), 793 deletions(-)
