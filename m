Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E62C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiCKQFQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiCKQFQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:05:16 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A51CE9AF
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:04:13 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso10971366ooe.6
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8WvoI2Yp3F0LzJGvGoLNbvsF/7KlKbYNZ4tZvEU6CU=;
        b=W6YhqNRBew4+uCt01evGuj+sEXMUObyGF3p54QsJsqnnJE2ELU0Wys/EJOfkE6qisy
         yCob5ruGMwKW6USlr+HHQD2C8D474BwOwV885l1h0tJdc9bFGM9TzPLHCDZGpTCY3hTX
         Wpj+ySxHMDCaTI4StBvLy/Wmv33NDiJMZ8mGxQK/gVDo9vEyrqs/SWP6PRfjvWmDNKvR
         yF2P8jnbZyfN1C1GAlXEfKvYAHoMlMSjheDcjhSkgxhtqBoA6hWpz5DA3sYXW3MxmmG4
         IBdMGdBchLGWstGYUkBcbVlhFjw1uXg9eaT3guvlhguHfkxZdAAaLGQcxuK+TdJgEoF2
         Y5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8WvoI2Yp3F0LzJGvGoLNbvsF/7KlKbYNZ4tZvEU6CU=;
        b=4XLskIs6mfZaUlCCQXBGJd9ebz1PqbIm1/kR70yr3/g5myxzkfvb2WhXPJbRQdNXiE
         TWD1u3rKJVXkDhLpXD3gz6yEQZNrh2FUvRkO/ErRBl2SDUlQkJnscX9D+bj6piBelEtX
         GEhaSKCoKMKN/oghLlTzRwVvVmcbATHIxMCUEuoQczCvbUKUNkkJNC/V2brKZ893qiqv
         X0wQv6fFOK0MAhp5ExKBgA9v+S0tpMdar25aENoUOQjLDvTIhb8Tnv1ZlXoXo8SFno6g
         UIEUGqcPH1IViAO0vXc4O8dr3Vns6lYK41ip8nSh4I32OxaXSWFxhqYeWQGJ5l0Jxl/Z
         2/Ng==
X-Gm-Message-State: AOAM530k0LTT/9tl1iDueLEIeJ7HwbYN500Mkcq0o2QF8yMvGlz4pa1P
        aaaa6lwGwCaDf4oHaRmXAf3UMgxzr1CTQbioQbA=
X-Google-Smtp-Source: ABdhPJy18NHhIbcdmf2/xsvzMZsmcb0j+4B+fQllXHjfEAXvhEtY2F/Y79zrUIhmoKNEVsgpKmrT7RSH5GLZlTtwj3I=
X-Received: by 2002:a05:6870:5a4:b0:da:b3f:3206 with SMTP id
 m36-20020a05687005a400b000da0b3f3206mr5731688oap.182.1647014652427; Fri, 11
 Mar 2022 08:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20220307105417.11913-1-richard_c_haines@btinternet.com> <CAP+JOzTa7t-LjQfTSqs5QFRvYaOpR95+jk_Xd5MoLu7otjqrmQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTa7t-LjQfTSqs5QFRvYaOpR95+jk_Xd5MoLu7otjqrmQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:04:01 -0500
Message-ID: <CAP+JOzSjRBULkdkC6topNfDmwpnTh=N4Gwf0T+Dy4Ce9D=9EyA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Shorten the policy capability enum names
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 10, 2022 at 1:33 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Mar 8, 2022 at 10:02 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > Shorten "CAPABILITY" to "CAP" following the kernel naming convention.
> >
> > The SELinux policy capability enum names should now follow the
> > "POLICYDB_CAP_XXX" format.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/include/sepol/policydb/polcaps.h | 20 ++++++++++----------
> >  libsepol/src/polcaps.c                    | 20 ++++++++++----------
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> > index 39c99839..f5e32e60 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -7,17 +7,17 @@ extern "C" {
> >
> >  /* Policy capabilities */
> >  enum {
> > -       POLICYDB_CAPABILITY_NETPEER,
> > -       POLICYDB_CAPABILITY_OPENPERM,
> > -       POLICYDB_CAPABILITY_EXTSOCKCLASS,
> > -       POLICYDB_CAPABILITY_ALWAYSNETWORK,
> > -       POLICYDB_CAPABILITY_CGROUPSECLABEL,
> > -       POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > -       POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> > -       POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
> > -       __POLICYDB_CAPABILITY_MAX
> > +       POLICYDB_CAP_NETPEER,
> > +       POLICYDB_CAP_OPENPERM,
> > +       POLICYDB_CAP_EXTSOCKCLASS,
> > +       POLICYDB_CAP_ALWAYSNETWORK,
> > +       POLICYDB_CAP_CGROUPSECLABEL,
> > +       POLICYDB_CAP_NNP_NOSUID_TRANSITION,
> > +       POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> > +       POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > +       __POLICYDB_CAP_MAX
> >  };
> > -#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > +#define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> >
> >  /* Convert a capability name to number. */
> >  extern int sepol_polcap_getnum(const char *name);
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index a5e515f2..687e971c 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -6,14 +6,14 @@
> >  #include <sepol/policydb/polcaps.h>
> >
> >  static const char * const polcap_names[] = {
> > -       "network_peer_controls",        /* POLICYDB_CAPABILITY_NETPEER */
> > -       "open_perms",                   /* POLICYDB_CAPABILITY_OPENPERM */
> > -       "extended_socket_class",        /* POLICYDB_CAPABILITY_EXTSOCKCLASS */
> > -       "always_check_network",         /* POLICYDB_CAPABILITY_ALWAYSNETWORK */
> > -       "cgroup_seclabel",              /* POLICYDB_CAPABILITY_SECLABEL */
> > -       "nnp_nosuid_transition",        /* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
> > -       "genfs_seclabel_symlinks",      /* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
> > -       "ioctl_skip_cloexec",           /* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
> > +       "network_peer_controls",        /* POLICYDB_CAP_NETPEER */
> > +       "open_perms",                   /* POLICYDB_CAP_OPENPERM */
> > +       "extended_socket_class",        /* POLICYDB_CAP_EXTSOCKCLASS */
> > +       "always_check_network",         /* POLICYDB_CAP_ALWAYSNETWORK */
> > +       "cgroup_seclabel",              /* POLICYDB_CAP_SECLABEL */
> > +       "nnp_nosuid_transition",        /* POLICYDB_CAP_NNP_NOSUID_TRANSITION */
> > +       "genfs_seclabel_symlinks",      /* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
> > +       "ioctl_skip_cloexec",           /* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
> >         NULL
> >  };
> >
> > @@ -21,7 +21,7 @@ int sepol_polcap_getnum(const char *name)
> >  {
> >         int capnum;
> >
> > -       for (capnum = 0; capnum <= POLICYDB_CAPABILITY_MAX; capnum++) {
> > +       for (capnum = 0; capnum <= POLICYDB_CAP_MAX; capnum++) {
> >                 if (polcap_names[capnum] == NULL)
> >                         continue;
> >                 if (strcasecmp(polcap_names[capnum], name) == 0)
> > @@ -32,7 +32,7 @@ int sepol_polcap_getnum(const char *name)
> >
> >  const char *sepol_polcap_getname(unsigned int capnum)
> >  {
> > -       if (capnum > POLICYDB_CAPABILITY_MAX)
> > +       if (capnum > POLICYDB_CAP_MAX)
> >                 return NULL;
> >
> >         return polcap_names[capnum];
> > --
> > 2.35.1
> >
