Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CDEC433DF
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 19:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450C320866
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 19:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Km+gsuLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLTCK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:02:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLTCK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 15:02:10 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5391120B4908;
        Wed, 12 Aug 2020 12:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5391120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597258929;
        bh=bKKzArq8dEzr/hz0mwQ2HyxPzIg7VaOZ6N9h8JYZDXU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Km+gsuLQoEsO1rPGk9mxgUiAzFinx403rXdAsdWOdDtQZ4TqEIQ7ufTKaNSgxVK7X
         hccwaYvWQ2xcXUJr6UJbo5aFP/0A916w9bJOsj7W1ECJBvjT4iuNu+5kRgVDgYaAW1
         s2ISYuUp2gHuhejuBw7XStRUbZS+LFloeY0QzYc8=
Subject: Re: [PATCH 0/4] Update SELinuxfs out of tree and then swapover
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
 <CAEjxPJ7aQLCAxdQHhWiUF6jUT4Fawm8utETAJSCzuY1k7VwK0g@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <417c25b1-a6b0-cea5-64a6-998b12d47f47@linux.microsoft.com>
Date:   Wed, 12 Aug 2020 15:02:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7aQLCAxdQHhWiUF6jUT4Fawm8utETAJSCzuY1k7VwK0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/12/20 2:51 PM, Stephen Smalley wrote:
> On Wed, Aug 12, 2020 at 10:09 AM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>> In the current implementation, on policy load /sys/fs/selinux is updated
>> by deleting the previous contents of
>> /sys/fs/selinux/{class,booleans,policy_capabilities} and then recreating
>> them.  This means that there is a period of time when the contents of
>> these directories do not exist which can cause race conditions as
>> userspace relies on them for information about the policy.  In addition,
>> it means that error recovery in the event of failure is challenging.
> I haven't looked closely yet, but note that my patches stopped
> removing the policy_capabilities directory entries altogether and only
> create them during initialization of the mount, because the set of
> directory entries is not policy-dependent (only the values read from
> them are policy-dependent, not the names themselves).  It was a
> mistake to ever re-create those entries in the first place.  So you
> only need to deal with the class and booleans directories in your
> patches.  Also, I would recommend cc'ing viro and linux-fsdevel on
> your patch set in addition to selinux so that they can look at it from
> a vfs point of view.
Oops, that was a mistake in the fixing up of the cover letter.  When I 
rebased
on your patches I fixed that issue in code and in the commit message for 
the second
patch in the series, but it looks like I missed it here and in the other 
commit messages.
I'll clean that up and resend with the additional ccs.  Thanks!

-Daniel

