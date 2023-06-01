Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1059C7EE29
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 22:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjFAWg4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjFAWgz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 18:36:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F3136
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 15:36:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-568928af8f5so22781467b3.1
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685659013; x=1688251013;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PImXdHKXqYIGgwpxjRysvZD3YRUZJhah0IyxPjnbRkw=;
        b=WPMfL28+DR8m9RECMKwuzyDm//n6MDkMcDHr3KMZ8zZi1uDgF/rCcTvQGaD5R8sZ+/
         jIccgp0c/mDPo5kSPQIQ9rzRE8i7jvdT/2ng4ztlRqtkfSGglESoY4dCd0xhCjiw1U7Q
         hUTb0fQB4LQkDwuhct50p/SsJ/cLxPbS2n1sdcumT04AtP2bWxTPxz7pf5jjj5vhTvMZ
         pazMiGncj2gCSGxegqGsYz5SZ0vF38mBBzZ2NrFGGZIYIAt8xZ2WAIhEgcCVJC71BCbl
         iqbSvyhxpTGoX9IwFMQtx/gl/AvpG3x/qtfEkNnyaMKUDkE4zlwpSnVXwYkPyYWyfyZ1
         5KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659013; x=1688251013;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PImXdHKXqYIGgwpxjRysvZD3YRUZJhah0IyxPjnbRkw=;
        b=EKTc82wynegxpUtF0Hy/fcuGaR+faYy82+/+t079oiIZaXQ3IJdeTUiS5zHzpA05Jd
         qJZM6xaMBAQbIysar+a8PO1ptPfb9XGz28/45dr4K5iZZNdtVLySZ15+cxI+pV8S9rP/
         gFeQ1HZRQ/p8dlB41fzFLCoOh/Y/LT4/O/wI3I5cTMA0ihgQwUEmXuCYX0tUVsRhb0TI
         5L4+gNAgT2hca7YclyagjP7LBY5/zwvFa+S0JRtOs4TCMgV371S/d2Q1apH10FJVO6Xy
         szi38sTdMjsKRbXLNbRokuIgHjxeA6djW8w/LclLZxVK+V7ZPwaBXA1OjsRkycBdqnws
         qyZg==
X-Gm-Message-State: AC+VfDzglv+7PYu7xMRmeoUpwoq4+pvvth37BNxfIOlV9r6fhp+2N3LB
        cUTBja/2AbWK5DPyamSZcgn1CzJPAbewb8LO6mNnJPBnw6CcPbHFKg==
X-Google-Smtp-Source: ACHHUZ6j51bxMN1pllUCH0uJbZMMwIUnalz8OH51UHJC4o4HY08JH3njFjsw4KpBD83SHJOP4TFmxmm7zZ7f/dUWJEg=
X-Received: by 2002:a0d:d651:0:b0:55d:626e:3dcf with SMTP id
 y78-20020a0dd651000000b0055d626e3dcfmr3779590ywd.12.1685659012670; Thu, 01
 Jun 2023 15:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214751.406786-1-paul@paul-moore.com>
In-Reply-To: <20230601214751.406786-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 18:36:42 -0400
Message-ID: <CAHC9VhQ=ysi=sOQbp_ZmZZEze-TJwUfFQ7FRB7mrGTLduQf5AA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix Makefile for versions of make < v4.3
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 5:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> As noted in the comments of this commit, the current SELinux Makefile
> requires features found in make v4.3 or later, which is problematic
> as the Linux Kernel currently only requires make v3.82.  This patch
> fixes the SELinux Makefile so that it works properly on these older
> versions of make, and adds a couple of comments to the Makefile about
> how it can be improved once make v4.3 is required by the kernel.
>
> Fixes: 6f933aa7dfd0 ("selinux: more Makefile tweaks")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/Makefile | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index ab8c3093d5fd..abf19fee09f8 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -3,6 +3,11 @@
>  # Makefile for building the SELinux module as part of the kernel tree.
>  #
>
> +# NOTE: There are a number of improvements that can be made to this Make=
file
> +# once the kernel requires make v4.3 or greater; the most important feat=
ure
> +# lacking in older versions of make is support for grouped targets.  The=
se
> +# improvements are noted inline in the Makefile below ...
> +
>  obj-$(CONFIG_SECURITY_SELINUX) :=3D selinux.o
>
>  ccflags-y :=3D -I$(srctree)/security/selinux -I$(srctree)/security/selin=
ux/include
> @@ -19,11 +24,17 @@ selinux-$(CONFIG_IMA) +=3D ima.o
>
>  genhdrs :=3D flask.h av_permissions.h
>
> -$(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
> +# see the note above, replace the dependency rule with the one below:
> +#  $(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
> +$(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
>
>  quiet_cmd_genhdrs =3D GEN     $(addprefix $(obj)/,$(genhdrs))
>        cmd_genhdrs =3D $< $(addprefix $(obj)/,$(genhdrs))
>
> -targets +=3D $(genhdrs)
> -$(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/genheaders/genheaders=
 FORCE
> +# see the note above, replace the $targets and $genhdrs dependency rule =
with
> +# the lines below:

My apologies, I didn't fully refresh my patch before sending it out so
there is a slight difference in the comments, below is what I
currently have in my working branch:

-# see the note above, replace the $targets and $genhdrs dependency rule wi=
th
-# the lines below:
+# see the note above, replace the $targets and 'flask.h' rule with the lin=
es
+# below:

--=20
paul-moore.com
