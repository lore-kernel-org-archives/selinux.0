Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28612ECE58C
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BCC206A1
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ngm6DRnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfJIWod (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:44:33 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:41102 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfJIWod (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 18:44:33 -0400
Received: by mail-lf1-f50.google.com with SMTP id r2so2851674lfn.8
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2019 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVxBYRNPXzwmdKR6D5c5yWrzDFUOnTC56hIjV3RF/h0=;
        b=ngm6DRnnu884UY6zCG8qlsCDF0JwOWV3clI76DOkxze2khZWhA25mKL3KO8PMKEM5c
         oPX8nbIxuqzz3dkw0oWcBzcwFKANl96bgZglHah4lYgHRAEqI/M61k6ise3VwxgSoALZ
         4suryLwjEQcSM8mWYkjaI5wmfMZGnpCt6KNqkTQ+j6kn60CEse4K0ujvFi4zpr6uOw6B
         /W5otktm/SGwn1p3FgntmQ2xY3IaGVPiiu6bnoAptYT92XrlffW9823kabE24qIEjSKL
         8V3W+PG/K3ZzOij8QYVd1nUd74faiWBhh/EfI7U+pUrhtw6Rdk/voRU5OwZFpeNF1YCF
         PDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVxBYRNPXzwmdKR6D5c5yWrzDFUOnTC56hIjV3RF/h0=;
        b=EGy1+UAW9o+ACEu2WqQm1BWxzY04w5xu8z+sqcMAgtuhxIduNwuAkq6sDsrZLqk58i
         lIEBD2YXHF/zj2da75s/8kaK90XJn+QpAlOiIx3G9J1suuoXKufEsogpoP0szX3ic2Em
         S1fDKHwY/NMIZSL8oOlVMu3FxS2lQmOtnapdxL94VuSAQdu4shGJFeJpg93UI8R7OIc0
         hu3E2A/A8hLBly9m4AFBZheWTOnV8+qgNCGHDNeYT1FmL8c6O9eQS0a+LHdBkhY2yoDV
         z2dvPzWyS+d5b+NYHaI2iI9sRfBlEMuCwBhoanM9mYgaPSUDZILW8/uGUG2ZOdjh7REq
         OIoQ==
X-Gm-Message-State: APjAAAVoSgAtHSgnv1PctITqdXTcPOcGf5uG7pKq79TLHezywdxTP70k
        wCBzUATauRsmFcnBj2SCQoR34twRRz1OsnTdWaBa
X-Google-Smtp-Source: APXvYqyVS2Y5DHpY3Ic4LCkQMCFFxLdXmImae7wy7XyQDKTo1Ju3AukOB/dG1GmZoTQthKt3iOMECZwC9jRFwaide/c=
X-Received: by 2002:a19:c7cf:: with SMTP id x198mr3493765lff.158.1570661069978;
 Wed, 09 Oct 2019 15:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <156936589827.661145.16998799838921887816.stgit@chester>
 <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
 <CAHC9VhQkwySJJecbZLh1bSNV-oMEy8Ch_ZmuujOHiu7UgeYYiA@mail.gmail.com> <d9248c65-d22c-4a4f-5fbd-8db9ed087d45@tycho.nsa.gov>
In-Reply-To: <d9248c65-d22c-4a4f-5fbd-8db9ed087d45@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Oct 2019 18:44:18 -0400
Message-ID: <CAHC9VhRf=OoJXDoDxw5pN=hv4-r=eviuwxHzUHC1siKPhtNRcQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 2:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/25/19 11:22 AM, Paul Moore wrote:
> > On Wed, Sep 25, 2019 at 5:06 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> On Wed, Sep 25, 2019 at 12:58 AM Paul Moore <paul@paul-moore.com> wrote:
> >>> From: Paul Moore <paul@paul-moore.com>
> >>>
> >>> On a modern Rawhide system builds that include libbpf require libelf
> >>> as well to avoid the following linker errors:
> >>>
> >>>   # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
> >>>      client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o client
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
> >> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1755317
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

Alternatively, it is worth just patching the test suite?  It's
obviously better if Fedora (and all the other distros) fix this
everywhere, but it doesn't look like that is happening.

-- 
paul moore
www.paul-moore.com
