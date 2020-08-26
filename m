Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20080C433E4
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D212078A
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZvkZ+aBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZTQZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:16:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33896 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgHZTP6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 15:15:58 -0400
Received: from chpebeni.northamerica.corp.microsoft.com (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 57B3D20B4908;
        Wed, 26 Aug 2020 12:15:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57B3D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598469357;
        bh=e5uaTaHHAobkPAiR8m4fJ4CpYS609tINzoWU/AqVoMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZvkZ+aBk3Av3Ayb8bMzvQijOE5lBQNTeVGm+ZqjEiCKH9emX87vkeZ5/3UNGPXzg+
         wyYuPgSqj9qPVRB32RpMi9uzosg6m7tTYYuTnrqwZGcuGKfd/H+bWez7oHsZ/GAV2Y
         YDOG7AoKr3oTS69B1Fiin5YZ9Wd99pV/BvQu5NFw=
Subject: Re: Userspace AVC auditing on policy load
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
 <e4cdec2a-8c01-fbe4-cba3-3468b4ebea2e@linux.microsoft.com>
 <CAEjxPJ7xrzm6GQUxckRgVot082xZtabV-RZzv0E-Orfq7y_riQ@mail.gmail.com>
 <2b50e8f1-08ef-0868-4a2e-dfdbb61ed5ea@linux.microsoft.com>
 <ypjla6yhql92.fsf@defensec.nl>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Message-ID: <fb237606-668e-c35e-2049-58c003dd838b@linux.microsoft.com>
Date:   Wed, 26 Aug 2020 15:15:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ypjla6yhql92.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/20 3:07 PM, Dominick Grift wrote:
> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
> 
>> On 8/26/20 10:46 AM, Stephen Smalley wrote:
>>> On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
>>> <chpebeni@linux.microsoft.com> wrote:
>>>>
>>>> On 8/26/20 9:25 AM, Chris PeBenito wrote:
>>>>> I was looking into this dbus-broker audit message, which has the wrong audit type:
>>>>>
>>>>> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295
>>>>> subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice
>>>>> (seqno=2)
>>>>>
>>>>> This is due to dbus-broker setting their avc log callback to send USER_AVC audit
>>>>> messages for everything that comes to the libselinux log callback. I think the
>>>>> right thing to do there is to change it to emit USER_SELINUX_ERR audit messages
>>>>> if the log message is SELINUX_ERROR, otherwise log the message using their
>>>>> regular method (stderr I think).
>>>>>
>>>>> But the question became, why is the userspace AVC not simply emitting its own
>>>>> USER_MAC_POLICY_LOAD audit message instead of sending a message to the log
>>>>> callback?
>>>>
>>>> Ok, I missed that there is a SELINUX_AVC log type and that's how the userspace
>>>> denial messages are sent out. How about adding SELINUX_POLICYLOAD and
>>>> SELINUX_ENFORCE log types so that callers can emit appropriate audit messages?
>>> Do we need two different new types or just one?  Otherwise, I don't
>>> have a problem with adding new ones as long as it doesn't break
>>> existing applications.
>>
>> Regarding the risk of breaking existing applications, I did some
>> checking on some userspace AVC users and what they do in their log
>> callback:
>>
>> * systemd only audits SELINUX_AVC and SELINUX_ERROR messages and
>>    ignores others(as Petr noted)
>> * xorg-server audits SELINUX_AVC correctly but audits SELINUX_INFO as
>>    USER_MAC_POLICY_LOAD and everything else it ignores the type and
>>   audits as AUDIT_USER_SELINUX_ERR
>> * dbus-broker ignores type and audits everything as USER_AVC
>> * dbus-service ignores type and audits everything as USER AVC
>> * pam: pam_rootok ignores type and audits everything as USER_AVC
>> * sepgsql custom AVC implementation (this was news to me)
>> * shadow-utils only audits SELINUX_AVC and SELINUX_ERROR messages and
>>    others go to syslog
>> * cronie: no callback set
>>
>> That's all the ones I could think of.  Which ones am I missing?
> 
> Probably libreswan, AFAIK that one might also still be using
> avc_has_perm() instead of selinux_check_access().

You're correct, it is still use avc_has_perm().  There is no log callback set here.

-- 
Chris PeBenito
