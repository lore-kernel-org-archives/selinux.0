Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6DC433E3
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007C12065E
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 22:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="02o38TeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGNWmg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 18:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGNWmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 18:42:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A7C061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 15:42:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so5231lfl.5
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjX8syOq9NNRSgFFsunWKHhLhML/0JiMtDG71D3L1K0=;
        b=02o38TeWV9EUTq5knWY2SsXdqyc/D7sV1ELDCPSZEvbrBZHvufIQjA4Yq1VFldmsuK
         YmuIDsQ7l6gQsn9z68zZC0sf2CvkNkfGuPUqmSIQg+tOuISbhsyTE1kTYM2gj4GPNOJn
         7HQKdrBY5A1Th1ojK+NvThf4o8NX7EWzDy0UNOldZxCJ2Y4+qLfezrkimQvOVWlKq+sR
         MIJCUT7mMUIJveEPQfKDzgrqJbjKM1EBcRYl9YpkrRUDPln5X7Y35yQjHIvTPWTexTwm
         AlxkEfeC4Zznd5CviwD/z/Iu3v3GCO6NiyNHq3JjDl3Ykapr8wAkK719GOyEvzZ1IsbR
         yYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjX8syOq9NNRSgFFsunWKHhLhML/0JiMtDG71D3L1K0=;
        b=uZHlvTgSmpLciIOihf4CX8RJ/2ctZxLS/ceNGsun0UyxKLxLr471CSCl/I3L0Er4S4
         EJwM2cX5hJ6/rp7R2jFYgvfzgtzd8Oa7inq0b4z/AcnBEu9tV34IDN0SqYOjBRke67Ez
         QrHCHBnSlffvac8RP66h1rYiZafNyH8+gVhg/h91G406XFfxBLw5RwghYsYPcRv4apdc
         GUjZucBPE9w08wNdcRLGrzuaDh5SK1BiNRXItuNfhj7bBBkIfeLqpcb9DDwOHT4fqByf
         m8cT36nddxBFj9Ur7aYvoNw7kINCwQuYrbZliSNdI86r4VGysmNaqFiVV3eBhcSMqfbs
         qjPw==
X-Gm-Message-State: AOAM530C7vvwpG9TNNpLluSyeeRx31WukxC/ohq97jE8uOrbCKZkjMzc
        9+FLpPp+zKllLkBrqROwLydn7w92ZZ7/UuUf+dHMI9T4h4Y=
X-Google-Smtp-Source: ABdhPJyhbJRE8FnsoFruFiWtt5TT0zqzclrThtmx84lgzyHRQKmGqHZfWXrRIpXTlz1KyC2wsvX/Xwo14wdyh7KgA1k=
X-Received: by 2002:ac2:5443:: with SMTP id d3mr3159750lfn.121.1594766554368;
 Tue, 14 Jul 2020 15:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com> <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Tue, 14 Jul 2020 18:42:22 -0400
Message-ID: <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 5:03 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
<snip>
>
> In its current form, your patch replaces one call in
> avc_has_perm_noaudit() to avc_netlink_check_nb() with a call to
> selinux_status_updated().  With that change alone, for existing
> callers of avc_has_perm_noaudit() that do not themselves call
> selinux_status_open(), selinux_status_updated() will find that the
> status page is NULL and will return immediately with an error. It
> won't fall back to probing the netlink socket.  So you either need to
> test for an error return and fall back yourself to
> avc_netlink_check_nb(), or change selinux_status_updated() to do that,
> or replace the use of avc_netlink_open/loop/close in avc.c with
> selinux_status_open/close.  Likewise for selinux_check_access().

For some reason I completely glossed over the selinux_status == NULL
case. I guess I didn't see errors when testing dbus because verbose
logging wasn't turned on.

I'll take a look at what it would take to move over sestatus entirely
and if it's too tricky/error-prone, _I think_ it should be fine to
move the selinux_status == NULL check down with the MAP_FAILED case so
they both fall through to avc_netlink_check_nb().

>
> > Do you think we should go ahead and completely swap in sestatus? I was
> > just worried about breaking userspace object managers that are
> > currently using netlink threads by default, for instance
> > systemd-dbusd.  I can spend some more time getting those to work with
> > the status page if you think that's worthwhile.
>
> I'd be interested in understanding the impact of such a change on
> existing userspace object managers.  If we can switch the default
> behavior for applications that are not explicitly using
> avc_netlink_*() interfaces themselves (e.g. they are only using
> selinux_check_access or avc_has_perm), then that would be beneficial
> since I think it fully removes the need for a system call on the AVC
> cache-hit code path.

I'll have to do a bit of digging to see how this will affect dbus, et
al. On first blush, it looks like they're just doing
avc_netlink_check_nb() in their watch thread. Presumably other object
managers are doing something similar so we would just need to make
sure there is a netlink fd available.

>
> > > Finally, I don't think you need to sanitize
> > > the enforcing value from the kernel; it takes care of that itself
> > > these days and no point in fixing it up for old kernels now.
> >
> > Very good to know, thanks! I'll update in the next version.



-- 
Mike Palmiotto
https://crunchydata.com
