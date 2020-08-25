Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87EFC433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDEA2067C
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mSj8+R+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHYPrA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:47:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41560 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHYPq5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:46:57 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B6F5220B4908;
        Tue, 25 Aug 2020 08:46:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6F5220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598370415;
        bh=cG0PU1AiCXqIk4eMHJUWBNM5pgMeFVP8Pc2YAFUO1Lo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mSj8+R+HyTWTccdCmaX3nwvs/qC1Imig3edjrJgu4HulycBCUbGm+F3HHf/nae1yY
         IHq+ic0DuDVeei+Ezy6lmnMP89du0Dok1QeKMez78ncPIJYfxf3WGtCc88IlTa4RAE
         /IzxlHbvHQp02qxCLmLTQfN2YaXczm/r9xcZei0g=
Subject: Re: [PATCH] IMA: Handle early boot data measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200821231230.20212-1-nramas@linux.microsoft.com>
 <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <307617de-b42d-ac52-6e9e-9e0d16bbc20e@linux.microsoft.com>
Date:   Tue, 25 Aug 2020 08:46:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/25/20 8:40 AM, Mimi Zohar wrote:
> On Fri, 2020-08-21 at 16:12 -0700, Lakshmi Ramasubramanian wrote:
>> The current implementation of early boot measurement in
>> the IMA subsystem is very specific to asymmetric keys. It does not
>> handle early boot measurement of data from other subsystems such as
>> Linux Security Module (LSM), Device-Mapper, etc. As a result data,
>> provided by these subsystems during system boot are not measured by IMA.
>>
>> Update the early boot key measurement to handle any early boot data.
>> Refactor the code from ima_queue_keys.c to a new file ima_queue_data.c.
>> Rename the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
>> CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
>> early boot data measurement. Since measurement of asymmetric keys is
>> the first consumer of early boot measurement, this kernel configuration
>> is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
>> both enabled.
>>
>> Update the IMA hook ima_measure_critical_data() to utilize early boot
>> measurement support.
> 
> Please limit the changes in this patch to renaming the functions and/or
> files.  For example, adding "measure_payload_hash" should be a separate
> patch, not hidden here.
> 

Thanks for the feedback Mimi.

I'll split this into 2 patches:

PATCH 1: Rename files + rename CONFIG
PATCH 2: Update IMA hook to utilize early boot data measurement.

  -lakshmi



