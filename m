Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9144C433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE023C32
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 14:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4ryKg17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIHOAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgIHN6d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 09:58:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46FC0619C2;
        Tue,  8 Sep 2020 06:35:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so14846921otg.5;
        Tue, 08 Sep 2020 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gar4BreDCQ/72P6bchhSRHNsc6Zc5dSSb5ZIWUFYbnU=;
        b=P4ryKg17uiPYjfiska4TXIoTtz0a9xSokIWzAMp6NfUGQkBwz4xpAvHocnh13JqWn8
         N8NkcguNthlcs9/UuzsCfw0qj8SHdBgvjLNj7JDDjjZ3pGt7JaI+du7t41v6u6lACv7I
         dv5p+dLohygkOOw+RtC92LmnB15ymXLjrF5uw2iY/mhjo7nDiq5PH1adNo9Yx4zH+MD/
         oG7jQFyBUD4gLpmBUESd0jSeEo0HzigfCOnkKo26MT/YL/lIZ7vPqP/mdZlW3l+pb0jw
         LYmv4g3o8HOVC1NYgIMDO0t8z9+dh+HP/uw5pnNLlDvW0gPjjIILjKSf/LN9sP+KEUlv
         32OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gar4BreDCQ/72P6bchhSRHNsc6Zc5dSSb5ZIWUFYbnU=;
        b=r9TcqnzFwoim7DAmDfOGZ3ANQUR6mMHOSlYhwuISCDUxi25eICrWzNjOXnbPi+7vT4
         Xu2bCNOO9ejWT4nwvz87zIPmOQb4ZI2XV+tSxmyjv+VwTV+P0lK2E9oytDOl9OqG1Au5
         889NU/dG1/EDWDhZAIicGNcznOJWkewMWKa50V910MuuF1KphifiGjcaqZsalb6frM7s
         Z0ZT0aRQTVurwJ/fO2uNxijJcFNhpqaW6WddjJrdgIiZrtwqQtCxVWOfzeQthmVA9ak+
         Cfap0gjuhUPpTeYeTe95Xuh1vDJlUw/d2r7FrwlJNTkO1uu/MFondNndroVDYoqKl2Kc
         9p2w==
X-Gm-Message-State: AOAM530hLpjUbHuLq+dmdukoKrRQtp7iGNVxmtfDuluBEn6Tyfk2ODzw
        5DXIiTYuSUEL109ilGX8jKYjlzpr4yCKW7rIvAF2pZYRV3w=
X-Google-Smtp-Source: ABdhPJyWhiQ0vShLlXuCv5fr448BVDeWmqjkRs6wxP3IGO8/JwS7/Gyogf/s6MDSZT/XRrzVYfRpZoeMQH4wTkN0STE=
X-Received: by 2002:a9d:185:: with SMTP id e5mr18471022ote.135.1599572116933;
 Tue, 08 Sep 2020 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com> <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com> <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
 <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 09:35:05 -0400
Message-ID: <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
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

On Mon, Sep 7, 2020 at 9:28 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Sep 5, 2020 at 3:07 PM John Johansen
> <john.johansen@canonical.com> wrote:
> >
> > On 9/5/20 11:13 AM, Casey Schaufler wrote:
> > > On 9/5/2020 6:25 AM, Paul Moore wrote:
> > >> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >>> On 9/4/2020 2:53 PM, Paul Moore wrote:
> > >>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
> > >> ...
> > >>
> > >>>> I understand the concerns you mention, they are all valid as far as
> > >>>> I'm concerned, but I think we are going to get burned by this code as
> > >>>> it currently stands.
> > >>> Yes, I can see that. We're getting burned by the non-extensibility
> > >>> of secids. It will take someone smarter than me to figure out how to
> > >>> fit N secids into 32bits without danger of either failure or memory
> > >>> allocation.
> > >> Sooo what are the next steps here?  It sounds like there is some
> > >> agreement that the currently proposed unix_skb_params approach is a
> > >> problem, but it also sounds like you just want to merge it anyway?
> > >
> > > There are real problems with all the approaches. This is by far the
> > > least invasive of the lot. If this is acceptable for now I will commit
> > > to including the dynamic allocation version in the full stacking
> > > (e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
> > > to take even longer than it already has. Sigh.
> > >
> > >
> > >> I was sorta hoping for something a bit better.
> > >
> > > I will be looking at alternatives. I am very much open to suggestions.
> > > I'm not even 100% convinced that Stephen's objections to my separate
> > > allocation strategy outweigh its advantages. If you have an opinion on
> > > that, I'd love to hear it.
> > >
> >
> > fwiw I prefer the separate allocation strategy, but as you have already
> > said it trading off one set of problems for another. I would rather see
> > this move forward and one set of trade offs isn't significantly worse
> > than the other to me so, either wfm.
>
> I remain unclear that AppArmor needs this patch at all even when
> support for SO_PEERSEC lands.
> Contrary to the patch description, it is about supporting SCM_SECURITY
> for datagram not SO_PEERSEC.  And I don't know of any actual users of
> SCM_SECURITY even for SELinux, just SO_PEERSEC.

I remembered that systemd once tried using SCM_SECURITY but that was a
bug since systemd was using it with stream sockets and that wasn't
supported by the kernel at the time,
https://bugzilla.redhat.com/show_bug.cgi?id=1224211, so systemd
switched over to using SO_PEERSEC.  Subsequently I did fix
SCM_SECURITY to work with stream sockets via kernel commit
37a9a8df8ce9de6ea73349c9ac8bdf6ba4ec4f70 but SO_PEERSEC is still
preferred.  Looking around, I see that there is still one usage of
SCM_SECURITY in systemd-journald but it doesn't seem to be required
(if provided, journald will pass the label along but nothing seems to
depend on it AFAICT).  In any event, I don't believe this patch is
needed to support stacking AppArmor.
