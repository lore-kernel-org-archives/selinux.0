Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C7C433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D7A64EE0
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhBIVoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:44:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48900 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhBIU6B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Feb 2021 15:58:01 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id DDD8820B6C40;
        Tue,  9 Feb 2021 12:57:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDD8820B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612904240;
        bh=B6IXBDuHhomANc68xDBuzWoNqMqvLzCJBM0oCkXf5Go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QIKx/TZuAS+rtaIewTuyzQuZx80Qjh5e9NVrj6QV9ag6zjTB47ANqs7trj2D+qGeA
         WXQeMGoIUn+5OCOSKXW0c+QUugkz+guiQzqx3Ptkk3cXlVzwl29fsuKhgc3iL6+1Fp
         6Fcp0+EsrzX7RPQeK6wSSdlO/ogqbgBHbdFLRQ6o=
Subject: Re: [PATCH 0/3] support for duplicate measurement of integrity
 critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
 <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
 <27a4592c3b75861d2b9c8fb1511f593aa987222c.camel@linux.ibm.com>
 <c5ecccbe-9e23-f297-8a79-2a9dd62a40fb@linux.microsoft.com>
 <38ba5889d517ee010a6bf370f8892059dd7d3bfe.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <6bf1d3b1-522a-4df7-b18b-3789855b5740@linux.microsoft.com>
Date:   Tue, 9 Feb 2021 12:57:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <38ba5889d517ee010a6bf370f8892059dd7d3bfe.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2021-02-09 10:53 a.m., Mimi Zohar wrote:
> On Tue, 2021-02-09 at 10:23 -0800, Tushar Sugandhi wrote:
>>> On Mon, 2021-02-08 at 15:22 -0500, Mimi Zohar wrote:
>>>> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
>>>>> IMA does not measure duplicate buffer data since TPM extend is a very
>>>>> expensive operation.  However, in some cases for integrity critical
>>>>> data, the measurement of duplicate data is necessary to accurately
>>>>> determine the current state of the system.  Eg, SELinux state changing
>>>>> from 'audit', to 'enforcing', and back to 'audit' again.  In this
>>>>> example, currently, IMA will not measure the last state change to
>>>>> 'audit'.  This limits the ability of attestation services to accurately
>>>>> determine the current state of the integrity critical data on the
>>>>> system.
>>>>>
>>>>> This series addresses this gap by providing the ability to measure
>>>>> duplicate entries for integrity critical data, driven by policy.
>>>>
>>>> The same reason for re-measuring buffer data is equally applicable to
>>>> files.  In both cases, the file or the buffer isn't re-measured if it
>>>> already exists in the htable.   Please don't limit this patch set to
>>>> just buffer data.
>>>
>> Agreed.  I wasn't sure if you wanted the support for files, or other
>> buffer measurement scenarios, except critical data.  So I started the
>> implementation with supporting just critical data.  Happy to extend it
>> to files and other buffer measurement scenarios as you suggested.
>>
>>> Instead of making the change on a per measurement rule basis, disabling
>>> "htable" would be the simplest way of forcing re-measurements.  All
>>> that would be needed is a new Kconfig (e.g. CONFIG_IMA_DISABLE_HTABLE)
>>> and the associated test in ima_add_template_entry().
>>>
>> Agreed.  Earlier I wasn't sure if you wanted allow_dup support for all
>> the scenarios.  Now that it is clear,  I will implement it as you
>> suggested.  Thank you so much for the pointers.  Appreciate it.
> 
> There are two different solutions - per measurement rule, disabling
> htable - being discussed.   Disabling htable requires miminumal
> changes.  Which version are you thinking of implementing?
> 
I am thinking of implementing "disabling 'htable' using a new Kconfig 
(e.g. CONFIG_IMA_DISABLE_HTABLE)".  That is, not using the var 
ima_htable or ima_lookup_digest_entry() if that CONFIG is set.
So the duplicate measurements are allowed when the CONFIG is set.
This would cover all the measurement scenarios through a single CONFIG 
setting.

I am not planning to implement it as a "per measurement rule".

Sorry it wasn't clear in my earlier response.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
