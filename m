Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC9C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9322964FEA
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 22:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCDWdx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:33:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45826 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCDWdx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 17:33:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id AD9624D2D0CCF;
        Thu,  4 Mar 2021 14:33:51 -0800 (PST)
Date:   Thu, 04 Mar 2021 14:33:47 -0800 (PST)
Message-Id: <20210304.143347.415521310565498642.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the
 DOI refcounts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <161489339182.63157.2775083878484465675.stgit@olly>
References: <161489339182.63157.2775083878484465675.stgit@olly>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Thu, 04 Mar 2021 14:33:51 -0800 (PST)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>
Date: Thu, 04 Mar 2021 16:29:51 -0500

> +static void calipso_doi_putdef(struct calipso_doi *doi_def);
> +

This is a global symbol, so why the static decl here?

Thanks.
