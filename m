Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C2C4360C
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1572054F
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhd+REH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJJLmZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:42:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40641 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbfJJLmY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Oct 2019 07:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570707743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoFOaWeJxaNZBXDMSxI/Jj+trSO1Sd9JM/4dc48PK0k=;
        b=bhd+REH5kGQlu5EcbtRFSqhUDPwz3R6vac9Y2y15nzgmq0ItpMcHLu/FfejXEqgu5bRMpb
        RAVnZDdXu8BKvy9o2MfO6FQo8iXuzfdO8k+tOoEZDXgyqGWTcm8uMN3x5NURTiYnTD+dHd
        hxgYxM2w6S68hmms4G5t25ORw6Pd1jE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-J1w6m-GbMxWh6s0keU5PkQ-1; Thu, 10 Oct 2019 07:42:19 -0400
Received: by mail-oi1-f198.google.com with SMTP id r144so2650507oie.4
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2019 04:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ7Bj4Vibk8aI9DxhsWjUSoaL4ajczN6zeXmJQ35qyA=;
        b=kSKyDxOHa0YU71CS5bUykI7VJWJxXRjkSlP/GU515ayWqO+8e4fQ+w1v8tRzwr4vzx
         /KV7IGOSkGgjbPdfkRecSFDaY5j0BGioZOhFnr128MdJbnXJDktzZ0Xwb28fP7Yf/0TG
         /d09HF4HFN7S6SFIn2O4dKJdvhY4UJaiIWqM74LQK0IOMGg2rzZ7NDmtzIVdhu5bfou1
         G4rsIaXfDqlnqu6J8DX+PKxxuHpP0VOCepzFQyIJif0wgHjfiziK0wblE6jTX/4v6xcH
         nF3LAfggz7RalnABKtSmIhg8Znb23PdeD9R3hAx1iKCM78+X+K+8JOAvERduUBFsAABL
         7nZg==
X-Gm-Message-State: APjAAAVxFfio5ObRmwSIO8YLjHtLIkOGtCLzCSUug2HpWCeBRQ5AWDCD
        pQv5RlujLLiY6dGhb+aOgz6tTOKqKSXw2xArGAm4ggvcPGD5vG5ECw5x1J2YKFzTZDKjXGHIIYx
        RMzB8TzdNruUF7SrqOw1X2W2hFNFTluO2dQ==
X-Received: by 2002:aca:1910:: with SMTP id l16mr7106036oii.26.1570707738067;
        Thu, 10 Oct 2019 04:42:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzb2vMW7042zPQXeJGJa2QRvIu37sSnii4ip833jHavIhWyVJsQRd3uH803UITENFiixqb19V147qXmThhFvQQ=
X-Received: by 2002:aca:1910:: with SMTP id l16mr7106018oii.26.1570707737636;
 Thu, 10 Oct 2019 04:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <156936589827.661145.16998799838921887816.stgit@chester>
 <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
 <CAHC9VhQkwySJJecbZLh1bSNV-oMEy8Ch_ZmuujOHiu7UgeYYiA@mail.gmail.com> <d9248c65-d22c-4a4f-5fbd-8db9ed087d45@tycho.nsa.gov>
In-Reply-To: <d9248c65-d22c-4a4f-5fbd-8db9ed087d45@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 10 Oct 2019 13:42:06 +0200
Message-ID: <CAFqZXNtzutozC=2vCC1w4s-4FPjqELg=f6JB9z4NN4u1cgOBSg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: J1w6m-GbMxWh6s0keU5PkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 8:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/25/19 11:22 AM, Paul Moore wrote:
> > On Wed, Sep 25, 2019 at 5:06 AM Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> >> On Wed, Sep 25, 2019 at 12:58 AM Paul Moore <paul@paul-moore.com> wrot=
e:
> >>> From: Paul Moore <paul@paul-moore.com>
> >>>
> >>> On a modern Rawhide system builds that include libbpf require libelf
> >>> as well to avoid the following linker errors:
> >>>
> >>>   # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
> >>>      client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o clien=
t
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getshdr'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_rawdata'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getscn'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_begin'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getrel'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_memory'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_end'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_strptr'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_nextscn'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getehdr'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_version'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getdata'
> >>>   /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getsym'
> >>
> >> This is a bug in libbpf. I filed a bug against the Fedora package [1]
> >> and also opened a PR [2] against the upstream repo (which is a
> >> modified mirror of the code in the kernel repo under tools/lib/bpf,
> >> where the bug is not present), which I think should fix this problem
> >> also in the Fedora builds.
> >>
> >> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1755317
> >> [2] https://github.com/libbpf/libbpf/pull/72
> >
> > Thanks for tracking down the root cause and filing a report upstream;
> > I didn't have time to sort out the "why", I just wanted to get the
> > test working again :)
> >
> > It looks like the best course of action is to hold off on this fix in
> > hopes that it gets fixed upstream, or at least in Fedora.  If this
> > issue persists for a week or two we can always go ahead and merge this
> > fix, it shouldn't break anything if/when this gets fixed upstream.
> >
> > Tests that fail to run made me sad :(
>
> FWIW, this is still broken on F30 (don't know about F31).  Any chance we
> can get the updated package pushed to F30/F31 too?

There are updates pending for F3[01], which both have the issue fixed:
https://bodhi.fedoraproject.org/updates/FEDORA-2019-aa28a02f4e
https://bodhi.fedoraproject.org/updates/FEDORA-2019-8519f326c2

Both should get pushed to stable automatically in 2 days if there is
no negative feedback (or earlier if there is enough positive feedback
- feel free to test and add +1 karma).

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

