Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A66AC761A6
	for <selinux@archiver.kernel.org>; Mon,  3 Apr 2023 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjDCM2m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Apr 2023 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjDCM2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Apr 2023 08:28:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACAF64EEA
        for <selinux@vger.kernel.org>; Mon,  3 Apr 2023 05:28:27 -0700 (PDT)
Received: from [192.168.254.22] (unknown [68.33.139.110])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B8C2210CB1F;
        Mon,  3 Apr 2023 05:28:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B8C2210CB1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680524907;
        bh=D+7VXiXRepQOWD1cnLZhfzrYdC15aCIn2VsToFRYbWI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y1WrRUnw8XqvUIzZRN+JUXk0eVjsZ9Kk7I7vf2KfL2J5asTbUDkxTu3CfpMAhywYQ
         1DdsX8MgDorKQg/g20TcI6JI8fEi4yZWXw6JspGmESDbzszdTMYnEnycbtCOJFWMDI
         23NY4MUZJEZF5K3gn5btlDsgq5Ficm8y4dp0sxrQ=
Message-ID: <2d898b44-02a3-dae2-8e92-fa3a22f9d7a1@linux.microsoft.com>
Date:   Mon, 3 Apr 2023 08:28:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: sesearch --neverallow
Content-Language: en-US
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <87ileh5ckg.fsf@redhat.com>
 <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
 <87h6u0bwvp.fsf@defensec.nl>
 <CAEjxPJ72BTh3MzGje82uN4ayCGFGnJyz7uKobprRhx0R1R0JNA@mail.gmail.com>
 <87cz4obsa0.fsf@defensec.nl>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <87cz4obsa0.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/31/2023 16:05, Dominick Grift wrote:
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> 
>> On Fri, Mar 31, 2023 at 2:26 PM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>>>
>>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>>
>>>> On Fri, Mar 31, 2023 at 8:37 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I've got a question what is `sesearch --neverallow` good for and how to
>>>>> make it work. I wasn't able to get any output from this command.
>>>>>
>>>>> Is it supposed to work with current userspace and policies? How?
>>>>
>>>> I don't see how it could work. neverallow rules aren't preserved in
>>>> the kernel policies.
>>>> It would only make sense if sesearch could be run on source policies or modules.
>>>
>>> Which according to `man sesearch` is possible, but only monolithic policy.conf.
>>
>> Even that doesn't seem to be supported by setools 4,
>> $ sesearch --neverallow policy.conf
>> Invalid policy: policy.conf. A binary policy must be specified. (use
>> e.g. policy.33 or sepolicy) Source policies are not supported.
>>
>> $ rpm -q -f /usr/bin/sesearch
>> setools-console-4.4.0-9.fc37.x86_64
> 
> I was probably looking at the man for setools3 then. (the one on linux.die.net)

I dropped source policy support some time ago. I'll remove --neverallow 
option and man page info.

-- 
Chris PeBenito

