Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D1C433B4
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8603A6144F
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhEGMNw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhEGMNv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 08:13:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CBEC061574;
        Fri,  7 May 2021 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+dVAaeGDRsnm7EmZB30VNrWQIAr0E+eqyzh293MfUQ=; b=nSYc1btXv3M2cw8GwJYsDpojwf
        8fALC/wqrfHNdOiQ2do676uByniOeGmKNO5onornYVp9Aqh1bdkst+q9Zur5Km6mVCOGnf5oWGlf/
        +Y3htQnDJAj/9e9kFhwcUw9+ohnIOmCXKcw+nGxbDdymITysK3JWwVu5hoK4r6k+bR/c7zbQi5Hqq
        sWrJD0VUWbZuzE3STv5H9Q8sz51G58WmaD823jZxmH0i58oWchef4JoedBUmRkLaWuy07Fe00ntTh
        af/iaNLYW2BBi42t+PvFiwGoC9OugycjFbmz7o4freBLANqQP1R+2vVUWEiuSEa3mK6WdGVlBaIzQ
        uenoHALQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lezL8-0039ft-PK; Fri, 07 May 2021 12:12:32 +0000
Date:   Fri, 7 May 2021 13:12:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
Message-ID: <YJUuoiKFjM8Jdx6U@casper.infradead.org>
References: <20210507114150.139102-1-omosnace@redhat.com>
 <YJUseJLHBdvKYEOK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUseJLHBdvKYEOK@kroah.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 07, 2021 at 02:03:04PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> > Make sure that security_locked_down() is checked last so that a bogus
> > denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> > ATTR_UID | ATTR_GID)) is zero.
> 
> Why would this be "bogus"?

I presume selinux is logging a denial ... but we don't then actually
deny the operation.

> > Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
> > debugfs when the kernel is locked down"), but it didn't matter at that
> > time, as the SELinux support came in later.
> > 
> > Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> 
> What does this "fix"?
> 
> What is happening in selinux that it can not handle this sequence now?
> That commit showed up a long time ago, this feels "odd"...
> 
> thanks,
> 
> greg k-h
