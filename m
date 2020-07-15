Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204F3C433F1
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68D320658
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="xp09bQYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGOWpr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgGOWpq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 18:45:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F205C08C5CE
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 15:45:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so4584706ljg.13
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPoIwS9/U2ZilxkSvSW+dNeuQDUBTa2rQNPOsJU/TOs=;
        b=xp09bQYw/VL+bEXZGmY7eiw+mTLwb7yHydi4WxnJYASFIXssQrxyM0EMvkGBzRhzBH
         bHSNJUNGwidR4Q0N02xyCfCu9q19qAHMHeHfKHyEW1EPhIHyaXjSSujs8wStoB4SIHxs
         Mj3M1r4rCb3Imsqh1VeXnANAtRviQXvIHIhHKp0nVX6w9dU1xzKuVbFnNgm/HIAvcIKf
         o6dAlZ5U0hU1mXxLJ95ob5UtX0IrnfIO4V7GzXs8Pgcm8eA061qhuQBccQJpkWEVDaYW
         hHjFwllTAIg9Cv6ibaji2YjJW3rels2O9p49CeVNX9AQu12BdJQyRNusbLcqmHlN1DXi
         wR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPoIwS9/U2ZilxkSvSW+dNeuQDUBTa2rQNPOsJU/TOs=;
        b=T00HFS+9U338957SPvH5iLYVqxwarbov+hN/FTChozlmsc4CpWWTaV5XwWA3DUDM8B
         ZwgCzcufBHvw++c8gyHNCHJ+qmai5bAL144GOx0G5aEGBKYV7CnwZ27F+q1a55FmLhu6
         Ki/vt/ws7g3VOEXyuD5olcGpbcQVB4zN3EZdCovYx0QH4xTP5qqaNXbrMMlWVN3V/+Lx
         f+0f8y859zTsvPeqF/ABhTKiRVG+640svbYQH3CbP2L3D8c8B53gTewNA2tivmxi2Xfr
         Be2bZ9hcIMH7wqLRs7T5ZNb/yIy2+mxvxCaj0AIm3byI35yQZToYANmZTBonATwxoUIx
         mP7A==
X-Gm-Message-State: AOAM5322BY10m9vrxmKZ6quuu1a89uoe7OKwuxkkdKbn/GSkwJrew02G
        wdcKJyhtGN9o1DKNx4AJ6uCK/QAxbx1XBvRgnzMAbZTpopXwlQ==
X-Google-Smtp-Source: ABdhPJzrDN60ZPi4nRTFntrTAHAnbPOEPRtPQRlvzWC4No0e7R3nZfoy23Vo+0wPXPv6GFBjHett1Ti/O6x4br1kxos=
X-Received: by 2002:a2e:91da:: with SMTP id u26mr613679ljg.311.1594853143985;
 Wed, 15 Jul 2020 15:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
 <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
 <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com>
 <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com>
 <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com> <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Wed, 15 Jul 2020 18:45:32 -0400
Message-ID: <CAMN686H=3RY-E1a01fWPY9QqGpUABVxJmQGrx00c53JrMVswZA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 3:46 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 2:52 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 1:10 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 12:28 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 15, 2020 at 12:04 PM Mike Palmiotto
> > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2020 at 6:42 PM Mike Palmiotto
> > > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> > > > > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > > <snip>
> > > > > > > > Do you think we should go ahead and completely swap in sestatus? I was
> > > > > > > > just worried about breaking userspace object managers that are
> > > > > > > > currently using netlink threads by default, for instance
> > > > > > > > systemd-dbusd.  I can spend some more time getting those to work with
> > > > > > > > the status page if you think that's worthwhile.
> > > > > > >
> > > > > > > I'd be interested in understanding the impact of such a change on
> > > > > > > existing userspace object managers.  If we can switch the default
> > > > > > > behavior for applications that are not explicitly using
> > > > > > > avc_netlink_*() interfaces themselves (e.g. they are only using
> > > > > > > selinux_check_access or avc_has_perm), then that would be beneficial
> > > > > > > since I think it fully removes the need for a system call on the AVC
> > > > > > > cache-hit code path.
> > > > > >
> > > > > > I'll have to do a bit of digging to see how this will affect dbus, et
> > > > > > al. On first blush, it looks like they're just doing
> > > > > > avc_netlink_check_nb() in their watch thread. Presumably other object
> > > > > > managers are doing something similar so we would just need to make
> > > > > > sure there is a netlink fd available.
> > > > >
> > > > > So it looks like dbus (at least) is directly checking for a netlink
> > > > > socket[1], so just doing away with the avc_netlink_open call wouldn't
> > > > > work out. My thinking is we have two options:
> > > > >
> > > > > 1) Add a new seopt to use sestatus and let userspace object managers opt-in
> > > > >
> > > > > 2) Call both selinux_status_open and avc_netlink_open in
> > > > > avc_init_internal. This would satisfy the hard requirement for a
> > > > > netlink socket. Then we can default to using sestatus in all of the
> > > > > netlink processing paths, as you suggested in your last reply. We
> > > > > could
> > > > >
> > > > > Option 2 seems better from the standpoint of using sestatus by
> > > > > default, but it looks like recvfrom will never be called and the
> > > > > messages will just sit in kernel memory.
> > > > >
> > > > > I'm inclined to go with option 1 at this point.
> > > > >
> > > > > [1] https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L269
> > > >
> > > > Couldn't we change avc_netlink_acquire_fd() to test whether fd hasn't
> > > > yet been set (i.e. == -1) and call avc_netlink_open() in that case?
> > > > Then dbus would still gets its netlink fd as expected but we wouldn't
> > > > need to open it inside of avc_init?
> > >
> > > Much better. I'll send a new patch up shortly.
> >
> > Okay, maybe not that shortly. I tried your suggestion and dbus doesn't
> > appear to receive the netlink messages.
> >
> > Initially I figured it had something to do with
> > avc_create_thread(avc_netlink_loop) call still being in
> > avc_init_internal, so I exposed the thread pointer in avc_internal.h
> > and moved the call into avc_netlink_open, which seemed more
> > appropriate. Still no dice.
> >
> > I'm probably doing something wrong -- I'll figure it out, but it's
> > going to take me longer than I thought to track this down.
>
> Recommend writing a little test program to exercise it first without
> bringing in all of the dbus baggage.  Don't think Fedora is even using
> dbusd anymore, just dbus-broker.
> If you get stuck, feel free to send your patch and I can take a look too.

Interestingly, the test program is working fine:
https://github.com/mpalmi/selinux/tree/sestatus
https://github.com/mpalmi/sestatus-test

On a test run, I'm seeing both the status page and netlink socket
notifications for load_polcy (twice for each case):

```
 ./test
opened avc successfully
got netlink socket: 4

watching netlink socket for events
avc:  received policyload notice (seqno=3)
policy reload notice received
avc:  received policyload notice (seqno=4)
policy reload notice received
^C
watching sestatus page for events
avc:  received policyload notice (seqno=5)
policy reload notice received
avc:  received policyload notice (seqno=6)
policy reload notice received
^Cclosing netlink socket: 4
destroying avc
goodbye
```

Still seeing the MAC_POLICY_LOAD audit message, but none of the usual
USER_AVC policyload notices.

I'm not certain if I've covered enough, but this is where things
currently stand. I can submit another patch to the list if that's
preferable. I just figured I'd keep the noise down as much as possible
until we figure out what's going on with dbus.

Thanks for all the help

--
Mike Palmiotto
https://crunchydata.com
