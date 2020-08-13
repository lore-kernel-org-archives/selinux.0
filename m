Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E913C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC39820829
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pIAPcaPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMRwI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:52:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40304 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMRwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 13:52:07 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B632020B4908;
        Thu, 13 Aug 2020 10:52:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B632020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597341126;
        bh=2l0TPnqy1h2HCab1hhpmyU5YtlYb9cGjfZQQg0KSl4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pIAPcaPFnv4LhZSR1nIW72voJt0jEhEzRHZgsbR+Tak92I7wv9VOPRaDmS9CsvT+0
         Hmf1h1SPZw/jqg3/VCMImCZdhomgI+8keC/GHl3FBZ1kPVZdCnoLThpOlLLThAxDEY
         Ei5+QWbzrlts0fZ4xO8qoetbVnMUmi0rFTTsoMLQ=
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        zohar@linux.ibm.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul Moore <paul@paul-moore.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com>
 <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
Date:   Thu, 13 Aug 2020 10:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 10:42 AM, Stephen Smalley wrote:

>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>> new file mode 100644
>> index 000000000000..f21b7de4e2ae
>> --- /dev/null
>> +++ b/security/selinux/measure.c
>> @@ -0,0 +1,204 @@
>> +static int selinux_hash_buffer(void *buf, size_t buf_len,
>> +                   void **buf_hash, int *buf_hash_len)
>> +{
>> +    struct crypto_shash *tfm;
>> +    struct shash_desc *desc = NULL;
>> +    void *digest = NULL;
>> +    int desc_size;
>> +    int digest_size;
>> +    int ret = 0;
>> +
>> +    tfm = crypto_alloc_shash("sha256", 0, 0);
>> +    if (IS_ERR(tfm))
>> +        return PTR_ERR(tfm);
> Can we make the algorithm selectable via kernel parameter and/or writing 
> to a new selinuxfs node?

I can add a kernel parameter to select this hash algorithm.

  -lakshmi

