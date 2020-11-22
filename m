Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF3C63777
	for <selinux@archiver.kernel.org>; Sun, 22 Nov 2020 20:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E4D2078B
	for <selinux@archiver.kernel.org>; Sun, 22 Nov 2020 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gGXIdg7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKVUxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:53:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgKVUxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Nov 2020 15:53:38 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B7AFB20B717A;
        Sun, 22 Nov 2020 12:53:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7AFB20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606078417;
        bh=alE6Kb/zDgqzLgdvNjihsk5l+fJjrnYiq4iR3wkQH+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gGXIdg7oo3NxBnYLTF6PEbRZvdcXdbnnlLlQ3YfDgE+wvrZM0lYR6WqM4X+tCmiPP
         EldLucw+lLJagJHWRX5TeaWcO7cM4RDF6UClTg5vO12b7cWO7BvlKuK9EQNMlEbryD
         Z/IiP2IE9CP5mW6v/DXF7UjLxi4UYMaRHDrEQGhs=
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
To:     Pavel Machek <pavel@ucw.cz>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com,
        tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201120124657.GA31468@duo.ucw.cz>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
Date:   Sun, 22 Nov 2020 12:53:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120124657.GA31468@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks Pavel for looking at this series.

On 2020-11-20 4:46 a.m., Pavel Machek wrote:
> On Thu 2020-11-19 15:26:03, Tushar Sugandhi wrote:
>> Kernel integrity critical data can be defined as the in-memory kernel
>> data which if accidentally or maliciously altered, can compromise the
>> integrity of the system.
> 
> Is that an useful definition?
I will rework on the definition in the next iteration.
Meanwhile, if you have any feedback on what can we add to the
definition, that would help is.

> 
>> There are several kernel subsystems that contain integrity critical
>> data - e.g. LSMs like SELinux, or AppArmor; or device-mapper targets
>> like dm-crypt, dm-verity etc. Examples of critical data could be kernel
>> in-memory r/o structures, hash of the memory structures, or data that
>> represents a linux kernel subsystem state.
>>
>> This patch set defines a new IMA hook namely ima_measure_critical_data()
>> to measure the critical data. Kernel subsystems can use this
>> functionality, to take advantage of IMA's measuring and quoting
>> abilities - thus ultimately enabling remote attestation for the
>> subsystem specific information stored in the kernel memory.
> 
> How is it supposed to be useful?
> 
> I'm pretty sure there are critical data that are not measured by
> proposed module... and that are written under normal circumstances.
> 
The goal of this series is to introduce the IMA hook
measure_critical_data() and the necessary policies to use it; and
illustrate that use with one example (SELinux). It is not scalable to 
identify and update all the critical data sources to use the proposed
module at once.

A piecemeal approach to add more critical data measurement in subsequent
patches would be easy to implement and review.

Please let me know if you have more thoughts on this. (what critical
data you think would be useful to measure etc.)

~Tushar

> Best regards,
> 
> 									Pavel
> 
