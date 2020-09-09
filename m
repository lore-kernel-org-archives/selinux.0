Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC236C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 13:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984022087C
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqnxKZl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgIINWx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgIINVV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 09:21:21 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48316C061573;
        Wed,  9 Sep 2020 06:20:50 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id y25so563462oog.4;
        Wed, 09 Sep 2020 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63PSCFxVUgf9cFtZOFDppeprHasPYk7KVkEdZRn0bLw=;
        b=mqnxKZl5ZnGwnTRHWg2f3W56NXbv+AJ2D3DCAG3pGsWIaVfiSQgMflgwmoqg4Cbed8
         d/A3qWEmO25H4Bj7qRDimUgZqTd+JXlaXQXLkCC/cwXwbyAvcTI8QEr6Z6V/X+UFaU8E
         nKV8YxphMYMUX7Zf/9kNF8UmlYJsoc8AIYp+qNYV9tcBll1BFKmhZ+n7LdohoujAFAnp
         yi8S0tjA9brImGo48Taw2qVCdp7S0OY05b9Iydm0kpbRLgq6uR+3vCuQmd9xvoIMDwje
         SRoCGmEOTReDlzvappeJffe6mOULEaiADDUzj+4WTidcT+IfsFSDxB0Z20+o5dA8Wg1u
         VWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63PSCFxVUgf9cFtZOFDppeprHasPYk7KVkEdZRn0bLw=;
        b=MsiN0FBnhPTJPhGedSHvgNF+PvjIGDoEKQKWkjosFnDWhlbwEM3PHdoRogbsdabIDh
         pCir15grRJ5rif6yww1TIjDKxRwruWO1e+Kqz4tqd1cSZTKwKB/TQKC8Q+GFFKj1Qnd/
         WPaUvagG6ERjXhe95hJPNzd87sbOdmu0wKeU/6mvXprBee3GVWfr2/RpoY/uawxPMr+1
         h/bi4TheYAbFQ2T5WDJZ0Tx/Zok6WNCjgaQ2Xyc+pOa9tAH+NaNEsd7W3kRih7B372Je
         3nAUGoacVitC0OL+vKH24SNXktETyJ9LIqH/Uz65+hKO0FqTYv75LZc9VjPfyZ99qVIO
         g5Dw==
X-Gm-Message-State: AOAM533hMJrBv5z4qX2kVF6fN5wwKuPbQOipLqcJ4JqWPgfrs55PxXwA
        jvVohqOcR6ncNn0ppFyxd9lOV0hkdRWNoEaz80k=
X-Google-Smtp-Source: ABdhPJzbXO7IXxWz8rasFqinds+vOSPYPPdDjmRVyVts6q7FAYoa/eJ4UHjV7ccel0e9l/ol8uS94rdkvmvRdOniqjg=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr763455ooq.13.1599657649486;
 Wed, 09 Sep 2020 06:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com> <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com> <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
 <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
 <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
 <c5bef71e-6d78-2058-bcaa-8497c76d7375@schaufler-ca.com> <b320f0f6-02db-95a5-acc5-cadd5dbb57dc@canonical.com>
In-Reply-To: <b320f0f6-02db-95a5-acc5-cadd5dbb57dc@canonical.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 9 Sep 2020 09:19:40 -0400
Message-ID: <CAEjxPJ6wFJz935RR_1u+-EjAw3VMv4nabo-Za_OqkZGJuNS5Sg@mail.gmail.com>
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

On Tue, Sep 8, 2020 at 8:21 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 9/8/20 4:37 PM, Casey Schaufler wrote:
> > On 9/8/2020 6:35 AM, Stephen Smalley wrote:
> >> On Mon, Sep 7, 2020 at 9:28 PM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>> On Sat, Sep 5, 2020 at 3:07 PM John Johansen
> >>> <john.johansen@canonical.com> wrote:
> >>>> On 9/5/20 11:13 AM, Casey Schaufler wrote:
> >>>>> On 9/5/2020 6:25 AM, Paul Moore wrote:
> >>>>>> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>>> On 9/4/2020 2:53 PM, Paul Moore wrote:
> >>>>>>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
> >>>>>> ...
> >>>>>>
> >>>>>>>> I understand the concerns you mention, they are all valid as far as
> >>>>>>>> I'm concerned, but I think we are going to get burned by this code as
> >>>>>>>> it currently stands.
> >>>>>>> Yes, I can see that. We're getting burned by the non-extensibility
> >>>>>>> of secids. It will take someone smarter than me to figure out how to
> >>>>>>> fit N secids into 32bits without danger of either failure or memory
> >>>>>>> allocation.
> >>>>>> Sooo what are the next steps here?  It sounds like there is some
> >>>>>> agreement that the currently proposed unix_skb_params approach is a
> >>>>>> problem, but it also sounds like you just want to merge it anyway?
> >>>>> There are real problems with all the approaches. This is by far the
> >>>>> least invasive of the lot. If this is acceptable for now I will commit
> >>>>> to including the dynamic allocation version in the full stacking
> >>>>> (e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
> >>>>> to take even longer than it already has. Sigh.
> >>>>>
> >>>>>
> >>>>>> I was sorta hoping for something a bit better.
> >>>>> I will be looking at alternatives. I am very much open to suggestions.
> >>>>> I'm not even 100% convinced that Stephen's objections to my separate
> >>>>> allocation strategy outweigh its advantages. If you have an opinion on
> >>>>> that, I'd love to hear it.
> >>>>>
> >>>> fwiw I prefer the separate allocation strategy, but as you have already
> >>>> said it trading off one set of problems for another. I would rather see
> >>>> this move forward and one set of trade offs isn't significantly worse
> >>>> than the other to me so, either wfm.
> >>> I remain unclear that AppArmor needs this patch at all even when
> >>> support for SO_PEERSEC lands.
> >>> Contrary to the patch description, it is about supporting SCM_SECURITY
> >>> for datagram not SO_PEERSEC.  And I don't know of any actual users of
> >>> SCM_SECURITY even for SELinux, just SO_PEERSEC.
> >> I remembered that systemd once tried using SCM_SECURITY but that was a
> >> bug since systemd was using it with stream sockets and that wasn't
> >> supported by the kernel at the time,
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1224211, so systemd
> >> switched over to using SO_PEERSEC.  Subsequently I did fix
> >> SCM_SECURITY to work with stream sockets via kernel commit
> >> 37a9a8df8ce9de6ea73349c9ac8bdf6ba4ec4f70 but SO_PEERSEC is still
> >> preferred.  Looking around, I see that there is still one usage of
> >> SCM_SECURITY in systemd-journald but it doesn't seem to be required
> >> (if provided, journald will pass the label along but nothing seems to
> >> depend on it AFAICT).  In any event, I don't believe this patch is
> >> needed to support stacking AppArmor.
> >
> > Stephen is, as is so often the case, correct. AppArmor has a stub
> > socket_getpeersec_dgram() that gets removed in patch 23. If I remove
>
> right but as I said before this is coming, I have been playing with
> it and have code. So the series doesn't need it today but sooner than
> later it will be needed

I don't understand why.  Is there a userspace component that relies on
SCM_SECURITY today for anything real (more than just blindly passing
it along and maybe writing to a log somewhere)?  And this doesn't
provide support for a composite SCM_SECURITY or SCM_CONTEXT, so it
doesn't really solve the stacking problem for it anyway.  What am I
missing?  Why do you care about this patch?
