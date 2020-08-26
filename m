Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A60C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3292078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oOPxbmKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHZOuj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51982 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgHZOug (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:50:36 -0400
Received: from chpebeni.northamerica.corp.microsoft.com (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6688320B4908;
        Wed, 26 Aug 2020 07:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6688320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598453435;
        bh=Fyghq3HUTw2OT0mnurPEw3f+YxgzFOcU/zX3pt1RXSI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oOPxbmKr9njYh0b9Sg7Ac43XXPD8lWzrKO3eAkgK3RBm2oruYrksp+c4PJ0ENEpmS
         pa8DDkBZjS4Kd32vUFvr1JSpZVQR8FgnYaufHXJ54TXa+23rbb+uDy22hcwFs1j15G
         HSOWPmbpJhQW4lNCxdQOqmuP4aA+WlIOhyJgn0tk=
Subject: Re: Userspace AVC auditing on policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
 <e4cdec2a-8c01-fbe4-cba3-3468b4ebea2e@linux.microsoft.com>
 <CAEjxPJ7xrzm6GQUxckRgVot082xZtabV-RZzv0E-Orfq7y_riQ@mail.gmail.com>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Message-ID: <be518adb-a7c9-cb50-f6cd-a00c783a8333@linux.microsoft.com>
Date:   Wed, 26 Aug 2020 10:50:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7xrzm6GQUxckRgVot082xZtabV-RZzv0E-Orfq7y_riQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/20 10:46 AM, Stephen Smalley wrote:
> On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
>>
>> On 8/26/20 9:25 AM, Chris PeBenito wrote:
>>> I was looking into this dbus-broker audit message, which has the wrong audit type:
>>>
>>> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295
>>> subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice
>>> (seqno=2)
>>>
>>> This is due to dbus-broker setting their avc log callback to send USER_AVC audit
>>> messages for everything that comes to the libselinux log callback. I think the
>>> right thing to do there is to change it to emit USER_SELINUX_ERR audit messages
>>> if the log message is SELINUX_ERROR, otherwise log the message using their
>>> regular method (stderr I think).
>>>
>>> But the question became, why is the userspace AVC not simply emitting its own
>>> USER_MAC_POLICY_LOAD audit message instead of sending a message to the log
>>> callback?
>>
>> Ok, I missed that there is a SELINUX_AVC log type and that's how the userspace
>> denial messages are sent out. How about adding SELINUX_POLICYLOAD and
>> SELINUX_ENFORCE log types so that callers can emit appropriate audit messages?
> 
> Do we need two different new types or just one?  Otherwise, I don't
> have a problem with adding new ones as long as it doesn't break
> existing applications.

Perhaps just the policyload.  There is a USER_MAC_POLICY_LOAD audit type which 
made me think of adding the SELINUX_POLICYLOAD type to the logging callback. 
There is the log message after processing the setenforce, but there isn't 
currently a corresponding USER_MAC_STATUS audit message type.  It seems like it 
is justifiable to have a USER_MAC_STATUS audit message for consistency, but I'm 
not sure how much value it provides.

-- 
Chris PeBenito
