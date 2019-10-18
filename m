Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11472CA9EA0
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64FB21925
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hrasi7ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409615AbfJRHoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:44:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727388AbfJRHob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 03:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571384668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHpDzlIdetdCaZNiT8hoQU/djmawWtA9HwbrDbOeJxk=;
        b=Hrasi7ZLk+CWJ9dguIu+ZW6/5pnrKIYYmxmxT7U0HTQfBOxP4s1ZyACQw3e9RkJSf5WnKD
        GNXw5+P6w6YsmU2ltUFM4MjRMg6jbyJwlBiOm7XYjNrrMz5dZw7eVIi7Kne4ZV8IldaUkw
        HokTpo6i/+/44xB7DVAGaCjRVSouWwM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-nd_umPmbOsy-g1QN_iLPYA-1; Fri, 18 Oct 2019 03:44:23 -0400
Received: by mail-ot1-f72.google.com with SMTP id v51so2540750otb.5
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2019 00:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unqjuQo8BwkbnIJigk2ZaSPMwrQ1jkfXUvUDYsTAY4I=;
        b=sK3vlPgx0U62G18Mr2i1ZO8EJPl6HLOnxzWLhtkvfhOM0fwejUc/uWn3YjYmCogff4
         MVJ8/8Tfv2wH8+Y67I7qjTcHS1K1tMxD4GpUtawPpgxWkO5dgN0oAzv6AB6SthS3NWvQ
         drkkLtthMGnmG8MJS9CjeITxb7U/zeE8rEcBbI9Jc3MWw064qY7x0zjLjSGh4QI8EBJ3
         2pefY0gJLhXJIcmzgmFtVU5bsoCbiLr3LpocKl9GbB7NnamR0tRTFcf8Lyy1Ypwoy+9S
         zimRAWVaXn2zoIf/V3bch7Y4YelMxcnGfZGmNKMaRxm5Ld/WaS8tSehn4NatoBPGmNuB
         7/Bw==
X-Gm-Message-State: APjAAAX1Hl1HXHX5+K2zn/oSkIt3wlAFr2K7E4J7yafR40zXwI4TOxQO
        RuJaZ/p1VNmZBmzF7cyNMeqpBuTTavLlWLhrUzy/tM/l/eN0N1yTwF3ZSlEdy4v6T/2jNFwPjze
        Pc07l8rlW34WeO6BWYYQYue5hJc5tUYYE7Q==
X-Received: by 2002:a9d:67cc:: with SMTP id c12mr6019039otn.43.1571384662841;
        Fri, 18 Oct 2019 00:44:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJnJSIJR24iI4/hRtsz8DLVfqMaXvpzPsvO+zF/kV4Yu3IhPoF4sHJHTmKE4qDmCOUjFH90hvvdQNSU9QTyZc=
X-Received: by 2002:a9d:67cc:: with SMTP id c12mr6019024otn.43.1571384662487;
 Fri, 18 Oct 2019 00:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191014080647.19602-1-omosnace@redhat.com> <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
In-Reply-To: <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 18 Oct 2019 09:44:11 +0200
Message-ID: <CAFqZXNsMVm2OmWOTiMaKybkhX8Zerp6rDeFfEd0UwhZRiNuNXQ@mail.gmail.com>
Subject: Re: [PATCH userspace] sepolicy: generate man pages in parallel
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: nd_umPmbOsy-g1QN_iLPYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 17, 2019 at 7:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/14/19 4:06 AM, Ondrej Mosnacek wrote:
> > Generating man pages takes a lot of time. Do it in parallel to speed up
> > the process.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thank you for the ack, however I discovered that after this change it
becomes more difficult to end the program via KeyboardInterrupt
(SIGINT). The first interrupt only stops the main process and you need
to send several more to take down the background processes as well...

I found a different way (multiprocessing.Pool) to do the same, which
ends the processing gracefully on interrupt, but that one behaves even
worse under Python 2 (each interrupt only cancels one work item and
the processing happily continues...). Since there are plans to support
only Python 3 in 3.0+ this may not be an issue, but I could also add a
few lines to fallback to sequential execution under Python 2 for the
sake of compatibility. Would that be OK or should I not bother?

Either way I'd like to send a v2 that uses multiprocessing instead of
concurrent.futures, so please don't merge this yet :)

FYI, here is a preliminary diff for a switch to multiprocessing.Pool:
https://github.com/WOnder93/selinux/commit/a33acec8c298c112f5412b8b61b5b090=
58a267ee

...and here is what the Python 2 fallback would look like:
https://github.com/WOnder93/selinux/commit/b39a12120656b50eb0a1ee01227646ba=
3cd63f15

>
> > ---
> >   python/sepolicy/sepolicy.py | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index 1934cd86..02094013 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -25,6 +25,7 @@ import os
> >   import sys
> >   import selinux
> >   import sepolicy
> > +from concurrent.futures import ProcessPoolExecutor
> >   from sepolicy import get_os_version, get_conditionals, get_conditiona=
ls_format_text
> >   import argparse
> >   PROGNAME =3D "policycoreutils"
> > @@ -326,8 +327,13 @@ def gen_gui_args(parser):
> >       gui.set_defaults(func=3Dgui_run)
> >
> >
> > +def manpage_work(domain, path, root, source_files, web):
> > +    from sepolicy.manpage import ManPage
> > +    m =3D ManPage(domain, path, root, source_files, web)
> > +    print(m.get_man_page_path())
> > +
> >   def manpage(args):
> > -    from sepolicy.manpage import ManPage, HTMLManPages, manpage_domain=
s, manpage_roles, gen_domains
> > +    from sepolicy.manpage import HTMLManPages, manpage_domains, manpag=
e_roles, gen_domains
> >
> >       path =3D args.path
> >       if not args.policy and args.root !=3D "/":
> > @@ -340,9 +346,9 @@ def manpage(args):
> >       else:
> >           test_domains =3D args.domain
> >
> > -    for domain in test_domains:
> > -        m =3D ManPage(domain, path, args.root, args.source_files, args=
.web)
> > -        print(m.get_man_page_path())
> > +    with ProcessPoolExecutor() as e:
> > +        for domain in test_domains:
> > +            e.submit(manpage_work, domain, path, args.root, args.sourc=
e_files, args.web)
> >
> >       if args.web:
> >           HTMLManPages(manpage_roles, manpage_domains, path, args.os)
> >
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

