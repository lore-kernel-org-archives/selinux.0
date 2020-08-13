Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC8C433E3
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B782087C
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 18:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RgebBq50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMSDH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:03:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41566 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSDG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 14:03:06 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 22C4420B4908;
        Thu, 13 Aug 2020 11:03:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22C4420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597341785;
        bh=Modxb3K7yV+fn+lZsLzpD0bAJRLvdDqXtA/f5BPYSis=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RgebBq50MoWJJfQ7slTtrv5HkiXjG+9SaCMslTqbChbX1hVnbpmfrZSXcIDcSXNAu
         qNuXkGBr41h1uCxxJxB0mCQE/2nvLRLV89bqD5RWPh0/bKuhZSZAhoSJAb+Zs6sDKK
         mJEiMmEwRxPU5kYyb2e2UTOq+xY6mVHR7Ti/fXn4=
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com>
 <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
 <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
 <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
Date:   Thu, 13 Aug 2020 11:03:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 10:58 AM, Stephen Smalley wrote:
> On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On 8/13/20 10:42 AM, Stephen Smalley wrote:
>>
>>>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>>>> new file mode 100644
>>>> index 000000000000..f21b7de4e2ae
>>>> --- /dev/null
>>>> +++ b/security/selinux/measure.c
>>>> @@ -0,0 +1,204 @@
>>>> +static int selinux_hash_buffer(void *buf, size_t buf_len,
>>>> +                   void **buf_hash, int *buf_hash_len)
>>>> +{
>>>> +    struct crypto_shash *tfm;
>>>> +    struct shash_desc *desc = NULL;
>>>> +    void *digest = NULL;
>>>> +    int desc_size;
>>>> +    int digest_size;
>>>> +    int ret = 0;
>>>> +
>>>> +    tfm = crypto_alloc_shash("sha256", 0, 0);
>>>> +    if (IS_ERR(tfm))
>>>> +        return PTR_ERR(tfm);
>>> Can we make the algorithm selectable via kernel parameter and/or writing
>>> to a new selinuxfs node?
>>
>> I can add a kernel parameter to select this hash algorithm.
> 
> Also can we provide a Kconfig option for the default value like IMA does?
> 

Would we need both - Kconfig and kernel param?

The other option is to provide an IMA function to return the current 
hash algorithm used for measurement. That way a consistent hash 
algorithm can be employed by both IMA and the callers. Would that be better?

  -lakshmi

