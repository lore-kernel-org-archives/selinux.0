Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A2C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D61020702
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 23:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXXIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXXIt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 19:08:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49849C061574;
        Mon, 24 Aug 2020 16:08:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4650112919717;
        Mon, 24 Aug 2020 15:52:02 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:08:47 -0700 (PDT)
Message-Id: <20200824.160847.2223520902285907820.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [net PATCH] netlabel: fix problems with mapping removal
From:   David Miller <davem@davemloft.net>
In-Reply-To: <159804209207.16190.14955035148979265114.stgit@sifl>
References: <159804209207.16190.14955035148979265114.stgit@sifl>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 15:52:02 -0700 (PDT)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Aug 2020 16:34:52 -0400

> This patch fixes two main problems seen when removing NetLabel
> mappings: memory leaks and potentially extra audit noise.
> 
> The memory leaks are caused by not properly free'ing the mapping's
> address selector struct when free'ing the entire entry as well as
> not properly cleaning up a temporary mapping entry when adding new
> address selectors to an existing entry.  This patch fixes both these
> problems such that kmemleak reports no NetLabel associated leaks
> after running the SELinux test suite.
> 
> The potentially extra audit noise was caused by the auditing code in
> netlbl_domhsh_remove_entry() being called regardless of the entry's
> validity.  If another thread had already marked the entry as invalid,
> but not removed/free'd it from the list of mappings, then it was
> possible that an additional mapping removal audit record would be
> generated.  This patch fixes this by returning early from the removal
> function when the entry was previously marked invalid.  This change
> also had the side benefit of improving the code by decreasing the
> indentation level of large chunk of code by one (accounting for most
> of the diffstat).
> 
> Fixes: 63c416887437 ("netlabel: Add network address selectors to the NetLabel/LSM domain mapping")
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Applied and queued up for -stable, thanks Paul.
