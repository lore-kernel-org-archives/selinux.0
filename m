Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01CC433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349308AbiFOSS1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357937AbiFOSSS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 14:18:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297350E2D
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:18:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso17561577fac.4
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3LBtMnPHqGDqPz+ev8Zi2sWP0S1pGLpteuFlKDp56w8=;
        b=ID54ohY+YkvYCK3iNnGPOz8k3fJ8FbOtxCTmZuzfqTrDoRTsvu5eccj6v8Co4LGcng
         7MOmP7hNlIRa3wAfIJMiEfvUuJbyqCO5zgnIlmNFg4SGYN4TTMB4ESzs0ZqSZLFEqPj5
         /wGSNSwzub08mu1CCEZh7NL+MNbSRLtfY5vYbpD956XocK4VTKg9L84pYo0Di0waHaxk
         CbcJdB5OauOfOfKRZyscwmMcFmQ9rnQ8AbxXQQKlDtDdlPt0NZne7fFyJH+GXVnNL0fM
         FcqRq5xS2vi0vx/JJTPCYYsDzMw/nz85JEjh0oUh/FU6mRDTbOMnEG7CK24YBT1KR7SI
         KV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3LBtMnPHqGDqPz+ev8Zi2sWP0S1pGLpteuFlKDp56w8=;
        b=6O4S3qoJN/bLj4OW3PXx5lurkveOboUs5I2RKHp+cKK16b+J7E2TTD19XCDGQAJ3Ic
         WAz7flnXxICu2F9KXonpBU1zuXWG5vS/FR9tq9eNmoyufwP3iuPet57uLH860OOnHHWX
         mpJ0Ovk1E6zrNWiLzAoUBHCKMelz2YlXnLrWKHF/ELwGsk0kxs0I4KJZDTp9Lpb3lafD
         VGX5KlCpwFJX9gLY5aOi6QF8VOtvyq7FwcsUiWgzuCdXD+DFzdgfUXg6ywmn+CogdbRS
         /Gv3ZGOshimTqUa4UUYca2YF3oNMUhHN5F40y12Wn7UxDa17ea7oOzQ0CjNwj6zuSiiB
         QUCA==
X-Gm-Message-State: AJIora9pMthoAnDH+y65Mp+RYld95veTJFSjbkKeRc2afz9T4vCX8/DB
        kT/O6guJWZqEFPYVedL8wWWrBr8ZEjxDogl3ig0mzgfPIbk=
X-Google-Smtp-Source: AGRyM1sgZAN8OS6Dc6tEznrUd2GxYafR7ZsI+YYUfVo3k1ot9YY1nrkHya4Dgx5TSTamahILOA7daUma38BH/KuYikc=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr558942oao.182.1655317096339; Wed, 15 Jun
 2022 11:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220610150637.21133-1-cgzones@googlemail.com>
In-Reply-To: <20220610150637.21133-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 14:18:05 -0400
Message-ID: <CAP+JOzSYuPN-W-qsruMq1xGjUq-kwf_WXxz0VZAt1q_9sRY5cw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: error out if required permission would
 exceed limit
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 10, 2022 at 11:12 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> A require statement for a class permission adds that permission to the
> class representation for the current module.  In case the resulting
> class would have more than the supported amount of 32 permissions
> assigned the resulting binary module will fail to load at link-time
> without an informative error message (since [1]).
>
> Bail out if adding a permission would result in a class having more then
> the supported amount of 32 permissions assigned.
>
> [1]: https://github.com/SELinuxProject/selinux/commit/97af65f69644a3233d0=
73ae93980a0d2e51f42e1
>
> Closes: https://github.com/SELinuxProject/selinux/issues/356
> Reported-by: Julie Pichon
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/module_compiler.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 129650fa..3188af89 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -851,6 +851,14 @@ int require_class(int pass)
>                                 free(perm_id);
>                                 return -1;
>                         }
> +                       if (datum->permissions.nprim >=3D PERM_SYMTAB_SIZ=
E) {
> +                               yyerror2("Class %s would have too many pe=
rmissions "
> +                                        "to fit in an access vector with=
 permission %s",
> +                                        policydbp->p_class_val_to_name[d=
atum->s.value - 1],
> +                                        perm_id);
> +                               free(perm_id);
> +                               return -1;
> +                       }
>                         allocated =3D 1;
>                         if ((perm =3D malloc(sizeof(*perm))) =3D=3D NULL)=
 {
>                                 yyerror("Out of memory!");
> --
> 2.36.1
>
