Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83A1C433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E7E215A4
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 01:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qar1nThL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgIHB3K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgIHB3F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Sep 2020 21:29:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6CC061573;
        Mon,  7 Sep 2020 18:29:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so14994635oif.7;
        Mon, 07 Sep 2020 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ds7NBB5D8yNeSFpML1Am6nIqrtrtVTsNXCIDzWTSpI=;
        b=qar1nThLpBgkEGtlL3nLLTq4Cvxdmkd0cZGfG3/a/IC8RjNmjFeliszJ3Idct/TwK6
         Ql3bO6XGH4QRNpPwv9wigKbNzNSL/NYRy5MmgxzV101axaQzOixPs1PwSTkap56OHkPj
         TvW0+gdukmwuIv1YkUD1ShyE8ManuayTHAvPd6hDCLz2rFTTxwvA5qda/lThnSbezhSu
         Tqer/qf9Lc4tHmHX8Xtxv0fGvyl3JLG80ifrgTVSIaYtgFxzdV6+wMDuzkiWC6aIoDaS
         9018mIbPG1upQaiq8adKbcU4iPHo9NE2LlZFenFu1UdxUhQ10KbPhGZUaCz4t8uZCxko
         i0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ds7NBB5D8yNeSFpML1Am6nIqrtrtVTsNXCIDzWTSpI=;
        b=OkeZAFf7/FqI6EQdfPImSGt9onlShngHYZ3UcDEcu3plWLsxnknZ2E7Hn02Wg6Q0sM
         HC8KetjLsn168MjuXLjpTw+5GhWUHZ0BVN3cj1Zw0xxjELJXcMsIcX7hkn/NTETF7E/W
         ce1eyaYhP+dj5z41RC3SOpcTP3hHCwwcOJjGyVvRISBCveBAqbt+SPhWw/Vb8SK7fBPo
         qVEPnyG5TjHDIfyoSbnVNd5LZM6deUaFeKUGy2oBcMf7vnn8+uWFoEn0myumUYeP1nK8
         rDFhEdRbnNWbEMzDAojtc/ukV71wY473wQAjiU4LjQQ1rI7zVWbXORxuwdzTRqNNfWUv
         HB0Q==
X-Gm-Message-State: AOAM530hkOqB1ZvMJjlfR+rSoamN3h6uiBbt887IVk03Q0dcGQraWkJC
        I3z2OIJaG4qkDcmC/eCyLyox8A5P45vQm2xw8QvNQIe0
X-Google-Smtp-Source: ABdhPJxiNwbBIzk86VbxsQS0ccfWr2VIdmSp3TwKoSS/frmmsoNKpzEp61FnarhD2g5NIXET4J3qx0lCGIUsG5c5Xx0=
X-Received: by 2002:a54:4f9b:: with SMTP id g27mr1260255oiy.140.1599528542891;
 Mon, 07 Sep 2020 18:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com> <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com> <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
In-Reply-To: <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 7 Sep 2020 21:28:51 -0400
Message-ID: <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, linux-audit@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 5, 2020 at 3:07 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 9/5/20 11:13 AM, Casey Schaufler wrote:
> > On 9/5/2020 6:25 AM, Paul Moore wrote:
> >> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 9/4/2020 2:53 PM, Paul Moore wrote:
> >>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
> >> ...
> >>
> >>>> I understand the concerns you mention, they are all valid as far as
> >>>> I'm concerned, but I think we are going to get burned by this code as
> >>>> it currently stands.
> >>> Yes, I can see that. We're getting burned by the non-extensibility
> >>> of secids. It will take someone smarter than me to figure out how to
> >>> fit N secids into 32bits without danger of either failure or memory
> >>> allocation.
> >> Sooo what are the next steps here?  It sounds like there is some
> >> agreement that the currently proposed unix_skb_params approach is a
> >> problem, but it also sounds like you just want to merge it anyway?
> >
> > There are real problems with all the approaches. This is by far the
> > least invasive of the lot. If this is acceptable for now I will commit
> > to including the dynamic allocation version in the full stacking
> > (e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
> > to take even longer than it already has. Sigh.
> >
> >
> >> I was sorta hoping for something a bit better.
> >
> > I will be looking at alternatives. I am very much open to suggestions.
> > I'm not even 100% convinced that Stephen's objections to my separate
> > allocation strategy outweigh its advantages. If you have an opinion on
> > that, I'd love to hear it.
> >
>
> fwiw I prefer the separate allocation strategy, but as you have already
> said it trading off one set of problems for another. I would rather see
> this move forward and one set of trade offs isn't significantly worse
> than the other to me so, either wfm.

I remain unclear that AppArmor needs this patch at all even when
support for SO_PEERSEC lands.
Contrary to the patch description, it is about supporting SCM_SECURITY
for datagram not SO_PEERSEC.  And I don't know of any actual users of
SCM_SECURITY even for SELinux, just SO_PEERSEC.
