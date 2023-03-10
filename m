Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6943C64EC4
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 00:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCJAcl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCJAck (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 19:32:40 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECD102852
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 16:32:38 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-176d1a112bfso4205688fac.5
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678408357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDDMqwW1GLC8UUv9JUljZTRtLeluA0sa4qkSLYsTZUk=;
        b=jLMBdmA1DctdygM0KaJKaF4HoA/uEkWX/OIvNbcARfYCzNd86E3GFnNc+Zm0GZV/Og
         b2Oe3PepZFx/3XNuNV/42fLDLVWatCFh5p4Tx1+LUQLoeqGHZp2uSGBg/RpqFcdEEgJe
         axj7m0tnscF+Y1EsbK0cKOCs8k1XRkKM+QWUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678408357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDDMqwW1GLC8UUv9JUljZTRtLeluA0sa4qkSLYsTZUk=;
        b=FCsAo16h2rvFZm00Bw6oUcHltbwrF0LFH8H0PnpmxvRZ3EDK4mgKepkA/vY/wTZhWs
         5tJ2y7bXBLwGhsXCDI8MW0uDkwUpAXZo18ezL5bVsQSao9KSE/NisnC18tzsnkAo6dJ0
         t5Ub2LN8qrHk2ueasEKEXX29Z2WcPLX3hyExRn1hbzYwIzKIBSyU2mr24GpCbCSwU9wS
         64Efuqk9KGPDPqAta2476OW8kxjqWkbhCsZ0hnMTi+nNoW6Z8CdAfzcaOC1duEshiVwa
         moj7moPxT7HGsuSE2OHp9mZViG0H2IBki8b+C/2WWklObprawZRzOMF6WMXRTqd5pUL6
         EWHA==
X-Gm-Message-State: AO0yUKWrO6tcToiTOkY2nYQhuFDpTiW1jIad94LfRyAhev+FlgmdQ7E2
        BVxA1TfX4C91aUkpk0A4x+Uh7jmSq5ndLx73Lpvo5w==
X-Google-Smtp-Source: AK7set+p4AewkRkijc5ome9qvzmpVoUPb7cFQqPzldM97wQ31oYnl6pmwhvpaQ09qjETLqHdSfbIpdUo+DXRx3lfTG4=
X-Received: by 2002:a05:6870:5b01:b0:176:4416:eeff with SMTP id
 ds1-20020a0568705b0100b001764416eeffmr6930112oab.8.1678408357486; Thu, 09 Mar
 2023 16:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
 <CAEjxPJ43nNKG4QEKK5W2_K_TGeUjyUywvsqiPipT8Pom5VNMxw@mail.gmail.com> <CAEjxPJ5_K7mxCbDGErQdoULA5n7pu1FP0y0cFq-NZAO6aQDiaQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5_K7mxCbDGErQdoULA5n7pu1FP0y0cFq-NZAO6aQDiaQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 9 Mar 2023 16:32:26 -0800
Message-ID: <CABi2SkVC04CNUXFXG6dNMvao-VVt0+NqkpfbxE4zFfjRXhw5_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 17, 2023 at 7:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 10:22 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Feb 13, 2023 at 1:02 AM Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > On Fri, Sep 23, 2022 at 11:45 AM Dominick Grift
> > > <dominick.grift@defensec.nl> wrote:
> > > >
> > > > Paul Moore <paul@paul-moore.com> writes:
> > > >
> > > > > On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wro=
te:
> > > > >> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com=
> wrote:
> > > > >> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
> > > > >> > >
> > > > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >> > >
> > > > >> > > When SECURITY_SELINUX_DEVELOP=3Dy and the system is running =
in permissive
> > > > >> > > mode, it is useful to disable logging from permissive domain=
, so audit
> > > > >> > > log does not get spamed.
> > > > >> > >
> > > > >> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > >> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> > > > >> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> > > > >> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
> > > > >> > > ---
> > > > >> > >  security/selinux/Kconfig | 10 ++++++++++
> > > > >> > >  security/selinux/avc.c   |  9 +++++++++
> > > > >> > >  2 files changed, 19 insertions(+)
> > > > >> >
> > > > >> > I'm sorry, but I can't accept this into the upstream kernel.
> > > > >> > Permissive mode, both per-domain and system-wide, is not inten=
ded to
> > > > >> > be a long term solution.  Permissive mode should really only b=
e used
> > > > >> > as a development tool or emergency "hotfix" with the proper so=
lution
> > > > >> > being either an adjustment of the existing policy (SELinux pol=
icy
> > > > >> > booleans, labeling changes, etc.) or the development of a new =
policy
> > > > >> > module which better fits your use case.
> > > > >>
> > > > >> Thanks for the response.
> > > > >> For a system that wants to control a few daemons, is there a
> > > > >> recommended pattern from selinux ?
> > > >
> > > > That is effectively a "targeted" policy model. You target a selecti=
on of
> > > > entities and everything else is "unconfined" (ie not targeteed).
> > > >
> > > > An "unconfined" domain is just a process type that has many allow r=
ules
> > > > associated with it making it effectively similar to an "permissive"
> > > > domain. The difference is that since "unconfined" domains have full
> > > > access there should not be any AVC denials (nothing is blocked by
> > > > SELinux because the policy does not target the entity)
> > > >
> > > It seems that my system doesn't have unconfined_t, so
> > > I am trying to get an example.
> > >
> > > Can I use a wildcard, something like below ?
> > > type unconfined_t
> > > allow unconfined_t *
> > >
> > > An example would be appreciated.
> >
> > If your policy in Android-based, then the su domain would be the
> > easiest starting point. It isn't quite what you want (a permissive
> > domain with dontaudit rules that suppress all denials, only included
> > in userdebug or eng builds) but if you replace "dontaudit" with allow
> > everywhere, it would be "unconfined".
>
> BTW SELinux already has a way to achieve the same end as your kernel
> patch without any code changes; there are dontaudit rules in policy
> that can silence denials and you just need to write them to cover all
> classes/permissions. This is done in the Android su policy.

Got it, Thanks everyone for pointing out solutions!

-Jeff
