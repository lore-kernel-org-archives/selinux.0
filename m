Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25E9C4332F
	for <selinux@archiver.kernel.org>; Tue, 29 Nov 2022 18:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiK2SmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 13:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiK2SmU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Nov 2022 13:42:20 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FB394D5FB;
        Tue, 29 Nov 2022 10:42:19 -0800 (PST)
Received: from [192.168.254.13] (unknown [68.33.139.110])
        by linux.microsoft.com (Postfix) with ESMTPSA id D792420B717A;
        Tue, 29 Nov 2022 10:42:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D792420B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669747339;
        bh=HU3r7mMp1QI/x9OFKaDjqV1d24/o/ENojGhZdVsP9tI=;
        h=Date:From:Subject:To:From;
        b=TSqEGcG5jLincQ5g+F82azBCSDK+4ryL13evZ+2LWBFQS9ORszGDRrWCx5qiyDOC2
         e5Lqv/8wz3xTHboTL/5Hr04wutIu1/oPdAJkWR7+iHqx3zzVKPR7XskrZefx9Zv2AN
         D+OejHOWGzZ0UZn06wwQ1fjplq8uotB67un9vQzo=
Message-ID: <706efa5c-9ac1-6a56-f6cc-043895de75aa@linux.microsoft.com>
Date:   Tue, 29 Nov 2022 13:42:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: ANN/RFC: SELinux Reference Policy 3 pre-alpha
To:     SELinux Reference Policy mailing list 
        <selinux-refpolicy@vger.kernel.org>,
        SElinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SELinux Reference Policy 3 is a rewrite using the Cascade policy 
language.  This new language allows a shift in the approach of the 
policy.  With the new ability to delete rules as a feature of the 
language, the approach in refpolicy3 is to a slightly coarser 
granularity than in v2, aimed at making common case usage the main 
focus.  This includes a focus on creating higher level abstractions 
while keeping low level functions for cases where tight least privilege 
access is required.

https://github.com/pebenito/refpolicy3

**Refpolicy 2 will continue to be maintained as normal.**

This is pre-alpha quality.  It is using the Cascade language which is 
also in development.  As such, syntax, structure, and API may change at 
any time.  This is developing in advance of the compiler development, so 
you should not expect it to compile at this time.

This is also an RFC. Please review and comment on structure, style, etc. 
Now is the time, as the design is not set.  We implemented the majority 
of kernel and system layers of refpolicy and are eager to hear your 
feedback while the policy is still in its early stages so broad changes 
are easier.

Please send any discussion to the refpolicy mail list.  If you would 
like to contribute, pull requests on GitHub are strongly preferred, but 
patches on the refpolicy mail list are also accepted.

For more information on the Cascade policy language see:

https://github.com/dburgener/cascade


-- 
Chris PeBenito
