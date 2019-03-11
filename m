Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0DFC43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFBD214AF
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NQLMFobl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCKUNE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:13:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35589 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfCKUM4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 16:12:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so293412lfc.2
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2019 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQGfIgvy8nOUmE5+eg5l/WOLCDb3JWDpoVq3m2E0Nuk=;
        b=NQLMFobl3qAmEwF6+C4bWJc17wgAzJOKScuIRcM0KoW6MNqRZ0Y6VrdlrsKgZeh2Hm
         ovUvxSkSMsXEd8d+dsvYSExSPzhQwjiWHX25tUZtbpPdudDyFf5VNUVGBNyeY06GxArw
         bztDn5cnQNMnILYwDVXSDbfzvAHHHtyO7KZyy0z2Io+kPYVL0rtzJbGtOdx24UPAv0rf
         ciw95BNmWb9FxzJqAJOeHxAe3gD1y+refngESYosbx3H6F0lNKGjB6Id7+McfwS2grhF
         /BsSX1MhVKWSNibvD/HDt5yj5l0TKAIWy3Yrce0erke2AqIpqMYQrPJfCkvhetktp0dI
         7nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQGfIgvy8nOUmE5+eg5l/WOLCDb3JWDpoVq3m2E0Nuk=;
        b=Ul97CMrWyhYvJQfaz4Mxprpid17MIpHPkMT0B/EXMoJvlDPfzjbcZVlNOuoyM/hn9m
         MHfzc5nfzPOOAEb0dIBtt9tCG3BgdQc7tOMum4/XX+cWsVbLEvGCoSd9WZ7kMD4A7Roh
         OQebw979XPIPA+ymcgVVAY8OnS2Xnv6lBGzYymH7K6GqPB3GuBLJq7EWACR9BMyo+ZTo
         MAJWJ68G1+FOwsXATtj2RZdnMBeijXZ1zIP5pmE7TddcRNRe1nvwPPz113G0IiRTJyp4
         yGQSdD/tcvQzPUiJDyAqyeIYOKCHC9a5rrJWfgH3Xbl1LXC6SrlYvz1KsXzKWGuH4l2R
         mtgw==
X-Gm-Message-State: APjAAAVwvFguxUW7MWbCxG1224iMSPp0lx9qtuQFCQqD7x5v5RVuI2GJ
        +XZQM/hmqCMo9awK+j3lr4KGyiXk4k0OnYB7EvBZ
X-Google-Smtp-Source: APXvYqwybGrl9N5+LJVTbppOiRQf5zAaxdTppXHES+IikU/UmrmffKhpj53HJ3gDRCCfUeIY9b9oE8CjeHzPqfqHliI=
X-Received: by 2002:a19:2891:: with SMTP id o139mr19215795lfo.135.1552335173575;
 Mon, 11 Mar 2019 13:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190305211758.GA27437@fieldses.org>
In-Reply-To: <20190305211758.GA27437@fieldses.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Mar 2019 16:12:42 -0400
Message-ID: <CAHC9VhSg4WWw9EdTYoOAZcd=TCaPQd2yyRqxcpX9Z+gKGriQhg@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix SECURITY_LSM_NATIVE_LABELS on
 reused superblock
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 5, 2019 at 4:18 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
>
> In the case when we're reusing a superblock, selinux_sb_clone_mnt_opts()
> fails to set set_kern_flags, with the result that
> nfs_clone_sb_security() incorrectly clears NFS_CAP_SECURITY_LABEL.
>
> The result is that if you mount the same NFS filesystem twice, NFS
> security labels are turned off, even if they would work fine if you
> mounted the filesystem only once.
>
> ("fixes" may be not exactly the right tag, it may be more like
> "fixed-other-cases-but-missed-this-one".)
>
> Cc: Scott Mayhew <smayhew@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 0b4d3452b8b4 "security/selinux: allow security_sb_clone_mnt_opts..."
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  security/selinux/hooks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks for the fix.  I just merged this into selinux/stable-5.1 and
I'll send this up to Linus tomorrow.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f0e36c3492ba..5e9304567233 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -959,8 +959,11 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>         BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
>
>         /* if fs is reusing a sb, make sure that the contexts match */
> -       if (newsbsec->flags & SE_SBINITIALIZED)
> +       if (newsbsec->flags & SE_SBINITIALIZED) {
> +               if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context)
> +                       *set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
>                 return selinux_cmp_sb_context(oldsb, newsb);
> +       }
>
>         mutex_lock(&newsbsec->lock);
>
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
