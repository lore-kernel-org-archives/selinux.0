Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BCDC432C0
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26D12251D
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574255555;
	bh=Y1YHQvbgqBVBtYfXoF968NFfUCGRtYRaQ43ufvzwMQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDGxXyzIyZK4/seKnbmAiKS6IWJL3UKwaOy++n7ppAPqVGivQ4KPbdTlZHsr2UGll
	 e1E59fkYquQTkd7PfJe2cqcL0XL22r8jFfiYY9iRRCH2uEr3g93tot5Woqpsc2N1uH
	 0nUWriiDutTzRg7bCy7seHt/q9MBVSvcPScI03Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfKTNMf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfKTNMf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Nov 2019 08:12:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCFA22519;
        Wed, 20 Nov 2019 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574255554;
        bh=Y1YHQvbgqBVBtYfXoF968NFfUCGRtYRaQ43ufvzwMQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdvavX/auzZdjuvYtAjnH7kGUHtTRVMH9RMGBCtfUp/dqm7hOuVcoXzICSr+4KR0X
         k+nzkC7879TNvYXHP9DvftbfnqeOGzK6+67GMqnl4NTsBdP5WtE5+VpNXlSY/GBk2/
         z8P65MllnB3+r6jPfIVRXO0FujcJWL/TDXoOsIHI=
Date:   Wed, 20 Nov 2019 13:12:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] selinux: Don't call avc_compute_av() from RCU
 path walk
Message-ID: <20191120131229.GA21500@willie-the-truck>
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-2-will@kernel.org>
 <5e51f9a5-ba76-a42d-fc2b-9255f8544859@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e51f9a5-ba76-a42d-fc2b-9255f8544859@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Stephen,

Thanks for the quick reply.

On Tue, Nov 19, 2019 at 01:59:40PM -0500, Stephen Smalley wrote:
> On 11/19/19 1:40 PM, Will Deacon wrote:
> > 'avc_compute_av()' can block, so we carefully exit the RCU read-side
> > critical section before calling it in 'avc_has_perm_noaudit()'.
> > Unfortunately, if we're calling from the VFS layer on the RCU path walk
> > via 'selinux_inode_permission()' then we're still actually in an RCU
> > read-side critical section and must not block.
> 
> avc_compute_av() should never block AFAIK. The blocking concern was with
> slow_avc_audit(), and even that appears dubious to me. That seems to be more
> about misuse of d_find_alias in dump_common_audit_data() than anything.

Apologies, I lost track of GFP_ATOMIC when I reading the code and didn't
think it was propagated down to all of the potential allocations and
string functions. Having looked at it again, I can't see where it blocks.

Might be worth a comment in avc_compute_av(), because the temporary
dropping of rcu_read_lock() looks really dodgy when we could be running
on the RCU path walk path anyway.

Will
