Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F11C001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHIUK7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHIUK6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:10:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D90910C4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:10:57 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c023900f3fso188952fac.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611855; x=1692216655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcd4lpuzwV3jzn/lKopjVe27KqF0ZY2po9hK2nT7bA4=;
        b=An3nhn2W9r+cAUlwJfDbM4hwP4zBSlvu9QVCWwqffbzTKJcTjLcQ6CUXg1OcnzUGWn
         m/tyeJXzAO0RC1U8iZop/GAdCLJ1SdHZ73RxwZWBnUEpY+9GEPV4TMMpGNPH+NuwxqNZ
         NCPgufJH0vGPneyXwIIdLoLa6pBn8q9cYCVphcgP59oUQelriIbsRBIEmn5PpZ9ONCAr
         XovLzwC+lywhm2622DgtqrXZShFJHOuoYw7yYafqdR37h8HHuLNI3cd8EWBwEYyHIOJ9
         nL+Ibbiuc9cm2Oyb1cVkJreUUWNem5V9HoqNYZ+x13jdjHwA8Gvj5EEHUT2MVyQ51Zar
         r24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611855; x=1692216655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcd4lpuzwV3jzn/lKopjVe27KqF0ZY2po9hK2nT7bA4=;
        b=bgmSLfWnpgRDaq1hC3ahTAKonJJ4vYO3CdWeLZRpc/su4cw80hsNk3WmrotcOAppAu
         /5dBacq/ByZmmn3X9GlcwHnADK2bPNtCkMByB0tdP+PsMx2luQPh2nG8eaHOTLzbALXZ
         qeTtF+3TcHmz6M9IHCw9vXGAnApleZz2T2K7Vmsn2pGF+JJ0qnQIAlZ9TdGUaprQdYHO
         l5EaaphVA/u6gelBuVkRn3pO3Olx1++O7NTOBnW3UmmilKbs+PIXAQLiupnmm94LMw4M
         UvtMsIeAkmey5PwlwzrdhS+G8xLqJi+ZY9KZaoQ9mDvimB7ym6IopBE/A56kR39QNv5n
         9i6Q==
X-Gm-Message-State: AOJu0YxhPIC5TKux9lAOOuWFkDSZXJ1+lAq8As5GryE4JMoL6hXiP1nj
        ct54UbPZjorqGfR563/clSR1jbwvyn8=
X-Google-Smtp-Source: AGHT+IHB/mt/3cbvCtkX2XSQJYs9tkeJfVirYNWXYeooMy4GfAyBSUTuiiAKowGpQGLMbNwWKT9HkQ==
X-Received: by 2002:a05:6870:a193:b0:1b0:222f:9cda with SMTP id a19-20020a056870a19300b001b0222f9cdamr395462oaf.0.1691611855245;
        Wed, 09 Aug 2023 13:10:55 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:10:54 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/13 v2] Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:36 -0400
Message-ID: <20230809201051.108944-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The Russian translations have not been maintained and are out of
date, so remove them.

Patch 9 in the first version was too large, so the only change
in v2 is to split the removal of the Russian translations in
the python directory into two patches.

James Carter (13):
  checkpolicy: Remove the Russian translations
  gui: Remove the Russian translations
  libselinux: Remove the Russian translations
  libselinux: Remove the Russian translations
  libsemanage: Remove the Russian translations
  libsepol: Remove the Russian translations
  mcstrans: Remove the Russian translations
  policycoreutils: Remove the Russian translations
  python: Remove the Russian translations
  python: Remove the Russian translations
  restorecond: Remove the Russian translations
  sandbox: Remove the Russian translations
  semodule-utils: Remove the Russian translations

 checkpolicy/ru/checkmodule.8                  |  55 -----
 checkpolicy/ru/checkpolicy.8                  |  60 -----
 gui/ru/selinux-polgengui.8                    |  35 ---
 gui/ru/system-config-selinux.8                |  36 ---
 libselinux/man/ru/man5/customizable_types.5   |  63 -----
 libselinux/man/ru/man5/default_contexts.5     |  75 ------
 libselinux/man/ru/man5/default_type.5         |  43 ----
 libselinux/man/ru/man5/failsafe_context.5     |  68 ------
 libselinux/man/ru/man5/file_contexts.5        |   1 -
 .../man/ru/man5/file_contexts.homedirs.5      |   1 -
 libselinux/man/ru/man5/file_contexts.local.5  |   1 -
 libselinux/man/ru/man5/file_contexts.subs.5   |   1 -
 .../man/ru/man5/file_contexts.subs_dist.5     |   1 -
 libselinux/man/ru/man5/media.5                |   1 -
 libselinux/man/ru/man5/removable_context.5    |  39 ----
 libselinux/man/ru/man5/secolor.conf.5         | 180 --------------
 libselinux/man/ru/man5/securetty_types.5      |  49 ----
 libselinux/man/ru/man5/selabel_db.5           | 219 -----------------
 libselinux/man/ru/man5/selabel_file.5         | 219 -----------------
 libselinux/man/ru/man5/selabel_media.5        |  92 --------
 libselinux/man/ru/man5/selabel_x.5            | 168 -------------
 libselinux/man/ru/man5/sepgsql_contexts.5     |   1 -
 libselinux/man/ru/man5/service_seusers.5      |  71 ------
 libselinux/man/ru/man5/seusers.5              |  67 ------
 libselinux/man/ru/man5/user_contexts.5        |  85 -------
 .../man/ru/man5/virtual_domain_context.5      |  44 ----
 .../man/ru/man5/virtual_image_context.5       |  46 ----
 libselinux/man/ru/man5/x_contexts.5           |   1 -
 libselinux/man/ru/man8/avcstat.8              |  35 ---
 libselinux/man/ru/man8/booleans.8             |  46 ----
 libselinux/man/ru/man8/getenforce.8           |  19 --
 libselinux/man/ru/man8/getsebool.8            |  40 ----
 libselinux/man/ru/man8/matchpathcon.8         |  62 -----
 libselinux/man/ru/man8/sefcontext_compile.8   |  70 ------
 libselinux/man/ru/man8/selinux.8              | 106 ---------
 libselinux/man/ru/man8/selinuxenabled.8       |  21 --
 libselinux/man/ru/man8/selinuxexeccon.8       |  28 ---
 libselinux/man/ru/man8/setenforce.8           |  32 ---
 libselinux/man/ru/man8/togglesebool.8         |  23 --
 libsemanage/man/ru/man5/semanage.conf.5       | 117 ----------
 libsepol/man/ru/man8/chkcon.8                 |  39 ----
 mcstrans/man/ru/man5/setrans.conf.5           | 106 ---------
 mcstrans/man/ru/man8/mcs.8                    |  24 --
 mcstrans/man/ru/man8/mcstransd.8              |  32 ---
 policycoreutils/load_policy/ru/load_policy.8  |  41 ----
 policycoreutils/man/ru/man5/selinux_config.5  | 136 -----------
 policycoreutils/newrole/ru/newrole.1          | 109 ---------
 policycoreutils/run_init/ru/open_init_pty.8   |  42 ----
 policycoreutils/run_init/ru/run_init.8        |  26 ---
 policycoreutils/scripts/ru/fixfiles.8         |  94 --------
 policycoreutils/secon/ru/secon.1              | 120 ----------
 policycoreutils/semodule/ru/genhomedircon.8   |  25 --
 policycoreutils/semodule/ru/semodule.8        | 133 -----------
 policycoreutils/sestatus/ru/sestatus.8        |  79 -------
 policycoreutils/sestatus/ru/sestatus.conf.5   |  97 --------
 policycoreutils/setfiles/ru/restorecon.8      | 193 ---------------
 .../setfiles/ru/restorecon_xattr.8            | 115 ---------
 policycoreutils/setfiles/ru/setfiles.8        | 221 ------------------
 policycoreutils/setsebool/ru/setsebool.8      |  27 ---
 python/audit2allow/ru/audit2allow.1           | 210 -----------------
 python/audit2allow/ru/audit2why.1             |   1 -
 python/chcat/ru/chcat.8                       |  57 -----
 python/semanage/ru/semanage-boolean.8         |  60 -----
 python/semanage/ru/semanage-dontaudit.8       |  32 ---
 python/semanage/ru/semanage-export.8          |  36 ---
 python/semanage/ru/semanage-fcontext.8        |  84 -------
 python/semanage/ru/semanage-ibendport.8       |  67 ------
 python/semanage/ru/semanage-ibpkey.8          |  67 ------
 python/semanage/ru/semanage-import.8          |  35 ---
 python/semanage/ru/semanage-interface.8       |  62 -----
 python/semanage/ru/semanage-login.8           |  67 ------
 python/semanage/ru/semanage-module.8          |  61 -----
 python/semanage/ru/semanage-node.8            |  59 -----
 python/semanage/ru/semanage-permissive.8      |  47 ----
 python/semanage/ru/semanage-port.8            |  69 ------
 python/semanage/ru/semanage-user.8            |  70 ------
 python/semanage/ru/semanage.8                 |  84 -------
 python/sepolicy/ru/sepolgen.8                 |   1 -
 python/sepolicy/ru/sepolicy-booleans.8        |  29 ---
 python/sepolicy/ru/sepolicy-communicate.8     |  40 ----
 python/sepolicy/ru/sepolicy-generate.8        | 173 --------------
 python/sepolicy/ru/sepolicy-gui.8             |  29 ---
 python/sepolicy/ru/sepolicy-interface.8       |  41 ----
 python/sepolicy/ru/sepolicy-manpage.8         |  38 ---
 python/sepolicy/ru/sepolicy-network.8         |  90 -------
 python/sepolicy/ru/sepolicy-transition.8      |  34 ---
 python/sepolicy/ru/sepolicy.8                 |  77 ------
 restorecond/ru/restorecond.8                  |  41 ----
 sandbox/ru/sandbox.5                          |  42 ----
 sandbox/ru/sandbox.8                          | 100 --------
 sandbox/ru/seunshare.8                        |  42 ----
 .../semodule_expand/ru/semodule_expand.8      |  31 ---
 .../semodule_link/ru/semodule_link.8          |  32 ---
 .../semodule_package/ru/semodule_package.8    |  48 ----
 .../semodule_package/ru/semodule_unpackage.8  |  24 --
 95 files changed, 6060 deletions(-)
 delete mode 100644 checkpolicy/ru/checkmodule.8
 delete mode 100644 checkpolicy/ru/checkpolicy.8
 delete mode 100644 gui/ru/selinux-polgengui.8
 delete mode 100644 gui/ru/system-config-selinux.8
 delete mode 100644 libselinux/man/ru/man5/customizable_types.5
 delete mode 100644 libselinux/man/ru/man5/default_contexts.5
 delete mode 100644 libselinux/man/ru/man5/default_type.5
 delete mode 100644 libselinux/man/ru/man5/failsafe_context.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.homedirs.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.local.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.subs.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.subs_dist.5
 delete mode 100644 libselinux/man/ru/man5/media.5
 delete mode 100644 libselinux/man/ru/man5/removable_context.5
 delete mode 100644 libselinux/man/ru/man5/secolor.conf.5
 delete mode 100644 libselinux/man/ru/man5/securetty_types.5
 delete mode 100644 libselinux/man/ru/man5/selabel_db.5
 delete mode 100644 libselinux/man/ru/man5/selabel_file.5
 delete mode 100644 libselinux/man/ru/man5/selabel_media.5
 delete mode 100644 libselinux/man/ru/man5/selabel_x.5
 delete mode 100644 libselinux/man/ru/man5/sepgsql_contexts.5
 delete mode 100644 libselinux/man/ru/man5/service_seusers.5
 delete mode 100644 libselinux/man/ru/man5/seusers.5
 delete mode 100644 libselinux/man/ru/man5/user_contexts.5
 delete mode 100644 libselinux/man/ru/man5/virtual_domain_context.5
 delete mode 100644 libselinux/man/ru/man5/virtual_image_context.5
 delete mode 100644 libselinux/man/ru/man5/x_contexts.5
 delete mode 100644 libselinux/man/ru/man8/avcstat.8
 delete mode 100644 libselinux/man/ru/man8/booleans.8
 delete mode 100644 libselinux/man/ru/man8/getenforce.8
 delete mode 100644 libselinux/man/ru/man8/getsebool.8
 delete mode 100644 libselinux/man/ru/man8/matchpathcon.8
 delete mode 100644 libselinux/man/ru/man8/sefcontext_compile.8
 delete mode 100644 libselinux/man/ru/man8/selinux.8
 delete mode 100644 libselinux/man/ru/man8/selinuxenabled.8
 delete mode 100644 libselinux/man/ru/man8/selinuxexeccon.8
 delete mode 100644 libselinux/man/ru/man8/setenforce.8
 delete mode 100644 libselinux/man/ru/man8/togglesebool.8
 delete mode 100644 libsemanage/man/ru/man5/semanage.conf.5
 delete mode 100644 libsepol/man/ru/man8/chkcon.8
 delete mode 100644 mcstrans/man/ru/man5/setrans.conf.5
 delete mode 100644 mcstrans/man/ru/man8/mcs.8
 delete mode 100644 mcstrans/man/ru/man8/mcstransd.8
 delete mode 100644 policycoreutils/load_policy/ru/load_policy.8
 delete mode 100644 policycoreutils/man/ru/man5/selinux_config.5
 delete mode 100644 policycoreutils/newrole/ru/newrole.1
 delete mode 100644 policycoreutils/run_init/ru/open_init_pty.8
 delete mode 100644 policycoreutils/run_init/ru/run_init.8
 delete mode 100644 policycoreutils/scripts/ru/fixfiles.8
 delete mode 100644 policycoreutils/secon/ru/secon.1
 delete mode 100644 policycoreutils/semodule/ru/genhomedircon.8
 delete mode 100644 policycoreutils/semodule/ru/semodule.8
 delete mode 100644 policycoreutils/sestatus/ru/sestatus.8
 delete mode 100644 policycoreutils/sestatus/ru/sestatus.conf.5
 delete mode 100644 policycoreutils/setfiles/ru/restorecon.8
 delete mode 100644 policycoreutils/setfiles/ru/restorecon_xattr.8
 delete mode 100644 policycoreutils/setfiles/ru/setfiles.8
 delete mode 100644 policycoreutils/setsebool/ru/setsebool.8
 delete mode 100644 python/audit2allow/ru/audit2allow.1
 delete mode 100644 python/audit2allow/ru/audit2why.1
 delete mode 100644 python/chcat/ru/chcat.8
 delete mode 100644 python/semanage/ru/semanage-boolean.8
 delete mode 100644 python/semanage/ru/semanage-dontaudit.8
 delete mode 100644 python/semanage/ru/semanage-export.8
 delete mode 100644 python/semanage/ru/semanage-fcontext.8
 delete mode 100644 python/semanage/ru/semanage-ibendport.8
 delete mode 100644 python/semanage/ru/semanage-ibpkey.8
 delete mode 100644 python/semanage/ru/semanage-import.8
 delete mode 100644 python/semanage/ru/semanage-interface.8
 delete mode 100644 python/semanage/ru/semanage-login.8
 delete mode 100644 python/semanage/ru/semanage-module.8
 delete mode 100644 python/semanage/ru/semanage-node.8
 delete mode 100644 python/semanage/ru/semanage-permissive.8
 delete mode 100644 python/semanage/ru/semanage-port.8
 delete mode 100644 python/semanage/ru/semanage-user.8
 delete mode 100644 python/semanage/ru/semanage.8
 delete mode 100644 python/sepolicy/ru/sepolgen.8
 delete mode 100644 python/sepolicy/ru/sepolicy-booleans.8
 delete mode 100644 python/sepolicy/ru/sepolicy-communicate.8
 delete mode 100644 python/sepolicy/ru/sepolicy-generate.8
 delete mode 100644 python/sepolicy/ru/sepolicy-gui.8
 delete mode 100644 python/sepolicy/ru/sepolicy-interface.8
 delete mode 100644 python/sepolicy/ru/sepolicy-manpage.8
 delete mode 100644 python/sepolicy/ru/sepolicy-network.8
 delete mode 100644 python/sepolicy/ru/sepolicy-transition.8
 delete mode 100644 python/sepolicy/ru/sepolicy.8
 delete mode 100644 restorecond/ru/restorecond.8
 delete mode 100644 sandbox/ru/sandbox.5
 delete mode 100644 sandbox/ru/sandbox.8
 delete mode 100644 sandbox/ru/seunshare.8
 delete mode 100644 semodule-utils/semodule_expand/ru/semodule_expand.8
 delete mode 100644 semodule-utils/semodule_link/ru/semodule_link.8
 delete mode 100644 semodule-utils/semodule_package/ru/semodule_package.8
 delete mode 100644 semodule-utils/semodule_package/ru/semodule_unpackage.8

-- 
2.41.0

