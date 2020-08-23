Return-Path: <SRS0=x6f6=CB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEBC433DF
	for <selinux@archiver.kernel.org>; Sun, 23 Aug 2020 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70C820706
	for <selinux@archiver.kernel.org>; Sun, 23 Aug 2020 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="x6zv1MeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHWO3n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Aug 2020 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWO3l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Aug 2020 10:29:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295FC061573
        for <selinux@vger.kernel.org>; Sun, 23 Aug 2020 07:29:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so6746244ljn.11
        for <selinux@vger.kernel.org>; Sun, 23 Aug 2020 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3WppUAkGp4EkLkzB+kVqFH50UYKw1vif3EsXlK2pus=;
        b=x6zv1MeMg/K+0ZLn+2ivaSGc/GsO6domL8dkUPfSm+b6uKGb9WPy1zt7AH9sBFcw/I
         wkiZ77O8BHlOjuIl/caLyjGBKmJBRxsKM+N40rRnIVyvZE3UzBwmTA+RsXdhOXyQREix
         kehGkMyFjLVNsA8ZRPDWQWPL2Bdwbgl6KNZG92b1OeGVfgWiM1u6sP2eMXdUlP5cwGhD
         kjpU9C3Qpby+1sW+GkL8h9KDsxZ14VzNEa/qxzvUWkjcHZM1uf2cjb9pfXD1GSUwODAQ
         iRe2aTF+MJTYWyWIMZRuRnsw1gD7/fHAhjbPXqDMVamHafJQ/p26+Bib4QGr53ZzVlng
         1CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3WppUAkGp4EkLkzB+kVqFH50UYKw1vif3EsXlK2pus=;
        b=mWvlZ/yQj3G73p+I9tSAsDoOsJ8o7FiICJG64ZjPcmLdniXPG6Aa1SW6k1T5vvJ2ke
         DCOztI+GeKYgHDT4Kg019QTkxCXto+qMt0BZiiTI/nlqgGe3frKYZycqb26h7BtYYARR
         lXd2UEoHei/+Ip1uZArho7SSoF2A9HPivx5f73D0zNEMD4JR/9v+AB9YEFlsCKnMeASE
         318W50t4kSMRHdNlIfV6PHRAfkF0Qm0RmMqmya600x7HYTeY5FQKiO0NwsChNlbKb22q
         lbCv8ziTtQqhGqbOl0WUzUw91e4OzcyoEAPcuZMEBnILHO1I11KP/An6ctJYjzVoxApJ
         qvxw==
X-Gm-Message-State: AOAM532uwD4zv/kWE92i4/5XjHifxT6AxzV4QOEeLEk2NckUQp34t+XP
        gedIQdvEAfn5wwkjhyXjphTHXDBI40+MxSxbdIO3pA==
X-Google-Smtp-Source: ABdhPJyRXpxqDMMQIgRMbDtMeYG1sFapCruAborSDyZpD3jvamVMX8CkXRGEHVavpmc+aqF9n8ktY8nJW0SqMLu79G8=
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr674632ljc.350.1598192979146;
 Sun, 23 Aug 2020 07:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200805194312.7188-1-mike.palmiotto@crunchydata.com>
 <56f3aed8-03e3-f847-967c-e9c8630f692b@gmail.com> <CAEjxPJ4F70OTPLi_u0Dz8LO7qs_1WuoaK9EqP4awVf92MViOtA@mail.gmail.com>
 <CAJ2a_DfkdX1Nmqs6_H-3k2qg=eYOuz3KDhS8EQYNG35jTR=bTw@mail.gmail.com>
In-Reply-To: <CAJ2a_DfkdX1Nmqs6_H-3k2qg=eYOuz3KDhS8EQYNG35jTR=bTw@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Sun, 23 Aug 2020 10:29:28 -0400
Message-ID: <CAMN686HHdq_xZXO8dHrQY90tjJuCPNQbukTbyN9w=KJ=4Pievw@mail.gmail.com>
Subject: Re: [PATCH v6] libselinux: use kernel status page by default
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 23, 2020 at 9:30 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Am Di., 11. Aug. 2020 um 14:14 Uhr schrieb Stephen Smalley
> <stephen.smalley.work@gmail.com>:
> >
> > On Thu, Aug 6, 2020 at 8:05 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On 8/5/20 3:43 PM, Mike Palmiotto wrote:
> > >
> > > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces f=
or
> > > > /selinux/status") introduced the sestatus mechanism, which allows f=
or
> > > > mmap()'ing of the kernel status page as a replacement for avc_netli=
nk.
> > > >
> > > > The mechanism was initially intended for userspace object managers =
that
> > > > were calculating access decisions within their application and did =
not
> > > > rely on the libselinux AVC implementation. In order to properly mak=
e use
> > > > of sestatus within avc_has_perm(), the status mechanism needs to
> > > > properly set avc internals during status events; else, avc_enforcin=
g is
> > > > never updated upon sestatus changes.
> > > >
> > > > This commit gets rid of the default avc_netlink_open() in
> > > > avc_init_internal(), replacing it with selinux_status_open(). In th=
e
> > > > event that the kernel status page cannot be mapped, the netlink fal=
lback
> > > > will be used. By default, avc_has_perm_noaudit() and
> > > > selinux_check_access() will now attempt to read the kernel status p=
age,
> > > > which removes a system call from two critical code paths.
> > > >
> > > > Since the AVC thread create/stop callbacks were intended to avoid a
> > > > system call in the critical code path, they no longer need to be cr=
eated
> > > > by default. In the event that the kernel status page is successfull=
y
> > > > mapped, threads will not be created. Threads will still be
> > > > created/stopped for the sestatus fallback codepaths.
> > > >
> > > > Userspace object managers that still need a netlink socket can call
> > > > avc_netlink_acquire_fd() to open and/or obtain one.
> > > >
> > > > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > > > functionality.
> > > >
> > > > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Applied.
>
> I think in `libselinux/src/sestatus.c` the static variable
> `last_policyload` does not get updated during `selinux_status_open()`.
>
> This leads to policyload-callbacks getting called if the first change
> to the status page is an enforcing change.
>
> Reproducible with trailed test binary:
> Running the binary and during its runtime changing the enforcing
> status via setenforce 0/1 triggers the policyload callback:

Thanks for the report. Seems like an easy enough fix. Do you want to
submit a patch, or shall I?

--=20
Mike Palmiotto
https://crunchydata.com
