Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8FC46CA1
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441919AbjJLRxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441905AbjJLRxl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:53:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EEFB8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c3ca6ff5a7so14866271fa.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133217; x=1697738017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8uaxxbCkJsR+QjEGb9B0AFGVfoSE8WBY0741DMTtAs=;
        b=CAKouv1a3QOfxXlbeMci0dYHfz24t4Qg+/QGUahThUXAYzWLf1QSYcuFc0txdrtRfh
         pq/e8ULXoq5YOQ3/83dhz5Hqt+hCjkEzs/X/HIGYsL91QtwzLVc98PtQ0liGFcdBRZfu
         GEO+FH3cHVTA9M0SfOeohB+Dn0A4nLkZ0ot3OW8HwFIbV2iAxpLVqyPqbYJZszxRjS67
         Zd4QTgQeTmNskXVDidXE8ofxFJPDzd6Ha68p8QP9Yk/xt8116MPTr5ED/kH5RZyuCFEp
         dNEPQ7NNrOpatHghyUu8CaWWC5C8QKA0Pis3c+vEVQHShaALYtAlmI0AYUVH2ghjEgN2
         DPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133217; x=1697738017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8uaxxbCkJsR+QjEGb9B0AFGVfoSE8WBY0741DMTtAs=;
        b=Odi3aaOCX8HB6tjCndQDhgKO786UG8Xh0kig4eQ0I1CeYGgSUW6xkEBpyNS3A/sTHY
         jwNz4A5BM2oIo/CFochStYbpOff3li/ZN1onoLiwZdaii/VXSjWfdGcKZmy2t5HEZraJ
         9BmIQAn85srkx47l9LmtQzMcuu2mT7SbilnCrK3aeV/B0EirytQtjiPn8QpAoK38JV02
         mJL7MzEYIg4b3znBRTkikUQqqpGtTjZjRWop+PisJe6QZvqdiE73JZZFxntoBfJR618t
         xUFqH6uTuf0hNA1FgzfMGe+QDA/FfD8xoa/bXZ5J9IGwlb5xP0BazCB5yozVbCCNBnoL
         feBQ==
X-Gm-Message-State: AOJu0YyeTVQO0w//4L1fGAWUc0SJpK82CqoFsg5yM2Dqg6OWfvpNM0Zm
        KBKTE71CEng8XWubm0qYP8wlKA3lUc9ICfwJYVQ=
X-Google-Smtp-Source: AGHT+IFk0SWN4QimMPrefqnJOgxcqnnZb8gWyidVwW8kmwWBw46uaG1wG4eTVZpjGWSq6sOX+G4nK4USH1i5JTa8VXY=
X-Received: by 2002:a05:6512:2511:b0:503:258f:fd1b with SMTP id
 be17-20020a056512251100b00503258ffd1bmr23957892lfb.18.1697133217184; Thu, 12
 Oct 2023 10:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-6-cgzones@googlemail.com> <CAP+JOzQrN5jK3f3fYYbh_fpcm4ycFBMZbmD3p_UpGmX-nnEDLg@mail.gmail.com>
In-Reply-To: <CAP+JOzQrN5jK3f3fYYbh_fpcm4ycFBMZbmD3p_UpGmX-nnEDLg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:53:26 -0400
Message-ID: <CAP+JOzR7NH_o0T3qxQfDdmacLhpeEmm9DG3OH6Pv3CeJ4yoZeg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/27] setfiles: do not issue AUDIT_FS_RELABEL on
 dry run
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 1:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not issue an audit event of type AUDIT_FS_RELABEL in case of a
> > passive check.
> >
> > Print the reason for an audit_open(3) failure.
> >
> > Do not prematurely exit in case audit_open(3) fails, since all importan=
t
> > work is already done, but proceed with cleanup tasks.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/setfiles/setfiles.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setf=
iles/setfiles.c
> > index 4dd0d0dc..88a27241 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -86,23 +86,20 @@ static int canoncon(char **contextp)
> >  }
> >
> >  #ifndef USE_AUDIT
> > -static void maybe_audit_mass_relabel(int mass_relabel __attribute__((u=
nused)),
> > -                               int mass_relabel_errs __attribute__((un=
used)))
> > +static void audit_mass_relabel(int mass_relabel_errs __attribute__((un=
used)))
> >  {
> >  #else
> > -static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabe=
l_errs)
> > +static void audit_mass_relabel(int mass_relabel_errs)
> >  {
> >         int audit_fd =3D -1;
> >         int rc =3D 0;
> >
> > -       if (!mass_relabel)              /* only audit a forced full rel=
abel */
> > -               return;
> > -
> >         audit_fd =3D audit_open();
> >
> >         if (audit_fd < 0) {
> > -               fprintf(stderr, "Error connecting to audit system.\n");
> > -               exit(-1);
> > +               fprintf(stderr, "Error connecting to audit system: %s.\=
n",
> > +                       strerror(errno));
> > +               return;
> >         }
> >
> >         rc =3D audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
> > @@ -463,7 +460,8 @@ int main(int argc, char **argv)
> >                                                &skipped_errors) < 0;
> >         }
> >
> > -       maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
> > +       if (r_opts.mass_relabel && !r_opts.nochange)
> > +               audit_mass_relabel(errors);
> >
> >         if (warn_no_match)
> >                 selabel_stats(r_opts.hnd);
> > --
> > 2.40.1
> >
