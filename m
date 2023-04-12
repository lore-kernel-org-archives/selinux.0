Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1FC77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDLWBa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDLWB3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 18:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0556C0
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681336853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDp7AtnleiC6yCgNIL7FvJVoRt9tHP8JgBYdAukk04s=;
        b=G97Vetxn+omf+nwGBeD+qGIelvRY1el0C47iej24qhBF8nq86ZbdLD2yQz9Yh8fNFn1grp
        vtgakuXJmCl9ot4AzoKv/4+OwsVphjzHhHcW6HzLJpDRN16J6FetCjfsTZD6RGTH5/GdcS
        C19Oqlz+F/Kb90ivzDYlf9Or4tbMevQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-2cxTJAZXNEuHKObcNKKDDA-1; Wed, 12 Apr 2023 18:00:51 -0400
X-MC-Unique: 2cxTJAZXNEuHKObcNKKDDA-1
Received: by mail-pj1-f71.google.com with SMTP id m21-20020a17090ab79500b00247099b5e7dso570318pjr.8
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 15:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336850; x=1683928850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDp7AtnleiC6yCgNIL7FvJVoRt9tHP8JgBYdAukk04s=;
        b=jh8ySq8LnNzV0f1ka8P5cHURAdH2xFD+HbtsBs1E1zmraVfyfxGt7sBM6fuQv4CweF
         UO1sOKbe9ZULJeah76cc2jUaOkhw9NLzw+GIhC9miUogfttm4yh0XjHU8u1OlfP0YHbA
         zlRoG5QBs6KbUt6DKs0JqS9jWzY8Ai6nB7Jtom+GRrQCiDTRvcAYfQ+gjA5fYKf1vMZ2
         cmSeFJzBvGFsn9niEPBLjkB06dwZH6TD3Rj73VnjJVkTyAZvktMaWoVLPuresO+Uxw7Y
         Cj5BxJXWq7NyJsPabsHJyE7tWQ1WjJ+b90r+dZBPHby6jTcxnrQvS9yyCD1ug/bpOa+H
         h7fw==
X-Gm-Message-State: AAQBX9dAfWLFeBJ41ROV5Ipv9+D7CrdHJwRzAOolryibXh1vrJz96Jjm
        fQ6RIQxt1/nX9T9TnO14E64O67XincC4uEdHfK+GapFiyPadpyFT84dJ9fFlanKIMSccY44hplu
        WVf2Jwywmb+XeNxJ0oq2+Bf3SCC/8xrMU4lx4rV5zT1g+BE0=
X-Received: by 2002:a63:1665:0:b0:51b:fa5:7bce with SMTP id 37-20020a631665000000b0051b0fa57bcemr1028900pgw.1.1681336850232;
        Wed, 12 Apr 2023 15:00:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZFhze2DiLcLF5c+Cnnl205MiyIqbBaKTwzBvszVNvJSbIV8RvEd2E8rNp7wRI8FViiibTKSORHSAyo7iywiwQ=
X-Received: by 2002:a63:1665:0:b0:51b:fa5:7bce with SMTP id
 37-20020a631665000000b0051b0fa57bcemr1028894pgw.1.1681336849946; Wed, 12 Apr
 2023 15:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230412205429.389382-1-paul@paul-moore.com>
In-Reply-To: <20230412205429.389382-1-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 13 Apr 2023 00:00:38 +0200
Message-ID: <CAFqZXNtjnHtDXp-dS6tpHp8bDdSYHhZLu-KRVYx1wrXe4ZbKvw@mail.gmail.com>
Subject: Re: [PATCH] selinux: ensure av_permissions.h is built when needed
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> The Makefile rule responsible for building flask.h and
> av_permissions.h only lists flask.h as a target which means that
> av_permissions.h is only generated when flash.h needs to be

Typo: flash.h -> flask.h

> generated.  This patch fixes this by adding av_permissions.h as a
> target to the rule.
>
> Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build=
")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 103c2776478a..df35d4ec46f0 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -26,5 +26,5 @@ quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)/av_pe=
rmissions.h
>        cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h
>
>  targets +=3D flask.h av_permissions.h
> -$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
> +$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders/genhe=
aders FORCE

I had something like this in my patch originally, but then I couldn't
come up with a scenario where it would matter, so I dropped it... Are
you sure it's really needed? (See also the "$(addprefix
$(obj)/,$(selinux-y)): $(obj)/flask.h" rule above.)

If it is, then I think you want to use "grouped targets" instead:

    $(obj)/flask.h $(obj)/av_permissions.h &: [...]

See:
https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.html

>         $(call if_changed,flask)
> --
> 2.40.0
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

