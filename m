Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92253C433E4
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0372070E
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcY5iNJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXM40 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXM4Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 08:56:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75091C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:56:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k22so7946215oib.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cehVpaUs1Kz92tZ8x9QKXQaZlCl+RI+kBD8Q1dmVLGo=;
        b=PcY5iNJV8bmT4MF09d/WOBBgydd4qrvEhn8j/cciEsy24T3J7usy1hyWtldsDQuoWI
         u8zfKGlFvv9NvMuW0j6TAzPvVLhk0tEHLK18myQ/CR1Ck/TmhLCQMcFCVpjfKoJztOav
         8xzb7Hd3ZbzKu09GxINsPV9JTxo815rPCP+JYZ56VvMyHe/aLbZCHHsyHyfHrET0GWD9
         He9GVeFrvkOMOnxYU5321/GaYDx0yxZBWgTi5x3Ypu50nFP/kEtgNB3hUoBg0NKpuqIj
         l8ywFpx3qFjDZrfkDRjEf140EdDLJUsVv+bKpTI/Hjim5wmFhQv7eB+DsGh8TkBeOo5T
         N5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cehVpaUs1Kz92tZ8x9QKXQaZlCl+RI+kBD8Q1dmVLGo=;
        b=F9UoNizY+VO46Pj+4A/QEnjn0pDuS9PGST9qCi6sVaajaD5infjrj8OVDSqOh03RU8
         UNGVhDkYkre8yxw7IYEmXoeAR7ryJ382/DGc2uLIptbaB7cM2wESqBKwDNC8tMIwuLJ5
         +WvhkSR4TtoceuWetgzihj6WUTVr3q8jQwkwMN4Xi5igA2loV/zJfKI4tAMWhR9c117i
         VSPzGdPIwRZjR4+wedlxCCQspFxrJbr+/Q+Ade9TGPtJNt1MBScfIl4F3WNt1tcWhX3A
         jT24xo5O1wTo1oEmVyL8uJNbCdYGc1K4DSISVYlYQyfT0ZijU1yY85pPdZq/rdoEch/s
         kf/w==
X-Gm-Message-State: AOAM533CqWbLIQFG0zS8qDVtc4mi8tERdrI++4Xqo9y5/ENFfqH+eqrs
        YBkr+ntObS5W5ubncqxb6LFGddQRGJsVCw+q6KQd+w==
X-Google-Smtp-Source: ABdhPJwv5f0cXRhEVmmBe06hMZv4o5bnoff20M+mYyqw05OfjyVSmhYmAWcEZOLkoa1VHeS2CKu3tQoQVxAotSAnDj8=
X-Received: by 2002:aca:ecd3:: with SMTP id k202mr7634636oih.92.1595595383831;
 Fri, 24 Jul 2020 05:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl> <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl> <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
 <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl> <CAEjxPJ6e=FSV6xiuZQW1m8yxEg-zQ-VMk=iQQYNF9JiQb3XJag@mail.gmail.com>
 <0c0245c2-ece3-f772-1595-d8433ec36386@defensec.nl> <CAEjxPJ7KuNR3T60-4XrsjAL-Po1a0MUuaBh_f_iTEuEVTFw+qw@mail.gmail.com>
 <ba69dd5b-8a01-5850-9375-2c99a92fe994@defensec.nl>
In-Reply-To: <ba69dd5b-8a01-5850-9375-2c99a92fe994@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 08:56:12 -0400
Message-ID: <CAEjxPJ5P7qGybMfhXaEVoUWWiRubhT=1NCNL-oKaY9CXjjqodg@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 8:29 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 7/24/20 2:23 PM, Stephen Smalley wrote:
> > On Fri, Jul 24, 2020 at 3:54 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >>
> >> On 7/23/20 3:24 PM, Stephen Smalley wrote:
> >>  > There is a tension there with fail-closed versus fail-open and the
> >>> potential for a security vulnerability to arise if it proceeds.  Would
> >>> have to look at the specifics to evaluate how it should be handled.
> >>> Of course, in practice, one really shouldn't be removing contexts
> >>> while they are still in use (or else use aliases to preserve some
> >>> degree of compatibility).
> >>>
> >>
> >> I guess if there is tension be between GNU/Linux use of libselinux and
> >> SEAndroids use of libselinux, where SE for Android is implemented by the
> >> vendor to be immutable by the device owner, and where GNU/Linux
> >> leverages SELinux to empower device owners, then any tension can be
> >> alleviated if Google forks libselinux. In GNU/Linux it should just be
> >> possible to switch policies.
> >
> > I wasn't talking about Android, just about the tension of
> > fail-closed/secure versus fail-open/insecure in general.
> > I don't have any problem with someone installing a new policy that
> > completely changes the set of file contexts; I just don't think they
> > should do that at runtime without a reboot in between and expect
> > things to work seamlessly.
> >
>
> Yes but that is not what I am saying. It does not work even when you
> reboot. I tried to explain that:
>
> You install a new policy and run fixfiles -F onboot && reboot (as one
> should)
>
> systemd will fail to compute create socket activated sockets. and so
> these socket activated daemon fail to start.
>
> One of the daemons is device-mapper, and so if you use LVM type stuff
> you may end up with with a system that is only partially relabeled.
>
> Not to mention that in the relabel target various other services that
> are socket activated fail to start, and so  who know how else that may
> affect things.
>
> There is also this (however this might no longer be accurate):
>
> systemd computes whether it can dynamically transition on boot. If the
> systemd executable file has an invalid label and this computation fails
> then systemd might just freeze in the first place.

I think for this kind of complete policy changeover, you need to
relabel prior to rebooting.  Obviously that carries its own set of
challenges; you'd at least have to switch to permissive mode first and
potentially run setfiles in a domain (e.g. setfiles_mac_t) that is
allowed to get/set contexts unknown to the current policy
(CAP_MAC_ADMIN + capability2 mac_admin permission) or load the new
policy prior to running setfiles.  Or boot with SELinux disabled,
label via setfiles, and then boot with the new policy.  The preferred
model of course is to install with the desired policy in the first
place. IIUC Android upgrades are a bit different in that they reboot
into recovery mode, create the new filesystem (required anyway for
dm-verity) with the correct labels for its policy, and then reboot
into normal mode.

I don't think the separate autorelabel service can work for whole
policy changeovers; it would need to be done directly by systemd
itself prior to any other actions.  I think Android's init does
something like that for the userdata partition since that doesn't get
replaced on upgrades.
