Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EDC38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D6B2078C
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdSBbD7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGIZP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 04:25:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIZO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 04:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588839912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VT7VDOrI9l89DKGcgUTh1dfQxbIZunaGzw3RZkOfDDY=;
        b=CdSBbD7Th3BiP0ELKJt80WxZVCNKJsk/UXNBEMTWC16qqC8xygmUIaNAesejn1VSM7kmI/
        hGzL1q59X0yacxGYeB2LqX2O9X61sC92W78Dyqa1oanMCDJJWhpM9L1GOsu+piTp85yc0y
        OBU0lRnmcdxwOW+N4zS1eIl+t0e3UKE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-L0Peu7aQM3i5PNVA6ZIdyw-1; Thu, 07 May 2020 04:25:11 -0400
X-MC-Unique: L0Peu7aQM3i5PNVA6ZIdyw-1
Received: by mail-ot1-f69.google.com with SMTP id e23so2871550otk.1
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 01:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT7VDOrI9l89DKGcgUTh1dfQxbIZunaGzw3RZkOfDDY=;
        b=DR9IJJXRbYnJWTfsRZvPTzRiaA4nyYHvCArJAbHZ6gKnpclkJF7qO5mRXQ2leiwkfJ
         QMQf0jTqovjPJsmaGjb1jgDLs32ESNZ58Wt4qPJMjAf2L9OjCHcjGNrC4JsEUjKrBqqs
         UGN251Gc9CLkSOUKXnf4lctyUvLGjUw4SrK88n0ot0yQgqiuQYzy0rR+n27RbrvbcC02
         ao/wty/947qNtWch46yr3b3cvqCMWzmkCDEAnrrRn4eJjTDe+7QMQ3p/88DnZOdckT9F
         RpzedsdjoEYmPHPgUWvnXtgsXCDKy85guiHMc/6yvZSop0TtV4UvgPYkzF+Ww+EqxIdG
         90rw==
X-Gm-Message-State: AGi0PuYWM2LitgGzgmcYK4KrsgyEF0UuntDl3MWrXZKmjlgq+ByVdI05
        zfzrU9iLrmXfQMsuqEhYQpjPDtXWYcv12zS1OEW0q+42TZ8x8AKJwJW/N/mxuGwRYD3CYynWmO/
        Zo+fFX/zZ7jb1/BNj4eMN/c0JioDayLiMPw==
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr10735856ooo.58.1588839910605;
        Thu, 07 May 2020 01:25:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypIOGK6bDyUqXLXy2e69x8K1QLXplHHpbEh8+hzwPai+2LkTLuTV6NTte+5gYWasFRdTwSK5EUB5b8SPf/6YzUs=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr10735839ooo.58.1588839910259;
 Thu, 07 May 2020 01:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFqZXNt0+BstXTn2yTMHHf=n10SY74nSrj8cfELP26-mcmYkfQ@mail.gmail.com>
 <CAEjxPJ5=6FhOukWThYeO+LrNTAfPSeCq-7Z27c+zhAdesPbDXg@mail.gmail.com> <CAEjxPJ7ZsE=ArK0HZiZMOZ0u_z-b8mdADpj+jWto7r+6+1Jozg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ZsE=ArK0HZiZMOZ0u_z-b8mdADpj+jWto7r+6+1Jozg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 May 2020 10:24:58 +0200
Message-ID: <CAFqZXNtXPjoj_aLPBi8QY5rf9kw8gMj8ioHfhSeK7GwZ_1ERgw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 10:27 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, May 6, 2020 at 3:57 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, May 6, 2020 at 3:37 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Wed, May 6, 2020 at 2:54 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > diff --git a/policy/Makefile b/policy/Makefile
> > > > index dfe601b..f86aac4 100644
> > > > --- a/policy/Makefile
> > > > +++ b/policy/Makefile
> > > > @@ -40,6 +40,8 @@ CIL_TARGETS = test_add_levels.cil test_glblub.cil
> > > >  endif
> > > >  endif # GLBLUB
> > > >
> > > > +CIL_TARGETS += test_mlsconstrain.cil test_overlay_defaultrange.cil
> > >
> > > This causes a problem on RHEL-6, since it doesn't understand CIL
> > > modules. We'll probably need to detect if semodule supports CIL before
> > > trying to add the modules.
> >
> > I thought we had stopped worrying about RHEL compatibility in the
> > upstream testsuite going forward and deferring all of those tweaks to
> > downstream?  I'm not fundamentally opposed but that was the impression
> > I had received earlier.  If we are still carrying RHEL support, then
> > how old of RHEL do we still care about?  RHEL-6 is six months away
> > from regular EOL?

I'd still like to keep compatibility with at least RHEL-6+ (with older
versions approaching EOL being less important than newer ones) at
least where it can be achieved easily (without too intrusive changes).

>
> Also not sure what we would test here to determine whether CIL is supported.
> It isn't directly linked to a particular kernel or module binary
> policy version, and the version of libsepol that first introduced it
> in RHEL-7 probably differs from upstream (assuming it was back-ported
> there).

Hm... yes, I sent the email late in the evening and hadn't given it
proper thought. I agree this would be too much trouble for little
gain.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

