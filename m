Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02CC04A94
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHATtW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjHATtR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 15:49:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C32711
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 12:49:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26813478800so3685063a91.1
        for <selinux@vger.kernel.org>; Tue, 01 Aug 2023 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690919353; x=1691524153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylGfSmYsW83S2sIlD3ijG30EHh1Eht85Vcatwpw9I5Q=;
        b=pQx75PAZv9ZiiZ/CQJdxiu+O3sFqQp0THdZ8m8i/WZQXgGna1nIu6zf5j/y92nKxDi
         VYgtHl9Fe5+AVZI6f0LhluHys9X3oKyOcGS4DmAgsKJZaQGgVlrbSYMagfpz/QQYTwo2
         Anr6BY+IBPnWqOxkhBADKE4VyUcDGiXIunz9oPv0OYW0Yl0UCJRXAg31W1O4XpqxfNF6
         Cm2Qd1JQlPbwg8a3fuDIQImp5MI3rD6jS8aTONzGrj3QkN/htmBW27Ngv2dKa2PLKk+Z
         atFYAnqMFRD43RrAyHYtR2yFclG4Wa8hbKDQS+zaKG+pEdNa6MvgCLMmPg9f8ecP6jMy
         Ke7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919353; x=1691524153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylGfSmYsW83S2sIlD3ijG30EHh1Eht85Vcatwpw9I5Q=;
        b=ibzWquLzQHpSxWWnWo+lZzwnPAf4rIwey6O9thJVqvjX96SfQk+a9jBwc2bDAYg7Sz
         dUYexJsfHQN687wDE2NK9JDmjFhagq69k7Sfs6c/tVipmp/dKZcBAUmQyGKcUtcT/EKZ
         Yg1clsff+0BqyXhds0Wx9WzC6pJ93o05P+KOmBtl0D08mvsMuka3x3Wuptb9mJI+0aDy
         Gp9SkeuM6G6PNB7C1c27BAd9sXJ3WfJK7AWkCgDv2nJCl+JiXm7VWqGC2cbYC0ENI69b
         RZIAAkx7UVhvMbyxf8wXXQKZH8oS6wikqRGSDe388WdaxD0SrQnj3hlG2bYl0XB5U3d5
         rGRw==
X-Gm-Message-State: ABy/qLaG5zIatWaE0Ad3Uk8CKOsbXYak8O8DNGYme9sTGHAkNSeVjnbe
        190LN93HUyOwG+rKE3QczyetSok5Ki78kqDlvMam4IHm
X-Google-Smtp-Source: APBJJlEoA7M/RZVEn67sd7mkeqRbnVd8CKKHTTkcT0JssaD1GQ3htZ4TViReHDcvTOveQW5wBcrkjiu/gLUsLTHRvD8=
X-Received: by 2002:a17:90a:db82:b0:263:e423:5939 with SMTP id
 h2-20020a17090adb8200b00263e4235939mr12884703pjv.28.1690919352649; Tue, 01
 Aug 2023 12:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
 <CAEjxPJ63oh92-49Oz3BjVxc=Kn6Rcwf1BbdziE_qLTnQ24VbLg@mail.gmail.com> <aced6072-1ca3-e01b-4964-67c36a869824@gmail.com>
In-Reply-To: <aced6072-1ca3-e01b-4964-67c36a869824@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 1 Aug 2023 15:49:01 -0400
Message-ID: <CAEjxPJ6f7SAO9gbkvriReDyqpAUMT5WT7cp64Me+8SUn8h93AA@mail.gmail.com>
Subject: Re: Network ports - multiple types?
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 1, 2023 at 3:38=E2=80=AFPM Ian Pilcher <arequipeno@gmail.com> w=
rote:
>
> On 7/31/23 07:13, Stephen Smalley wrote:
> > On Sun, Jul 30, 2023 at 5:03=E2=80=AFPM Ian Pilcher <arequipeno@gmail.c=
om> wrote:
> >> # semanage port -a -t fdf_port_t -p udp 1900
> >> ValueError: Port udp/1900 already defined
> >>
> >> # semanage port -m -t fdf_port_t -p udp 1900
> >>
> >> # semanage port -l | grep 1900
> >> fdf_port_t                     udp      1900, 3483
> >> ssdp_port_t                    tcp      1900
> >> ssdp_port_t                    udp      1900
> >>
> >> And, sure enough, my FDF service is now able to bind to udp/1900.
> >>
> >> I was not previously aware of this feature, and my internet searches
> >> aren't turning up anything about it.  I'd just like to confirm that th=
is
> >> is expected behavior (as it just seems really weird).  Are there any
> >> caveats to doing this?
> >
> > As far as the kernel is concerned, there can only be one type assigned
> > to a network port, so your new definition is overriding the earlier
> > one. Is the earlier one in a policy module rather than being created
> > via semanage? A potential concern with what you are doing is that any
> > rules written on the earlier type obviously won't be automatically
> > applied to your new type, so anything relying on that behavior will
> > break.
>
> Yes. The earlier context rule (ssdp_port_t) is in the default Fedora
> policy.
>
> Just to make sure that I'm understanding you correctly, it sounds like
> modifying the context of a port with 'semanage port -m' effectively
> changes it to the new type.
>
> So is it fair to say that the 'semanage port -l' output in this
> situation is deceiving?

I would say so, although technically it is an accurate depiction -
there is a rule in a policy module that defines it one way, and then
there is a local customization that defines it another, with the
latter taking precedence as far as the kernel is concerned. Confusing
at least.
