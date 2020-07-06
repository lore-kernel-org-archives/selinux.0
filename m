Return-Path: <SRS0=GZQR=AR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B65C433E0
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144CA20675
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDslvB8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgGFTsy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgGFTsy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jul 2020 15:48:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30437C061755
        for <selinux@vger.kernel.org>; Mon,  6 Jul 2020 12:48:54 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e90so2026446ote.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2020 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bCv1TagbzCNVVmU2tdgyHMLKVIStjHRl+4U8KOsmF2c=;
        b=qDslvB8CfCOU+pH6jUUDVNm9MibYGa7ptwwX25OdP8Eo/4YaRws34m9P2tjB4AYHxp
         i9ZALdaq/nKubCP6wYse2C1GfV0XEMagIKf70MY9edMwWzp+zLCFItITJzCcqO+3ugj+
         BjlbXvdN5n4B6XszUGjydKjA4zyNLy5IxFgQ2aWk4z0GprBoPYGZzt8tExJbOVly0YeX
         AtV36LhMjeEOh6YAoC0qv3lwElXYbaaCST4PxsB1Aeoul9Mmtv4TeYFwW+VhL/yFcIUO
         6Cz4VFqYgekP+S2l+Z+2Tj8ClwB+ajsN1VzwcDc2s5FHH9Jcl4fNER+F8Nk0Z6uV8NDq
         TOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bCv1TagbzCNVVmU2tdgyHMLKVIStjHRl+4U8KOsmF2c=;
        b=L1LCSQly3DzXPMWROsClEf8ig3+UOPjOVh7dIHLYkbabq8+McD+FKbdIftKGAkLykE
         h5hlZ5Fje8jf//qV2PQRbmL4hLONbhsNiELWYilMHUdum12T+mUoLuqeMriCl0s6Bf2U
         xquYGR2FMznetvTzJ2mbMoFR2YPVeUN6dGE4hai8iDwFfxJpyyAqkBozI+H88t+vFfii
         1XZOMsGu4zBJq7D7502QljTt6fcRxNCbZ3y3BevdyoYOUFUivFXkVl5himMj0U7P/PVJ
         PrVvTYqTHgJ7Aptk89hXtcy+qNpoWTVBvMn4/xtbPuHF7h26mbPAyzu5BUESx+5wLi8y
         6Osg==
X-Gm-Message-State: AOAM531aEqS5LrYhB8rP1mLsZj2jpk1u6JKEfGnzMcvd7S6VEBD3Osu8
        kpuUk+qXRthgrT9otQRiTqHVeIuve/li1UwrO5OOcYV7
X-Google-Smtp-Source: ABdhPJzxx56ZLVUhVt2//CwWCLMljFMvO19e+WGqbUJI9ZxeDU9VEF692q3HWp0PDn4gK3ogrCVGQFTSGrTnoBlMcxI=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr30232941otr.89.1594064933497;
 Mon, 06 Jul 2020 12:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <330f12f0-44d6-3659-0153-32b3cddf2db6@gmail.com>
 <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com> <0e910b9f-de42-bbba-b512-d0c96378a7a4@gmail.com>
In-Reply-To: <0e910b9f-de42-bbba-b512-d0c96378a7a4@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 6 Jul 2020 15:48:42 -0400
Message-ID: <CAEjxPJ672ykPqrgcTHKhjAbfdjSb9GZJNQMxFkM3j1mVuiVyAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fixfiles: correctly restore context of mountpoints
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 6, 2020 at 3:16 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Thank you for reviewing:
>
> On 7/6/20 8:25 PM, Stephen Smalley wrote:
> > On Tue, Jun 30, 2020 at 11:01 AM bauen1 <j2468h@googlemail.com> wrote:
> >>
> >> By bind mounting every filesystem we want to relabel we can access all
> >> files without anything hidden due to active mounts.
> >>
> >> This comes at the cost of user experience, because setfiles only
> >> displays the percentage if no path is given or the path is /
> >
> > Perhaps this should be opt-in via a new command-line option rather
> > than the default, given the user-visible difference in behavior and
> > the potential for something to go wrong for existing users.  We might
> > also want to look at improving setfiles / selinux_restorecon() to
> > support percentage progress without this limitation.
>
> I would argue that the new behavior is in theory "better" and allows remo=
ving a few questionable mounton allow rules from policies. If a user has fi=
les in a directory that was mounted over it could lead to surprises, so kee=
ping a backwards compatible behavior is probably preferable. I will impleme=
nt a new command-line option for it
>
> Fixing selinux_restorecon() to display the correct percentage is just a m=
atter of improving it to check if the relabel targets the root of a mounted=
 filesystem instead of the currently hard coded "/" (I think).
>
> >>
> >> Signed-off-by: bauen1 <j2468h@gmail.com>
> >
> > Generally I think a real name is required for Signed-off-by lines in
> > the DCO since otherwise it isn't truly meaningful from a legal
> > perspective.
>
> I've now also read the guide on submitting patches to the linux kernel. W=
hat would be the best way to go about adding my real name and email address=
 while also keeping my pseudonym and email in the commit, e.g. would just r=
eplacing the Signed-off-by with my real name and email address work ?

I think the important part is that you use your real (legal) name in
the Signed-off-by line. You can use whatever email address you like in
the Signed-off-by line (as long as you can in fact receive email sent
there), and that need not match the email address in the From header.
Of course, IANAL and others may disagree.
