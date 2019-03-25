Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F76C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4404E2084D
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfCYOYr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:24:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39347 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCYOYj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:24:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so10455902qte.6;
        Mon, 25 Mar 2019 07:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBxCXC/ofVh4I63rwfqTaDVGTSSuPV/2kdbKsG89gLk=;
        b=cyaJ1R06Y6q+bAbkgpkiiZi4a3A0aVL7slRr+GvpDOya8l2Jhp/uUI+ZW+lGkoW0nJ
         DST31O/u+1Fd8okFRS9XugUjxw5svBHzyZUdUJoNLPZZbdOb0CB43mb7/a2UPzgvjMh2
         piQFzXjlBNGa7FsN+mGwlpprhFqniY6KgseY57JJaNlml1902FMrdD54DU96Wtp9KeC5
         sUcxtEfGjYBZg/I+6m2jGvlAqz1Sep8+wydDRy2/iqJfCMDS52/XegecPwHiRg8ogsOS
         Qgm8K6Ue/0+TVJYRp+lrlKLRLK7M06+SfCcafqJejkuV/zrZ0CfBj5jlEDjEs09a3kr3
         nFnw==
X-Gm-Message-State: APjAAAXGkA0H/wIkwoh2f6F+buqok+Hsv8afrmdHEpaPSf2HiUbgGCfU
        pF4vygwlIDBzR5UCazrD0vhs/sEFwaWyElPUOCQ=
X-Google-Smtp-Source: APXvYqxftRdIUcgh4nNbBKwIvQAxwZBSBnSf8+fGWfv6TRYZybfARBpi0gqd1G2MCsGN3fStMdI9AI6s1NbsKWbdHW8=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr20402512qve.149.1553523878445;
 Mon, 25 Mar 2019 07:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190325124050.1285877-1-arnd@arndb.de> <CAHC9VhSmxfpGpVkHvu=HmATm8+uRkdyo8bgrU8XJAK_h3K3dhA@mail.gmail.com>
In-Reply-To: <CAHC9VhSmxfpGpVkHvu=HmATm8+uRkdyo8bgrU8XJAK_h3K3dhA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 15:24:20 +0100
Message-ID: <CAK8P3a1DWqc5psQAgDM0zy5bRJH7-Bs1pWWtSoxQf_CZbrkjdw@mail.gmail.com>
Subject: Re: [PATCH] [v2] selinux: avoid uninitialized variable warning
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 3:15 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 25, 2019 at 8:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > clang correctly points out a code path that would lead

> > -#if IS_ENABLED(CONFIG_IPV6)
> > -       } else {
> > +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
> > +       } else if (IS_ENABLED(CONFIG_IPV6)) {
>
> I thought we had talked about using an else-if statement like the one
> below, is there any reason why you changed it to just the IS_ENABLED()
> check?  I liked the idea of explicitly checking the IP header version
> number before treating the packet as an IPv6 packet.
>
>   else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6)

Ah of course, sorry for missing that important part when I revisited
the patch. I've sent a v3 now.

      Arnd
