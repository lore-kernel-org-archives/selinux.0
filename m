Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0643C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB232080C
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHSOZi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:25:38 -0400
Received: from smtp-auth.no-ip.com ([8.23.224.60]:14993 "EHLO
        out.smtp-auth.no-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgHSOZh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 10:25:37 -0400
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
        (Authenticated sender: flyn.org@noip-smtp)
        by smtp-auth.no-ip.com (Postfix) with ESMTPA id E9D92604;
        Wed, 19 Aug 2020 07:25:36 -0700 (PDT)
Received: from imp.flyn.org (localhost [127.0.0.1])
        by www.flyn.org (Postfix) with ESMTP id 0D83E260001C;
        Wed, 19 Aug 2020 10:25:36 -0400 (EDT)
Received: by imp.flyn.org (Postfix, from userid 1101)
        id 57A372D800B4; Wed, 19 Aug 2020 09:25:35 -0500 (CDT)
Date:   Wed, 19 Aug 2020 09:25:35 -0500
From:   "W. Michael Petullo" <mike@flyn.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Working to enable SELinux on OpenWrt
Message-ID: <20200819142535.GA3333118@imp.flyn.org>
References: <20200818181120.GA748671@imp.flyn.org>
 <20200818203731.GA1490393@imp.flyn.org>
 <CAEjxPJ6iBSu8Ts29yJVJH5rKNY0Qf1toTPLBk7_oN=F8MaEO6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6iBSu8Ts29yJVJH5rKNY0Qf1toTPLBk7_oN=F8MaEO6A@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

>>> I am working with Thomas Petazzoni and the OpenWrt community to add
>>> SELinux support to OpenWrt. OpenWrt is a Linux distribution tailored
>>> for running routers and similar devices.
[...]
 
> Great, thanks for working on this.  I agree that OpenWrt could be a
> compelling use case for SELinux.  In the case of Android, we started
> from scratch to create a policy tailored to its userspace and security
> goals.  Have you considered doing the same for OpenWrt or are you just
> trying to use refpolicy?

Policy will be the second step. Our initial aim is to package the stock
refpolicy, and then I hope to tailor or write policy for common OpenWrt
services. We will expand from there. We are working with the monolithic
policy right now, but I would like to transition to modular policies
once things settle down.

My intuition is that OpenWrt will resemble standard Linux installs more
than Android. We'll see!

-- 
Mike

:wq
