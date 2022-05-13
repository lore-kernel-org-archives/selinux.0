Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95CC433EF
	for <selinux@archiver.kernel.org>; Fri, 13 May 2022 09:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiEMJ4i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 May 2022 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379235AbiEMJ4g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 May 2022 05:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60F642B27E
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652435793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/A/pl6VstgfdtzSJv80crgQSx2eN7/oeq9l1Ed6O6oQ=;
        b=KEBYH/F/gA9i/If75frZS21h2hSGoohjOQssJEh3LjcSu05RiXOMcsh9O4uUPIAJJybeZ6
        F93WlJyT+SukKuVqwOnYYg4Zpas06bGrQGmaqpE8H0mpIUNh+RjlTxZdc/ALy9eED9NGOA
        j5XGZ4U/9xIYLdk5xL20IA/FLgLjuKw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-H1fdbfdgMSqZ_SNAwWuS9A-1; Fri, 13 May 2022 05:56:31 -0400
X-MC-Unique: H1fdbfdgMSqZ_SNAwWuS9A-1
Received: by mail-ej1-f70.google.com with SMTP id qa15-20020a170907868f00b006f4c89bf2e3so3872044ejc.9
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 02:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/A/pl6VstgfdtzSJv80crgQSx2eN7/oeq9l1Ed6O6oQ=;
        b=SAjOGqx3J7cXMEknCiuVqM1Pizky9pNxd8LC8YaMeEZVHYsN/GO8kV0rv4B5nbuQ+U
         oIaqed8NAZAyklJEswz77yHwNKMmjd14sm5NljtI7NVPFR/4cbejiDXb02fSgP6elZ0g
         YCBpOckfhlQqHJ5iHJAyzG3EDoqBfqJmidCCAQw/xx6LgGgZzyw7VKN6vcY172+f2NbU
         RJWlwTcSJW/V312Z9agvO6b5GX3I2/Ladn3dMaWuI2tLO6Y52EZR4nsr0QqTWUDEQEkE
         173Bv5kdFTtHvXtvW9ndfBN3SrEHnd1vU/T29bg8hDM4GDtewj2AL9cB4MlYkM5B3h2F
         kHtQ==
X-Gm-Message-State: AOAM533AIIpySEPfbpMxOCsNMiz6XB17UVQZcmoCoEaTaoGoq61SYd2m
        d8tCCWvFcjC4za9zX0LxFYUD1i7USIxZ81yoND5R0pHT5kYXZCgSOcwIhJAl+0UI1gayTIfOOxZ
        VzVYNdBjhZCpWmTu7CPiWsHmC5zXzb2s8wrQLybPwum8Qq4ajLUKWVrhaw1fcwLFF4Zt/lw==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr3392986ejc.112.1652435789919;
        Fri, 13 May 2022 02:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLpX/s2MSIN2d28yhEMNF71WEFnLoj3SXrR2jmQcsz9zEszOtj5VDBrSs8mb3S5qa10nlTg==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr3392962ejc.112.1652435789655;
        Fri, 13 May 2022 02:56:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090602cd00b006f3ef214e1asm588189ejk.128.2022.05.13.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 02:56:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH userspace v4 0/2] Support the 'self' keyword in type transitions
Date:   Fri, 13 May 2022 11:56:26 +0200
Message-Id: <20220513095628.154274-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
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
kernel policydb. Since type_change and type_member rules are handled by
the same common code, these are extended with self keyword support as
well.

The patches have been tested using the following WIP beakerlib/tmt test:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f/libsepol/self-keyword-in-type-rules

Changes in v4:
- fix module_to_cil.c behavior for rules with the including self + other
  types/attributes (James Carter)
- update the test to verify the above + also type_change and type_member

Changes in v3:
- update commit messages and cover letter to state that other type rules
  also gain self keyword support with these patches (James Carter)
- error out in case a policy module containing the newly supported rules
  is downgraded to an earlier module policy version (James Carter)

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
 libsepol/src/module_to_cil.c               |   7 +
 libsepol/src/policydb.c                    |  33 +++-
 libsepol/src/policydb_validate.c           |   4 +
 libsepol/src/write.c                       |  32 +++-
 secilc/test/policy.cil                     |   7 +
 11 files changed, 302 insertions(+), 90 deletions(-)

-- 
2.36.1

