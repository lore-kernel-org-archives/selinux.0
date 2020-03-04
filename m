Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595C7C3F2D8
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC0F2146E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 12:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZV9IUyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbgCDM0T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:26:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387801AbgCDM0T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 07:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583324778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwMkDnrq0HkvemhOLxSNb+eFZMzawFiy2Vc9pPzmKnQ=;
        b=RZV9IUyLvq9KrfMgnn85qJlObp7rVh18OC71382zdD5dArxqRnjwcgmeG4+D56EQ6euix9
        89s/+zAjsF2aClrDsTdzgOzfPNDvmT+SUMTPubbV4+Cn55prKmNjhWB7ZOH8vBG6o9koDt
        BBIvty9XIlQDTe7CSNg+ts7R9+w6w7I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ixD1Je35NQKJXIDQ8gr9nw-1; Wed, 04 Mar 2020 07:26:16 -0500
X-MC-Unique: ixD1Je35NQKJXIDQ8gr9nw-1
Received: by mail-oi1-f197.google.com with SMTP id k206so779428oia.22
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 04:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwMkDnrq0HkvemhOLxSNb+eFZMzawFiy2Vc9pPzmKnQ=;
        b=Wr3E/FL815RysWmXkrEXY3b3r22G+CY+Mlzc8B1KLjG8iUtIQnD1cBnmEdrr1vR/jY
         hX8pj1D/0zdhMbEjlgpkBBGyYkoutiM29v8OHLmOoQcPT3+Q2qeGrTrcDqlujXCPXJVY
         EqJDiFNZkjeaQdJ572KJNs19RuC+EWpTwkiQ4aOsu8W1Zg7AuJUcYL1d31JQx0SwY4SM
         uCN1n9qwVYwidOnbEKZB4qcZGVAgFM6YZZJAx7Mxqw3QaFuGg3Nu6dcVUdRWE7qvNgZr
         oqaRJNC2Xk2A2ft2d50ra7GcqATzW2G+cjbzG84LRjSWr36y3ZdfFDjtfTAFhYVLDRhL
         aATg==
X-Gm-Message-State: ANhLgQ3d8bTOI8rBR51FZ8KMPZnwh/QK+oxdOXlt2WvEP9H9cn4Gb8m8
        xfvGcS3pJuBFMfCOB/dOYmLk5hfL7/tZdWK4qdxW+K2YKiOZXfrliTiorAScctYn8JSDiM9UCok
        2tc8tdty85SFksvKg3efM1U/Xos54wtyj4A==
X-Received: by 2002:aca:574c:: with SMTP id l73mr1564535oib.156.1583324775261;
        Wed, 04 Mar 2020 04:26:15 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtoK8TvXDuyQ7AroTEVl+6Q0/dU1ocXWtC02kSMk3bm3nSDJVHFyBOqUTiMw4mqptFF1/OoTbgBv39DFS0xu50=
X-Received: by 2002:aca:574c:: with SMTP id l73mr1564523oib.156.1583324774958;
 Wed, 04 Mar 2020 04:26:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Mar 2020 13:26:04 +0100
Message-ID: <CAFqZXNuUjXwD=k65ACy_fuiYyq3r1rWSV8UpBQEr-+1a8vbXvQ@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 7:57 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
> >
> > Version 4:
> >   - Fix linker option warnings.
> >   - Move map file to begining of options.
> >
> > Version 3:
> >   - Add more symbols that should be dropped from the dso:
> >     - map_class;
> >     - map_decision;
> >     - map_perm;
> >
> > Version 2:
> >   - adds a version to the linker script LIBSELINUX_1.0
> >   - Adds a patch to drop some additional symbols from the dso:
> >     - dir_xattr_list
> >     - myprintf_compat
> >     - unmap_class
> >     - unmap_perm
> >
> > This four part patch series drops the dso.h and hidden_*
> > macros.
> >
> > The old dso.h functionality provided libselinux with both control over
> > external exported symbols as well as ensuring internal callers call into
> > libselinux and not a symbol with the same name loaded by the linker
> > earlier in the library list.
> >
> > The functionality is replaced by a linker script that requires public
> > API to explicitly be opt-in. The old method required that internal API
> > be explicitly annotated, and everything else is public. This should help
> > make it easier to control libselinux DSO hygene going forward.
> >
> > The second functionality is replaced by compiler option
> > -fno-semantic-interposition
> >
> > Note that clang has this enabled by default, and thus doesn't need it.
> >
> > See:
> >   - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition
> >
> > [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> > [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> > [PATCH v4 3/4] Makefile: add linker script to minimize exports
> > [PATCH v4 4/4] libselinux: drop symbols from map
>
> This looks fine to me but I'd like at least one of the distro
> maintainers to ack it (especially the last one).

FWIW, I scanned all Fedora (32) packages that Require: libselinux
using this script and it seems that nothing is using the symbols
mentioned in patch 4/4 on Fedora:

https://gitlab.com/omos/selinux-misc/-/blob/master/scan_imports.sh

BTW, the same dso.h infrastructure is used also in libsepol and
libsemanage - are there plans to do the same thing for those two?

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

