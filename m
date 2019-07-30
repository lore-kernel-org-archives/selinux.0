Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D4C433FF
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2B5206A2
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 23:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JX0pwltA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfG3XQG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:16:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3XQG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 19:16:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so7206328lfm.12
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buo+fUgRnfTxKhh/Q+vhJfJVCtn/nvXnVkk7SyZ4+gk=;
        b=JX0pwltA+EZ5SKjHg3TLMuviyS7d0P2gY9TUDL2naCvPI9zievllMV9EqudofiIPt8
         ADzbUgLkFsTq152eNIVJg+6okO0/t8t/pllV9+YLFDLdSo9bEZo+Y+AyFcuMqBtdRQV+
         1uVEnQQkQNPJ4lL4hI0l4cJUAwB7EvMiJZHIOOZLq7GLwyABKBP6mb6sVTl7QAw5OPG3
         /YmvvMeEMMUErwRFk56Y+TgIy5XbCJTEmeQ9sqRnA4b2A39pA+LUC02cLkaYkSgdkqK1
         MbPyEwdGXMBLazcTPfheaWawAbsAcHntd57K2USh1IHw/zN+x0az9DwnfGkSzmP2Jesg
         snhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buo+fUgRnfTxKhh/Q+vhJfJVCtn/nvXnVkk7SyZ4+gk=;
        b=SQazk1LCdO80WvTr1+1JpxH2OkzQEkMCoeYUIu8we2gJkbAB1aYP3jx5TjcnR6PffP
         AodMnmjPUyuSxLYIQmGRJyJ7i0sGvtS0EIO6x8ssE1OdvAIJrGniVGd3a1TIwyVWlEjn
         Nx6VFzfeZivTnpI9ignW6SvkrSH3k340VKUQasz0clM5Ubn3L7hCNbRb3QqEt0tksN/o
         NNJmiuveaTF/kG16O/a1y4ltCwALszEi7IyiiFLqJGf8EgvtNIXAxdbVVKKo0D0JYOHp
         IbnVZe3FAeBgfdfTMRe0wM0HpL/nK8mVaOWCmFV5JGL+VtuQQU3rKjZfFeAzBviEnyfg
         ee3Q==
X-Gm-Message-State: APjAAAWv+xVYcS7N+zPwt735wSi/4RXcGTB2fKLatRYxZALp3mgwYQ85
        IFONv8G1JJNLt4ENPjjrD/pF6VE2b8VBX7Ayxw==
X-Google-Smtp-Source: APXvYqz1m0qKP5RjYPMwJOL1a+dD3X2S8B56yxW5zm8fjT3FTZ/obeYko6Kmmpbrzf/TIhWh6dE3ExnbEJuPoMmOwUY=
X-Received: by 2002:ac2:4644:: with SMTP id s4mr19598483lfo.158.1564528563644;
 Tue, 30 Jul 2019 16:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-2-omosnace@redhat.com>
 <CAHC9VhSRvfGJjBfxkNc2kdwbN5UZP6LSJbyYuBa+OE8YJ1-weg@mail.gmail.com>
 <CAFqZXNsEH1H5=rLyn=SEay3od+=bdAGYW3_CKvNWBhjNsvHd6g@mail.gmail.com>
 <CAHC9VhR85CBD4FRPrh+ANf0rZeDgmxH9DWNOW8F4DXMyM2Exrw@mail.gmail.com> <CAFqZXNuQbXPCZLoSqbsm3bLERPA=aYZQ6NF7ro1B+Xhxo+NOiQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuQbXPCZLoSqbsm3bLERPA=aYZQ6NF7ro1B+Xhxo+NOiQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Jul 2019 19:15:52 -0400
Message-ID: <CAHC9VhSPTfHpoHGbJkx2S7T+wgMMxJG6Mpnc7MF06CRaetXG2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: policydb - fix memory leak in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 30, 2019 at 12:15 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jul 30, 2019 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jul 30, 2019 at 8:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Tue, Jul 30, 2019 at 12:48 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Since roles_init() adds some entries to the role hash table, we need to
> > > > > destroy also its keys/values on error, otherwise we get a memory leak in
> > > > > the error path.
> > > > >
> > > > > To avoid a forward declaration and maintain a sane layout, move all the
> > > > > destroy stuff above policydb_init. No changes are made to the moved code
> > > > > in this patch. Note that this triggers some pre-existing checkpatch.pl
> > > > > warnings - these will be fixed in follow-up patches.
> > > > >
> > > > > Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  security/selinux/ss/policydb.c | 976 +++++++++++++++++----------------
> > > > >  1 file changed, 489 insertions(+), 487 deletions(-)
> > > >
> > > > Hmmm, that is one ugly patch isn't it?  If I saw this diff I'm not
> > > > sure I would have suggested what I did, or rather I would have
> > > > suggested something slightly different.
> > > >
> > > > When I ran my quick test when I was looking at your v1 patch, I only
> > > > moved perm_destroy() through ocontext_destroy(), leaving out
> > > > policydb_destroy(), and the diff was much more cleaner[*] (diffstat
> > > > below, includes the actual fix too).  Could you try that and see if it
> > > > cleans up your patch?
> > >
> > > Yeah, excluding policydb_destroy() from the move is what's needed to
> > > get a nice patch...
> >
> > Good, let's just do that.
> >
> > > Actually, what do you think about keeping the
> > > bugfix patch as before (with the forward declaration) and then doing
> > > the moving around in a separate patch (removing the forward
> > > declaration)?
> >
> > Yes, I thought about that too when looking at your patch yesterday and
> > trying to sort out why it was such a messy diff.
> >
> > > Then we keep the patch with the actual fix small, but
> > > still get a clean final result. It would also allow moving
> > > policydb_destroy() up closer to the other destroy functions in another
> > > separate patch (I tried it and both patches end up clean when the move
> > > is split up like this). (I don't have a strong preference for this,
> > > let me know what works best for you.)
> >
> > I'm fine with leaving policydb_destroy() where it is, but I agree that
> > separating the fix is likely worthwhile.  I'll go ahead and merge your
> > v1 patch into selinux/stable-5.3 (it's borderline -stable material
> > IMHO, but I'm pretty sure GregKH would pull it into -stable anyway, he
> > pulls everything with a "Fixes" tag it seems), and then merge the
> > reorganization patch into selinux/next.  Honestly, I can go ahead and
> > submit the reorg patch, it's basically already sitting in a tree on my
> > disk anyway, but if you would prefer to do it that's fine too, just
> > let me know.
>
> Sure, feel free to submit the reorg yourself (I assume you will then
> merge the checkpatch fixes 2-3/3 on top, right?)

Yep, that's my plan (I should have mentioned that in the previous email).

-- 
paul moore
www.paul-moore.com
