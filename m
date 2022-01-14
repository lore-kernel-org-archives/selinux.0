Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8812DC433F5
	for <selinux@archiver.kernel.org>; Fri, 14 Jan 2022 14:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbiANOzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jan 2022 09:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiANOzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jan 2022 09:55:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BCC061574
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 06:55:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id h14so24514376ybe.12
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BrRHaQL/QigfOcx+z1jU/TryMURgQRJZmEoEYGALYM=;
        b=cLJy9FDkdxMYIl0AaggLyaURLrh8k8jWaYIRPpFGFiRAZjYDOdaXkZzVa2aOcHq3b3
         3qGyNtAkxEQEHn4fMmhG3KDI/0AAEzkZ462u/MkAaLAS9qvBTDmfmPje3sKmVkRzGDYG
         9zxdDGNmWjaf9ObI8aXz2bVx2pPGysreF+xPY57stdfB7XKtkCYrxJpqUs8Q0y5rk41f
         xBtexg0/Hp87ZWhRwfs6wgavDM5iUuOC8zgoQFKTWQKYCN5eyHy2hZAAQHI0Zujiwx3b
         k+l2bjZrPhkLK3P6Ritd6m9E7rWAt3MDwqOhsuuyvdnQK26RQIRAI7c/E8dponIYEOKg
         RwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BrRHaQL/QigfOcx+z1jU/TryMURgQRJZmEoEYGALYM=;
        b=SZw8U/B3kA+ZKyMYEYAHP9VBnnH1DRBcIoNCg44D4v5eRkUL75WpwkG4+5L2v8ijuT
         nmKZ3p2bI+NxDPLkQi0ADn3bGJB+wGAhFT/f9iZzqG6EyMQpZkoPXCiy4Km8F3mqRFS7
         7F3znpN/rSz4TsMibzJg3b7LZl3OnrDZfSzKnV2AnlameOwsVXlZVSFnF1VaYxxyERMt
         X2qgBQlCphNiCzyy9Rn5IKaSYa+x8qhT272Wsl+V75fIrXoe9iJa8xcSlfB4tKIGuWck
         G6FWXksVNBEAKx0eJXX6/XUg3hrkpQkPbliCsbUE1S311qRsCuRh5W/5EGPc5nimMsLZ
         LgEw==
X-Gm-Message-State: AOAM530rvyp384oDVut4xarl1oejAx3siIP+erK9VK0dCdQiVVatoEYf
        9ZUkkrMEDLzYxbscbR4jvQzzYLuXTlmXmzyVSHi8iGd5t3Y=
X-Google-Smtp-Source: ABdhPJxBUtPzOGas5Gbv2JujhuJ2XWKGrfrSIkbEfgwqVG4iASt62sO1levjiYe4b5vsE2KTp8DfDroESopYNyk+MWo=
X-Received: by 2002:a25:cb14:: with SMTP id b20mr11898142ybg.327.1642172139558;
 Fri, 14 Jan 2022 06:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20220110173527.582954-1-vmojzis@redhat.com> <CAFftDdqxdrfp2ekq8feF4+naYUwf1=c1anu5-i9hpEu3tpCWqw@mail.gmail.com>
In-Reply-To: <CAFftDdqxdrfp2ekq8feF4+naYUwf1=c1anu5-i9hpEu3tpCWqw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 14 Jan 2022 08:55:28 -0600
Message-ID: <CAFftDdq1F1_0HMuZSLFohcYnTadP3qc8vdgqAU4ctWCeUuwoRg@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: Improve error message when selabel_open fails
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Merged https://github.com/SELinuxProject/selinux/pull/338

Thanks,
Bill



On Tue, Jan 11, 2022 at 8:18 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 9:32 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > When selabel_open fails to locate file_context files and
> > selabel_opt_path is not specified (e.g. when the policy type is
> > missconfigured in /etc/selinux/config), perror only prints
> > "No such file or directory".
> > This can be confusing in case of "restorecon" since it's
> > not apparent that the issue is in policy store.
> >
> > Before:
> >   \# restorecon -v /tmp/foo.txt
> >   No such file or directory
> > After:
> >   \# restorecon -v /tmp/foo.txt
> >   /etc/selinux/yolo/contexts/files/file_contexts: No such file or directory
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  policycoreutils/setfiles/restore.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
> > index 74d48bb3..e9ae33ad 100644
> > --- a/policycoreutils/setfiles/restore.c
> > +++ b/policycoreutils/setfiles/restore.c
> > @@ -29,7 +29,7 @@ void restore_init(struct restore_opts *opts)
> >
> >         opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
> >         if (!opts->hnd) {
> > -               perror(opts->selabel_opt_path);
> > +               perror(opts->selabel_opt_path ? opts->selabel_opt_path : selinux_file_context_path());
> >                 exit(1);
> >         }
> >
> > --
> > 2.34.1
> >
>
> Acked-by: William Roberts <bill.c.roberts@gmail.com>
