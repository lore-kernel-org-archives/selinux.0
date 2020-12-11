Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1432AC433FE
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 01:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEEA23DE4
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 01:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbgLKBad (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:30:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgLKBa3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Dec 2020 20:30:29 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5007320B717A;
        Thu, 10 Dec 2020 17:29:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5007320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607650188;
        bh=yGgzoIdOorbDs7MxKlg+eL3hr036hpEtLmS92RUcudE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=atAYxjfS4S+6flO2iq7tGQCKH1dwb7TX5DHXLt0M7SEA+Olvn4o6HH1g3u6UypVYd
         E7ApJD01S/8ifxPosxr9WzFOQW8E7wJUsOfc3rtrgqzjLTSO5++WuHAk1H8xmfc3qF
         Ph8i/xozYVTLTThJbGWxwTrie4zn0apcGL67klHQ=
Subject: Re: [PATCH v7 6/8] IMA: extend critical data hook to limit the
 measurement based on a label
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-7-tusharsu@linux.microsoft.com>
 <20201210231922.GK489768@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <d0ad5746-e699-ad61-72bd-15a373e06928@linux.microsoft.com>
Date:   Thu, 10 Dec 2020 17:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210231922.GK489768@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2020-12-10 3:19 p.m., Tyler Hicks wrote:
> On 2020-12-09 11:42:10, Tushar Sugandhi wrote:
>> The IMA hook ima_measure_critical_data() does not support a way to
>> specify the source of the critical data provider. Thus, the data
>> measurement cannot be constrained based on the data source label
>> in the IMA policy.
>>
>> Extend the IMA hook ima_measure_critical_data() to support passing
>> the data source label as an input parameter, so that the policy rule can
>> be used to limit the measurements based on the label.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Tyler
> 
Thanks for the review.
~Tushar
