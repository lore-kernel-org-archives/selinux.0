Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385AAC43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE43F208FE
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="icn5YDih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgIKQXI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:23:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59396 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgIKQWp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 12:22:45 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 953AD20716FC;
        Fri, 11 Sep 2020 09:22:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 953AD20716FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599841365;
        bh=Su6m0M3GjOhlI1z/NUkRmKtJzGmhY9DfdpjSMQkRt4Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=icn5YDihH4nELQOa8XNaTtjLDKp8AAuHVuJp46dNGCfren5N/F4OyEY0zubNe4Afz
         AU1se4eyggNhCjrdVqxdR65dpaLxKCZ3iPAt3S8r3n0Uj0kyoOZhfysoGyK3jNvgpt
         HpvqV+kp8zkc9lqaawhKse8yHKUq5PidqsO1b9tA=
Subject: Re: [PATCH v3 2/6] IMA: change process_buffer_measurement return type
 from void to int
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
 <20200828015704.6629-3-tusharsu@linux.microsoft.com>
 <e76bdb18c6045702156441470e50380445e6e218.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <b4cc6ec3-a58b-df2b-2de9-864775ae2a5f@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 09:22:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e76bdb18c6045702156441470e50380445e6e218.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2020-08-31 4:36 a.m., Mimi Zohar wrote:
> On Thu, 2020-08-27 at 18:57 -0700, Tushar Sugandhi wrote:
>> process_buffer_measurement() does not return the result of the operation.
>> Therefore, the consumers of this function cannot act on it, if needed.
>>
>> Update return type of process_buffer_measurement() from void to int.
> 
> Failure to measure may be audited, but should never fail.  This is one
> of the main differences between secure and trusted boot concepts.
> Notice in process_measurement() that -EACCES is only returned for
> appraisal.
> 
> Returning a failure from process_buffer_measurement() in itself isn't a
> problem, as long as the failure isn't returned to the LSM/IMA hook.
> However,  just as the callers of  process_measurement() originally
> processed the result, that processing was moved into
> process_measurement() [1].
> 
> Mimi
> 
> [1] 750943a30714 ima: remove enforce checking duplication
> 
I can ignore the result of process_buffer_measurement() in
ima_measure_critical_data(), and make  ima_measure_critical_data()
return type "void".

But currently ima_measure_critical_data() is the only place where the
results of p_b_m() are being used.
So I might as well just revert back the return type of p_b_m() to
the original "void".


