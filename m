Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A9C35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B2320842
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PbTrDQ0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBLCNJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:13:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37489 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBLCNJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:13:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id s3so555274edy.4
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybY2xD/reTzMWGMdSUDK+3BGDgQg7LMIh4mbb6jB71g=;
        b=PbTrDQ0E/fqrpMiIjbcfA6FZWn0ec61LzkkrApBhZNv9s2nHOf+12ye1dWq8x9T5iP
         bw4V7EJ6V4Ei/x/XbgHB2HwFa13MAMpnsaleYCgrNKdyljEGTjXWPHVD/V7k1jNwpPIc
         ixq9dG47ecXFBwacJYuiojcVwQgXAad7Ft1Q6iNuaCQ5iccg9lO74mNI3U7bAARS187q
         pQoXF1pAEr/Z1LS9u81TAKyDM/GrstsufV4msZbF0L1HP+zsXVyd5MhG+fLit/YfXuZH
         sgO3xyi5URrMt56KFLwTs+RMB9OL8mjGWfbHlL69a70spqvo3l5jliCfg1aBwZ5frR/i
         86sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybY2xD/reTzMWGMdSUDK+3BGDgQg7LMIh4mbb6jB71g=;
        b=bQiWt3hwweSU/uBUZ5Vla8y2/WsD46AaZ/D/JwTaBePUlfl2qwiZ9MkWg5bo8PZ9GE
         I0F0oWT1mJ7PjYSOLNSsb2541zGD/p06OPJ+0ZgjoSOdrZU2GGdiEpQW/aTAPAvQYPVH
         m9rUYqguuA0oUs4D4qxhU3gCAXpY9nCyAUKOI51NHfuesVn7YZKrJkrsyxM1yWQYr/oq
         DNXXe1qwrPDOtJPBdeLg+E+u2mRKhPyzCNaZZLPdenAB/SccZtgUqM2OEMc7YOiv2Yzz
         /pEvWIHHR3hHVvgr19RkRh87OhAo2QrKR+6jH4YPNnspXrmQDikIl/y3ZMI5npUetPs3
         LgLQ==
X-Gm-Message-State: APjAAAWEpE6uR9Mwi4HokjrmqJ6wXKNtROCFevej8er78d2zAytD2P+u
        jDZVxHHrmCthPKBNBk0wyc0jOnzt5mGr4Vv+9VHkL/ii6g==
X-Google-Smtp-Source: APXvYqzWZ/arz73Wjw8kEcPN+D6Va9P3E45uje8BFGJQfRmFqChm/nFLt+mO+Dl7KkT8Fa//jk+kIGc5j0HNgARxmU8=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr8099713edv.135.1581473586193;
 Tue, 11 Feb 2020 18:13:06 -0800 (PST)
MIME-Version: 1.0
References: <158143665924.193851.6057679833915268046.stgit@chester> <5bc73b28-2a6e-0a64-5cb1-5dd7b2bfa94b@tycho.nsa.gov>
In-Reply-To: <5bc73b28-2a6e-0a64-5cb1-5dd7b2bfa94b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:12:55 -0500
Message-ID: <CAHC9VhSSfuQfBb6Hh2pjgzoAVevFwC64kqF=PrPeMhb9nOgweA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add the quota package to the list of
 deps in README.md
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 11, 2020 at 3:29 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/11/20 10:57 AM, Paul Moore wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > The filesystem tests require the quota tools.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

A trivial fix, so I'm going to go ahead and merge this now.

-- 
paul moore
www.paul-moore.com
