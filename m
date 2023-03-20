Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E14C7618D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjCTQmJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCTQlu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 12:41:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BABA10423
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:36:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k17so3083877ybm.11
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679330176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flerCisFXQEnt8k/stiYcpE3X9K15bjOOu57Iwj/jp8=;
        b=IvdnO+NZpS+b+zAtDyf6z4sWyq/gp4eg/4NmZGmAQ7KiSXfHoIaSDQEZ7qQnqRy9s/
         8ZyLS23l03vymI0MR2Vf6GM388lzGEJ1Lo4iHxgMYS2vsz583nAfdE6XPtB8L0xlg2cj
         AaGrc/eFYJVmVjBrHGjTnzZUQ5Do80BSaLtWoW8gU6d3Q99qCVLqEDCCjp9STTszcLK0
         NRTjs3k7yK6vXyGC3cgbe9bDZCTpXJa6yE9L4xcMKTWyUiawaLw6jHPer+Xf/CBGNSgE
         Bv0IlHitg6RChIbU+Rrmc68D52Xw5BBQBNdxoZjN+QgjNKlt/16tUX2m26n3DxsK/ztc
         +kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flerCisFXQEnt8k/stiYcpE3X9K15bjOOu57Iwj/jp8=;
        b=v/mZttNS5m5WklePz8fwiP7pfVLyFAs3mPMVw/4opTwzhrMVfeh3As0j9gEgXUcqoj
         Urruqo3aesNsPCBScZ9mJukiLiSPuE2E2xNevjPRUIlY0BxFlZPqQ6hOff7cNOq6hOPP
         /Qze9goowWh7I03a/KIezkaHNVkocwG+Oo6Oaf5yuLdcycHdvqbQ3jF5QwIYmcPuNLaI
         W1jpjqSP07o36XjOtqCwTpY2lKhbAof3v0K2DlSGkWAu1a4xtybM3XSrjw1eVvsR1QPU
         dY+o/3yAaVuDsO2JCW40Kji2siooMzjlDr0xZ2ilxcJQjPML+WSNKQiCCLNnE7Z+ps4V
         PiRg==
X-Gm-Message-State: AO0yUKXJZQRowqP2xrnionZGl956rdmy/06LZQM15V/o4NsMEyONHtZs
        FKGtRjPnLNwXjaGNxhD32rgi4/kSGuXcDyTevWub8JD/zMDqspQ=
X-Google-Smtp-Source: AK7set/NEr+ibxuQti2c2NCKGggMmHU65e/Ay2Q89N1uGU7AfNHt1EJJT6himL74k8u1vf+ti8xFbhLaO9i24pJKojY=
X-Received: by 2002:a05:6902:708:b0:b6c:f26c:e58d with SMTP id
 k8-20020a056902070800b00b6cf26ce58dmr2159517ybt.3.1679330175777; Mon, 20 Mar
 2023 09:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com> <004b613e-c139-b4dc-157b-2f61433fe1d2@digikod.net>
 <CAHC9VhQ1kPCnx9Ha_ZX+6rq2hdLOESFrz5qF2kw05j8szFu1jQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ1kPCnx9Ha_ZX+6rq2hdLOESFrz5qF2kw05j8szFu1jQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 12:36:05 -0400
Message-ID: <CAHC9VhRjO7g7VfTsX49Lc6rz4ig8c5AL5_2GmuVszpBGNP41dQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Mon, Mar 20, 2023 at 11:14=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> >
> > This looks great, but I cannot apply it on any of these trees: Linus's,
> > the LSM's next, nor the next one.
>
> Likely because it's based on the SELinux next branch with the
> checkreqprot removal patch added on top as I expect to merge both of
> these patches soon.  There have also been some pretty widespread
> changes in the SELinux tree this dev cycle outside these two
> deprecation/removal patches.
>
> One could make an argument that this should go in via the LSM tree as
> it touches all of the LSMs, but those impacts are trivial, and the
> SELinux changes are more significant so I made the decision to do the
> development and merge the patch via the SELinux tree.

... and you'll now find this merged into the selinux/next tree.

--=20
paul-moore.com
