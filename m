Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000FCC5518A
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86D320857
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="UTIQqXB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgDVKt1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDVKt0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Apr 2020 06:49:26 -0400
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84302C03C1A8
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2020 03:49:25 -0700 (PDT)
Received: from liv.localnet (localhost [127.0.0.1])
        by smtp.sws.net.au (Postfix) with ESMTP id 8F051ED42;
        Wed, 22 Apr 2020 20:49:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1587552560;
        bh=UYi4hFXS7gdGK0/uHlSaRVZBzVyTI7QiATsOpv6xYDc=; l=1032;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTIQqXB0KX1a9p9gUgxig3Iw6mKXDUjHf4w2ohNCJcNJ0+mJphJLRDR2m8d6OdwDM
         cRkiVlCcPy5oln+qPskyy/LgfiDDVsPxdq8qL/omt5jXWPJ07LOFFZmCC9O6rv3jCA
         TVW37am81jpkNFCK6Ltn8v7NIoZUBS2KP0u+k3Ic=
From:   Russell Coker <russell@coker.com.au>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: semodule -i and load_policy coredumps on version 3.0 - not latest GIT
Date:   Wed, 22 Apr 2020 20:49:10 +1000
Message-ID: <1991878.H4qNpjkt8I@liv>
In-Reply-To: <2529366.HMiiFnPMKa@liv>
References: <2203189.X40rEyH0Y1@liv> <CAJfZ7==9L2PZkbBO22=RapRKvdiZQ1Fj7jgEhNSUcZ1hTDyKPA@mail.gmail.com> <2529366.HMiiFnPMKa@liv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tuesday, 21 April 2020 2:01:45 PM AEST Russell Coker wrote:
> After the reboot I could not reproduce it on saved snapshots of the VM in
> question dating back to when I had previously had problems.  I conclude that
> rebooting the hardware solved the problem.
> 
> The problem was either an issue of failing hardware (I am running memtest86+
> right now) or hostile action.  When testing for issues with libsepol I got

Memtest86+ has proven that the system in question had a damaged motherboard, 
any time when any DIMM socket other than socket 1 was in use Memtest86+ would 
lock up solid in less than 7 seconds (for reference a complete Memtest86+ run 
was successful at the time the system was deployed).  The system is on the e-
waste pile and I don't expect to see such semodule problems again.

How the system in question managed to boot Linux and run multiple VMs while 
Memtest86+ crashed so soon remains a mystery to me.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



