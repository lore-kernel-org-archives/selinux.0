Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB1C433E3
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 16:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4220672
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="lFBU7ZDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgGOQGV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGOQFT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 12:05:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C13CC061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 09:04:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so3186279ljo.7
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6lE5f0+/rEY7wdBC8Q7Qj3lCzWdxiIC/n2zXInDzEU=;
        b=lFBU7ZDrr8gw0F/OashSboYcXovomuNUPl7T/1kx4IsnKkdJ09vg2DXjHAeiHjrwTT
         cCi3bVW9ype/DHUERCf2wlL/aDuTFS0HlRe/U/hiybXP+sW1tUZtWBtMnNRu15AHfLfw
         l4EWOFd7a2/ANIH/bE1q6pePYk/PNwY5Uxabo1zH/XUV6iIQU8QJCLIy+WJKHXwBWvcC
         ou+1j1os+xdVkidS6n4ppqf1MaVlfWWsoCCL7d2Xm7e8DzqpmGAcIFHaFJ8E59B2ksqi
         l58JHL2oRWoge6toltaqUsnhUaSoOW0GzXhhV3YmUT5kg+rtmwXAyJ6/ZBIrZH+LYeJ3
         wLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6lE5f0+/rEY7wdBC8Q7Qj3lCzWdxiIC/n2zXInDzEU=;
        b=gX8fI4umYIS6RKL8BPka2DaOeAFb4DorqxxirG8sI+c9boafPr4XebQWLwlTuv2j0h
         Z/ZpOlz/ONDtqxIlZT1raIJkS0aahuG/8ah8C6V/iXSgnYBYdLAtYo+vWxso+b80Hegq
         +H7KyG/dLgcfRL1yleBA/qmtm2sGitD1GX3HtvBoRRvXkXP/zStCMXerbaon44obvn1E
         RDnywSC2BzTciP2TEoOMttMAZeZiO5/keK2FPD6yRM8AySQPt/d4QZhy1BOOVm6m0OZ0
         DBNWIvopRnaKdKh3m8825glhbbMWe1ohW1kLXnsbNy+WlmEU6H8kL78cSvIXXCsglU3i
         OTLA==
X-Gm-Message-State: AOAM533jpL426CByR0YVIJh8KGeUFDORAlML1ybbSAnQgpQKBDXyInzJ
        kezepVe/FPevmYvkg9jAO7dzGRtD1b68+UBluIhmNu6/Uoeb3w==
X-Google-Smtp-Source: ABdhPJyDlF1/CgH7OQK8VSVAtI8xtOsae7PKfD9w/S3dSOuXYNnffJuQ0TNuGOIJj0hiFgXfWY2KALUd6SJFSBDqP+E=
X-Received: by 2002:a2e:91da:: with SMTP id u26mr5344911ljg.311.1594829092617;
 Wed, 15 Jul 2020 09:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com> <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
In-Reply-To: <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Wed, 15 Jul 2020 12:04:41 -0400
Message-ID: <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 14, 2020 at 6:42 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
<snip>
> > > Do you think we should go ahead and completely swap in sestatus? I was
> > > just worried about breaking userspace object managers that are
> > > currently using netlink threads by default, for instance
> > > systemd-dbusd.  I can spend some more time getting those to work with
> > > the status page if you think that's worthwhile.
> >
> > I'd be interested in understanding the impact of such a change on
> > existing userspace object managers.  If we can switch the default
> > behavior for applications that are not explicitly using
> > avc_netlink_*() interfaces themselves (e.g. they are only using
> > selinux_check_access or avc_has_perm), then that would be beneficial
> > since I think it fully removes the need for a system call on the AVC
> > cache-hit code path.
>
> I'll have to do a bit of digging to see how this will affect dbus, et
> al. On first blush, it looks like they're just doing
> avc_netlink_check_nb() in their watch thread. Presumably other object
> managers are doing something similar so we would just need to make
> sure there is a netlink fd available.

So it looks like dbus (at least) is directly checking for a netlink
socket[1], so just doing away with the avc_netlink_open call wouldn't
work out. My thinking is we have two options:

1) Add a new seopt to use sestatus and let userspace object managers opt-in

2) Call both selinux_status_open and avc_netlink_open in
avc_init_internal. This would satisfy the hard requirement for a
netlink socket. Then we can default to using sestatus in all of the
netlink processing paths, as you suggested in your last reply. We
could

Option 2 seems better from the standpoint of using sestatus by
default, but it looks like recvfrom will never be called and the
messages will just sit in kernel memory.

I'm inclined to go with option 1 at this point.

[1] https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L269

--
Mike Palmiotto
https://crunchydata.com
