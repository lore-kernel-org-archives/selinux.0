Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACA9C433E7
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A5620866
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602862706;
	bh=wgXOoHVkVPjnMrqcgErkRfYElHlsFkJdpJKZOEHflzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G966vFx0aOi+8WDFuLeW+f7RpyHsB4s+Xb6mV4jV3tyiZ7+7nrvkCwTvSOCDAEkGo
	 3cBdjSpLGofc3OYyKNKuYF3mMIY4pMef0nQ/C6WL6bg59klK/JJ8S710KVxQcTOPei
	 M3dN6iZOk12pyuLlC2TOBKy41VanLqNLf7R1xOss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408458AbgJPPiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408427AbgJPPiZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 16 Oct 2020 11:38:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B41207DE;
        Fri, 16 Oct 2020 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602862705;
        bh=wgXOoHVkVPjnMrqcgErkRfYElHlsFkJdpJKZOEHflzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOXom/y3bd47t/YLEAhgSEQ1l/L0yvd95y0T9YHf9ML0jENkmAQxf5Ri5jmXGgqU2
         KCxPhTg3LIDHyvLm0J7VYNWhwVHg6fnRmryypMQ5Np5FedltLTyB7cvGc+W1Of4PGr
         5MvSH53ZS7gtmkjRdqzlEL8MxxYqJVAhmFdQZkJg=
Date:   Fri, 16 Oct 2020 11:38:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        stable@vger.kernel.org, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, selinux@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5.4 v2 0/4] Update SELinuxfs out of tree and then
 swapover
Message-ID: <20201016153823.GA2415204@sasha-vm>
References: <20201016134835.1886478-1-dburgener@linux.microsoft.com>
 <20201016150120.GB1807231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201016150120.GB1807231@kroah.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 16, 2020 at 05:01:20PM +0200, Greg KH wrote:
>On Fri, Oct 16, 2020 at 09:48:31AM -0400, Daniel Burgener wrote:
>> v2: Include all commits from original series, and include commit ids
>>
>> This is a backport for stable of my series to fix a race condition in
>> selinuxfs during policy load:
>
>Has this race condition always been present, or is this a regression
>that is being fixed from previously working kernels?

So this issue has always been there, but:

>If it's always been present, why not just use 5.9 to solve it?

Because it was merged for 5.10 rather than 5.9, which is a few months
out, so Daniel is looking to see if we can have it in 5.8/5.4 to close
the gap.

-- 
Thanks,
Sasha
