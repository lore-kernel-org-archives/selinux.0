Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64749C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD2A20818
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ILjoTvDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfCAQuL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:50:11 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:33967
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbfCAQuL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 11:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551459008; bh=VtI4JmP4p7NhaNlYMyOerirk2w/Aem8+Y1TxSBQf+K8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ILjoTvDTLqRkR63cSuz64VjWmexvek4F7p40a5v3FpbUd9zSwmNz3f4K2Viawhlc1TV5g8qmxd/4NSlBB8VFyxNi6ge1IcvbUFYQVDQdFKFT36GtcVPG7eV/ONZY5xFRa6Uv2Lh9LJ6Q0bSj+heT+yIdwN26Qz5a6jsHm1+930ojMv+9OLSKqBDWUd6FwYc5g6r2XZaj32eQZ+gv5W00+NdTEiZ+doCAuZH1QpHydBtVltHh2ZxdfJNaDDybX//+oBqFajm52ye9HfWSb/qNF4RaPyzH1l0BQscJ/KcnwvOd4gqDN6XXZ91ljsHPdCSxMsDSYdx9MDpVaVqwuDR21w==
X-YMail-OSG: GYYaioQVM1lIHBBJKo2vmjIYcc4AyLaS7r.wpoJl54dWHYm1gPf3QPMWfus9sC1
 1yaeRYhHM2gWVRCo9c3cTeeF7eE8RYxbffPwbRFY9c5kc04WhcWBafwApEjmaPoCaH58CX346Xjy
 Q6yzbyAgbNYlrcCFlfY1Kn1L1XsJpRDd1FdgZZu2vw3hsqbFSoiSNzfQAvfkc9HN.xBxF7UcNSQ9
 VOSfRaHdLmU_UdffUhDm.5tDfz3nLawoKyrac9OCvj1LJv1h73eK5fe0GL.F_8m3smWmzP6bIDcZ
 ESUSzrQEuqC.IQceZBEhplcbnM20E0kDepVJqYvDhsBop8G2nexw7kUc3IKD5CH9E7_iw2DwJjGN
 qP2HQaOivbP.JRd88pPccaEDRllycKf_9LYJinQAXGviFM9BoPr8kG4wRjtgIdbMmxcHBMgrJrN_
 YAAHr1rVPS1nSW0J2UL_KuSPDPtcd_skhTTwRSJAlY4xy2VZv8RvM8mqa_XojEP8boi3AC1e_2Fk
 6kjQw7PpxC3X2jw7SbCQMr554oGDxl7jFfiOIDXFnLNFcj4rSdljbQER4jQOrkcvk.pfLdzF58UY
 RJIoH31670IguFvwzdL0Nhxb5qCYkY4eR4tHBRD0IJsyuAoS8tBafizMnGnXIjnkU.Yl6xcdgkpw
 KVUlRRO1s2CbBmAqvTzwtpsvo.hDUoT.w1qr5MFFOb3YiK3xi1gjWDggCCBZuyj4GcuM8L2tvXcs
 Jn6rGf4qMXionSXRAZhC0TjOfxYDI6reV52FmUXhLFNYMEXNtVCZF8xxKq2t._lxEnvquOnywDBy
 3pbMyusTmR355DNqRWhmIyFMmQLSz9MeAflQra.A4Hq__Gbg75cMgQF93gHakwe7OsgoPyM8A_bO
 EP59bMShHdXuewywmXsmWH0HpLZth3vg5DaRTVZ7zbx.4EQu5wElLH4bmmRuCzjewkCrXPqSbhJG
 ztIcCKeQ2fat2m.JON7wHwT80Xd.SnAYYA0pdZnY2K6T__oZDP75MAmU8WdeE6IqZMdlca0FYOSa
 _HgJuLtaZE_oQX6pXyNmzGP6FCYpJ2iIQIdvmsDIf9LWy43tQ4Tn7VXaBCgNsB2WM.u5txOlcA4U
 WfhHll5xoHSiISKl3h6L21WedQSELgWlA690zajiHkbu35A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Mar 2019 16:50:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f6d87077ede0286f369bc2067a6bc68;
          Fri, 01 Mar 2019 16:50:04 +0000 (UTC)
Subject: Re: [PATCH 01/97] LSM: Infrastructure management of the superblock
To:     Edwin Zimmerman <edwin@211mainstreet.net>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
 <20190228221933.2551-2-casey@schaufler-ca.com>
 <000701d4d037$6e9d7aa0$4bd86fe0$@211mainstreet.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <de68fa0e-c9cf-2829-c360-e5db0f65415a@schaufler-ca.com>
Date:   Fri, 1 Mar 2019 08:50:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <000701d4d037$6e9d7aa0$4bd86fe0$@211mainstreet.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/1/2019 6:02 AM, Edwin Zimmerman wrote:
> On Thursday2/28/2019 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> From: Casey Schaufler <cschaufler@localhost.localdomain>
>>
>> Move management of the superblock->sb_security blob out
>> of the individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
>>
> ...
>> @@ -296,12 +297,13 @@ static void __init ordered_lsm_init(void)
>>   	for (lsm = ordered_lsms; *lsm; lsm++)
>>   		prepare_lsm(*lsm);
>>
>> -	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
>> -	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
>> -	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
>> -	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
>> -	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
>> -	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
>> +	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>> +	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>> +	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>> +	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
>> +	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>> +	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>>
> Any reason this couldn't be a single line, or am I missing something?

Indentation. If the preceding patches had gotten the indentation
right this would be the one line patch you suggest. To be fixed in
the next version.

> It took a second look to realize that the only line actually being added was
> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>
>
