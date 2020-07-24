Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA6C433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812542065F
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/5ObIBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXN0U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXN0T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 09:26:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78148C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:26:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c25so6948532otf.7
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jjGN8joT+3u2VD9qbF1P5y9y+F3peRgWM1VwBLQPrs=;
        b=S/5ObIBz4p5pesB9WsvRX+inqEXxH5JANyhpt056BElh5V29yQjN/8elfE7yBmZJxW
         uuUpR0oWQtfWTsLvpXXWoYd+j0GuFH+78OuE4r/JqnY1szQmsp347s0um7mbqfEDvmZs
         iOVSTeNHM664H+WW93dHb8vrUazKK9/TaMeeCswpomG5vMQ6AXC+P4gy1MX9CoCHrKiE
         SenwXKuz2fRtLqmEPbH9IzcTir/G+/L4bHhTBnYO6XykuP3GZo+reEZ2gZZPR3TTnUj4
         UjZubmg0vKkUo/YVEtkwvbisONq87LEq2bRdaHD2onqDIwh9E4Ujy1CLT7/IRpmB15Fq
         FLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jjGN8joT+3u2VD9qbF1P5y9y+F3peRgWM1VwBLQPrs=;
        b=m8zrDDsZropzjgmVoffjGr5jtQ7L7s0251ZELmeZhXu99PVUCyTZ/mG+Jvte1R987m
         lEFQwYsj1qi7n3UVVFaQpGB1MTXmpBqPcPxizWNxFfCups0yKdNfI7vNiylero4vojPw
         disOn0HkA1D2yR058IrXedzRlRCvjzJUS8naytbXxGI6vuYTNeg68lqTOWdVNZ3nuKVk
         ab87aBeRyvnyhm1gsPUqe4WiM2dWYpcYdkilG4D5ebKqprpqXJz1c9MxxwoVA+cvF7my
         ClUHz0eCdqrV6rJs/CutfeVgIMrSjaiYdnCieya9KfVe3NMg6F/zjrr/PXzU4NkzvZM/
         OLjg==
X-Gm-Message-State: AOAM532cZjhDfvblbx6GxLwHSs9EqsJsENArVQNTNuQs8KkPO888lDVS
        XQgXz16FKd+flMHqdCZQSy5qQT3twtOWfPBh6RII8A==
X-Google-Smtp-Source: ABdhPJyDK7I7Qcv8d2o8DI6FbYSIN2JhGqxSARvViuX2FKVDvipEbDQuOvRiGxtA4lFY1MgrKtFvbRbYC2TyLqJCBo0=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr8421170otr.89.1595597178901;
 Fri, 24 Jul 2020 06:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl> <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl> <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
 <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl> <CAEjxPJ6e=FSV6xiuZQW1m8yxEg-zQ-VMk=iQQYNF9JiQb3XJag@mail.gmail.com>
 <0c0245c2-ece3-f772-1595-d8433ec36386@defensec.nl> <CAEjxPJ7KuNR3T60-4XrsjAL-Po1a0MUuaBh_f_iTEuEVTFw+qw@mail.gmail.com>
 <ba69dd5b-8a01-5850-9375-2c99a92fe994@defensec.nl> <CAEjxPJ5P7qGybMfhXaEVoUWWiRubhT=1NCNL-oKaY9CXjjqodg@mail.gmail.com>
 <fde88aa9-1f4d-fb60-b27e-0da093753cdf@defensec.nl>
In-Reply-To: <fde88aa9-1f4d-fb60-b27e-0da093753cdf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 09:26:08 -0400
Message-ID: <CAEjxPJ4TsTfNELBGguF7+1asKTnMdkSdNMu+R15PC=ixgeOX7Q@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 9:06 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 7/24/20 2:56 PM, Stephen Smalley wrote:
> > On Fri, Jul 24, 2020 at 8:29 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >>
> >> On 7/24/20 2:23 PM, Stephen Smalley wrote:
> >>> On Fri, Jul 24, 2020 at 3:54 AM Dominick Grift
> >>> <dominick.grift@defensec.nl> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/23/20 3:24 PM, Stephen Smalley wrote:
> > I think for this kind of complete policy changeover, you need to
> > relabel prior to rebooting.
>
> I think i tried that, but the extended attribute filesystems need to be
> re-initialized AFAIK else fixfiles just returns with "Operation not
> supported". Not sure if that strictly speaking requires a reboot or if
> you can somehow do that with mount -o remount?
>
> Is there a way to enable labeling support of extended attribute
> filesystems without rebooting?
>
> I think there was a patch recently by the Red Hat ContainerOS people to
> enable labeling from the initramfs (ie labeling when SELinux is
> disabled) How does that relate to the issue where I am seemingly not
> able to relabel the filesystem after adding a fsuse trans rule without
> rebooting? (ie SELinux is enabled, there is a fsuse xattr but the
> filesystem hasnt been re-initialized yes and setfiles reports "operation
> not supported")

So, first, fs_use_* rules should be relatively standard across SELinux
policies because they are more about the characteristics of the
filesystem driver and what it supports than about a particular policy.
The only thing policy-specific about them is the context to assign to
filesystem/superblock.  I updated scripts/selinux/mdp to auto-generate
appropriate fs_use* rules for many filesystem types and I'd recommend
using those rules in any new policy.  Similarly, mdp can be used as a
guide to which filesystem types should be using genfscon although
incomplete.  If there was a good general way that I could test for the
properties of a filesystem type in the SELinux module code and
automatically assign FS_USE_* and/or use of genfscon, I'd do that
instead.

Second, if your policy is changing these rules and the superblock has
already been initialized, then the only way to get your new rule
applied is if you can cause the old superblock to go away, e.g.
unmount.  And that won't work while it is in use.  So rebooting if
your only option if you cannot do that.  Rebooting with SELinux
disabled and then running setfiles will be the safest when performing
a complete policy changeover since you will then have no interference
by the old policy.
