Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F725C433DF
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 01:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E3D2083B
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602813020;
	bh=Xj+mBp5030/4UsIx6cE0dgTRR8XQvQnGmSDr6zSCeWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dN/8pIBdCDqGZ7xld6ZXIHyofPZrnJ4BktInFTRXzT2yHrls9i/iKPV21zo2JzBqa
	 1WFpcsLZLk76wJ89pHsMDFDe06L5Z+7U2FuG6Mh8FCYpyTgNu5vx57s/jurkXfODZV
	 WLbVe0zLHsciOWrL7jC5EJtpb6u2pZiIPB+tn2C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbgJPBuT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 21:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388885AbgJPBuT (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 15 Oct 2020 21:50:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960572078A;
        Fri, 16 Oct 2020 01:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602813018;
        bh=Xj+mBp5030/4UsIx6cE0dgTRR8XQvQnGmSDr6zSCeWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0vThze8OEM4BqYXYmEdw4gjjZyfku5rioKHjMmnQVmMLikoQ89gTAgd2iiiMDtMQ
         0hCmrOR/bdbo7F3INdrjSSS5rAbEe8svgl3wmX5jbhoiY8WmIskg1hU/jG0sttyhnz
         248ReZZkhVhG76jPqeF/KjSI1k4Gt7Hf8XHxAyhQ=
Date:   Thu, 15 Oct 2020 21:50:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     stable@vger.kernel.org, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, selinux@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5.4 3/3] selinux: Create new booleans and class dirs out
 of tree
Message-ID: <20201016015017.GU2415204@sasha-vm>
References: <20201015192956.1797021-1-dburgener@linux.microsoft.com>
 <20201015192956.1797021-4-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201015192956.1797021-4-dburgener@linux.microsoft.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 03:29:56PM -0400, Daniel Burgener wrote:
>As a final note about changes from the original patch, I dropped a patch
>that was only style cleanup, so this patch no longer takes advantage of
>the style changes.

I'd suggest to bring that patch back for this series. We're trying to
minimize the delta between upstream and stable rather than minimize
stable itself.

-- 
Thanks,
Sasha
