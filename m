Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D03EB64DB
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 21:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFSVya (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFSVy2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 17:54:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D781BB
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:54:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b46f27f562so1275388a34.0
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687211658; x=1689803658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPxv5Pzmbzti4ZhHQG5/rtwZPeD+cnCO/79ABGcA7AQ=;
        b=UX7gW/NkDcSZwax3xhGeEIho0oO5PyxH+sGHkRgFsX/4/OcvCh9vTZkJff8K82Pi0O
         myB5Ub+qB5/P1R2BmlRUi/GsOByLUx+b16FOvC/yb6/DKJ+1r4D4XRl5V6m5lfnC+HRN
         9wDxquoaSImzjYCv+FoLcjppeuA0B5BQTLatg5GpRfUnLLPBIC5mv+WSgmkTyMozP8Co
         1aVzGyjMxxg2dMghdD/n+SROwZvkkcGMgA7ZLzbR+IDXik0Iln3VoqHcb+K7gum18ZT9
         F93BpSyAmKGA7ASZCJ4tl5WikK72o16G2ycZHj5TatJksNfTiYDO2BGkx6eru3+02+gS
         iI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687211658; x=1689803658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPxv5Pzmbzti4ZhHQG5/rtwZPeD+cnCO/79ABGcA7AQ=;
        b=T7JLkrpYSEJgvtwjdVJ/0QP/ZNu06kSH1XhwzR3b705yfS0hzp3AWm94esqeT9srq4
         TTrZiRuPQMPTxHTzqxjrw/zIDcGb/RANYAa4LT/+rGXvfuvXyaxyATRgC99xdiFk6ZKB
         qs2G+1nVZ8mrfkHhiiy0ZBQyzjG5LK632IQxO+5fpKLk0ZNH+nM8gST5U4QjNub3i13Y
         qhTdJWXsfGtbtsMEwp8IoL8+SmKaSdTmQwXFLiPsJCwl0xFS0LHW5/eW4WYl59Y4hz1b
         i5z1etOyImDE+Y3hr6xeL5TOXNvpC9siAicgIcHDW03GnW2SMO8tjdVOyukv5ZcAtr8a
         TBhA==
X-Gm-Message-State: AC+VfDxo0PUNXpOw0EoUHjTHuXQ+VSgMKqp+I03LP1lQGKYdY21OZ15L
        MtqzGVDuzUyyU5KNU4ZmVud2+ldaLcU+2LgPaIa3
X-Google-Smtp-Source: ACHHUZ49/U5dOxpd+8//7qJVPNmO1Z28AXIb6dDX/fpCzwrrStAOWix9AiT09aHMvnPB6G3u273NQyF4kRVhfCbDmz8=
X-Received: by 2002:a05:6358:e820:b0:129:c3a3:5efd with SMTP id
 gi32-20020a056358e82000b00129c3a35efdmr2841483rwb.24.1687211658479; Mon, 19
 Jun 2023 14:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
 <87r0qcotc0.fsf@redhat.com>
In-Reply-To: <87r0qcotc0.fsf@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 17:54:07 -0400
Message-ID: <CAHC9VhRTVRgNZ-PqpZCYJGT-zpidi-ahYFjXj5rbeKCQK1fStg@mail.gmail.com>
Subject: Re: SELinux and systemd integration
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 16, 2023 at 1:43=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > Hello all,
> >
> > Amongst Christian's various other SELinux contributions, over the past
> > several years Christian has been working on improving the SELinux
> > integration in systemd.  One of the things that Christian has been
> > working on is revamping the SELinux permissions that systemd uses for
> > unitfile operations, both to resolve problems and generally improve
> > the mapping of permissions to systemd operations.  As this work has
> > been languishing for several years, I would like to see if we can get
> > things "unstuck" by proposing two things:
> >
> > 1. I've provided links to the systemd GH PRs below, but I think it
> > might be helpful if Christian could provide a quick summary of the new
> > permissions, how they map to systemd operations, and how they map to
> > the existing SELinux/systemd permissions with a focus on helping
> > policy developers migrate existing SELinux policies.
> >
> > 2. Given the significance of systemd to modern Linux distributions, I
> > think it might be a good idea if we selected a SELinux "liaison" for
> > the systemd project.  This person, or group of people, would work with
> > the systemd folks to keep the SELinux integration in good working
> > order, review systemd code as necessary, and help represent the
> > SELinux project within systemd.
> >
> > How does that sound to everyone?  If we are in agreement on #2, and
> > assuming he would be willing to help out, I would like to nominate
> > Christian as our SELinux liaison to systemd; any objections?  Anyone
> > else interested in helping out?
>
> I agree with the Christian's nomination.
>
> As for #1, I looked on both, but I have to admit that I had a lack of
> understanding of the problem and so I would need some time to get
> into it. Therefore I postponed it due to other priorities, (but never
> come back). If it's still open I'll focus on it next week.

Thanks.

--=20
paul-moore.com
