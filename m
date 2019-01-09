Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A42BC43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5164C21738
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 11:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfAILbc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:31:32 -0500
Received: from foss.arm.com ([217.140.101.70]:41736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfAILbc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Jan 2019 06:31:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5065DA78;
        Wed,  9 Jan 2019 03:31:32 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04FD3F70D;
        Wed,  9 Jan 2019 03:31:29 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:31:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-tegra@vger.kernel.org, talho@nvidia.com, swarren@nvidia.com,
        linux-mm@kvack.org, snikam@nvidia.com, vdumpa@nvidia.com,
        Sri Krishna chowdary <schowdary@nvidia.com>
Subject: Re: [PATCH] selinux: avc: mark avc node as not a leak
Message-ID: <20190109113126.nzpmb7xx4xqtn37w@mbp>
References: <1547023162-6381-1-git-send-email-prpatel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547023162-6381-1-git-send-email-prpatel@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Prateek,

On Wed, Jan 09, 2019 at 02:09:22PM +0530, Prateek Patel wrote:
> From: Sri Krishna chowdary <schowdary@nvidia.com>
> 
> kmemleak detects allocated objects as leaks if not accessed for
> default scan time. The memory allocated using avc_alloc_node
> is freed using rcu mechanism when nodes are reclaimed or on
> avc_flush. So, there is no real leak here and kmemleak_scan
> detects it as a leak which is false positive. Hence, mark it as
> kmemleak_not_leak.

In theory, kmemleak should detect the node->rhead in the lists used by
call_rcu() and not report it as a leak. Which RCU options do you have
enabled (just to check whether kmemleak tracks the RCU internal lists)?

Also, does this leak eventually disappear without your patch? Does

  echo dump=0xffffffc0dd1a0e60 > /sys/kernel/debug/kmemleak

still display this object?

Thanks.

-- 
Catalin
