Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C9C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B820848
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sJlrKwSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbfCARHC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:07:02 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:39952
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389368AbfCARHC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 12:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551460020; bh=2QZLEBxqVMwGb/+X/Rc6rKWfVt78oHesiIkDn6v9Orc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sJlrKwScj7jLMlf2BzuY7zQA48qPMi+quHaFcEzbx94OIfnKdsFtuMZ8KYVmzvnvXESL1j9FEeOl2IB5aIFzbIrODerPgxgcXIgARCVq8uIu0KI8OLcCMljn+J3aNO99T9A0ZhqlUvM1zcd46KOQ3Pke0mqrwqHXOTk5hT4wcO9CvY4O07D3kfTlcN7KZfLHxGjsYcfoS3cjk3ihlJIaFi6s+8pSS3cEkOTXiNVd11EQp2j4fuic4JDRk7xzrPiKJHqeoZnVIYrTXaacm7H0tEq2HtndEV06KHnBpyo/IdbKcQC4vwgM6U/kBf3pEDBjhSJsaBrjzm0MNucIIDSBnw==
X-YMail-OSG: 0rYds30VM1mZoVF4izbak0nMOyY_D8sTD5DcP79VWyAL9VU6Fic31LwX7bGMsF1
 FWJOFsP_ODLivd1v67BJ3ueGoExkteixRHwa4wItUC0C4Agnr49qL7uW9CRyCX4g8muVSIUy1gzk
 ltmQRaWWne_LyZOsbI81PFEvkdgScw_t0YU4fdO3aw0Qk1OMTrpREWt5oTb7CNMZ.DqP1lJs2BbY
 L9qll0xlX.ipTW7bUFkvjSL6JNd_uIfG5s7WJCTRmR6Huf0H_iRTqQEHaU1wzWEvQdsU47vUSJN4
 srJ0UmD6KiefJhXpm_hTulMfXu729FDNjzv7i0sT76l0BSnf7ZlWXZYMysJCVgAD5PxkLWUMoHRF
 UPSoH09SiAEpaWoS7fx8HifLnMTAXfyl_RDhFgbg.y9R._n1VH09V.HTjb9Yi93iHFWE9fUgaBbZ
 zJhZkPsXtknZSiYmYiy250oElXaDQSIdhcfRvvnC4H4TzE.fr_80SNKfeOZNQn6Ab9cQq49sYBNC
 7ccqV3FRlpth8uVmAlLw4ipzhJjNYZxO10FdI9.cwV6C2bsuDofy6ua5zQMZw6DCJXLcTrsnDbVf
 Y3JyDegCJpTIRIn4qHOtgv3ZAhFqZlREm9sQTxEip97UfA2sET8ODpN9LR5MHV6_Mqhbwj4ri9yF
 Pe6Wiz9pypVBeqlIrC1iWn._k5lsBvrvYw2pa2AUbVwgPJ.jPG8Bv_kqENsV0lmmg0TlGz48FSJ3
 ZSkmsbbkXKUHrz7ZGMjR61XoqmzH7lNxSGwS3MVWa25YTf9TMPn4qwtSpwOdwKr7TK8oko0JQFF2
 kt9cl7lTUIFp2XdI7HlFvSbULaMHQG5Lz0zg8YlBgGsJGyVqTeJbz_U3TcrqrfihqgWIxvPkIqJy
 70XanMxXoUW1VIE8OuEoqhA8Ijko1nytax1lseVMrR1E51TOVru65rnVoA6BPixM3Uva8OV2G_su
 i8h.rYg15uJNHPeHQWAGFDguzZcDl.YH9SBNZ.0SOHRE5kiDbuUjI.skqNfPzH32mm6vveMRangp
 _RcI91bfqh2ASHW0J1yDuAQf.hewJnSiJemawOD2LCwBybxUIae0__Kvy7F_VZyareH2QEj5gUs6
 SSrJOQIvH5tFaEDVwr44nE9vBqFoX0A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Mar 2019 17:07:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp426.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 60268e672cc812182bc8fbbe4273d3a1;
          Fri, 01 Mar 2019 17:06:58 +0000 (UTC)
Subject: Re: [PATCH 00/97] LSM: Complete module stacking
To:     Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
 <c334385a-89e8-169a-3e92-4b816145391d@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <92e75397-13a6-c048-e667-7a4f71879807@schaufler-ca.com>
Date:   Fri, 1 Mar 2019 09:06:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <c334385a-89e8-169a-3e92-4b816145391d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/1/2019 6:17 AM, Stephen Smalley wrote:
> On 2/28/19 5:17 PM, Casey Schaufler wrote:
>> This is a preliminary version of the complete stacking
>> implementation. The patches need to be cleaned up, and
>> several are not strictly necessary. There is likely to
>> be work required in the audit sub-system. It does address
>> all the shared data, including CIPSO headers. It should
>> handle CALIPSO once Smack supports it. I will be revising
>> the set after 5.1.
>>
>> Complete the transition from module based blob management
>> to infrastructure based blob management. This includes
>> the socket, superblock and key blobs.
>>
>> Change the LSM infrastructure from exposing secids to
>> exposing an opaque "lsm_export" structure that can contain
>> information for multiple active security modules. Update
>> all of the security modules to use information from the
>> lsm_export structure. Update the LSM interfaces that expose
>> secids for more than one module to use the export structure.
>> Update all the users of these interfaces.
>>
>> Change the LSM infrastructure from using a string/size pair
>> for security "contexts" to a "lsm_context" structure that
>> can represent information for multiple modules. This contains
>> information that allows the "context" to be properly freed
>> regardless of where it is allocated and where it is used.
>>
>> Add an interface to identify which security module data
>> should be presented with SO_PEERSEC. /proc/.../attr/display
>> will set and report the name of the LSM for which the
>> security_secid_to_secctx() will use to translate to text.
>> If it is not explicitly set, the first security module that
>> supplies secid (now lsm_export) interfaces will be used.
>> To ensure consistency, a set of module hooks dealing with
>> the secid/context processing is maintained with each process
>> that explicitly sets it.
>>
>> Before sending a network packet verify that all interested
>> security modules agree on the labeling. Fail if the labeling
>> cannot be reconciled. This requires a new Netlabel interface
>> to compare proposed labels, and a change to the return values
>> from the existing netlabel attribute setting functions.
>
> Have you run any benchmarks to assess the performance impact of these 
> changes?

Nothing I can publish. Benchmarking is getting close
to the top of the list.

