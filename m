Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C29BC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B5420B1F
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="ZVdX2QsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEFQhU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 12:37:20 -0400
Received: from smtp.sws.net.au ([46.4.88.250]:52168 "EHLO smtp.sws.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbgEFQhU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 May 2020 12:37:20 -0400
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id 0D8CAF5A8;
        Thu,  7 May 2020 02:37:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1588783038;
        bh=Qk4y8RtdskZW0kCiypG5h3BiIN1at9ih0uWHAkVtYN8=; l=1513;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVdX2QsDkfrdSpQY8Fh5wOVkjlF7WUPM4yWcGi0TVD7XV29HPhqyaqE80N7pOO1Ek
         AqCIpGLmu9LueUNmwt07bxAev2f1NPBsbzN9wo9/V9ynH3PvGnxZKVcbz2cGH5e4C9
         2W6zCrgIqsDpUOMuVuWZdEo7MbJYT43mgoKv9+A8=
From:   Russell Coker <russell@coker.com.au>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
Date:   Thu, 07 May 2020 02:37:11 +1000
Message-ID: <3838641.zh4Wi6GlAV@liv>
In-Reply-To: <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com> <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com> <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
> on that running instance, but not to specify custom kernel parameters
> initially or to reboot the system before proceeding with further
> commands (if anyone knows differently, speak up). We'd have to get to
> the point where enabling SELinux in Debian is possible without
> requiring a reboot at all.  And then we'd have to wait for that
> support to find its way into one of the Ubuntu images supported by
> travis-ci.  Might be easier to just get travis-ci to support Fedora or
> CentOS images in the first place. Regardless, allowing the testsuite
> to be run by users of other distributions is worthwhile IMHO.

In the past there hasn't been much demand for a smoother installation process.  
If you are setting up a traditional Unix server system the Debian SE Linux 
installation thing doesn't make things much more difficult.  Past complaints 
about it have been more about an imagined difficulty of using SE Linux and have 
ended when I showed and wrote about how to do it (one time I showed 
screenshots of the process in an LCA lightning talk and didn't have problems 
with time).

I don't think that the people who maintain the Debian installation related 
packages would have a great objection to adding SE Linux features, although it 
might take a bit of time for it to migrate from Debian to Ubuntu.

We can make this a priority.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



