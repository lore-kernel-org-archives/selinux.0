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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A642C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E7464E4B
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBWPeT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhBWPeT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 10:34:19 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A7EC061574
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 07:33:37 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id k1so1680517oop.0
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kTHWm7UMHouWfps98WmZjO3QEmMhc/j++5j7pOb3+Mk=;
        b=RCPT/xMKboXAJI1PbS7mg91g31FuQjDo8rHWVoEEYe5aGgdTP/jC2+z97z1Sr+Mq7x
         pmUtWtmU0bMhVqlNcPZMheve4ElRGz+p/Q3VPzseCYqYTFWx24xqDAwmeeryfHjYHtu/
         jZ7kMn+wCYMk8uV/I0GX1g5d+IXBzxtBxFbN6Q2A22HmJcKPpbvf1ewovE2wetdFo2Sc
         I8eN3MOB+jBxPmwnGeYYyG1nG8DCnrL+4YpMrI0rJSH8JZg9y65G2BnK+l2L/EfxnZ5G
         jbVFGwSljwcQZSa4X4y9ArWs5/Rp/iNOcBEtPG8Fi0TGAXG6MnuL3J8B4nSqIKkKbdiz
         3YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kTHWm7UMHouWfps98WmZjO3QEmMhc/j++5j7pOb3+Mk=;
        b=P5RQgFz0lOGPscyvNe7LrtYyiQHXy/pwFeg+qRwzOVfnw1jDlSI1obA8IQcPRG3Tq7
         /Hc0x6U/IQi0pBohYcUBZMYPF+73xKix9KhOEftkzHeZiggCcWJ3JvhaP3YU6c6CtC76
         7zfCWhOMl5dltCDErJoPGEkQaveW1MQbMDcJ2jiRxn9to1z0/51LeUEFA+9YHwPpRjuu
         ZhB/xX8wYe3BKVJ+dVCbZjTFrOo15Avyt/FBCGgTqvUKlFspmx5Xqo3GkBTBQNpcQbut
         tkmh47uGfFSk5ovncw3qOCmfV/5mnp0+Y1XjQ0/PPrpOpmvu5m2lkkN8e7quC1a7dgmM
         eBmA==
X-Gm-Message-State: AOAM533fWa+q034wBFTeBehSvfH2OpcqwaniBTb7L5aCSYgApkNSoYLx
        ye8Ga1krxKDFQKx7axGITKqYs6+BSVo7dPtryas=
X-Google-Smtp-Source: ABdhPJx1OItr1UarGpc7w8jLsVpgirluQud3WnsBeNwCaCknXuOB/LHulAM8SeDIeqI0dizHWOyiJQ/sYtpLv4Aqce8=
X-Received: by 2002:a4a:b302:: with SMTP id m2mr6094203ooo.59.1614094416088;
 Tue, 23 Feb 2021 07:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20210220190806.22139-1-cgzones@googlemail.com> <20210223130917.23360-1-cgzones@googlemail.com>
In-Reply-To: <20210223130917.23360-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 23 Feb 2021 10:33:25 -0500
Message-ID: <CAP+JOzTz0X+AEF3KJ1N-L8DLitit6r-+nFUegkYorFg=GSSv8g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: handle SID without assigned context when
 writing policy.conf
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 23, 2021 at 8:13 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> CIL permits not assigning a context to a SID, e.g. to an unused initial
> SID, e.g. 'any_socket'.
>
> When using the example policy from the SELinux Notebook,
> https://github.com/SELinuxProject/selinux-notebook/blob/main/src/notebook=
-examples/cil-policy/cil-policy.cil,
> secilc logs:
>
>     No context assigned to SID any_socket, omitting from policy at cil-po=
licy.cil:166
>
> But secil2conf segfaults when writing the policy.conf:
>
>     ../cil/src/cil_policy.c:274:2: runtime error: member access within nu=
ll pointer of type 'struct cil_context'
>
> Only print the sid context statement if a context was actually assigned.
> The sid declaration is still included via cil_sid_decls_to_policy().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Oops, I should have noticed that. I was too focused on the segfault.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   Drop the statement completely in cil_sid_contexts_to_policy(),
>   cause cil_sid_decls_to_policy() will have printed the context less
>   declaration already.
>
>  libsepol/cil/src/cil_policy.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index 74edb345..91e767b7 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1660,9 +1660,11 @@ static void cil_sid_contexts_to_policy(FILE *out, =
struct cil_list *sids, int mls
>
>         cil_list_for_each(i1, sids) {
>                 sid =3D i1->data;
> -               fprintf(out, "sid %s ", sid->datum.fqn);
> -               cil_context_to_policy(out, sid->context, mls);
> -               fprintf(out,"\n");
> +               if (sid->context) {
> +                       fprintf(out, "sid %s ", sid->datum.fqn);
> +                       cil_context_to_policy(out, sid->context, mls);
> +                       fprintf(out,"\n");
> +               }
>         }
>  }
>
> --
> 2.30.1
>
