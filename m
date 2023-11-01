Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992EC4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKAUOg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjKAUOg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 16:14:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE828110
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 13:14:33 -0700 (PDT)
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1282D20B74C0;
        Wed,  1 Nov 2023 13:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1282D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698869673;
        bh=R5MZzNvjYLCAuUH55sXqLUk2KbIfrN3s7MIUEU5pSbk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AJR5l5kF19dqk9okBQIhvxpRJW5ZOqX5y80jCqHxr4mJj6+UpSVMbvnXajYVFl6kK
         CS2/w87CZDQUk6tmZvpwRDnJk4PxkFibAagLqCfIVGOnZfEJUD2+QFY4M5SDqGflFV
         r19GSvgk7Q7RT81zTwV6aahXlcHdfGcccC+7FXLk=
Message-ID: <f267b593-a5bd-43f2-b369-f09f5a67ab2e@linux.microsoft.com>
Date:   Wed, 1 Nov 2023 16:14:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SELinux userspace 3.6 release - the current status and plan
To:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/1/2023 8:38 AM, Petr Lautrbach wrote:
> Hello,
> 
> it's been some time [1] since we released 3.5 so it's time to start with
> 3.6
> 
> [1] https://lore.kernel.org/selinux/87v8auhbr6.fsf@redhat.com/T/#t
> 
> Currently we have about 153 merged changes and about 39 changes waiting
> for review or to be merged.
> 
> You can see waiting queue at
> 
> https://patchwork.kernel.org/project/selinux/list/?series=&submitter=&state=&q=&archive=&delegate=82149
> 
> # Series:
> 
> ## [RFC,1/9] libselinux: annotate interfaces with compiler attributes
> 
> https://patchwork.kernel.org/project/selinux/list/?series=747047&submitter=&state=*&q=&archive=&delegate=
> 
> Given that some patches were already rejected, I guess that the whole set could be considered as rejected as well.
> 
> ## [1/5] libsepol: free memory on str_read() failures
> 
> https://patchwork.kernel.org/project/selinux/list/?series=765423&submitter=&state=*&q=&archive=&delegate=
> 
> Based on https://lore.kernel.org/all/CAP+JOzQ-AuM9M3c4ehKYca-eUAOy0wbVGkygkpPkhhSTNaVC-Q@mail.gmail.com/ I've marked them as "not applicable"
> 
> ## libselinux: rework selabel_file(5) database
> 
> https://patchwork.kernel.org/project/selinux/list/?series=775966&submitter=&state=*&q=&archive=&delegate=
> 
> Given that the majority was already accepted/merged, the rest could be considered as rejected.
> If there's no objection I'll mark them before the release.
> 
> ## [1/5] libsepol: include length squared in hashtab_hash_eval()
> 
> https://patchwork.kernel.org/project/selinux/list/?series=776635
> 
> no response yet
> 
> ## CIL Cleanups and Improved Argument handling
> 
> https://patchwork.kernel.org/project/selinux/list/?series=788225
> 
> There's Reviewed-by and Acked-by attached to the first patch but I guess that it applies to the whole serie.
> If it's not merged before the release and there's no other objection, I'll merge it.

I only managed to make it through the first patch in that series before 
getting pulled elsewhere unfortunately.  My Reviewed-By was intended for 
that patch only.  I can try to find time to review the rest of the 
series next week if that would be helpful.

-Daniel

> 
> 
> 
> The rest are individual patches which are already acked or waiting for review.
> 
> 
> # Plan
> 
> During this week, I'll prepare update of translations from fedora weblate and I'll prepare pre-release list of highlights for this release.
> 
> I'd like to start with rc1 during next week and then do rc releases every other week (14 days)
> 
> 
> Please let me know if there's any objection or if you think that we should wait for somethig or if you want to have seomthing in release notes.
> 
> 
> Thanks,
> 
> Petr
> 
> 
> 
> 
> 

