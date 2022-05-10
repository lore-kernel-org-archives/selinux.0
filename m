Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22704C433F5
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 11:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiEJLnd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiEJLnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 07:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D81424BB18
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652182773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EdeFh9Bix50UVBlmt8JJzJ2deQwguEbqWXaOBtKfQ+c=;
        b=DeDDuyMvTo16fyBbsWeF7Stb52XKeGclF0vooK0H1HgmbJi6F16bXKHUIOgNwiqqMvmlXD
        XIzefXPw3lM6gUnda/4e6Qhl3Xsl95+eF5+L73OvPrnW+gS+zAMZFlyz2Nk5Wz89LuMlv+
        qO+CA319cCCrCUxYXwzJmkOUaz5z72U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-lZaOf2XLOuScvvINy-4DzQ-1; Tue, 10 May 2022 07:39:32 -0400
X-MC-Unique: lZaOf2XLOuScvvINy-4DzQ-1
Received: by mail-wm1-f70.google.com with SMTP id s14-20020a05600c29ce00b00394611a8059so1157527wmd.4
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdeFh9Bix50UVBlmt8JJzJ2deQwguEbqWXaOBtKfQ+c=;
        b=y+vB90g349YrFIqrrrB+ur4FcpA7FCbccaDRxqK7O+HdcDVaM0/hFzV3NMVtMBCO20
         id1cSKKYPXmmQB1kcSTv86RLaSJfYEI5rsiF8A6hoe9oJl18FjHtU9EZnh3Kd+OtTMhV
         MHQMtKWPcdxGto5M+dPZ+Y432zhR4L4c2YhZhMfDHMJJugx4l9OwXD+zZjA1Dxnr5ChI
         BUDnZIOUlz4KVFc3wY0HZSOWwbw04lf3yGzfquOR2irygmUB+Go8g8TiEhwSqBegbCvC
         Aa3p7uAo38vzH/ccyDW4bf0UhSebTREoDhdkhPJ/BCTHhqA0OZU9MUR/yAW/j07pm0uc
         gfbg==
X-Gm-Message-State: AOAM532KAez/09/2AP7mCZmAclT+9ylEwb3YR44X0KC/pJmO0NuaHQ4V
        NGw+vbsnGi7yVd+SPjUuIuJAgMvjOJrqluyDAAA+szu+IoICEbytlsQFUMhHf0MWdftSkD9U1TA
        EBhNdNXqVnNgyKgU+3t59ZQowhW9WvQZUYbPXkToFU1Qk6EYkNpLOUPFazavYKpzi9EI8yw==
X-Received: by 2002:adf:ec8c:0:b0:20a:dfe5:749e with SMTP id z12-20020adfec8c000000b0020adfe5749emr18568135wrn.615.1652182771059;
        Tue, 10 May 2022 04:39:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV0rQ+CC755S/DDj49dP63MuJtW/nsTBAVoCfX0rm2n+KoFCnO9MlDbJeZEflrGVN1g8M5ZQ==
X-Received: by 2002:adf:ec8c:0:b0:20a:dfe5:749e with SMTP id z12-20020adfec8c000000b0020adfe5749emr18568116wrn.615.1652182770803;
        Tue, 10 May 2022 04:39:30 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c502500b003942a244ee7sm2368855wmr.44.2022.05.10.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:39:30 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH userspace v3 0/2] Support the 'self' keyword in type transitions
Date:   Tue, 10 May 2022 13:39:27 +0200
Message-Id: <20220510113929.2780308-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.3
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
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f/libsepol/self-keyword-in-type-transitions

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
 libsepol/src/module_to_cil.c               |  30 ++--
 libsepol/src/policydb.c                    |  33 +++-
 libsepol/src/policydb_validate.c           |   4 +
 libsepol/src/write.c                       |  32 +++-
 secilc/test/policy.cil                     |   7 +
 11 files changed, 315 insertions(+), 100 deletions(-)

-- 
2.35.3

