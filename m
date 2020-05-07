Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D5C38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A71220643
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="FYi7ZyM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgEGOtc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 10:49:32 -0400
Received: from smtp.sws.net.au ([46.4.88.250]:41264 "EHLO smtp.sws.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgEGOtb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 May 2020 10:49:31 -0400
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id 8B212F2E8;
        Fri,  8 May 2020 00:49:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1588862969;
        bh=9Giib3huB1xTgRD02CwtHmIuKmUZh6euTkQqUSq/EXc=; l=752;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYi7ZyM1iw6LBpWSw82RaVy/GDjfORHEsw7Sf1ITsVh1BtacpkPd0bDULETfVQzC/
         3bXLNl8NZNtPYIthKC6/M3+TofbIIcELu2v7BoFwV92jR2JIclEHeUSa+vnlVlaeOI
         CBrZFWWwkAo7qv/1ydDE1apndgrl5hgktqbfFTW0=
From:   Russell Coker <russell@coker.com.au>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
Date:   Fri, 08 May 2020 00:49:23 +1000
Message-ID: <1916523.qzzCliNl98@liv>
In-Reply-To: <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com> <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> If people are using preseed installations (kickstart equivalent), I
> think that enabling SELinux in the installer shouldn't be too difficult
> (installing the needed packages, modifying the files and relabeling with
> fixfiles). It's obviously not user friendly, but the question is what's
> the target here.

If we want to do that properly then I guess we want SE Linux enabled in the 
kernel that the installer uses and then have the policy installed early in the 
installation so the files can have the correct labels from the start instead of 
having a relabel process afterwards.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



