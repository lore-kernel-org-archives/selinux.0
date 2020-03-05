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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7272AC3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DBA207FD
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB9sIfvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCEQMi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:12:38 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:38910 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEQMi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 11:12:38 -0500
Received: by mail-il1-f175.google.com with SMTP id f5so5502240ilq.5
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNDC03srt396rh86JPHuOo37Qk+RtBruFhaPkRQaswk=;
        b=ZB9sIfvLS/SCUJJB6Tr+IGHPgEzl6EAn+FNyz+ye8VyXTz9YPuCSgTO0093YURvZs4
         b4ypmmc2u6nBKuwWdL/3n6ZPLGYgI1T5nlOIdZCcNHYEoD1HFPzgzauVH3yn5+FXYNKi
         m2tTagrOw0wEKeeW0wruNOTxyiNmfBUtshHHTtRQMnRrkcu5hZyJtJ4h6+JhqSGMz38N
         KXnUbsiNBk4rI2YoOarHyTWg2SWCKcFFZ5S1IrOvbHZuD3kSxfJgfmrV04DVryXGfi1y
         GiTs8lM+4RK+j2YClHvWPk2id7GgV1/HPYHpbAUwN829psbIlsp7hCQMUFBHORSTXQDF
         I/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNDC03srt396rh86JPHuOo37Qk+RtBruFhaPkRQaswk=;
        b=cSJQuk1qA1i1nL7W0JrxDohcs44SuoCHSrh2q0xPC72Q/VNI8ERxsBM3YXjm9wyf9h
         m/7zmQMoq0nNO1+t+z1LRlglphR7Io98ARoXWPzbDslJJjNbajEOSo6skI8kT0WF1H0j
         un9IknsghDSrYElDkXPz9Sl5Pw1akmy4wUipYZLvmbS5j9inFZJbTCDU/ich+Jur7j04
         ylSvn7mhoPTWVFyRCzHNwkEn3RSQUWhLO6+dRQVxKMmN/HkjcL/Y9lM07nf5M4AJ9aWs
         kCpBGRA2b9mkJi0CcoSiBe/nfNXj4drqlheTRNtT+skd/rhdlYggxiKLhj8eNyF3LFvw
         wD4w==
X-Gm-Message-State: ANhLgQ0EpOEmcWEDTbQVukgcJhcIKNzUUUeM5xdRyPbgNhDnx3yo1iCC
        jLK+Gs865mkxBiNpWjx5czCjY8IRv47+F/mmdOU=
X-Google-Smtp-Source: ADFU+vsL0atiBlo+el8CXq+U2ibnWVFbBlusyd+deUiBOT17NSaVPdZr/abokaHk2rHC+jO1+9E40BiQBuOgoB9zdjI=
X-Received: by 2002:a05:6e02:14e:: with SMTP id j14mr8396928ilr.129.1583424756254;
 Thu, 05 Mar 2020 08:12:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
 <pjdd09r6ki8.fsf@redhat.com>
In-Reply-To: <pjdd09r6ki8.fsf@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 5 Mar 2020 10:12:24 -0600
Message-ID: <CAFftDdob6kA2XbsaLLKPND7uRFPFJyBwnzcPQPJ+pZsNw+vBzg@mail.gmail.com>
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

On Thu, Mar 5, 2020 at 6:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
> >>
> >> Version 4:
> >>   - Fix linker option warnings.
> >>   - Move map file to begining of options.
> >>
> >> Version 3:
> >>   - Add more symbols that should be dropped from the dso:
> >>     - map_class;
> >>     - map_decision;
> >>     - map_perm;
> >>
> >> Version 2:
> >>   - adds a version to the linker script LIBSELINUX_1.0
> >>   - Adds a patch to drop some additional symbols from the dso:
> >>     - dir_xattr_list
> >>     - myprintf_compat
> >>     - unmap_class
> >>     - unmap_perm
> >>
> >> This four part patch series drops the dso.h and hidden_*
> >> macros.
> >>
> >> The old dso.h functionality provided libselinux with both control over
> >> external exported symbols as well as ensuring internal callers call into
> >> libselinux and not a symbol with the same name loaded by the linker
> >> earlier in the library list.
> >>
> >> The functionality is replaced by a linker script that requires public
> >> API to explicitly be opt-in. The old method required that internal API
> >> be explicitly annotated, and everything else is public. This should help
> >> make it easier to control libselinux DSO hygene going forward.
> >>
> >> The second functionality is replaced by compiler option
> >> -fno-semantic-interposition
> >>
> >> Note that clang has this enabled by default, and thus doesn't need it.
> >>
> >> See:
> >>   - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition
> >>
> >> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> >> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> >> [PATCH v4 3/4] Makefile: add linker script to minimize exports
> >> [PATCH v4 4/4] libselinux: drop symbols from map
> >
> > This looks fine to me but I'd like at least one of the distro
> > maintainers to ack it (especially the last one).
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

Thanks staged:
https://github.com/SELinuxProject/selinux/pull/205
