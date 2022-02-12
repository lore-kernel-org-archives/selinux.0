Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB44C433F5
	for <selinux@archiver.kernel.org>; Sat, 12 Feb 2022 17:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBLR7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Feb 2022 12:59:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiBLR7c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Feb 2022 12:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A2AF2E0AF
        for <selinux@vger.kernel.org>; Sat, 12 Feb 2022 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644688767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WvDQx/YlpbeiDDYelHT2SHMuzpCfQD74ETqwLNGiv58=;
        b=G19O7o2FJepXgZRiMWCe+GjatmyUmOPgv1L9oxp3gnCfBZaA1r6riUQ27qI2vWBxTcJvkq
        /QsDPyl7NQtYDsbJl6mrdXT5gbKp2U3lXlWZYyHFbccJHEkaNiySsLUyn7Oz6OTEIhmsb6
        5wjJtl2eSRkTwvra7ERZ40W589LAq3c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-hUGZWo-_MyKqA_yujoS81w-1; Sat, 12 Feb 2022 12:59:26 -0500
X-MC-Unique: hUGZWo-_MyKqA_yujoS81w-1
Received: by mail-ed1-f70.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso7342169edk.13
        for <selinux@vger.kernel.org>; Sat, 12 Feb 2022 09:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvDQx/YlpbeiDDYelHT2SHMuzpCfQD74ETqwLNGiv58=;
        b=OwQKsnzk/dVmya6hf2Mb0GeS5W5/D6W7MnLy2t0d6tze5MiabSVKfN96Sr1e8HTVWt
         YQCURwsd4izjTah9woEA7/XW7QbHKuCZ2XIjkPiGuTqCn/DWzmdMhH5nomLHkVUIHauH
         av+YNOdJCwboxEv9m3vTUl5N2EIvB1wPxbRf3He6jAMyBzVH/RUKUFohZaByBv4GFEae
         Z4iJUHjUWcZAVwU2KHMqApkuvFui9pkmTWyRHdOOJ8lmFr1K7oJKiS1rXxSRmAfL/JcT
         9jA2/gojTPA/b2PXDyOy0UG8zZvnqdWw4tXYfI/Gtl6A/QosyTM2n+ecUazxGblf3R+r
         bxlA==
X-Gm-Message-State: AOAM5313DCyL+eoh4GpKwmd+U6KyBPUJcQ+GrnR5RhkRetJat233D07B
        M6zf/Ufk7md81ap40Ta1qXbmhxWvUpHwCdEf4Az+uo689+k7BzGR5OGrXOHjbofj51kvSze0sl6
        LhLtxw34nFlRDyRDENA==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr5494123ejc.281.1644688764816;
        Sat, 12 Feb 2022 09:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpCLnkWipDo+gFAaDaKcNOlElyuo5FfhyBrRsys1CHR6MQDWnLUVKo21UiNITagZ4ZP8k9xg==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr5494102ejc.281.1644688764546;
        Sat, 12 Feb 2022 09:59:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id d10sm437409ejo.207.2022.02.12.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 09:59:23 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
Date:   Sat, 12 Feb 2022 18:59:20 +0100
Message-Id: <20220212175922.665442-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a third round of patches to fix the SCTP-SELinux interaction
w.r.t. client-side peeloff. The patches are a modified version of Xin
Long's patches posted previously, of which only a part was merged (the
rest was merged for a while, but was later reverted):
https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/

In gist, these patches replace the call to
security_inet_conn_established() in SCTP with a new hook
security_sctp_assoc_established() and implement the new hook in SELinux
so that the client-side association labels are set correctly (which
matters in case the association eventually gets peeled off into a
separate socket).

Note that other LSMs than SELinux don't implement the SCTP hooks nor
inet_conn_established, so they shouldn't be affected by any of these
changes.

These patches were tested by selinux-testsuite [1] with an additional
patch [2] and by lksctp-tools func_tests [3].

Changes since v2:
- patches 1 and 2 dropped as they are already in mainline (not reverted)
- in patch 3, the return value of security_sctp_assoc_established() is
  changed to int, the call is moved earlier in the function, and if the
  hook returns an error value, the packet will now be discarded,
  aborting the association
- patch 4 has been changed a lot - please see the patch description for
  details on how the hook is now implemented and why

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/
[3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests

Ondrej Mosnacek (2):
  security: add sctp_assoc_established hook
  security: implement sctp_assoc_established hook in selinux

 Documentation/security/SCTP.rst | 22 ++++----
 include/linux/lsm_hook_defs.h   |  2 +
 include/linux/lsm_hooks.h       |  5 ++
 include/linux/security.h        |  8 +++
 net/sctp/sm_statefuns.c         |  8 +--
 security/security.c             |  7 +++
 security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
 7 files changed, 103 insertions(+), 39 deletions(-)

-- 
2.34.1

