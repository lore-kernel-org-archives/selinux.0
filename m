Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5A3C433FE
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 15:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449541AbiDVPrd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449555AbiDVPrX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 11:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44F15DE6B
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650642192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CNLD/AktzEEic80RSyEVfvLl500YFX1PwWTE6hWvuJA=;
        b=F2YruDqIv3DTQCOH2IAV9gRHslebTXcEMh2VGVV33/WrK3wAli/BthKHAW03tsM/wQCW6k
        vjrS1f+29OViymI9hBEnMPptG5ImgYwf1XfRtSbQbLXO+eHdGrtnp9rygcWk8lszWznOjg
        zJ7VTSMpfF4v0py1bfv2OqnMwhQq+1I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-dAfUxXt-PBuu9TyLsIpAGg-1; Fri, 22 Apr 2022 11:43:11 -0400
X-MC-Unique: dAfUxXt-PBuu9TyLsIpAGg-1
Received: by mail-wm1-f69.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so3890666wmb.2
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 08:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNLD/AktzEEic80RSyEVfvLl500YFX1PwWTE6hWvuJA=;
        b=GpgWR+shUOuIfnQ+9zSJZ25rA1jHW2pw/sunOZVbWEYqIIDbN6GptXEfLvnkhcU9Gh
         SaDFh/I/ED4qjSFD6XTyKg3ZLJuUHlvu/yugQkBf1kGc0RIwOIs4dzCbKpjvAw++OT5n
         jpJwKloiIUQlMNS7xq5df/Sj6SO/lkB5o91+ZnyGqcrsrt5i/diPLfU5UBFcizBXJrnU
         TeJxdfs4oHlVVYMmQFVYTTkeenelRJVqpt768JWa8TJWaqKlPs1BU8JmvgqoH/Bz7HNF
         NqgJK8THtTTv5q3+FXKTPiNanc3UC1yzZtn3T7LWepxcv0FFLGBv5WSvVLdZURExtjUC
         WsXg==
X-Gm-Message-State: AOAM532NPa5ZpcDoR1zUUQ9FIe8t+t5BXffM5WKeGiVyWwpEWedSjJNL
        Eh6Jg2jdWdtIXFZrojE2BPONxCo8nogjNqoXyAcuTI/C4XXjChEja9cO93eA0niRuM87FP/FIwL
        BAM8uv/4bUMgOzVfech8z5+RWFmhom67uE+FHDn7XmIANFKOGp+F/HbImSuqkMe3lvWE2AQ==
X-Received: by 2002:a5d:6caf:0:b0:207:ab83:64c7 with SMTP id a15-20020a5d6caf000000b00207ab8364c7mr4389049wra.668.1650642189547;
        Fri, 22 Apr 2022 08:43:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmW2gGGaXnqu0fmVj3BgsnWDWitQEV9edOU31tVCFo82N8SnvQoxZaZMoyhSE5+4mYIgFeJw==
X-Received: by 2002:a5d:6caf:0:b0:207:ab83:64c7 with SMTP id a15-20020a5d6caf000000b00207ab8364c7mr4389032wra.668.1650642189268;
        Fri, 22 Apr 2022 08:43:09 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm2044080wra.96.2022.04.22.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:43:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH userspace 0/2] Support the 'self' keyword in type transitions
Date:   Fri, 22 Apr 2022 17:43:05 +0200
Message-Id: <20220422154307.968527-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the addition of the anon_inode class in the kernel, 'self'
transition rules became useful, but haven't been implemented.

This series implements the self keyword support in the CIL & TE
languages and the module policydb format. The kernel policydb format
doesn't need any changes, as type transitions are always expanded in the
kernel policydb.

The patches have been tested using the following WIP beakerlib/tmt test:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f/libsepol/self-keyword-in-type-transitions

Ondrej Mosnacek (2):
  libsepol/cil: add support for self keyword in type transitions
  libsepol,checkpolicy: add support for self keyword in type transitions

 checkpolicy/policy_define.c                |  42 +++++-
 libsepol/cil/src/cil_binary.c              | 168 +++++++++++++++------
 libsepol/cil/src/cil_resolve_ast.c         |  25 ++-
 libsepol/include/sepol/policydb/policydb.h |   4 +-
 libsepol/src/expand.c                      |  69 ++++++---
 libsepol/src/link.c                        |   1 +
 libsepol/src/module_to_cil.c               |  30 ++--
 libsepol/src/policydb.c                    |  33 +++-
 libsepol/src/write.c                       |  19 ++-
 secilc/test/policy.cil                     |   3 +
 10 files changed, 293 insertions(+), 101 deletions(-)

-- 
2.35.1

