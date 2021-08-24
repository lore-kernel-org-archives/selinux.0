Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F77C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAAC61212
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 16:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhHXQPe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhHXQPd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 12:15:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B149DC061757
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 09:14:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r19so32482927eds.13
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wd5fwU1ingF5we5lrgTxhk7KOFoXPoajglzjOg/e+8=;
        b=UgB3gOA4MhoWlP1R3khI/jIQ4pMtU5YR+JOpnCW+J29/Agjl1pDy9qkC1b3nzlAsYL
         dAYuHXCl58WVS++K6CSh7ktGKzzFCq7D953Mjw/9HlQT1elJq1ATh9kanLUreJZcM57I
         7c4F2ugRL2buebBDNG/0wLOWe1gym3wcACkhZ8POzQKz7slV2nacn7YlNsfUstKojrvd
         ERvMteHfxBV6zgKJcJUcp92odUQFnKAz6M6tyPodgeUrvRdBn+xI1uaaWw1o6Nm6nKC+
         OfXttdDNUEYiTL92RbV4tAoFcHo/KrWqr/yJliRSig5lCbBMfR4G0ovkOiAd5i0df7a5
         KmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wd5fwU1ingF5we5lrgTxhk7KOFoXPoajglzjOg/e+8=;
        b=DnJTrE+X/jt8PQgt5bjTiygd5IJiI2w2CH1qu37uQCB/UtI1VmA8cxKBjGkmDKTzOZ
         Bf/Peky9jrcoPuMh9JkCOEbzMq9XGSRWrmLhHspDdg5H9qZwWsV7VU+OD1IM8q90r7O9
         PWKwdLyv8qxiruQnneKRrOhJcYKCW1MRdTtKNq77hbytUIxoA7hqyuMDugdEr4TrGfpQ
         bATYDXmTtQGGx8QjqTIYpDrfy6UzBOFIlecdgqiwYl1wywxVbW4GAf1ryxZb2fs4HKZ4
         P3FDKkYD6PWLzLcllm5gLoF27P8IAExPXYQp7ZltdVcauHeJxS2B204kJoV3K81I3kN+
         M4sw==
X-Gm-Message-State: AOAM53075/gBPEy9yz80RLUuMrmnQvf95Bq5sFLECjk1+B279Q9t+T66
        uXynrByx/Oic76zhM8mMeDy77/89MeXhgufEMyXp
X-Google-Smtp-Source: ABdhPJyqVacyZAu8LmkjNLUvPcgqLxMjCyziEBhul97XiKpJBnl0nVpGyUgZBFHoymGSiJ9l+38s62p9ak1Mdm+/Z38=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr44587348edw.269.1629821687092;
 Tue, 24 Aug 2021 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com> <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com> <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com> <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com> <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com> <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
 <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
 <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com> <be20e3c8-a068-4aa2-be52-8601cf2d30a6@schaufler-ca.com>
 <CAHC9VhT-MfsU-azbV4QQ-asQFqdCG8fAeB-BOV3MKAdtSOW8Nw@mail.gmail.com> <a44252d1-6a96-def2-e84c-2faec643f5c1@schaufler-ca.com>
In-Reply-To: <a44252d1-6a96-def2-e84c-2faec643f5c1@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 12:14:36 -0400
Message-ID: <CAHC9VhSXg9To_V=SW6Go5_WLSs=S_++TvDG0wxSLNQb7N7vwMA@mail.gmail.com>
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 24, 2021 at 11:20 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/24/2021 7:45 AM, Paul Moore wrote:
> > On Fri, Aug 20, 2021 at 7:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 8/20/2021 12:06 PM, Paul Moore wrote:
> >>>> Unless you explicitly enable audit on the kernel cmdline, e.g.
> >>>> "audit=1", processes started before userspace enables audit will not
> >>>> have a properly allocated audit_context; see the "if
> >>>> (likely(!audit_ever_enabled))" check at the top of audit_alloc() for
> >>>> the reason why.
> >> I found a hack-around that no one will like. I changed that check to be
> >>
> >> (likely(!audit_ever_enabled) && !lsm_multiple_contexts())
> >>
> >> It probably introduces a memory leak and/or performance degradation,
> >> but it has the desired affect.
> > I can't speak for everyone, but I know I don't like that as a solution
> > ;)  I imagine such a change would also draw the ire of the never-audit
> > crowd and the distros themselves.  However, I understand the need to
> > just get *something* in place so you can continue to test/develop;
> > it's fine to keep that for now, but I'm going to be very disappointed
> > if that line finds its way into the next posted patchset revision.
>
> As I said, it's a hack-around that demonstrates the scope of the
> problem. Had you expressed enthusiastic approval for it I'd have
> been very surprised.

That's okay, you can admit you were trying to catch me not paying attention ;)

> > I'm very much open to ideas but my gut feeling is that the end
> > solution is going to be changes to audit_log_start() and
> > audit_log_end().  In my mind the primary reason for this hunch is that
> > support for multiple LSMs[*] needs to be transparent to the various
> > callers in the kernel; this means the existing audit pattern of ...
> >
> >   audit_log_start(...);
> >   audit_log_format(...);
> >   audit_log_end(...);
> >
> > ... should be preserved and be unchanged from what it is now.  We've
> > already talked in some general terms about what such changes might
> > look like, but to summarize the previous discussions, I think we would
> > need to think about the following things:
>
> I will give this a shot.

Thanks.  I'm sure I'm probably missing some detail, but if you get
stuck let me know and I'll try to lend a hand.

> > [*] I expect that the audit container ID work will have similar issues
> > and need a similar solution, I'm surprised it hasn't come up yet.
>
> Hmm. That effort has been quiet lately. Too quiet.

The current delay is intentional and is related to the io_uring work.

When Richard and I first became aware of the io_uring issue Richard
was in the process of readying his latest revision to the audit
container ID patchset and some of the changes he was incorporating, in
my opinion, hinted at the io_uring issue, or at least drew more
attention to that than I was comfortable seeing posted publicly.
Richard discussed this with his management and security response team,
and they felt differently.  I told Richard that I didn't want to block
him posting an update to the patchset, but that I felt it would be The
Wrong Thing To Do and if he did post the patchset I would likely
ignore it until after the io_uring fix had been posted so as to not
draw additional attention to his changes.  I can't speak for Richard's
mindset, but he appeared anxious to post his changes regardless of my
concerns, and he did so shortly afterwards.

That's why you haven't seen much progress on this for a while, and why
you will see me comment on the latest patchset after the io_uring
patches land in -next after the next merge window closes.

-- 
paul moore
www.paul-moore.com
