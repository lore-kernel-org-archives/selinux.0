Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FFDC433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE8564F68
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBCIrz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:47:55 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50183 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhBCIrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:47:55 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9C8BC561286
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:47:12 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id w8so25961389oie.2
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 00:47:12 -0800 (PST)
X-Gm-Message-State: AOAM530u9TgxuUzFBkFFxnD/ERviBwqr5Cq8uZHuht+I1bEv1yb4t5QF
        kpSGfW1kCYMDdfOtZoAvcE/nq1JgMJSODYGeljk=
X-Google-Smtp-Source: ABdhPJzE70Bsr3ovvYL4kNK5tc28oOAHdR5hgu3qU/CCoFW4/nMCqvnuQjOxHHLQw04Xg5ExF8o3iCDvKhLdFENEDz4=
X-Received: by 2002:a05:6808:918:: with SMTP id w24mr1368146oih.20.1612342031514;
 Wed, 03 Feb 2021 00:47:11 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 3 Feb 2021 09:47:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nfbM7xzR3OH4o73DzZNxvrMX12f5-TEkszqXW1K=yLdQ@mail.gmail.com>
Message-ID: <CAJfZ7=nfbM7xzR3OH4o73DzZNxvrMX12f5-TEkszqXW1K=yLdQ@mail.gmail.com>
Subject: libsepol/cil: use-after-free with optional+class common
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 09:47:13 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I am continuing to investigate OSS-Fuzz crashes and the following one
is quite complex. Here is a CIL policy which triggers a
heap-use-after-free error in the CIL compiler:

(class CLASS (PERM2))
(classorder (CLASS))
(classpermission CLSPRM)
(optional o
    (mlsvalidatetrans x (domby l1 h1))
    (common CLSCOMMON (PERM1))
    (classcommon CLASS CLSCOMMON)
)
(classpermissionset CLSPRM (CLASS (PERM1)))

The issue is that the mlsvalidatetrans fails to resolve in pass
CIL_PASS_MISC3, which comes after the resolution of classcommon (in
pass CIL_PASS_MISC2). So:

* In pass CIL_PASS_MISC2, the optional block still exists, the
classcommon is resolved and class CLASS is linked with common
CLSCOMMON.
* In pass CIL_PASS_MISC3, the optional block is destroyed, including
the common CLSCOMMON.
* When classpermissionset is resolved, function cil_resolve_classperms
uses "common_symtab = &class->common->perms;", which has been freed.
The use-after-free issue occurs in __cil_resolve_perms (in
libsepol/cil/src/cil_resolve_ast.c):

  // common_symtab was freed
  rc = cil_symtab_get_datum(common_symtab, curr->data, &perm_datum);

I have not found a simple way to fix this issue. For example there is
no way to get all the classes which references a common, from a common
object (which would be helpful to remove these references when
destructing the common). Another idea would be to implement some kind
of reference counter and only really destroy the common when this
refcount reaches zero, but the current implementation does not do such
a thing.

How should this issue be fixed?

(For those who have access, the OSS-Fuzz issue is
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29002)

Nicolas

