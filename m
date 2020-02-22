Return-Path: <SRS0=hfZQ=4K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C7DC35666
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57CE206EF
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AVwXRj//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBVTrk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:47:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39904 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVTrk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Feb 2020 14:47:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so6829484edb.6
        for <selinux@vger.kernel.org>; Sat, 22 Feb 2020 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqLK/jTuhcrBIJpThwCXNLPaByOrpXDNKST/EExrt2s=;
        b=AVwXRj//4sVQdz3HkZ6QdYxjOyFtMyxpwUmoYZ/yMJeAa1Hk7ECw52Z84JgVIcBjrl
         R4P+zFx7I3U5nZehARpLF6IJJDYUM8s2lIN92lhJeYK3V9GAcRWGGIgkalDc4e8HUm41
         kjjUhBpLmJWGmLuqkdCD2lNWTUHXYPQwXcoplck//+etiVbGVDE857urX34pgdhWF+Kq
         hCcTn/PbAr2fSU7pajDVLtJw3B2st3PXjm3bA/lysQbyNBCqB7+PaY+m6yc2JbldgVr+
         0uFgP+7MU8WZQkqZgDQTAjL1m/gMJdTSDpTeMMAuA7mN6+RqCfBq0FfIaX/r+HaORw8c
         ixIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqLK/jTuhcrBIJpThwCXNLPaByOrpXDNKST/EExrt2s=;
        b=gxZlWaQ8ib+6viB6urUHH4H+1yLjcdykSmjpaTdkm+dAENlJtUnq27PtzH7GqL+X6H
         QmdUlkrtUZJKk8qWvL/wb7DOSk1RCxl0PSEfDcY4O8H0FUPg3gJqfITEHTFXqQ9Mlsvk
         tg0csy7qyHXC9FNC0zTX2DlUopRe5f2iMbBIeynZaEN3khyTkYW/+FRpv7BHmPwL0v2l
         4+QWdjoPqwReZj+gl0XPH2F8j6Y3TBUbiDR0yijhhVeeWq9Jq8fUye7q80Ysb+76zLlb
         d3RDgVt6kphTiOAUi44G26LxhcTf++vYblSNojTdEyGN/X6MdyRk3V5pCAY1hZUdGmSR
         tU+Q==
X-Gm-Message-State: APjAAAWifkKGkd1FidScTe190v/b2QnVemj3pFGI2WB+BlXxup28oiDs
        q3p/c6BPJ5SLHnj6h4utwF38voHPscgzUDT0P5AA
X-Google-Smtp-Source: APXvYqwZnS4M0tsLf3Cy7NfSpM5uphAxmHSL7HmdPXmF2bdBG1zTzKvzgYJPp40mhPPfKhCdzpIlbncHYFjWoIpU1RQ=
X-Received: by 2002:a50:e108:: with SMTP id h8mr37533243edl.196.1582400858848;
 Sat, 22 Feb 2020 11:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20200220153234.152426-1-richard_c_haines@btinternet.com> <20200220153234.152426-2-richard_c_haines@btinternet.com>
In-Reply-To: <20200220153234.152426-2-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Feb 2020 14:47:27 -0500
Message-ID: <CAHC9VhSF1Q22tEM2xK4_GUkX5eGaZT25i9Dg6J7TfKrc-jJwLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: Add xfs quota command types
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     darrick.wong@oracle.com, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-xfs@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 20, 2020 at 10:32 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add Q_XQUOTAOFF, Q_XQUOTAON and Q_XSETQLIM to trigger filesystem quotamod
> permission check.
>
> Add Q_XGETQUOTA, Q_XGETQSTAT, Q_XGETQSTATV and Q_XGETNEXTQUOTA to trigger
> filesystem quotaget permission check.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  security/selinux/hooks.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks Richard, I've merged this into selinux/next.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 46a8f3e7d..974228313 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2145,11 +2145,18 @@ static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
>         case Q_QUOTAOFF:
>         case Q_SETINFO:
>         case Q_SETQUOTA:
> +       case Q_XQUOTAOFF:
> +       case Q_XQUOTAON:
> +       case Q_XSETQLIM:
>                 rc = superblock_has_perm(cred, sb, FILESYSTEM__QUOTAMOD, NULL);
>                 break;
>         case Q_GETFMT:
>         case Q_GETINFO:
>         case Q_GETQUOTA:
> +       case Q_XGETQUOTA:
> +       case Q_XGETQSTAT:
> +       case Q_XGETQSTATV:
> +       case Q_XGETNEXTQUOTA:
>                 rc = superblock_has_perm(cred, sb, FILESYSTEM__QUOTAGET, NULL);
>                 break;
>         default:
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
