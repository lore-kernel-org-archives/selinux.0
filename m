Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2595BC433F5
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 10:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiDZKyk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346792AbiDZKyh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 06:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A6B85648
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650970284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eOj+PmNuG/L9MVVcw2DNZkXRx319ekMXVUqlsoKGFXk=;
        b=PBLcU/17Y4NYaS6VGSq1KUvWOSoxi/wC/yXbco7+6dadx+FXV+H68X9LxVl7zhR6ycIbnz
        X8DWaZiTiFejcVvsb/smXxt5F+Tx3faZZ0aa4DZLTAtD4zQNhG1sF1WKqO/a2K0xwlhpSM
        oyTafnX0qAgmT1RZ4vBFp0wcbY4G+F4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-Xh25_0OtOS6Pn6oG7g2PZA-1; Tue, 26 Apr 2022 06:51:23 -0400
X-MC-Unique: Xh25_0OtOS6Pn6oG7g2PZA-1
Received: by mail-ej1-f72.google.com with SMTP id sg44-20020a170907a42c00b006f3a40146e8so2010294ejc.19
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOj+PmNuG/L9MVVcw2DNZkXRx319ekMXVUqlsoKGFXk=;
        b=6T1iQKRVcrJrqvhMSnDRmFVQuxBi9B4eP7Pd59i9M0jOtyPnLPi6cs4we/D1RRls5/
         kunl8WI6ICuuOcESIYHgb6Op1lnbQDHl6XgcPApcC0hwhynk9zwIJ3EUcIjbI3u3CiuV
         AMqIaUvyMLwWBT8U8IUzD1/Gqk+H/2jOGPwVaw0LTKsa+1Rp5m8rrBkMpRBzs9zaACmu
         AB7wy/KPWfqPVwaNXV7p4sIWFpLTOU0SZYGkH7ZM3kuM/rv7XlwwDyTARBCHYXRRtDkI
         +PT0XOFmIs6rMPVPiRniRAtGd9bGtkCkLt41Mig9JyNIf4o7Wk4OLVOo+0q0kXOTgLL4
         Qt3w==
X-Gm-Message-State: AOAM5303PbERFJBXXuwT2s2pPEblO3CP7rbz9ha7InhMOrxxSnnYycWS
        tvFIO+6p97G5Kugcg33RPVy2OH9/lRHgdv6Evh1jtwJoFRU2aaWkmgdl20oL3nv9V4nQ7B2D2Zk
        naTwRX+I5fKA4qbvUNqvz8kni1/sq/XMRHPghpI0tfo/Mj5mxJ/QAtN9rEsQq6t72WfEHjQ==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id mp27-20020a1709071b1b00b006e47fac6ce0mr20790262ejc.617.1650970282085;
        Tue, 26 Apr 2022 03:51:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp0uv+fXndhJaq7++DijZBibyB65RwQ3BxTpJj+1fKtVbHe06ctPLqleDMRZpkalURpFpgNw==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id mp27-20020a1709071b1b00b006e47fac6ce0mr20790243ejc.617.1650970281795;
        Tue, 26 Apr 2022 03:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id en13-20020a056402528d00b00423dd17c95asm5629959edb.95.2022.04.26.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:51:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH userspace v2 0/2] Support the 'self' keyword in type transitions
Date:   Tue, 26 Apr 2022 12:51:16 +0200
Message-Id: <20220426105118.506847-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v2:
- validate the flags member of filename_trans_rule_t in
  policy_validate.c (Christian Göttsche)
- add missing error check in filename_trans_rule_write()
  (Christian Göttsche)

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
 libsepol/src/policydb_validate.c           |   4 +
 libsepol/src/write.c                       |  19 ++-
 secilc/test/policy.cil                     |   3 +
 11 files changed, 298 insertions(+), 100 deletions(-)

-- 
2.35.1

