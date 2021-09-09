Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9437C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32BD6103C
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 19:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhIITwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIITwX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Sep 2021 15:52:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8CC061574
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 12:51:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s20so4067814oiw.3
        for <selinux@vger.kernel.org>; Thu, 09 Sep 2021 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYmKmzFYXCf2iz+KdHqoH9WS9StYLHyhmF2ygYC4fBg=;
        b=SChBioWzh/CO1A5bTAEgnrrNUjXJWGGBPM0nTeP8ftaI7czhWh0BA4PWbt05WiZKzg
         IsooCMnGmV6KcNOE45w+/m7T4lY0+BulVZkO6QHrusEyIc63hjVza4/h9M5KCz6WqBdW
         RfDLbYidQzvyY4NtDVtN3dNAeivJfwMhMdipRYZ3frfVE2HOHqLsLre6tL/xp0ZPMg4e
         zdt0VeDkWbXJZw7HMLUDKXIpHwbMt8Qy+P0XhkVtPychQEL4vd2s2kfF9foYdHIOiix1
         a5whbJoJlj/0OMa+tC4OLQU/u+UlOWOynluM1rkK0euDyVed9tMtJfbBCGvzdicYLwwT
         391Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYmKmzFYXCf2iz+KdHqoH9WS9StYLHyhmF2ygYC4fBg=;
        b=CZpnKWGTJZuWP8dr7cwDYBfqhF+5mU3fuQLhQJujPCM+qRVQQKZ3FfcdV0cB6u4uxX
         IqMcXNFUK93+CNWtVLLZfMJxaHqIoK/iR4SptaHOZmKSV+BYAsY/kiOQBHSmBPkzk7g8
         SE4BakxKu3VFC7FDEoY6pPQwd4y6K5xPkS/C7un27Zs/pu+l8fFqAYTMMWSSO0s7xrIg
         F4mkM/knipRtc3ytGndWOCrW34k7lyQk4ZfoEoY2vlLVvfoIJISb62Iv4Yy9ZeRTyzfr
         c1Iit4HwOlRKMIQ3MrD8dfSwzgpWz4Cbm1ERL2M18n65Q1aqaRk0URehmGUlePMXUyDo
         K20w==
X-Gm-Message-State: AOAM533YqKOvxFITavfIWZ4xA4EbnbtymDIf67kHyYMHmlyS9u/+HAff
        OtGrhp4LgqGtWxOtRbH3ixVhuQYPGdb0RPNmkBM=
X-Google-Smtp-Source: ABdhPJxns3G/YPBDn3eHgjNb6NOCNS/u4dPon3LXAxV9IqOdMkIoaILY95V9S4CBn+QO/Ih6Kyu9yopiB23fgYbcZeQ=
X-Received: by 2002:aca:f189:: with SMTP id p131mr1318885oih.128.1631217073190;
 Thu, 09 Sep 2021 12:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <877dfpa7pm.fsf@redhat.com>
In-Reply-To: <877dfpa7pm.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Sep 2021 15:51:02 -0400
Message-ID: <CAP+JOzSsZzgAdHX7Tknx9vaQZiecn8fjSGmyU9RxK9rGUpLABw@mail.gmail.com>
Subject: Re: Another libsepol USE_AFTER_FREE defects detected
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 9, 2021 at 3:10 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> our internal scanner reports the following defects:
>
> Error: USE_AFTER_FREE (CWE-416): [#def1]
> libsepol/cil/src/cil_build_ast.c:473: freed_arg: "cil_gen_node" frees "class".
> libsepol/cil/src/cil_build_ast.c:480: deref_after_free: Dereferencing freed pointer "class".
> #  478|         if (parse_current->next->next != NULL) {
> #  479|                 perms = parse_current->next->next->cl_head;
> #  480|->               rc = cil_gen_perm_nodes(db, perms, ast_node, CIL_PERM, &class->num_perms);
> #  481|                 if (rc != SEPOL_OK) {
> #  482|                         goto exit;
>
> Error: USE_AFTER_FREE (CWE-416): [#def2]
> libsepol/cil/src/cil_build_ast.c:942: freed_arg: "cil_gen_node" frees "map".
> libsepol/cil/src/cil_build_ast.c:947: deref_after_free: Dereferencing freed pointer "map".
> #  945|         }
> #  946|
> #  947|->       rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_MAP_PERM, &map->num_perms);
> #  948|         if (rc != SEPOL_OK) {
> #  949|                 goto exit;
>
> Error: USE_AFTER_FREE (CWE-416): [#def3]
> libsepol/cil/src/cil_build_ast.c:1042: freed_arg: "cil_gen_node" frees "common".
> libsepol/cil/src/cil_build_ast.c:1047: deref_after_free: Dereferencing freed pointer "common".
> # 1045|         }
> # 1046|
> # 1047|->       rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_PERM, &common->num_perms);
> # 1048|         if (rc != SEPOL_OK) {
> # 1049|                 goto exit;
>
>
> They might be related to commit 0d4e568afe5a28edc5fcdcff8e925d4ec1d0d3d0
> ("libsepol/cil: Create function cil_add_decl_to_symtab() and refactor")
>
> Please take a look.
>

These are false positives. The only time the datum passed to
cil_gen_node() gets freed is when the declaration is a duplicate and
duplicate declarations are allowed and the datum is a type, type
attribute, or an optional.

It would probably be better, however, to pass the SEPOL_EEXIST back to
the calling function and to free the datum there.

Jim


> Thanks,
>
> Petr
>
