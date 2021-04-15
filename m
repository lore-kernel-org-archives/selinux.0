Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4325C433B4
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF5961139
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhDOUpa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUp3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:45:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D0C061574
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:45:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so23814487otb.7
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=20IKulgT8YDTTDbCp7o46YPxSHyaUNopKuFV7T5cxJQ=;
        b=dk1tyO6T8H/2Vv8C92q6V1Y9kpqXP6qckRCXbzkPsyeY4BJbqS4NnsC6y6xWi17mlK
         93LOe7oEbIVxs0sKDlvVif2lht8gRgQa9XgV/i5Lb7wGjhdmoO9mfyG+wO2W4Ab5x4T3
         FKg7Ro8c9/mVpBsHeWHHimB5KDXZfIkTIvMePg60lvRKyCGMLCiUWfJSSvDwlAh62u32
         hD7is8iTpuFQU1+ykXtNyFhBrT6Xn57h6OUfQrfQif2zvxThz/6DLUI5rHDHlJqAkd5g
         RMU21gn93ltQ7WyWSjlNuIMhroWtzKRyVkfW6APouQ0Vr3t7ki6C/GWyS20zlW67aOWU
         E7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=20IKulgT8YDTTDbCp7o46YPxSHyaUNopKuFV7T5cxJQ=;
        b=Xmw15xLSzv53vmIM8F2OYJxLrE9YzFS5UV6X3EsVX5L72z2YqH88+iCvxIvvAmvQih
         FxCEvAKR2c+/wYjCgDb8Vqk2QYr6lLelmAMocG50yh6g3mHgElyHXScZXeHBMcucgB5a
         Eq1CsPU8yHO5tWxNCuNgYe9qH68LG0UFvJqBtNHsmE3Eq91ul+CnYKKITSbA6X5yjz0Z
         oCGc5f3Kf434zzezX0EybLNX2JXDvwePJbLzACN8H4uFOGLGEJwW0m16ovNNp09xhwcv
         w4In+3WyZwHdtgP3W9xTg9ACHpt8x+RZ139ACnpX8FkQ+sS/YgjuMRzrPshhoODAKh+O
         PwAA==
X-Gm-Message-State: AOAM5321WU2Ju56EUJDPj06e+amkPif4O1pFuNbc+JhJSq9a8rwNTB4j
        63v7ERjSbfwaVjVez7SSLAoPm4YqK7XecPpCpo8aMg04AN0=
X-Google-Smtp-Source: ABdhPJyx5PiPOaTl/b9HhUHGlsvOLbE7qx16GBr5NY3ZpNQbJdY03c2lbmPYaDOu7F3NSIFrZZeUy9DshWD6LdsvZjA=
X-Received: by 2002:a9d:aa4:: with SMTP id 33mr828178otq.295.1618519505637;
 Thu, 15 Apr 2021 13:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210408191614.262173-1-jwcart2@gmail.com>
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Apr 2021 16:44:54 -0400
Message-ID: <CAP+JOzQo6qA9cd8a_KgDTLF3m0qip=WZaH482fG74BD6imQCCA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Various CIL patches
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 8, 2021 at 3:16 PM James Carter <jwcart2@gmail.com> wrote:
>
> All of these patches (except the first) have been sent to the list in the
> last month. The first patch is a slight modification of an earlier patch
> sent by Nicolas Iooss. I also corrected a couple of whitespace errors and
> updated one patch that would not apply cleanly with one of the earlier
> patches applied.
>
> James Carter (11):
>   libsepol/cil: Fix out-of-bound read of file context pattern ending
>     with "\"
>   libsepol/cil: Destroy classperms list when resetting classpermission
>   libsepol/cil: Destroy classperm list when resetting map perms
>   libsepol/cil: cil_reset_classperms_set() should not reset
>     classpermission
>   libsepol/cil: Set class field to NULL when resetting struct
>     cil_classperms
>   libsepol/cil: More strict verification of constraint leaf expressions
>   libsepol/cil: Exit with an error if declaration name is a reserved
>     word
>   libsepol/cil: Allow permission expressions when using map classes
>   libsepol/cil: Refactor helper function for cil_gen_node()
>   libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
>   libsepol/cil: Move check for the shadowing of macro parameters
>
>  libsepol/cil/src/cil_build_ast.c | 132 ++++++++++++-------------------
>  libsepol/cil/src/cil_build_ast.h |   2 +
>  libsepol/cil/src/cil_copy_ast.c  |  26 +++---
>  libsepol/cil/src/cil_post.c      |  11 +++
>  libsepol/cil/src/cil_reset_ast.c |  11 ++-
>  libsepol/cil/src/cil_verify.c    |  78 +++++++++++++++++-
>  libsepol/cil/src/cil_verify.h    |   3 +-
>  7 files changed, 160 insertions(+), 103 deletions(-)
>
> --
> 2.26.3
>

Most of these patches were sent out almost a month ago. I am planning
on merging them next week.
Jim
