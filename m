Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF86C433DB
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0616191D
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCVQvC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCVQue (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 12:50:34 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7EBC061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:50:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso16589864oti.11
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lDnVjHo1U/zVzO4FImavMUm4EDy25awUf7KYQchnUFo=;
        b=mf0ghEq7HpFtYN6HtUKc7wy9OZk87flGS+u3ZgQANuuZU7UhpiJFspC49POgH4SaE+
         vjrELzGyxHU+wCd8452QB5RVOvcHk4bvvJlqtu03J8cu3Lm3mh9c7L8NXv2Daw7OmU9g
         OCUz/BMBngF6V/DHQ0BaULRpihg17dW8btPzp1viy6S2srw+uEWM7gRaOb55Mk6k3GD4
         xJ+/G4jPrzLZ+yq7dQ0om/0j+hUOI2iAhImr69v3IIKGYq1V7hyt84Cyx8SFKtCXPtrE
         HVXaJ2bNLnNA/GXI1xsXj7x/1WLWNjRfN//LY+IHdEm+t2lUIhFQ9EeNbagFfCxT6ULs
         DoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lDnVjHo1U/zVzO4FImavMUm4EDy25awUf7KYQchnUFo=;
        b=IWP9GjRM3NQE6hugKW9iElQPB9U75hEKUKtEOabxIjSGZ+TdMgPS7Of51dZ2CE3Nrw
         mUMvxvwL6Tv3T95Cu3ebSYQE1YEOb+96desBeg2m1VkRSnUqhPlcljiTVuubb59RjwQw
         I1tpxZ7aavzIsjHKmkoU6eel1pPkBjNJ9ytY0LvbbSACIcYQf8Anvt5pbJrYI3efMxdV
         Rt+nPdaNVYtvR2kMM32kv4xNLLLUwO607dnjHtL6xkRDQ/lT8O7FzXI8AiAoGf5bliEg
         2PSJ9WF3Q1Idyt2lC1/X2HSOWtPwbHwh1w0nC+gJoWQSqaiHCeAp5N5/1RoeMa+CzVV0
         BRRQ==
X-Gm-Message-State: AOAM5321VHeRR0DJqr6yibwSd4ApB4htlevkYcFKC8bUp1wXABMCL7oA
        +nckz3vRQ3ndj/qhGJeLGOkxYDIFwXkDfQDX3dttaewJ+hk=
X-Google-Smtp-Source: ABdhPJz+B/urSTatFt5XBJSoRKsGPNG/1f0Gm5bD7djAV6crdjnbdPENML4lYs9GaJNwUinn3QdO/FoYw9m+IjeKZ7g=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr678263otr.59.1616431831688;
 Mon, 22 Mar 2021 09:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164703.29564-1-jwcart2@gmail.com>
In-Reply-To: <20210322164703.29564-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 22 Mar 2021 12:50:20 -0400
Message-ID: <CAP+JOzSof+B=G7Fbq9k5paAOcCEuXNrzGfCo7uPZvLQCY+9GBw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Allow permission expressions when using map classes
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Oops, sorry for the duplicate.
Jim

On Mon, Mar 22, 2021 at 12:47 PM James Carter <jwcart2@gmail.com> wrote:
>
> The following policy will cause a segfault:
>   (class CLASS (PERM))
>   (class C (P1 P2 P3))
>   (classorder (CLASS C))
>   (sid SID)
>   (sidorder (SID))
>   (user USER)
>   (role ROLE)
>   (type TYPE)
>   (category CAT)
>   (categoryorder (CAT))
>   (sensitivity SENS)
>   (sensitivityorder (SENS))
>   (sensitivitycategory SENS (CAT))
>   (allow TYPE self (CLASS (PERM)))
>   (roletype ROLE TYPE)
>   (userrole USER ROLE)
>   (userlevel USER (SENS))
>   (userrange USER ((SENS)(SENS (CAT))))
>   (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>   (classmap CM (PM1 PM2 PM3))
>   (classmapping CM PM1 (C (P1)))
>   (classmapping CM PM2 (C (P2)))
>   (classmapping CM PM3 (C (P3)))
>   (allow TYPE self (CM (and (all) (not PM2))))
>
> The problem is that, while permission expressions are allowed for
> normal classes, map classes are expected to only have permission
> lists and no check is done to verify that only a permission list
> is being used.
>
> When the above policy is parsed, the "and" and "all" are seen as
> expression operators, but when the map permissions are converted to
> normal class and permissions, the permission expression is assumed
> to be a list of datums and since the operators are not datums a
> segfault is the result.
>
> There is no reason to limit map classes to only using a list of
> permissions and, in fact, it would be better to be able to use them
> in the same way normal classes are used.
>
> Allow permissions expressions to be used for map classes by first
> evaluating the permission expression and then converting the
> resulting list to normal classes and permissions.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_post.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index d2ecbd43..6990fc07 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2130,6 +2130,10 @@ static int __evaluate_classperms_list(struct cil_list *classperms, struct cil_db
>                                 }
>                         } else { /* MAP */
>                                 struct cil_list_item *i = NULL;
> +                               rc = __evaluate_classperms(cp, db);
> +                               if (rc != SEPOL_OK) {
> +                                       goto exit;
> +                               }
>                                 cil_list_for_each(i, cp->perms) {
>                                         struct cil_perm *cmp = i->data;
>                                         rc = __evaluate_classperms_list(cmp->classperms, db);
> --
> 2.26.2
>
