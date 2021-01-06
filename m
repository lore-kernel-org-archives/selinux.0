Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DEC433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB2122CAF
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAFOL5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFOL5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 09:11:57 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7012C06134D
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 06:11:16 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j12so3041458ota.7
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkRGeV69SqUIVrkAILM8gY9VcjNRzgfc0MDWjTUl5ac=;
        b=gNGK+RaWSvaR5U/AZ2KKWh9COlJjzh0snvJlvv99k/t+Dp5VBsfg67MZ+FV+iCMHYm
         2Q/bQmJNYKhAiJZxffI0oSxEL3hpObx9IDO2I0CCJRUQaAj5i7SR2dkv+VK0opDEbnqT
         dwpcligEfRJg1qg7m1a5KeRr7l2/tyW4AlxPxz7e25MlBDoErHdK1MvY4iHEAWtXqP6m
         YaZ6Rh4bWGVVoqoj9WCItALw6gPlALyWXDiBMMo/4OdoV3AaEvLbKNcHUVdXCDYYIyMV
         xDjqQV2hA7KkyJxtHEUnPmuhIWfFk/9E6pEtvPqO/q334wt9EE2Y9AsDxYg560Jc9JH2
         pQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkRGeV69SqUIVrkAILM8gY9VcjNRzgfc0MDWjTUl5ac=;
        b=n09YaMT6HFei0LkjF88MCjFd9k7/IeJ12HsAlZ43AjxfbrUCOHshcq+r+ajyeruj52
         lUvuKTFSYLLFm1U7TIIGppZXieV4L6OGFUXNNoSld6vorbAjUYQ9MV3Kx73RNWsXKrcX
         wm5j5HJaFJ74rTCEMyPcc4LP9tQyXzMkuIKyGgj1ARNYiqk6m27fiWvKHIHW56LcwALZ
         kY6YHOI0cBC9lPTqLRPJ/zX3P6ZdWU1fXQJ+GMIIOcMRhG9xtbGlzbh9hw8lv37FUASu
         P1+8B/DBn+Gwcm3P1cjB8iXtMBv1JgwseSOHED+eQQWCF7pLQcWI35EydTmUDhcdIQNO
         rHfA==
X-Gm-Message-State: AOAM533JSqbITpVX3WIHE4+4/1fY8GHGeKot7ZJlpD7UZphbHLyxZKGc
        RwyOLoppwok02CS/TaFRgI6IdIilENp0LVFuMfw/IBYr
X-Google-Smtp-Source: ABdhPJznRf69sO4wLMW81k6xKlVzcv5w6/StTjlWlXAPNKZSF4/tCgBA6nOTD7MsziHi/EmSgLYWbLhnmgKk7mIwB1w=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr3277518otb.59.1609942275955;
 Wed, 06 Jan 2021 06:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20210105215443.238513-1-jwcart2@gmail.com> <CAJfZ7==zWr2b9upXx2RZi0cisp0p8apajXYE3zvea+x96ExUiw@mail.gmail.com>
In-Reply-To: <CAJfZ7==zWr2b9upXx2RZi0cisp0p8apajXYE3zvea+x96ExUiw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jan 2021 09:11:05 -0500
Message-ID: <CAP+JOzScrdkesUhLzMtv=NH_S5c3=TdFr5m=WYj7DJCg+s=27Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 5, 2021 at 6:18 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jan 5, 2021 at 10:54 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Nicolas Iooss reports:
> >   A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
> >   policy compiler (cf.
> >   https://github.com/SELinuxProject/selinux/issues/215 and
> >   https://github.com/google/oss-fuzz/pull/4790). It reported a bunch of
> >   simple issues, for which I will submit patches. There are also more
> >   subtle bugs, like the one triggered by this CIL policy:
> >
> >   (class CLASS (PERM))
> >   (classorder (CLASS))
> >   (sid SID)
> >   (sidorder (SID))
> >   (sensitivity SENS)
> >   (sensitivityorder (SENS))
> >   (type TYPE)
> >   (allow TYPE self (CLASS (PERM)))
> >
> >   (block b
> >       (optional o
> >           (sensitivitycategory SENS (C)) ; Non-existing category
> >   triggers disabling the optional
> >           (common COMMON (PERM1))
> >           (classcommon CLASS COMMON)
> >           (allow TYPE self (CLASS (PERM1)))
> >       )
> >   )
> >
> >   On my computer, secilc manages to build this policy fine, but when
> >   clang's Address Sanitizer is enabled, running secilc leads to the
> >   following report:
> >
> >   $ make -C libsepol/src CC=clang CFLAGS='-g -fsanitize=address' libsepol.a
> >   $ clang -g -fsanitize=address secilc/secilc.c libsepol/src/libsepol.a
> >   -o my_secilc
> >   $ ./my_secilc -vv testcase.cil
> >   Parsing testcase.cil
> >   Building AST from Parse Tree
> >   Destroying Parse Tree
> >   Resolving AST
> >   Failed to resolve sensitivitycategory statement at testcase.cil:12
> >   Disabling optional 'o' at testcase.cil:11
> >   Resetting declarations
> >   =================================================================
> >   ==181743==ERROR: AddressSanitizer: heap-use-after-free on address
> >   0x6070000000c0 at pc 0x55ff7e445d24 bp 0x7ffe7eecfba0 sp
> >   0x7ffe7eecfb98
> >   READ of size 4 at 0x6070000000c0 thread T0
> >       #0 0x55ff7e445d23 in __class_reset_perm_values
> >   /git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17
> >
> > The problem is that the optional branch is destroyed when it is disabled,
> > so the common has already been destroyed when the reset code tries to
> > access the number of common permissions, so that it can change the
> > value of the class permissions back to their original values.
> >
> > The solution is to count the number of class permissions and then
> > calculate the number of common permissions.
> >
> > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_reset_ast.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> > index 43e6b88e..569f630b 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -9,6 +9,16 @@ static inline void cil_reset_level(struct cil_level *level);
> >  static inline void cil_reset_levelrange(struct cil_levelrange *levelrange);
> >  static inline void cil_reset_context(struct cil_context *context);
> >
> > +static int __class_count_perms(__attribute__((unused)) hashtab_key_t k, __attribute__((unused)) hashtab_datum_t d, void *args)
> > +{
> > +       int *num = (int *)args;
> > +
> > +       (*num)++;
> > +
> > +       *((int *)args) = *num;
> > +
> > +       return SEPOL_OK;
> > +}
> >
> >  static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
> >  {
> > @@ -22,11 +32,15 @@ static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, ha
> >  static void cil_reset_class(struct cil_class *class)
> >  {
> >         if (class->common != NULL) {
> > -               struct cil_class *common = class->common;
> > -               cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
> > +               /* Must assume that the common has been destroyed */
> > +               int num_class_perms = 0;
> > +               int num_common_perms;
> > +               cil_symtab_map(&class->perms, __class_count_perms, &num_class_perms);
> > +               num_common_perms = class->num_perms - num_class_perms;
> > +               cil_symtab_map(&class->perms, __class_reset_perm_values, &num_common_perms);
> >                 /* during a re-resolve, we need to reset the common, so a classcommon
> >                  * statement isn't seen as a duplicate */
> > -               class->num_perms -= common->num_perms;
> > +               class->num_perms = num_class_perms;
> >                 class->common = NULL; /* Must make this NULL or there will be an error when re-resolving */
> >         }
> >         class->ordered = CIL_FALSE;
> > --
> > 2.25.4
> >
>
> I confirm this patch fixes the issue reported in
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28467.
> Nevertheless counting the items of a symtab_t using a callback feels
> strange. Can class->perms.table->nel (or a new accessor function that
> returns the table->nel of a symtab_t structure) be used to replace
> num_class_perms?
>

I don't know why it won't work. Let me give it a try and resend the patch.

Thanks for the suggestion.
Jim

> Thanks,
> Nicolas
>
