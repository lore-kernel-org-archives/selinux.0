Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CEFC433FE
	for <selinux@archiver.kernel.org>; Sat, 12 Dec 2020 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672C2064A
	for <selinux@archiver.kernel.org>; Sat, 12 Dec 2020 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439300AbgLLRfU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Dec 2020 12:35:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47444 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbgLLRfK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Dec 2020 12:35:10 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 02E6920B717A;
        Sat, 12 Dec 2020 09:34:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02E6920B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607794469;
        bh=cZNRh5Q0U3GyMBcA1RlqvaJ5uqRCrL2/ckYKpzPbib4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pB/695MRRD18jLHm/C0AAvVFk64X89Y4SucWJmv0A4oLuwIf5tE8CsTKFEkIpcd8A
         e4EQNlfHwf8ZnJn9YtK9QqAC2iP2niJacGmuePAGBAQok6CMS4+757koOXqUg+aJqw
         ZfV+lZZMAqg0dN9yzbUo4R0HQrzxBQqeYiUBYmd8=
Subject: Re: [PATCH v8 4/8] IMA: add policy rule to measure critical data
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
 <20201211235807.30815-5-tusharsu@linux.microsoft.com>
 <20201212002500.GF4951@sequoia>
 <7e137e37-c195-1d16-05ef-56c2645fcc84@linux.microsoft.com>
 <20201212144741.GH4951@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <157daf28-9b59-bb3a-9b14-17d5aa0a9943@linux.microsoft.com>
Date:   Sat, 12 Dec 2020 09:34:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212144741.GH4951@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


>>>> +	case CRITICAL_DATA:
>>>> +		if (!rule->data_source)
>>>> +			return true;
>>>> +
>>>> +		opt_list = rule->data_source;
>>>> +		break;
>>>
>>> I guess this case should unconditionally return true in this patch and
>>> then the include this additional logic in the next patch.
>>>
>>> Sorry, I missed these on my last review.
>>>
>> No worries.
>>
>> As I mentioned above, I kept it purposefully in this patch since
>> my impression was rule->data_source is not part of the user facing
>> policy.
>>
>> But I can simply return true here as you suggested, and move the logic to
>> the next patch.
> 
> I understand the thinking that it isn't harmful in this patch but I
> think it is a bit cleaner to introduce the data_source policy language
> element and all of its backend support in the same patch. Please move it
> to the next patch. Thanks!
> 
> Tyler
> 
Will do.
Thanks a lot Tyler for a detailed review. Appreciate it.

~Tushar



