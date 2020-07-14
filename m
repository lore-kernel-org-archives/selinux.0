Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99943C433E0
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 21:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724AB2064C
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 21:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxgGxefH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGNVf1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGNVf0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 17:35:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078FC061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 14:35:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g37so14153631otb.9
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7pc1SsTqbRyKGb4HTE4eFLBh6IgII14xWC77SY05Is=;
        b=FxgGxefHkO2BCYUTs8ggyKYKxOqwZIOeZY9Ix12ISH63fvJOWPYnJIvz1mL6SRtLHc
         aEkLcrhop8l0plKhIRSfWhYHf6hB2rq2k6SsNNpeLFb2/RMU5VKy+t5g8VJ7bVvfvKhB
         Zv5LARokbnTceRysxW0Zp3G+RE9Pbos5/HIhty7DQcyMmOAbFTgwPAPZGfD5ZQQvYr8I
         OmgW3caq77SurmnJQzr8uw3Q/SN8tr4XLj7p4OOAGRPYLXpTS+SieUCLueboTZsZpxJp
         GInSWmGDDRs8SIvBrnUOB3CFPRg+c5xlOjXMMXitU3mph4xVOtE/Gh/96HYjJclngs44
         jdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7pc1SsTqbRyKGb4HTE4eFLBh6IgII14xWC77SY05Is=;
        b=C3mjx24zudTQ4INXEu6BsSBiZtJui4hd2RkCGfNhGTt97DAAb9kntKBzVCpi/7geHQ
         9KDqUCT/fpkCJ1gvtncTK9i2cQFa/kIAKZDR7Pq5A//906Lxu0jHUMBgGN5b2BpxDPTb
         tHvukYr8DkSv1YpYxMTMV6Z1x9c20tPALlU/MUn7YKA/3N6qZfdYMWil1y47EMw8lsLF
         Du3rEQdg+lI2aHVIiP2NCgpr9TWSlMIwFUOID+o1E4h28uSmXIQ8UBK3CpNSwBU+NkvJ
         ZYXGft/Xj201ciPK4TKduLZg+Oo9KFAFLv7stavJ1ShWTkULAGtSc9kx5sd7JVxBKNkS
         tNBw==
X-Gm-Message-State: AOAM530fuvcVJTNTo9kNIKCIj0QPEPLgAt9X3fpTSBCJOZwJqliRO/Zz
        ISICPbn4bdBNEfc7TblaIdhL9oooaxA9U/sqqSd7OQ==
X-Google-Smtp-Source: ABdhPJxnKxBuxgKkhlKS/xZq7tfvrWU0Zek7QDGVr+abclOwcdaVhlcMZDKUIGulsETKSZbcKY42/FyaZCb/b71smLE=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr6089653oti.162.1594762526056;
 Tue, 14 Jul 2020 14:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com> <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
In-Reply-To: <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 14 Jul 2020 17:35:15 -0400
Message-ID: <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Tue, Jul 14, 2020 at 5:03 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 4:35 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > >
> > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > > /selinux/status") introduced the selinux_status page mechanism, which
> > > allows for mmap()'ing of selinux status state as a replacement for
> > > avc_netlink.
> > >
> > > The mechanism was initially intended for use by userspace object
> > > managers which were calculating access decisions in-tree and did not
> > > rely on the libselinux AVC implementation. In order to properly make use
> > > of sestatus within avc_has_perm, the status mechanism needs to properly
> > > set avc internals during status events; else, avc_enforcing is never
> > > updated upon sestatus changes.
> > >
> > > This commit moves the netlink notice logic out into convenience
> > > functions, which are then called by the sestatus code. Since sestatus
> > > uses netlink as a fallback, we can change the avc_netlink_check_nb()
> > > call in avc_has_perm_noaudit to check the status page if it is
> > > available. If it is not, we fall back to
> >
> > Missing word/phrase here.
>
> Oops. I'll go ahead and fix that, thank...
>
> > Also you need to do more than just replace
> > this one call or selinux_status_updated() will do nothing unless the
> > application has explicitly done a selinux_status_open() itself, e.g.
> > avc_netlink_open -> selinux_status_open, avc_netlink_close ->
> > selinux_status_close, deal with other avc_netlink_* calls including
> > the multi-threaded case.
>
> That was by design. I figured for this version of the patch, we could
> just introduce the ability to use sestatus instead of netlink (if
> open).

In its current form, your patch replaces one call in
avc_has_perm_noaudit() to avc_netlink_check_nb() with a call to
selinux_status_updated().  With that change alone, for existing
callers of avc_has_perm_noaudit() that do not themselves call
selinux_status_open(), selinux_status_updated() will find that the
status page is NULL and will return immediately with an error. It
won't fall back to probing the netlink socket.  So you either need to
test for an error return and fall back yourself to
avc_netlink_check_nb(), or change selinux_status_updated() to do that,
or replace the use of avc_netlink_open/loop/close in avc.c with
selinux_status_open/close.  Likewise for selinux_check_access().

> Do you think we should go ahead and completely swap in sestatus? I was
> just worried about breaking userspace object managers that are
> currently using netlink threads by default, for instance
> systemd-dbusd.  I can spend some more time getting those to work with
> the status page if you think that's worthwhile.

I'd be interested in understanding the impact of such a change on
existing userspace object managers.  If we can switch the default
behavior for applications that are not explicitly using
avc_netlink_*() interfaces themselves (e.g. they are only using
selinux_check_access or avc_has_perm), then that would be beneficial
since I think it fully removes the need for a system call on the AVC
cache-hit code path.

> > Finally, I don't think you need to sanitize
> > the enforcing value from the kernel; it takes care of that itself
> > these days and no point in fixing it up for old kernels now.
>
> Very good to know, thanks! I'll update in the next version.
