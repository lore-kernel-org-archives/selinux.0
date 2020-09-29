Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C52FC4727D
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE11F21548
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgI2Xsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:48:36 -0400
Received: from namei.org ([65.99.196.166]:60428 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI2Xsg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 29 Sep 2020 19:48:36 -0400
X-Greylist: delayed 2347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 19:48:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08TN9KBD006807;
        Tue, 29 Sep 2020 23:09:20 GMT
Date:   Wed, 30 Sep 2020 09:09:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH] lsm,selinux: pass the family information along with
 xfrm flow
In-Reply-To: <160141647786.7997.5490924406329369782.stgit@sifl>
Message-ID: <alpine.LRH.2.21.2009300909150.6592@namei.org>
References: <160141647786.7997.5490924406329369782.stgit@sifl>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 29 Sep 2020, Paul Moore wrote:

> As pointed out by Herbert in a recent related patch, the LSM hooks
> should pass the address family in addition to the xfrm flow as the
> family information is needed to safely access the flow.
> 
> While this is not technically a problem for the current LSM/SELinux
> code as it only accesses fields common to all address families, we
> should still pass the address family so that the LSM hook isn't
> inherently flawed.  An alternate solution could be to simply pass
> the LSM secid instead of flow, but this introduces the problem of
> the LSM hook callers sending the wrong secid which would be much
> worse.
> 
> Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

I'm not keen on adding a parameter which nobody is using. Perhaps a note 
in the header instead?

-- 
James Morris
<jmorris@namei.org>

