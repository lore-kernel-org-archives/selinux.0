Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A14C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E215921841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iziq9aKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHPmS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEHPmS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321CC061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n14so1956034qke.8
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aWj/6jtHNi0V3HHXuGdni1bPMKLwjYe1dLX/5FiFsw=;
        b=Iziq9aKymw+XqF6/40GaT+9AqlTFMODl04g11JoECt3zKZGmo2n+b95FReug905WAQ
         qBIPy08ESNWocR0Zq8DpV4xXWPQ1ae62lq7QwmXope77e9rFAUmH7e2NSq64WXSnKkO2
         49m9SB8vJi8bXRyrxkQUcDfO+u8HE4ydgbJANiFCiChYRSxEdRvNZeFh+M5rej6kd5hu
         Y5vx3z5a/vxrHP3C5bVZSLaLLowSVwgIt71/zmwR/IPOtcxXRGFFtxboon0Nu+IUHio5
         9/hbU/LOWEZR0x42WHK3EMxIL4vGD3nX0f7yunV2/aOjxcRtA/1wpW1sDPB784MM8rrH
         QqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aWj/6jtHNi0V3HHXuGdni1bPMKLwjYe1dLX/5FiFsw=;
        b=YvayPWl1db74thJGJbcQ5IJpqy7yjUBpj6cKv2GW0K8X8YjfpIQ7SnlBTjVU6TEFTm
         /VJr8r5NwrRSqeZ//E/x0O9YxkVSisiy1XAPz+9/0m8INRfYxXMgdtW94IJrcC2C2B4h
         S4tN0ua8SYnnYe9CEqZaO1HWFhI0fC2t0wAy8Pp+0f/JBgKpOIDkFtkjOIY/2/LHxrBX
         6syyChn7PdWT+gtMZ0k/HYiDAlL82vnXsB1v5ILgZiVS/IXFkk+Cx8WT6DXs9/sVA/oV
         MohNVtc4ksJlrSItrYcYat66XGbrRUe8SUd0W/Xj7byVVmhNzYXGaN7f50xMpVIMdrrV
         sNCw==
X-Gm-Message-State: AGi0PuYwm+whtBoJDojnWIMV3BjW3F1P3FA0qX3R36d6Son0Yyd1LTjw
        XRyNtUaPKUSItKZNkuHCGRMO0TiY
X-Google-Smtp-Source: APiQypIzxl53+hxYTFhiEIKEznE2A9w2dXHIR5IP4Mzhvf2YU1mNIwZBuX79YGIaVO3R5yauTRXGRA==
X-Received: by 2002:a37:4e08:: with SMTP id c8mr3469904qkb.60.1588952537063;
        Fri, 08 May 2020 08:42:17 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:16 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 00/15] Update to work on Debian
Date:   Fri,  8 May 2020 11:41:23 -0400
Message-Id: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the selinux testsuite to work on Debian and provide
instructions for building and running it there.

v4 splits the patch into one patch per logical change, updates
some of the descriptions, drops an unnecessary constraint
(only appear to need the peer recv constraint from Fedora for
the current tests, not the packet/SECMARK constraint), cleans up
the Makefile, and updates the test for noexec dev to match
any "/dev .*noexec" instead of just devtmpfs since not everyone
uses devtmpfs.

Stephen Smalley (15):
  test_capable_net.te: remove corenet_tcp/udp_sendrecv_all_ports()
  test_execute_no_trans.te: stop using mmap_file_perms
  test_ibendport.te: use dev_rw_infiniband_mgmt_dev()
  test_global.te: allow test domains to statfs selinuxfs
  test_inet_socket.te: switch from generic_port to
    _all_unreserved_ports()
  test_sctp.te: make netlabel_peer_t a MCS-constrained type
  test_policy.if: use ptynode instead of unconfined_devpts_t
  test_overlayfs.te: allow test_overlay_mounter_t to read user tmp files
  policy: Add MCS constraint on peer recv
  policy: Add defaultrange rules for overlay tests
  test_filesystem.te,tests/{fs_}filesystem: do not force user identity
    to system_u
  policy/Makefile: conditionalize setting of allow_domain_fd_use
  tests/cap_userns: set /proc/sys/kernel/unprivileged_userns_clone if
    needed
  tests/mmap: skip /dev/zero tests if /dev is noexec
  README.md: Add instructions for Debian

 README.md                            | 66 +++++++++++++++++++++++++++-
 policy/Makefile                      | 23 +++++++---
 policy/test_capable_net.te           |  2 -
 policy/test_execute_no_trans.te      |  3 +-
 policy/test_filesystem.te            |  1 +
 policy/test_global.te                |  1 +
 policy/test_ibendport.te             |  9 ++--
 policy/test_inet_socket.te           | 22 +++++-----
 policy/test_mlsconstrain.cil         |  2 +
 policy/test_overlay_defaultrange.cil |  7 +++
 policy/test_overlayfs.te             |  1 +
 policy/test_policy.if                |  4 +-
 policy/test_sctp.te                  |  1 +
 tests/cap_userns/test                |  8 ++++
 tests/filesystem/test                |  2 +-
 tests/fs_filesystem/test             |  2 +-
 tests/mmap/test                      | 48 +++++++++++++-------
 17 files changed, 154 insertions(+), 48 deletions(-)
 create mode 100644 policy/test_mlsconstrain.cil
 create mode 100644 policy/test_overlay_defaultrange.cil

-- 
2.23.1

