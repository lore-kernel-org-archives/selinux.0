Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CEC05027
	for <selinux@archiver.kernel.org>; Wed,  8 Feb 2023 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjBHTx7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjBHTx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Feb 2023 14:53:57 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE4B4DBF7
        for <selinux@vger.kernel.org>; Wed,  8 Feb 2023 11:53:55 -0800 (PST)
Received: from [192.168.254.22] (unknown [68.33.139.110])
        by linux.microsoft.com (Postfix) with ESMTPSA id 000EB20C8AD4;
        Wed,  8 Feb 2023 11:53:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 000EB20C8AD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675886035;
        bh=JZSZEeJ+EEn/2/6H+xDEfPpQQ3tD7DjUwMyXJfUUj2E=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fxfhpxeGLurWF4M9VZDSO7/AsGz5WFvFTJC/j9NHfL1r9xfmVdoQSG8p6Mm52NhQq
         MZvDasP0yVvPaMSGXAT96BfOCiLeZt5RjB7HHQKHTcH6ABz9C4hmj1VGYiXBsfNsOS
         rmoB+nK/6QJrE6A5oG9GeT7ayo2kmdNCTBzWQCdU=
Message-ID: <9bfbdc29-1094-c321-276a-afc586c5fb61@linux.microsoft.com>
Date:   Wed, 8 Feb 2023 14:53:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: ANN: SETools 4.4.1
To:     Petr Lautrbach <lautrbach@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>,
        SElinux mailing list <selinux@vger.kernel.org>
References: <988e8169-e701-80c8-2b95-5fb2cc03e015@ieee.org>
 <878rh9eo6m.fsf@redhat.com>
Content-Language: en-US
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <878rh9eo6m.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/2023 05:59, Petr Lautrbach wrote:
> Chris PeBenito <pebenito@ieee.org> writes:
> 
>> An new release of SETools is available:
>>
>> https://github.com/SELinuxProject/setools/releases/tag/4.4.1
>>
>> Changes:
>>
>> * Replace deprecated NetworkX function use in information flow and
>> domain transition analysis. This function was removed in NetworkX 3.0.
>>
>> * Fix bug in apol copy and cut functions when copying from a tree view.
>>
>> * Fix bug with extended permission set construction when a range
>> includes 0x0.
>>
>> * Add sesearch -Sp option for permission subset match.
>>
>> * Fix error in man page description for sesearch -ep option.
>>
>> * Improve output stability in constraint, common, class, role, and user
>> queries.
>>
>> * Updated permission map.
>>
>> * Fix bug in sechecker parsing of multiline values.
>>
>> * Other code cleanups not visible to users.
> 
> It looks like https://github.com/SELinuxProject/setools/pull/68 didn't
> get into the release. Is it expected? If yes, would it be possible to
> backport it to 4.4 branch for the next 4.4.x release please?

This was an oversight.  I started a new staging PR for 4.4.2 fixes:

https://github.com/SELinuxProject/setools/pull/86


-- 
Chris PeBenito

