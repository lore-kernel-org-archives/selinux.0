Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB8C433E5
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CDF2065E
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB/wvzJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGOQ2o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGOQ2n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 12:28:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CFC061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 09:28:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id h17so2681903oie.3
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTT4V2N3/Joh0JAQw9X21XFKKYvWxQc1aZWKiDpksEQ=;
        b=KB/wvzJnQ7H94abM6OgiJU6abyehsYJhc9CO7C3ovEY3CsdbNqCm7SiQk0TaYIxQ/e
         KnRwoIKV2fsbEXe66vMU41NBPhGNXSfmUV9zpTLWPRvUiQsAtVtNLrkmJVlrzH93GMVr
         ozkVFhaVgNdh0ekzwX9zBcvM/3BzpS7vowB+ToWbyTJ/2uXUE9HSp9usGeHP2eqEhV6A
         HlO7Jd797fIWoElykK6YwC5kbwK7AXRC+Iu9MvCT0+Qzf1GT9gR3S1Tg8Z7p8uMDFAcM
         M0Jx7IB9/CC1/LsdBj6bVdIRMfpKpl9XPMz+vICdKJoxWGCUjozFFz05vNTuEYAFMOKQ
         YxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTT4V2N3/Joh0JAQw9X21XFKKYvWxQc1aZWKiDpksEQ=;
        b=Lr2Dk3nC/qVUbaRN/4YdR/gHYikhppr8D6wQqYL/vTEDkVpnBfdG6HURKfKiqfAu71
         MNXKkJN9z9N2pzy3DuLEyc3y658sdrdGveQTIqGfEFi2/refOTaP0SIeo/5jCqqQntpy
         LEgMlnwDgw1Ia/vzi8uBRdgUDK3tlCkZTFzbkFibTccARHtZQU9IpBeJf0rrOPILxZ/N
         7IJTI5xxTj2K16GRJrMK/9zNCyCNk3X4oU68oSQVzN7OIROUBfpaE6I+hRJ8BVw08zyg
         gEEyjL8ncjuQgi2PIh4bbdEQaEpbNZNKKXxLKUFC5iP8sWE4D7L+aQ2V9pLA56o3xWEn
         FrDQ==
X-Gm-Message-State: AOAM530Vyd7b++X+/hWiIUBCRj6DbtcOiGasTryHkgLv1LfVmeJPvNoI
        fHYzP15FvAPekR5jAGcxBRdhP80FSUVHP97irg4=
X-Google-Smtp-Source: ABdhPJw1Y3o5pMpMyKnVqs+s2NqVbiMls/PWundxyOGcrsLExlNdNRWPW2r2lpAc7R7jq2wA81mY1xJXMfUY0yf/Q74=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr430339oif.160.1594830522655;
 Wed, 15 Jul 2020 09:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com> <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
In-Reply-To: <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Jul 2020 12:49:06 -0400
Message-ID: <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 12:04 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Tue, Jul 14, 2020 at 6:42 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> > > <mike.palmiotto@crunchydata.com> wrote:
> <snip>
> > > > Do you think we should go ahead and completely swap in sestatus? I was
> > > > just worried about breaking userspace object managers that are
> > > > currently using netlink threads by default, for instance
> > > > systemd-dbusd.  I can spend some more time getting those to work with
> > > > the status page if you think that's worthwhile.
> > >
> > > I'd be interested in understanding the impact of such a change on
> > > existing userspace object managers.  If we can switch the default
> > > behavior for applications that are not explicitly using
> > > avc_netlink_*() interfaces themselves (e.g. they are only using
> > > selinux_check_access or avc_has_perm), then that would be beneficial
> > > since I think it fully removes the need for a system call on the AVC
> > > cache-hit code path.
> >
> > I'll have to do a bit of digging to see how this will affect dbus, et
> > al. On first blush, it looks like they're just doing
> > avc_netlink_check_nb() in their watch thread. Presumably other object
> > managers are doing something similar so we would just need to make
> > sure there is a netlink fd available.
>
> So it looks like dbus (at least) is directly checking for a netlink
> socket[1], so just doing away with the avc_netlink_open call wouldn't
> work out. My thinking is we have two options:
>
> 1) Add a new seopt to use sestatus and let userspace object managers opt-in
>
> 2) Call both selinux_status_open and avc_netlink_open in
> avc_init_internal. This would satisfy the hard requirement for a
> netlink socket. Then we can default to using sestatus in all of the
> netlink processing paths, as you suggested in your last reply. We
> could
>
> Option 2 seems better from the standpoint of using sestatus by
> default, but it looks like recvfrom will never be called and the
> messages will just sit in kernel memory.
>
> I'm inclined to go with option 1 at this point.
>
> [1] https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L269

Couldn't we change avc_netlink_acquire_fd() to test whether fd hasn't
yet been set (i.e. == -1) and call avc_netlink_open() in that case?
Then dbus would still gets its netlink fd as expected but we wouldn't
need to open it inside of avc_init?
