Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD41C433E4
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7BE20792
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFtXUf4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGUNOC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgGUNOB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 09:14:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798CC061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 06:14:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g37so14989877otb.9
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Utqmej9H65XFzMq3WWoXuNGR8/SEtzEf8PjhVupMBWg=;
        b=WFtXUf4rwSHBCpdHJ+TS+UQpLZ1ikW5WGcUGfR0qJ4+Bc5APZUUbu4E0/Grz0Zc62p
         vwmZ2b1niH8yN2V7+szYVLg+87reLp3qts/yNzkWOlXsQrDkyaWIYoyJwX4udlbJaOJF
         JhfcXQDNSlPKzGDqNyTo6Xxezmypik6Dh+moUwY3h8iQ484MpZn40W9IhP7+ajuqChTk
         MayPgor/kHJHuAldNebiM73c8fQblk8K8Cp3Z+A+BSOOl9J86t4o9NF43B0lHn9B5FYj
         RbmyxfruIrqlxtuQVWbqeRTUYgdKreCHoZpncaRgIqyrBXwLtd3zQjdlAbcqxTIGsYfb
         e/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Utqmej9H65XFzMq3WWoXuNGR8/SEtzEf8PjhVupMBWg=;
        b=tHfq76bOdh+dUfnWEdEF4DPhAjg8v0v4KgeOl4M3W3P593fl0hsi2uPDZ/NjGEZ2JN
         EhfuWco+rEw1y/Ycipjr3nm6Q6fd+3JYqoUAwOBjIsquZdLJs+W50lcW2B3CDgsg+dvj
         zd+ZitzDsWIn9IXiY9EWqbwas/mJqY6TxJaDGQHmrpyMVkZcMlgjPDKpTwSRFhGA3wnq
         p5B7wi5nRJZUNU2x3uM03s5Z6PvueWRypTtgodu7HSq+wI/jeHmfP1RX5wkTOgatptqv
         EafokwsLZ6yOwelZmN+uLKW7EKaau6jemV9TJSkTKpl+XRKRDWAyP67RbwkKyWfzqJ65
         LXEA==
X-Gm-Message-State: AOAM531wmtAsOrxrG8KftzA4PZFwCSBQh2Wgv2WDFOCWsYFUGoENvtQj
        8IVpqmTH/kF+TYj/20Mf1ELv01lY2imAdKnGPUyUrA==
X-Google-Smtp-Source: ABdhPJyFKG+FuwkeR2vpqPtkFS07nucutHlloEog9eU44Uo3QwNsjmNn6I4pL2ukZBb8H0xhwUcvbKUlTXNLC/3Xdak=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr24715432oti.162.1595337241083;
 Tue, 21 Jul 2020 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200721115734.GA43979@aloka.lostca.se> <CAEjxPJ5wZ6HE0hA7+RAPfJkzL_W3LTLop9gNb8GxkHxMkLEAcA@mail.gmail.com>
 <87365lqarb.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87365lqarb.fsf@oldenburg2.str.redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 09:13:50 -0400
Message-ID: <CAEjxPJ4UTfRA7jigEE3+LWfXBqa3OSiOe11o+rH2KyafRvnfaQ@mail.gmail.com>
Subject: Re: [RFC] Porting glibc away from deprecated libselinux APIs
To:     Florian Weimer <fweimer@redhat.com>, dwalsh@redhat.com
Cc:     Arjun Shankar <arjun.is@lostca.se>,
        SElinux list <selinux@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 9:05 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Stephen Smalley:
>
> > On Tue, Jul 21, 2020 at 8:07 AM Arjun Shankar <arjun.is@lostca.se> wrote:
> >>
> >> Hi,
> >>
> >> glibc currently uses several recently deprecated libselinux APIs:
> >>
> >> 1. makedb uses matchpathcon:
> >>
> >> https://sourceware.org/git/?p=glibc.git;a=blob;f=nss/makedb.c;h=8e389a1683747cf1047f4de8fe603f2b5ccc5f3f;hb=HEAD
> >
> > Should migrate to selabel_open/lookup/close.
> >
> >> 2. nscd uses avc_init and multiple old style callbacks:
> >>
> >> https://sourceware.org/git/?p=glibc.git;a=blob;f=nscd/selinux.c;h=a4ea8008e201b9397aa4274bb558de471b0573af;hb=HEAD
> >
> > Wondering if nscd can migrate to using the higher level
> > selinux_check_access() interface instead of direct usage of the
> > avc_*() interfaces.
>
> Somewhat related:
>
> I do not know the reason *why* we have SELinux-specific code in glibc,
> and in this places in particular.  What makes nscd and makedb special?
> ldconfig also writes a file used across trust boundaries
> (/etc/ld.so.cache), and yet we don't label it explicitly.
>
> (nscd is a daemon that runs under its own user and loads NSS service
> modules.  makedb is similar to ldconfig.)
>
> Do you have an idea why we need this code in glibc in the first place?
> Could it be that it is simply there to work around an incomplete system
> policy?

It could be that at the time we didn't have restorecond or support for
name-based type transitions and therefore they needed the makedb
changes to keep its file in the proper security context.  WRT nscd,
using SELinux to provide the policy decisions is both more flexible
and more robust than a DAC-based scheme, and allows central management
of the overall system policy.  Dan Walsh and/or prior glibc
maintainers might recall more of the specifics.
