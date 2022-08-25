Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF655ECAA25
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbiHYSyT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbiHYSyS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 14:54:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A09B6D51
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 11:54:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s199so24374058oie.3
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1GDMXcmocnUNPd7c7V4EJPSa9hmL2/HWVEFqBdrevOA=;
        b=ygeEW0MO4b4LHaSLT1HUmE/zLVp24mG7VyVMbQC5/JMMusrdxarSNE6NlQBPRIUQnV
         8F9D4v9VHf2YbgIaB4wFvGalKSvlXBan/KqUDwfM698oUc4jkYXuRE/LcypPgXJ/kIz7
         FEkZg7Kin/ZKqVnNQTtaRuF5uXec7T9sSTi+/73GUUX1OeDS3x2YBbP+37AdWH5Eaxkd
         ltLsvDnT2Qx0hz1OxivmWjjX8CdcLb9SHboSzlTQmeTMSoP4Q/aGHMtxfeDa9gRkWmid
         MREaRN3x1Zi53l9GBvM7WyDBVXpwA0GevfZxZbtHbIQtfHblpT9xNWoWru+dIJkuTIyK
         txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1GDMXcmocnUNPd7c7V4EJPSa9hmL2/HWVEFqBdrevOA=;
        b=FVu7S7rXbJHGa0MsoN1wtmQ0unFHhvFWoEKmAYV5ZyD3ydxo7k0R6kjXdN28h9vvd8
         VYtuxXAOLvTUjqw5JfLIZaEa5vUdx8b1mQb14tUhLfSjf6IfSZ9RKBNEu8QTwQColkPn
         nCnV+I09xns0MqSsLJ98BipM74Gt43TYkkY6g07/2JEB73D+heHwkqV+hDAxPzxNJBdJ
         Qfy5NKAle/0BCZMS33SYthYbGTlncSF/ubacoe7n1ju4FAeCpdYK7+0pLy372PtmCO6g
         uQLFHF/HihitKpTe0avf2bmJ9ci5E3WI3LZJS8xLpYvSkLGQp9a8EfGXcTe1DGfWuQZw
         g1CA==
X-Gm-Message-State: ACgBeo1Ve9iPUCdZQGf4uBcUr8kOMx/41DbSa8POaz2+iqLpov+WfdZ/
        pdmmiJ1shBBpGhNwPMPfDYIA939pPwuKTivUo4kBJStaUg==
X-Google-Smtp-Source: AA6agR5pVuG6+EI4MIzmC0em0zOEXfrggjWH7PcJ27XWYLVqW8TBsEhILS5Od7BBXuelcmd1/RUZXoDvvx2EtM6/A34=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr172143oif.136.1661453656542; Thu, 25
 Aug 2022 11:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <166061510477.614432.940552725841920786.stgit@olly> <CAFqZXNsHyi_ga68=jFXh=qb4SQR9HOwCUNgHcascMn_ycOTtWw@mail.gmail.com>
In-Reply-To: <CAFqZXNsHyi_ga68=jFXh=qb4SQR9HOwCUNgHcascMn_ycOTtWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 14:54:05 -0400
Message-ID: <CAHC9VhTbNSS_SkgyWAjXq+soOa_LUfFZR5eV0auG4K-cLFRTTw@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] tests/binder: remove stray flag files
 with 'make clean'
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 25, 2022 at 9:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Aug 16, 2022 at 8:50 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Failed or incomplete test runs can leave temporary test files in
> > the binder test directory, remove them with 'make clean'.
> >
> >   mkfifo: cannot create fifo \
> >     'binder/manager_flag': File exists
> >   mkfifo: cannot create fifo \
> >     'binder/service_provider_flag': File exists
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  tests/binder/Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> > index e78ad16..b89d4db 100644
> > --- a/tests/binder/Makefile
> > +++ b/tests/binder/Makefile
> > @@ -18,6 +18,6 @@ endif
> >  all: $(TARGETS)
> >
> >  clean:
> > -       rm -f $(TARGETS)
> > +       rm -f $(TARGETS) manager_flag service_provider_flag
> >
> >  $(TARGETS): $(DEPS)
>
> Thanks, though it would be good to do the same cleanup also in other
> tests.

I agree, but I didn't/don't have the time to do that for the other
tests, I saw this one and I fixed it :)

> I extended your patch to almost all other dirs in [1] - is it
> OK if I apply that version?

No, but not because I think those changes are wrong, it's because I
don't agree with the approach.  Let me try to explain ...

It is my personal opinion that with few exceptions, a maintainer
should not alter a patch significantly beyond the normal fuzz that can
sometimes happen when there are merge conflicts.  Of course there are
trivial changes sometimes, e.g. a missing semicolon, whitespace
issues, etc. which are okay to fixup (with a note in the commit!), but
changes of more than a couple of lines, or changes that impact the
logic of the patch, are not something a maintainer should be doing as
a normal practice.  I am not a lawyer, so please don't take this as a
valid interpretation of the laws involved, but I can see legal reasons
for this: if the maintainer changes the patch in a significant way, I
imagine that could potentially muddy the idea of authorship, would the
maintainer now also be considered an author of that patch?  How could
one clearly distinguish between the original author's code and the
mainatiner's changes?  Sure, there is the mailing list, but what if
the mailing list is not available and all you have is the git log?
However, the biggest issue that I see is that of community building.
Having a back-and-forth with a patch contributor can help both welcome
them to the community and teach them what is expected from a patch
submission point of view.  It might be easier and quicker for you just
to edit the existing patch, but it's better for the community to take
the time and ask the original submitter if they could make the change.

Does that make sense?

-- 
paul-moore.com
