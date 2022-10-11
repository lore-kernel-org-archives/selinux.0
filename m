Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E01C4332F
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJKWBf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKWBe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 18:01:34 -0400
X-Greylist: delayed 1170 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 15:01:33 PDT
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364E14D24
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.master; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description;
        bh=wz8t/iUpBxJLmSMkOrgiJ7667YITuThFRK51x0eQe6c=; b=kHIzQ7DhpeRsM+yrd/Fom9i5ai
        /+cWLzDjwYSbnqBWnafSSM83uGx/wzqIoohw39HDdwqrLVfaM1WuOcjrCCF7/ci72bH57s5xUBWIc
        yj1jXBXpfdBs9KZ/ga4iRRJSrGwksmdEM/9R2zF1gFWzsHJx74Jys0aHJ2CgFUc6XeEh8FeEJ638P
        i5AZse6w6NUVzTwSx3zqerLqzIvEsAx7xtYlNBs00nsqoo2r8Xo+BmRIi3p3FznUCxp4HC/IXGvt+
        Eo4FisohBsaC2cbDE79hxsa3kl1nGGG84HPkzIrSrrg1UavYIbSYVxOsZ43Id/6l9mTy9gKsPWow0
        0BH9kwVg==;
Received: from guillem by master.debian.org with local (Exim 4.94.2)
        (envelope-from <guillem@master.debian.org>)
        id 1oiN0i-005Hky-HU; Tue, 11 Oct 2022 21:42:00 +0000
Date:   Tue, 11 Oct 2022 23:41:59 +0200
From:   Guillem Jover <guillem@debian.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     debian-dpkg@lists.debian.org, selinux@vger.kernel.org
Subject: Re: [DPKG PATCH] selinux: install log callback to filter messages
Message-ID: <Y0XjJ+qULy0x1JQ7@thunder.hadrons.org>
Mail-Followup-To: Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        debian-dpkg@lists.debian.org, selinux@vger.kernel.org
References: <20221011160700.82258-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221011160700.82258-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi!

On Tue, 2022-10-11 at 18:07:00 +0200, Christian Göttsche wrote:
> Since libselinux 3.2, via commit 05bdc03130d7 ("libselinux: use kernel
> status page by default") [1], selinux_status_updated(3) will issue log
> messages on enforcing changes and policy loads.  dpkg is only interested
> in whether the policy changed to then reload the SELinux label database.
> 
> Ignore non-relevant log messages and forward messages of type error,
> warning and avc (which should be treated as error if not audited
> according to selinux_set_callback(3)).

Thanks! I've merged (with a couple of tiny style changes) and pushed,
will be part of the upcoming dpkg 1.21.10 release.

Regards,
Guillem
