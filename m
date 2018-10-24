Return-Path: <SRS0=klO3=NE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B06C67863
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D046207DD
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBSaw3I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D046207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJXTQu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:16:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46003 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTQu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Oct 2018 15:16:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so4279763ljc.12
        for <selinux@vger.kernel.org>; Wed, 24 Oct 2018 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=gBSaw3I7jd1fjqCzFEJsk8Mqy5gaVU9+uJD6jxVsIXdQcyE4Ihc5eV6NJTF4is7xjT
         OjcSjwQLwU8Ieug4JML6Z5isEHZFFv2dKfbvPmJ599/Ob+7Gq10PuuKCm7R6+qBp0q+q
         6ayotGuv7IVj35Te+FuIHehp/sTrE3WYPdnao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=Ci111yfwB1otpGUK8+2P3hO+KkPjwF9RX3x5GWWoZxqgLhN1GR6pLnREXpKu6H7uR9
         6jnOXBLRcUMhRH7UiCXAVxOG8I8N0mSVjOASwkN80kgkELOamQwulm16Rd6LMn/TG7td
         EOhhYoZFPtXrz5zyiCeO58SNXxtIyO+n/DF0rib+lkAyLufj8Gwnoj0KmuDKiQJX/JCF
         RbyIyycbJ0zp7ezknJH5z0cT8xiQABu1zntazq1S20gMVXCMt5hJeimK/gbkF//P6qrS
         X84mhZtvfrA46xlQpxz4WQl8AOdDUaNQuXQmYNVxHK99awJRov0MnS1GUfG5iiBefEm0
         jv4w==
X-Gm-Message-State: AGRZ1gJx8Hhxup3l2CinwSLqHAK54+aaEBTbcppCgeuZpHIP0D3HtTTo
        HYMWYM1fssDJjP5o6rArgPixROt2IBWaWwk2
X-Google-Smtp-Source: AJdET5djR4UtosVmQY0z+tKKsI8yEj5fCJoeSgjAv/8JrucQwJA5j7X/DH6igAKYIfizZ1b3q4Ck8w==
X-Received: by 2002:a2e:529d:: with SMTP id n29-v6mr1379773lje.54.1540378152202;
        Wed, 24 Oct 2018 03:49:12 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e21-v6sm645335lfc.48.2018.10.24.03.49.11
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id l25-v6so2490053lja.9
        for <selinux@vger.kernel.org>; Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr1423488ljh.118.1540378150673;
 Wed, 24 Oct 2018 03:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
In-Reply-To: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:48:54 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.20
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 23, 2018 at 1:55 AM Paul Moore <paul@paul-moore.com> wrote:
>
> Three SELinux patches for v4.20, all fall under the bug-fix or
> behave-better category, which is good.  All three have pretty good
> descriptions too, which is even better.  Please merge this for v4.20.

Pulled,

               Linus
