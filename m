Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799BC3F2D2
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7019C2072A
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 19:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXyYkcD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCETJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:09:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37236 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCETJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 14:09:18 -0500
Received: by mail-io1-f65.google.com with SMTP id k4so2168997ior.4
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gX34zfq3l8r7nYkxgyigvndLmRb7KUo3sU1truBGj04=;
        b=dXyYkcD/gXuzXFxk66zbxL5dfWWgaZBcnVD78f2YGy+zFEDaDQjI68B3pcGdfFM2uP
         7cm6Aoq/j8hLOXGcPRun3KksExJ2F118rdb+CMXflieHi3Cwas1TZIwV/dnYNxswRK9y
         bhj546EjJxUyKcrNdLJ7xI4G6yeVORdc0MJ561MEL2UcPc9lZjVUuWbogGBxSmT+nxne
         Sm7u6L32uiHmMhM30KvpDquQOEy80+7+Ly33PH4hvrYbx54+JWPA5J7xj0Jwq3Wcu2dS
         i9FeJ7p5VV7prfhAMY5CJJx9gTOuGmrilT3Fpkx+dlFpGWTvDMucF3mVUFPfgCqlHbvY
         0XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gX34zfq3l8r7nYkxgyigvndLmRb7KUo3sU1truBGj04=;
        b=suqSykYUo7Ak1cKXHo4qBFd65/OJKy4mXUof6a8tgysk8t+zrHY+5O6YKlquMB8HbO
         Wy4KlaoSReMYdfk3OPyaQXGF2Wg6YdjcM8TJ/aMSyCEWR6emNmoQ0BH1Rr+zddODO9/M
         xNRVCxEmw0zatRLaqJ9jHWS4FGdv2j4zDnXuWVmnn1jcUkWKq7+aYNOLbDLUbWFJ2tpG
         wBvFaAEd9J/vD6lItkFYJAWEvhbnWvwNriQocBR8X7i0S0q9kFS45rtw2xYedPt5pJay
         SfBJVh/cf+XhGDjO47h34YVwzvguIw4yIrbyaKusmWOBWrmD/wRvtt5gXPzEQZOlskKc
         r68g==
X-Gm-Message-State: ANhLgQ1tA2GI4jsF7Gt511Cq9TD1wwt0oIiFqZa1XeFHiaPT1G8IkbMU
        VnIdzwp/NOEL4T0e2EOwvwXGIJDIf09NIzqzUBw=
X-Google-Smtp-Source: ADFU+vuC5Ri4O0YI0CngplqRPnzAh1p7q33W1ypgChiMI1Xk31SKBKjQ1SZQfQHTtjOpnrE9vkfMS5xraDTr5dfIKBc=
X-Received: by 2002:a5d:8b98:: with SMTP id p24mr415621iol.139.1583435357017;
 Thu, 05 Mar 2020 11:09:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
 <pjdd09r6ki8.fsf@redhat.com> <CAFftDdob6kA2XbsaLLKPND7uRFPFJyBwnzcPQPJ+pZsNw+vBzg@mail.gmail.com>
In-Reply-To: <CAFftDdob6kA2XbsaLLKPND7uRFPFJyBwnzcPQPJ+pZsNw+vBzg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 5 Mar 2020 13:09:05 -0600
Message-ID: <CAFftDdo2grFfgkFhSmw_XSeyu3Eo9wKvThqNyAjD73EoJdXJYQ@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 5, 2020 at 10:12 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 6:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
> > >>
> > >> Version 4:
> > >>   - Fix linker option warnings.
> > >>   - Move map file to begining of options.
> > >>
> > >> Version 3:
> > >>   - Add more symbols that should be dropped from the dso:
> > >>     - map_class;
> > >>     - map_decision;
> > >>     - map_perm;
> > >>
> > >> Version 2:
> > >>   - adds a version to the linker script LIBSELINUX_1.0
> > >>   - Adds a patch to drop some additional symbols from the dso:
> > >>     - dir_xattr_list
> > >>     - myprintf_compat
> > >>     - unmap_class
> > >>     - unmap_perm
> > >>
> > >> This four part patch series drops the dso.h and hidden_*
> > >> macros.
> > >>
> > >> The old dso.h functionality provided libselinux with both control over
> > >> external exported symbols as well as ensuring internal callers call into
> > >> libselinux and not a symbol with the same name loaded by the linker
> > >> earlier in the library list.
> > >>
> > >> The functionality is replaced by a linker script that requires public
> > >> API to explicitly be opt-in. The old method required that internal API
> > >> be explicitly annotated, and everything else is public. This should help
> > >> make it easier to control libselinux DSO hygene going forward.
> > >>
> > >> The second functionality is replaced by compiler option
> > >> -fno-semantic-interposition
> > >>
> > >> Note that clang has this enabled by default, and thus doesn't need it.
> > >>
> > >> See:
> > >>   - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition
> > >>
> > >> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> > >> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> > >> [PATCH v4 3/4] Makefile: add linker script to minimize exports
> > >> [PATCH v4 4/4] libselinux: drop symbols from map
> > >
> > > This looks fine to me but I'd like at least one of the distro
> > > maintainers to ack it (especially the last one).
> >
> > Acked-by: Petr Lautrbach <plautrba@redhat.com>
> >
>
> Thanks staged:
> https://github.com/SELinuxProject/selinux/pull/205

merged.

Since folks have interest in doing the same for libsepol and
libsemanage, im going to roll those before updating the attribute
deprecated patches.

Thanks,
Bill
