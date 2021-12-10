Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155AC433EF
	for <selinux@archiver.kernel.org>; Fri, 10 Dec 2021 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbhLJRNO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:13:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59290 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhLJRNN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Dec 2021 12:13:13 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C1A720B7179;
        Fri, 10 Dec 2021 09:09:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C1A720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639156178;
        bh=EbjE3WriJjlVdIpzxIPl6mTVfj8amKLn0S6lhLWkRD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fpZpAQh5tI/zn0DGAXwt999EF3YoCLFWC4CZ7Z6+suXbSvfqskzy3tduml2B6u94m
         +u1rZQ3hYXROWlgWpb1pvcFrFOUZUFNknZhTnf92M04kioortDOmIC/uLsyhLNj6iz
         CkpIaKX7Lmf605KtLmOuDZwMW5K1VnE9/AzsKi7M=
Message-ID: <4a56b4a0-55b4-3c26-af3f-89be991ed0bd@linux.microsoft.com>
Date:   Fri, 10 Dec 2021 12:09:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/4] src/images: Remove current penguin
Content-Language: en-US
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20211210114340.13977-1-richard_c_haines@btinternet.com>
 <20211210114340.13977-3-richard_c_haines@btinternet.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20211210114340.13977-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/2021 6:43 AM, Richard Haines wrote:
> Remove pengiun image before replacement
> 

nit: typo in commit message ("pengiun")
