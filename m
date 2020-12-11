Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0883C433FE
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 01:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8426E23C18
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 01:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbgLKBbh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:31:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53526 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgLKBbG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Dec 2020 20:31:06 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7FF0F20B717B;
        Thu, 10 Dec 2020 17:30:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FF0F20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607650226;
        bh=22gUqI4ITgUIK0xRDfvH6Jh/NoT35bN2te63MEKRp2w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PguH9qx1sLqdQS/KVhu7igFG+lvm/KeC8k1oreR+pGemthTL7xrPSRJkxgjAvc0mM
         TecdjRjNxCmjVClAtFJXta4Hgne37gXtMNZ2IuH0aCB/9KZr5eai2QIauMcli5QYSr
         PfJHz+sL08ZlncLyDps3V0q+XAsqSeWq0kGWBGag=
Subject: Re: [PATCH v7 7/8] IMA: define a builtin critical data measurement
 policy
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-8-tusharsu@linux.microsoft.com>
 <20201210232214.GL489768@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <f8952107-94a8-5eab-d778-f7317ad6772f@linux.microsoft.com>
Date:   Thu, 10 Dec 2020 17:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210232214.GL489768@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2020-12-10 3:22 p.m., Tyler Hicks wrote:
> On 2020-12-09 11:42:11, Tushar Sugandhi wrote:
>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>> Define a new critical data builtin policy to allow measuring
>> early kernel integrity critical data before a custom IMA policy
>> is loaded.
>>
>> Add critical data to built-in IMA rules if the kernel command line
>> contains "ima_policy=critical_data".
>>
>> Update the documentation on kernel parameters to document
>> the new critical data builtin policy.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Tyler
> 
Thanks for the review.

~Tushar
