Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9620BC433E9
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 20:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6007D22D5A
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 20:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbhAEUNl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:13:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43928 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbhAEUNl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 15:13:41 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A527520B7192;
        Tue,  5 Jan 2021 12:12:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A527520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609877580;
        bh=EVc75e2pcyzUJYUa1pwKwEYc67I7LZZCYXHcE/6twSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pSEf01qfw5N4YwxF49diw9lCEpw7NEroG9OpS2A7BH0DJB5yCKeHX6LmxXKxNuKUR
         jwH1L9IytifLtZFKKtVQOJ9gEk4tFU6a7G5lK5jui2QCL3EFx7xCRxDaeivWXFK8zg
         gIRjC4O5ISWuZn4aMF9pyVr75TLGMC6q3u5BRZRw=
Subject: Re: [PATCH v9 4/8] IMA: add policy rule to measure critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-5-tusharsu@linux.microsoft.com>
 <2e0baa1902b6f360e542f92906d077d44e53e59e.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <f1e3c1e6-07e1-2e8a-9824-208ccba28d17@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:12:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2e0baa1902b6f360e542f92906d077d44e53e59e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 2020-12-24 5:48 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Please update the Subject line as, "Add policy rule support for
> measuring critical data".
> 
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> A new IMA policy rule is needed for the IMA hook
>> ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
>> measuring the input buffer. The policy rule should ensure the buffer
>> would get measured only when the policy rule allows the action. The
>> policy rule should also support the necessary constraints (flags etc.)
>> for integrity critical buffer data measurements.
>>
>> Add a policy rule to define the constraints for restricting integrity
>> critical data measurements.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> This patch does not restrict measuring critical data, but adds policy
> rule support for measuring critical data.  please update the patch
> description accordingly.
> 
Will do. Will update the patch description accordingly.

> Other than that,
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
Thanks a lot for the Reviewed-by tag. :)
