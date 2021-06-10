Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D1C48BE0
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A08C613D9
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFJXJB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 19:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFJXJA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 10 Jun 2021 19:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B49B261002;
        Thu, 10 Jun 2021 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623366411;
        bh=aMjnWiRXIIFtpfNKdQPke7wLaKuf2YhVmu2bgNyjv9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yXLnn8Yl9LUUawdnehr55E1vfccCnaxgHHyaGafBGdhqQDkyfAtp8xoAdBb1hPdX8
         m+XnjRi+2eEjBr0eq3ZGfdjCC+ZWZ/GmOr6JF7OTfuj4Gja1ubdsdI2HZ1F58nMJT3
         qx78tUFmy0Wnc7Eaf1vUJDpVbTNt9HhFg0YQ4D6w=
Date:   Thu, 10 Jun 2021 16:06:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: use __GFP_NOWARN with GFP_NOWAIT
Message-Id: <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
In-Reply-To: <20210609163717.2719253-1-minchan@kernel.org>
References: <20210609163717.2719253-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed,  9 Jun 2021 09:37:17 -0700 Minchan Kim <minchan@kernel.org> wrote:

> In the field, we have seen lots of allocation failure from the call path below.
> 
> ...
>
> Based on [1], selinux is tolerate for failure of memory allocation.
> Then, use __GFP_NOWARN together.
> 

Thanks.  I trust that the selinux developers will process this patch.
