Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABECEB64DB
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFSV6V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFSV6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 17:58:21 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E814134
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:58:19 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-570282233ceso33459847b3.1
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687211898; x=1689803898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfGwSWonWBN26ecTP3gWkXOCwieG5Sr/urFm9BHeFnc=;
        b=JoZOnSLC6AiZEFNYuVasCpycJzKb47uM/FVrx9BpgWer7FqiUb7DHvntPC0iLZEif7
         7HBOHXHADBR+DReJJgthfT2XJyqaHvfG94b5zHgNyOf1C0ElOGfcS7y75u7GrJIUsuQt
         iZH0vFK1M6eObfbH9Xopht1l0H8JhHwN9WekP89P49ewcXNWpSctrp28L435Udo/EWsD
         pKAWoBM8BIcoEY+5QygBFzV9wGruBBmPjju77rM0y7IOBUU1zq+GCtZmi4Sf7fU8iXiR
         wnAN1SPkSdi3r9JLntadNiY4R6fkqhM3wSpbUC7malD8wDfsK3s4GGgwaMMKOi3TRDHp
         uDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687211898; x=1689803898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfGwSWonWBN26ecTP3gWkXOCwieG5Sr/urFm9BHeFnc=;
        b=MBYX+W/gjaLm8ijU3kOcyxRNu0KhPZ6KRmGiyX+w3BZwg9kslwlmNYwrvrOxNrlnh2
         s8SgOGieU5+yg/+t98+eKtQ1miQ7udQh6E7Q4KTTwyI5Li45kFG6Y2tc+1UhCaNz8D8q
         9ob6RmZ0/FzfQ1EKpgO8Qr/NuMxWZW6bynBRrOGQo3iR1eJaVmNTwcRf0V6g/Bph+ZHL
         AN/QuMuNt5j/q54VfDwRKfjqU03u1kYoj3hG/szT5z9GH0Q8HC/QxhcGt+fxBUcnw5rl
         XitIbmi6iILyEh99K+lVH4I+LcxyVumEtDHNdAqPLgT/hTn8xmjsdfyeSCDGxMmGVcu5
         PAjw==
X-Gm-Message-State: AC+VfDzUk7reoWtlKJkXpLXICCjo94veAAiKcxoQCZBxphaamoWZ/3Ix
        03YXQdeyWUyDmWU0kjkOGk6kdIJ0en/jE1g4d1ZjTS1otbhUJ0KRQg==
X-Google-Smtp-Source: ACHHUZ7oDnHnbcgQfdy7IN9CaF9OwDO5e3prALV57cRCdmT2ybXZDKum56f3hR+A8lQrCILwJuocrs0ZU8gl7UCgVp4=
X-Received: by 2002:a25:e70b:0:b0:bc7:f963:eb48 with SMTP id
 e11-20020a25e70b000000b00bc7f963eb48mr5681392ybh.32.1687211898503; Mon, 19
 Jun 2023 14:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
 <87r0qcotc0.fsf@redhat.com> <CAJ2a_Dd0EM10WsgrEGY_SUh3L444d23_T1F36pphdJDnk_DSLg@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd0EM10WsgrEGY_SUh3L444d23_T1F36pphdJDnk_DSLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 17:58:07 -0400
Message-ID: <CAHC9VhRbEa8keNU=oNd1oNCkZuYYUZdLhvJTqhJ522sB9Fo=sg@mail.gmail.com>
Subject: Re: SELinux and systemd integration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 17, 2023 at 2:09=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Fri, 16 Jun 2023 at 07:43, Petr Lautrbach <plautrba@redhat.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > Hello all,
> > >
> > > Amongst Christian's various other SELinux contributions, over the pas=
t
> > > several years Christian has been working on improving the SELinux
> > > integration in systemd.  One of the things that Christian has been
> > > working on is revamping the SELinux permissions that systemd uses for
> > > unitfile operations, both to resolve problems and generally improve
> > > the mapping of permissions to systemd operations.  As this work has
> > > been languishing for several years, I would like to see if we can get
> > > things "unstuck" by proposing two things:
> > >
> > > 1. I've provided links to the systemd GH PRs below, but I think it
> > > might be helpful if Christian could provide a quick summary of the ne=
w
> > > permissions, how they map to systemd operations, and how they map to
> > > the existing SELinux/systemd permissions with a focus on helping
> > > policy developers migrate existing SELinux policies.
> > >
> > > 2. Given the significance of systemd to modern Linux distributions, I
> > > think it might be a good idea if we selected a SELinux "liaison" for
> > > the systemd project.  This person, or group of people, would work wit=
h
> > > the systemd folks to keep the SELinux integration in good working
> > > order, review systemd code as necessary, and help represent the
> > > SELinux project within systemd.
> > >
> > > How does that sound to everyone?  If we are in agreement on #2, and
> > > assuming he would be willing to help out, I would like to nominate
> > > Christian as our SELinux liaison to systemd; any objections?  Anyone
> > > else interested in helping out?
> >
> > I agree with the Christian's nomination.
> >
> > As for #1, I looked on both, but I have to admit that I had a lack of
> > understanding of the problem and so I would need some time to get
> > into it. Therefore I postponed it due to other priorities, (but never
> > come back). If it's still open I'll focus on it next week.
> >
> >
> > > For reference, Christian's systemd PRs on GH:
> > > * https://github.com/systemd/systemd/pull/10023
> > > * https://github.com/systemd/systemd/pull/20387
> > >
> >
> > Thanks,
> >
> > Petr
> >
>
> Hi all,
>
> Thanks Paul for attracting some attention to the SELinux integration
> of systemd.  It has been several months since I last worked on the
> systemd related patches, so they all need a rebase and another round
> of testing.
>
> Addressing the first point, here are some details about the changes I
> would like to see in systemd ...

Thanks for all the details Christian :)

--=20
paul-moore.com
