Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E04C4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAD061131
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhHEO0b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbhHEO0b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D0C061765
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so9946179ejz.1
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwsOiF47TupkcRgjT3jdmRCVNXbu6V2qd15Zk9iZsrc=;
        b=d5i36/K4nxaU9puu6UAPDO0Rc8Mk4vaSGa5JduknjvKoJ5y08xsqJDiYyS5aHcYChh
         H4jpAzhNDgwsSyLf5UTFwD0AjWFxbVkx9mRIQEYiKoA6pdY4Xe/YU9vQudeDDSQ66sJx
         nu9D4aJUvEZok/r/HQiRHdW2rjeUh4sOIm4Z1y52HS1saL5k/73+VZq6R3l7PvFZLD45
         cyhaSGmGVYjfL06EGVKEDt6oNbcJNVquS5kAmmMUNIaqratWPOTcv1/bSGD80GZ5l4yG
         UrkhjGkfLXm83FRz39jL7YKaht/zMMw/zbjW/FVtXjik6JXKt8sMm8pxRVGk8BimD/eO
         SPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwsOiF47TupkcRgjT3jdmRCVNXbu6V2qd15Zk9iZsrc=;
        b=Hhx+MV5F4snbl6r0Wwb4anZL7/L33lyljsop0ZpRSEoTyJ0Gt+GZFpTMv+7dofykBZ
         R1XSeCeiMpgxaAAX6eN7M3/BmfCglzTo3ItPzcJLO5l3CrvyqxadJscuO88uzgfTo0ZY
         HKGyyPs5LwEPqjoi98KMzPgEDW8g0fQmifqEumpp05fMrfvXaLBsY3JrK4o72IydPhMl
         t7iH7y4v9WEjHWcIIHlaT6dxNAzFvN8SRMbAicYxG+4S/NkK5Q1wppHlFGhQzTN5rYqK
         r7SvEgiLoQPf6vb8ydZcp/Ib9ec0WheVVGCOcIvxLoZnIy4A8Yn47oQJ7WQR1R9BiOty
         H5NQ==
X-Gm-Message-State: AOAM532HBM7Tfv4mfVF/niC0CBJZtmH+uZoPZqygvYlFAilp6tVJSJ1Y
        Gm8CeKePkPD1fAHWLxEP9xs6PS41h70=
X-Google-Smtp-Source: ABdhPJy/ZdW9dd9UdkuKL+CxcBo0LiP4x0XXPJTVo4Zu1YrjegCqzncF1FyQQFKro8Nwt8JGU11SGg==
X-Received: by 2002:a17:906:4917:: with SMTP id b23mr5293344ejq.468.1628173574766;
        Thu, 05 Aug 2021 07:26:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 0/7] Re-add SELinux checks for unit install operations
Date:   Thu,  5 Aug 2021 16:24:38 +0200
Message-Id: <20210805142445.61725-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The checks (permission verbs) in question are enable for the operations
enable, reenable, link and unmask and disable for the operations disable
and mask; those SELinux permissions exist in the the reference and fedora
SELinux policy.
These checks were dropped with v225 (see [1]) due to incomplete and
missing infrastructure in the unit handling code.

In addition the operations preset and revert are checked with the (also
already existing) SELinux permission reload.
(In the future I'd like to separate them into a new permission modify?
together with calls to the standard D-Bus interfaces at
org.freedesktop.DBus.Properties.Set.)

Job actions JOB_RELOAD_OR_START and JOB_VERIFY_ACTIVE are now checked with
the permission start instead of reload.

The D-Bus filter now falls back to an instance check in case no unit can
be decoded (e.g. the job has finished or the unit does not exist).

Reduced proposal of [2]/[3]
Closes: [4]

[1]: https://github.com/systemd/systemd/pull/1044
[2]: https://github.com/systemd/systemd/pull/10023
[3]: https://lore.kernel.org/selinux/20191218142808.30433-1-cgzones@googlemail.com/
[4]: https://github.com/systemd/systemd/issues/1050

Christian Göttsche (7):
  selinux: add function name to audit data
  selinux: improve debug log format
  selinux: mark _mac_selinux_generic_access_check with leading
    underscore
  core: add support for MAC checks on unit install operations
  core: implement the sd-bus generic callback for SELinux
  core: avoid bypasses in D-BUS SELinux filter
  core: tweak job_type_to_access_method SELinux permissions

 src/core/dbus-callbackdata.h             |  15 +++
 src/core/dbus-manager.c                  |  70 +++++++---
 src/core/dbus.c                          |  44 +++----
 src/core/job.c                           |  14 +-
 src/core/manager.c                       |   9 +-
 src/core/manager.h                       |   1 +
 src/core/selinux-access.c                |  75 +++++++++--
 src/core/selinux-access.h                |  17 ++-
 src/shared/install.c                     | 160 ++++++++++++++++++++---
 src/shared/install.h                     |  44 +++++--
 src/systemctl/systemctl-add-dependency.c |   2 +-
 src/systemctl/systemctl-enable.c         |  16 +--
 src/systemctl/systemctl-is-enabled.c     |   2 +-
 src/systemctl/systemctl-preset-all.c     |   2 +-
 src/test/test-install-root.c             |  88 ++++++-------
 src/test/test-install.c                  |  38 +++---
 16 files changed, 437 insertions(+), 160 deletions(-)
 create mode 100644 src/core/dbus-callbackdata.h

--
2.32.0

