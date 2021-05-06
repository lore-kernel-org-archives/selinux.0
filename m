Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFA6C433B4
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FF261003
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 18:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhEFSr5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 May 2021 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFSr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 May 2021 14:47:56 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D241C061574
        for <selinux@vger.kernel.org>; Thu,  6 May 2021 11:46:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso5794349oti.2
        for <selinux@vger.kernel.org>; Thu, 06 May 2021 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ke0BkVg3cT+e/eLPe0AcY3A+60IJtRpc6QmP2e3MEE=;
        b=YPpig80ua9q+UbkMhbA9a9gdsOLnndq3E898npnbjkKPauYcTzg2D/fJDyvstBMI5G
         A5XDjK1v2yHVRuqWEY7y3zfY5yjhHVMNnpgrZGmL3Ggslc0QKxmFtrDK7PKp9BT4feMF
         tbxozmCaqjASI5SKr44ebix1giAE0lTby0XqIJtizHlKbK4dHRH8i94eJ2xUGPNzmZ1I
         YBuFLE9MXR3azzXp8mZDPWYRd64FgP2lndBbLUEU8/r3Mq3DjwvUREjDtwT/Ath16Cc4
         RO9/+kV06lyqtWPg4W+PqvsZ005IQpot+gjzoelgOwi2ilA3VDAUpnOrL/qXNobTHoLM
         7ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ke0BkVg3cT+e/eLPe0AcY3A+60IJtRpc6QmP2e3MEE=;
        b=cLiJPiQPxTxhPZuMvhKtApLwJolPENhx5EKcBu3Q+7ciLQrRq0LbLp6QwnKTB21yeS
         X3BRQrHY3tjUYIuld0x3ylDpgXeKzEfQLmc44TNI29x0i4XVJ+5qnI83umjmUTlmOVlK
         awrTCRGfwP0+IlO2Vd0Ldi7qZqWEOK3a8utjocv2Ah6UmP/DwekxBiWuN60pwFuR8aCp
         GL5/GEncfgPm5ihxyVY6cUV1CWe1EGN1PCcPvpSCkmRvd9nWkGLm9JXj7G3ygV8f5J5o
         F1XK4TmTRCuIOUFsyLiorGMXjDa1kR0JmG4AINCnjWmlKI/a0fJzHD7GvPZ27s9Ng0P1
         HKDw==
X-Gm-Message-State: AOAM530jg8ap1uY9BwPJ/3ORzxnHSaoNq1NdWIm5DtlH7X0phAD5eOtJ
        fpHQCTumhKWIbOODHEvbwS5GoS4B4r4GmQugZlGl0e2Yw9M=
X-Google-Smtp-Source: ABdhPJx9/a7Tde1vuM0bRJFdQPXoaA/yCJ788FY/R4SE17GY14s8PtABggrilfVDLsDGgztZZMADcKhu5Yl53T++hYM=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr4943661otk.59.1620326817776;
 Thu, 06 May 2021 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210506170537.146337-1-jwcart2@gmail.com> <87wnsbsr0j.fsf@defensec.nl>
In-Reply-To: <87wnsbsr0j.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 6 May 2021 14:46:46 -0400
Message-ID: <CAP+JOzQhE3FrmrU6awX3+FXWbfuHe6DbLSmbFCf7cbNYQ8AFyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Fix name resolution involving inherited blocks
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 6, 2021 at 1:37 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > When resolving a name in a block that has been inherited. First,
> > a search is done in the parent namespaces (if any) of the
> > blockinherit rule with the exception of the global namespace. If
> > the name is not found, then a search is done in the namespaces of
> > the original block (starting with that block's namespace)  with
> > the exception of the global namespace. Finally, if it still has
> > not been found, the global namespace is searched.
> >
> > This does not work if a declaration is in the block being
> > inherited.
> >
>
> This example does not make sense to me
>
> 1. you shouldnt be allowed to inherit a block that is not abstracted:
> (block b) does not have a (blockabstract b)
>

You have always been allowed to inherit any block. That is by design.
The blockinherit just means that that block won't show up in policy if
nothing inherits it.

> 2. the a typeattribute is not associated with any types and so the
> compiler would filter it out since its useless
>
> I tried it out here and surprisingly the compiler does not fail, but no
> policy ends up in the result, so I do not know how you get to those results
>

You are right that the binary policy will not have either of the rules
because no types have been assigned to the attribute. It still
resolves as I stated and that can be seen by using secil2tree. It
would have been better to use a type declaration instead, but I used
typeattribute because that was what the fuzzer had used.

Thanks,
Jim

> > For example:
> >   (block b
> >     (typeattribute a)
> >     (allow a self (CLASS (PERM)))
> >   )
> >   (blockinherit b)
> >
> > This will result in a policy with the following identical allow
> > rules:
> >   (allow b.a self (CLASS (PERM)))
> >   (allow b.a self (CLASS (PERM)))
> > rather than the expected:
> >   (allow b.a self (CLASS (PERM)))
> >   (allow a self (CLASS (PERM)))
> > This is because when the typeattribute is copied while resolving
> > the inheritance, the new datum is added to the global namespace
> > and, since that is searched last, the typeattribute in block b is
> > found first.
> >
> > This behavior means that no declaration that is inherited into the
> > global namespace will actually be used.
> >
> > Instead, if the name is not found in the parent namespaces (if any)
> > where the blockinherit is located with the exception of the global
> > namespace, start the next search in the namespace of the parent of
> > the original block (instead of the original block itself). Now if
> > a declaration is inherited from the original block, the new
> > declaration will be used. This behavior seems to be the originally
> > intended behavior because there is a comment in the code that says,
> > "Continue search in original block's parent".
> >
> > This issue was found by secilc-fuzzer. If the original block
> > is made to be abstract, then the type attribute declaration
> > in the original block is not in the policy and a segfault
> > occurs when creating the binary because the copied allow rule
> > refers to a non-existent type attribute.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index f251ed15..55080396 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -4211,7 +4211,7 @@ static int __cil_resolve_name_with_parents(struct cil_tree_node *node, char *nam
> >                       rc = __cil_resolve_name_with_parents(node->parent, name, sym_index, datum);
> >                       if (rc != SEPOL_OK) {
> >                               /* Continue search in original block's parent */
> > -                             rc = __cil_resolve_name_with_parents(NODE(inherit->block), name, sym_index, datum);
> > +                             rc = __cil_resolve_name_with_parents(NODE(inherit->block)->parent, name, sym_index, datum);
> >                               goto exit;
> >                       }
> >               }
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
