Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F98C0502C
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 15:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiH3PKX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiH3PKW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 11:10:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF158532
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 08:10:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y25-20020a056830109900b0063b3c1fe018so927693oto.2
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=k4uIZCj09OPiB9ZIZXJi0lST5T3gMDtE/b1B+oEFiow=;
        b=d7E2BS8pqriBSzyX2L1kJkLT/EdlpRTwtyafGYc+WlT0upFRzlxOzoFmkyjeCbWoWY
         PpWH1vdQ0J4Y5yOJY923KGymU2Ua2wdxMwn2yYWF+TLlEDRTDdsZgfI0/aUguA0/kwUZ
         tXiZ4LSLyAYlC27lsMNirFrgZkkP50ot3/VuloHfrKgfDloxLZVdj/vZ4GRS4e/6gRSK
         jZMNyOo4V/bexmbIUkkWrghHpMxqExYG5BStkmvpu138zhKH+hJWqiaaRREL6xrwQnKB
         uiOkY9fHYBNMagio1amJNBLeRJT674DYho7WTWgN3rUUDbtin4euzyvE9c55PQxd+od1
         Uohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=k4uIZCj09OPiB9ZIZXJi0lST5T3gMDtE/b1B+oEFiow=;
        b=n14ozldmPyJVkkm+oxRZbuB4oFcyzLIQdsad7sPUTU4cYpgYv3D54CZNR8j9uzPwXL
         /IwMifPYV7BkrNzfoanTB5rgqoqcbZPQXJ55ckNht4AkCfKEmqCNXzgfogcKuFHoYF/9
         gDvMch2agnKM5s/kquxUHbVS4AjFaqXp1aAMs0NlGkPIcQQtelmlbqIeYYbZitnJ7q9m
         OGBpcRWgo4al0p6MCX8ZogLbR8W+MGH8ieMis9+TI8RICoDn7BT95lmxgI8sAWxDA3zq
         058va9ffP1k5CvQlqqrU1q/8EcR7pTVANIwAOa1L4TT1B9kU/ll23kZlhGsx6DmiXxAY
         vzXA==
X-Gm-Message-State: ACgBeo22twZETjXhAYC5hZa6qs3jNTpzvt2usF+WhzM1Ei5JY4wSdQjH
        ag8WE2zh652+pz6J5m2TxzAJp+YHIc/swAUbfFrh41mO+1di
X-Google-Smtp-Source: AA6agR5GDMY9cll7BYezRMDbG58KYZyFzYK3xadeGPxUWVt5WbsZ2Bm8KCdmDWa6VCvcsnNK21suuM9D15DMVEVKnJQ=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr8657727otv.26.1661872218854; Tue, 30
 Aug 2022 08:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-8-cgzones@googlemail.com>
 <20220626223441.GA30137@mail.hallyn.com> <CAJ2a_DepL9pLqu48bsSAZzYjb6TPx6vR-U0puMzD3XjPK64yJg@mail.gmail.com>
In-Reply-To: <CAJ2a_DepL9pLqu48bsSAZzYjb6TPx6vR-U0puMzD3XjPK64yJg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 11:10:06 -0400
Message-ID: <CAHC9VhRK=xLCBLnGHkggkE0R1kEp6hCr5C+wCzvzuUqZWe8oUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 11:05 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 27 Jun 2022 at 00:34, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, Jun 15, 2022 at 05:26:23PM +0200, Christian G=C3=B6ttsche wrote=
:
> > > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > > alternative to multiple `capable()`/`ns_capable()` calls, like
> > > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> > >
> > > `capable_any()`/`ns_capable_any()` will in particular generate exactl=
y
> > > one audit message, either for the left most capability in effect or, =
if
> > > the task has none, the first one.
> > >
> > > This is especially helpful with regard to SELinux, where each audit
> > > message about a not allowed capability will create an AVC denial.
> > > Using this function with the least invasive capability as left most
> > > argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writ=
ers
> > > to only allow the least invasive one and SELinux domains pass this ch=
eck
> > > with only capability:sys_nice or capability:sys_admin allowed without
> > > any AVC denial message.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> Kindly ping.
>
> So far patch 3 was reviewed [1] and patch 4 was reviewed [2,3] and
> partially acked [4].
>
> Currently this series trivially rebases on top of 6.0-rc1.
> Should I send a rebased v4 or what is the best way to move forward?

Hi Christian,

Sorry for the delay, this is one of those things that was stalled a
bit during the maintainer hand-off.  It's on my list of things to look
at, it is just unfortunate that we have had a lot of things going on
at the LSM layer lately; don't respin it just yet, let me take a quick
look first ...

--=20
paul-moore.com
