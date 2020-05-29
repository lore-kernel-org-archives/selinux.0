Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2421EC433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6C32073B
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYXPzqal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2OWR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgE2OWR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 10:22:17 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23917C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:22:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b18so2058214oti.1
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UZEVorzkTmjXOdoTSOHPg9Aoj1N7M0x+xkhjXcXd2c=;
        b=NYXPzqalqrTXmfD7N5RRoJImzVGHBCKgrqwlsGrrPFyVugOLOkItYc0vg6Dk0VfmcY
         wxYxqZ0Vi068eun7+7ZEI1H4b0f0JPIj81xOJAwGnugEaF+B39hzMscfdY9ruV9NyHvH
         U0rY8zQ5/8lsKMxMj2sy3SFewM7+g648PdUwRUf4IGlrnnoIg+B609qmnzejs/Xdd4Q4
         rA1cp/NzNOigYtIbS/aK+7ebACfAVT1YLjDSLc9TG5DbgMnhs2Ye6oukYPPJ9nMloGSE
         m+AG8mBh54zNp1fmeB+UJijwCV7ASWibgn6FQ2g3f1D3esqITRiTV26PyaSp/fwmyoXn
         LojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UZEVorzkTmjXOdoTSOHPg9Aoj1N7M0x+xkhjXcXd2c=;
        b=l7r2CL+nz1W6opfDeUBd/JcrJ58/pV8D6Y79BVOWn9JvieJoZVnaWuKOdfwoWKM99T
         hr+AAGuujveYy0iKx7unxTzYn7atWHE3QsQKjA6/IhD4ss6k0QwOONWzxPFygdTrjNRq
         njK94WcqTxQer+kl15L+TikzrYW8JZr8A5len2X22af48CDIA5fkldLbMG6WKklcsa++
         fkKTQFRXFWQ4QaEFER+ZlbkDVJ/aMQQSgy3G2oN8NEHFwMcDArQXcDYZpqBVDG/BmJ7u
         w9+8ZmiYelBG2HDG0OcNwAqLh90euFLkwfg7ozY1j75nwv3+R665p2Pb91j51kM6VJtZ
         ED0g==
X-Gm-Message-State: AOAM531dkeZkgP+GAcpzPrWleLOeR2uOGg/gmXAwZhk4CJninKc5Utx1
        XMdagdQB73IsrlUoBxLSpdXtJVvNNMUOc/AZh+QFe3cUhjI=
X-Google-Smtp-Source: ABdhPJzm9TtM1g2KbgH2dDRMUmuHujK1TN19U+jr11cqge6wt5RmpodMzjne3GIPW7pt14pwhznHxxXLfHuqqXJ9blI=
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr3429887otk.135.1590762136424;
 Fri, 29 May 2020 07:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200526170217.32966-1-pww@edgekeep.com>
In-Reply-To: <20200526170217.32966-1-pww@edgekeep.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 10:22:05 -0400
Message-ID: <CAEjxPJ6F75V9=vCW6V9gnA7sc-7uPm_vU7h5ppSbqZVWqC=_ZA@mail.gmail.com>
Subject: Re: [PATCH] Add restorecon -x opt to not cross FS boundaries (cf
 github #208)
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 1:04 PM Peter Whittaker <pww@edgekeep.com> wrote:
>
> Folks, this patch adds and documents a "-x" option for restorecon
> to prevent it from crossing file system boundaries, as requested
> in github issue #208.
>
> P
>
> Signed-off-by: Peter Whittaker <pww@edgekeep.com>

You didn't update the actual ropts string so restorecon -x fails even
after this patch.
Did you test your change?
In your patch description, you can put the following line before your
Signed-off-by
and drop the separate references to github issue #208 in the subject
line and body:
Fixes: https://github.com/SELinuxProject/selinux/issues/208

> ---
>  policycoreutils/setfiles/restorecon.8 |  7 +++++++
>  policycoreutils/setfiles/setfiles.c   | 11 +++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
> index bbfc83fe..0d1930de 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -13,6 +13,7 @@ restorecon \- restore file(s) default SELinux security contexts.
>  .RB [ \-F ]
>  .RB [ \-W ]
>  .RB [ \-I | \-D ]
> +.RB [ \-x ]
>  .RB [ \-e
>  .IR directory ]
>  .IR pathname \ ...
> @@ -31,6 +32,7 @@ restorecon \- restore file(s) default SELinux security contexts.
>  .RB [ \-F ]
>  .RB [ \-W ]
>  .RB [ \-I | \-D ]
> +.RB [ \-x ]
>
>  .SH "DESCRIPTION"
>  This manual page describes the
> @@ -153,6 +155,11 @@ option of GNU
>  .B find
>  produces input suitable for this mode.
>  .TP
> +.B \-x
> +prevent
> +.B restorecon
> +from crossing file system boundaries.
> +.TP
>  .SH "ARGUMENTS"
>  .IR pathname \ ...
>  The pathname for the file(s) to be relabeled.
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index 16bd592c..afd579e3 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
>  {
>         if (iamrestorecon) {
>                 fprintf(stderr,
> -                       "usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
> -                       "usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
> +                       "usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
> +                       "usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
>                         name, name);
>         } else {
>                 fprintf(stderr,
> @@ -386,6 +386,13 @@ int main(int argc, char **argv)
>                 case '0':
>                         null_terminated = 1;
>                         break;
> +                case 'x':
> +                        if (iamrestorecon) {
> +                               r_opts.xdev = SELINUX_RESTORECON_XDEV;
> +                        } else {
> +                               usage(argv[0]);
> +                        }
> +                        break;
>                 case 'h':
>                 case '?':
>                         usage(argv[0]);
> --
> 2.20.1
>
