Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E0C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 18:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DAA60FA0
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbhIPSwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349459AbhIPSwP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 14:52:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41262C121BE7
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 10:41:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so9305330otq.7
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9zvWE77w7x29csTgfNiHfUPEbGIFJ3MdK/XtErrU+c=;
        b=I3coV31rVzPvBHjThkzuKPkrqRvCeOeTfjAFsLY7PI/7a+4p+4eT5l9i6CLw2FkFMB
         WJwnIeA7JBqW6iG++WcY0t0ahJUy7Yb1mOr/6q3CVgecUsR1hFDY/7zaKS/wT9/4K4Fg
         0PsNGZgO6lw9KwvwS4sm9kN27WDMbipM/aElXLCZmHC4Yyje91q7V6L4BC9cJ4n/GWG5
         0enMrUGymehNJfgtKb6fhOCxr9Ks+VGMyqYcS6uRIuy2nGSQgLoWZYveAU7aJkQdsExB
         VYgkaLCLThvjC/TeOwm49nv5i0yxx0MFO8T5mmgZPR+eCxOnDE+kwdc+8zBYxQ82Kq0Z
         zpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9zvWE77w7x29csTgfNiHfUPEbGIFJ3MdK/XtErrU+c=;
        b=mqZljA/mJ1IfheDiwVSacrteydAMjOVejdUhpJa6raD/b6ZcMNF32Jcdq9XhW6PIMP
         cnofwzTpMgxlBrG2tglY7zHS0CsQj8NDYzGMUJVYmz3pIODEYi+fL5VbXpn6za8YH1xL
         VuwBaWXeR2tsdUDxHDf+XRm9txc5WLbLg+G8hTa9nt6YmeVnr+cLtMjEAiwBR5JrXbWd
         TIJica7qM8H2YNqBzNQEpf4aRlg3x8dNuimuG1a2jCBlgFue39Ss7kpGtBYS3R2jgQrs
         kJMnqPr0+Gjpo9rdFwCm50YJga+mUC23svN/HZrpb+0OH4SlKiNn65i+KRdFBY4Qr0dA
         ry9w==
X-Gm-Message-State: AOAM532K29Pyz+rBf+eQqhHfd5pwHcjWxvdEn6LoIBCUyaSMxIB8MsWM
        mXWdOEOiWdWx8Wkeqh3DeJAPPIPZcuw0XtiutX/B/i+4xsQ=
X-Google-Smtp-Source: ABdhPJxczr0XIChxEVRdBi1Krivu1K8w6JCiFYD4QVSV2MY7eS5rl+6AogxgGlq4HDCohEPQRnAUvlyW38tbOf01tMA=
X-Received: by 2002:a05:6830:4003:: with SMTP id h3mr5918398ots.56.1631814090584;
 Thu, 16 Sep 2021 10:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com> <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
In-Reply-To: <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 16 Sep 2021 19:41:19 +0200
Message-ID: <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 15 Sept 2021 at 20:28, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add support for genfscon per-file labeling of securityfs files. This al=
lows
> > for separate labels and therby permissions for different files, e.g.
> > /sys/kernel/security/integrity/ima/policy.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/hooks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Hi Christian,
>
> It would be nice if you could add some additional notes on how this
> was tested to the description above.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6517f221d52c..a18626424731 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
> >             !strcmp(sb->s_type->name, "tracefs") ||
> >             !strcmp(sb->s_type->name, "binder") ||
> >             !strcmp(sb->s_type->name, "bpf") ||
> > -           !strcmp(sb->s_type->name, "pstore"))
> > +           !strcmp(sb->s_type->name, "pstore") ||
> > +           !strcmp(sb->s_type->name, "securityfs"))
> >                 sbsec->flags |=3D SE_SBGENFS;
> >
> >         if (!strcmp(sb->s_type->name, "sysfs") ||
> > --
> > 2.33.0
>
> --
> paul moore
> www.paul-moore.com

Something like:

    Add support for genfscon per-file labeling of securityfs files. This al=
lows
    for separate labels and thereby access control for different files.
    For example a genfscon statement
        genfscon securityfs /integrity/ima/policy
system_u:object_r:ima_policy_t:s0
    will set a specific label to the IMA policy file and thus allow to
control the ability
    to set the IMA policy.
    Setting labels directly, e.g. via chcon(1) or setfiles(8), is
still not supported.

?
