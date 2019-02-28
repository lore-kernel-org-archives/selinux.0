Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695DC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 05:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8736206B8
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 05:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfB1FqD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:46:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1FqD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 00:46:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85937140125BE;
        Wed, 27 Feb 2019 21:46:02 -0800 (PST)
Date:   Wed, 27 Feb 2019 21:46:02 -0800 (PST)
Message-Id: <20190227.214602.1750233644419373187.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH] netlabel: fix out-of-bounds memory accesses
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155113956675.10125.14312108729252175194.stgit@chester>
References: <155113956675.10125.14312108729252175194.stgit@chester>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Feb 2019 21:46:02 -0800 (PST)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Feb 2019 19:06:06 -0500

> There are two array out-of-bounds memory accesses, one in
> cipso_v4_map_lvl_valid(), the other in netlbl_bitmap_walk().  Both
> errors are embarassingly simple, and the fixes are straightforward.
> 
> As a FYI for anyone backporting this patch to kernels prior to v4.8,
> you'll want to apply the netlbl_bitmap_walk() patch to
> cipso_v4_bitmap_walk() as netlbl_bitmap_walk() doesn't exist before
> Linux v4.8.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: 446fda4f2682 ("[NetLabel]: CIPSOv4 engine")
> Fixes: 3faa8f982f95 ("netlabel: Move bitmap manipulation functions to the NetLabel core.")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Applied, thanks Paul.
