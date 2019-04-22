Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EAEC10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C420B1F
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G5dM/lGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfDVQK7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:10:59 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:37555
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727571AbfDVQK7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 12:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555949457; bh=gSoWLbL856iO5itaqIdSOZaMjAy3oo/XlqwiM+VmltA=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=G5dM/lGQV9zbGce3+jq+Jf8T21gy++5x3xwApE08Kf9mi4mBR71uvTSXN4fjYAkuXpWIIN6NzH0r2/HTgoXOjY7mMB5Kon9/nriZten6Y12F4inWOSiDjiFL451bivxADqHtt+GWptXYpwLDQvQtUSWWc/jmplX1NhE5kzSv3bX2sSe2p2+qOiwFkbjkIz+2wupKvtgy9m0xa7XPt+PtwrESUkuxNPgZE3aL5sA015rLiWNeSCgw3X4yU3XzI/cu2ILo8pmjlVXCahX00sWLFawF7/y0tjasA/Ml3YFn6RffOFbBA9ZNoUoQAWIglGLQPMGguQx6K6/GhJzngIxhgA==
X-YMail-OSG: uXWDzcoVM1kbFMWOkeIYhccWmi5MIQDSF06GFb6SVItvEe8bZSUvvlSl3td6PKw
 LbTsThLTFT0I75PQNu3N4QKtx2Sv6a0kfx9WPCZ44ND0tefA2lW5ZmH4mJ1u5NNCVmaJ12xliAbm
 7Zi4.kXPIUFSDwAShcEyZ3_JiQ9wKHw2AEhpU0tDoaAhvJmZa86_8dT3ccI7ICV3Zx7wsL8lqSMz
 EYF5t_819y4R9AS_dWfIxejz4J9Sj3Ui8c0IhCqRHpr7aiy5aVsqnMpjNX29RiNd3BDnJKrAW38b
 _0LS3pTupV_e9pRJXH8I.At36qUrcT_hpLK8zFMxThSa79RqyAvCwBXoXfAGInAiiBD0WQKVbFbP
 YE3O1DZYOXcirPri75.RLuICSKhF1y2hzdtz0RBxTwnN.eK6gf5JpUol13JAoMm0ftHd55zbpSWC
 2jHaQFcaxIXpOiF596GemLDgSZRTrw7HELdx_etXaROT9zrylu8Tam4s6upsJ20b8xbACVffYC5c
 tN0s9jJ589jLdG4RiStvPMNQBO64qLwlwBNZEuqCQEIMbUrAR958E6hJZLaEkzX.IUprS1ds0YAj
 kZ.YdrDl292Tu4SRI_l8.Is3xxynY_mujqCbUCwMDrgUbMX7EWmcNXeB59U3VvnA.ioGDXofSLiQ
 9h1eCW.d_zTWo.wKpXnNZiOmKHjxivgmf_Ei_.9SLBdqsxgEtVfLovDDS4LHrs7ilrPvLIwb_.CO
 9EYl9Occ0mDSOMq0QklPDgtsbN2aKNQbviztQdH_9Ak8jTjcGsRqRVpiyqy_yjulj1tOGMd1TUbP
 uXeR_0dxFhIPahsgD3fRALUGoLIsTSmsZQx54EJgJdMhRrBHw6FMeL_kyJ0GO2Kvxa4VAB63IhjX
 9zS86y_TVpla8811I9xgPDuFAIBERMKyjWO6vtqgrk6wE9PJOM_ZaqrsPCHRIZqAvvIFm_dIG5kK
 b0ZNJNUqEpYxKP3rFLMZoBy3bUDVBW9eeiU_pw5skWGt1KA33MxlXpOVm9YV_WQtfe5ulS3BfCan
 Rgtp7nY_uDnbbgBqrTwmNFGK46.3641WkC._8DEZS0Fsot3YMIBNs3FiPxQSzPZ09YOyIFRifIU8
 OCDAHisqlxkxr.mCifRe1Du.TZqi7QLwLBrY3WPqOI3XOwg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Apr 2019 16:10:57 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3daa66f7a693088fc8c10476d9b0f313;
          Mon, 22 Apr 2019 16:10:55 +0000 (UTC)
Subject: Re: [PATCH 00/90] LSM: Module stacking for all
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <6c9c3782-a168-c435-0caf-311c2d21d174@tycho.nsa.gov>
 <dbf99650-b53e-f197-aeb8-ed6fd9031837@schaufler-ca.com>
 <fc27e666-5446-08b3-48c3-a4871d06bb68@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <179fbe62-795a-564f-f8ec-26acae77685c@schaufler-ca.com>
Date:   Mon, 22 Apr 2019 09:10:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fc27e666-5446-08b3-48c3-a4871d06bb68@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/22/2019 5:46 AM, Stephen Smalley wrote:
> On 4/21/19 1:31 PM, Casey Schaufler wrote:
>> On 4/19/2019 8:27 AM, Stephen Smalley wrote:
>>> On 4/18/19 8:44 PM, Casey Schaufler wrote:
>>>> This patchset provides the changes required for
>>>> the any security module to stack safely with any other.
>>>>
>>>> A new process attribute identifies which security module
>>>> information should be reported by SO_PEERSEC and the
>>>> /proc/.../attr/current interface. This is provided by
>>>> /proc/.../attr/display. Writing the name of the security
>>>> module desired to this interface will set which LSM hooks
>>>> will be called for this information. The first security
>>>> module providing the hooks will be used by default.
>>>>
>>>> The use of integer based security tokens (secids) is
>>>> generally (but not completely) replaced by a structure
>>>> lsm_export. The lsm_export structure can contain information
>>>> for each of the security modules that export information
>>>> outside the LSM layer.
>>>>
>>>> The LSM interfaces that provide "secctx" text strings
>>>> have been changed to use a structure "lsm_context"
>>>> instead of a pointer/length pair. In some cases the
>>>> interfaces used a "char *" pointer and in others a
>>>> "void *". This was necessary to ensure that the correct
>>>> release mechanism for the text is used. It also makes
>>>> many of the interfaces cleaner.
>>>>
>>>> Security modules that use Netlabel must agree on the
>>>> labels to be used on outgoing packets. If the modules
>>>> do not agree on the label option to be used the operation
>>>> will fail.
>>>>
>>>> Netfilter secmarks are restricted to a single security
>>>> module. The first module using the facility will "own"
>>>> the secmarks.
>>>
>>> Is it expected that enabling all security modules with this change 
>>> will yield permission denials on packet send/receive (e.g. sendmsg() 
>>> fails with permission denied), even without any configuration of 
>>> NetLabel or SECMARK?  That's what I see.
>>
>> Yes.
>>
>> Smack is much more aggressive about using labeled networking
>> than SELinux. Smack tells Netlabel to label networks, whereas
>> SELinux expects them to be unlabeled. Smack has the concept of
>> an "ambient" label, which is applied to unlabeled packets, and
>> for which packets are sent unlabeled. SELinux only uses netlabel
>> for the MLS component, whereas Smack uses it for the entire
>> label. In short, it's amazing if there's a case where they do
>> agree.
>>
>> You can make the default configuration work better by specifying
>> that the Smack "floor" label be treated more like the unconfined_t.
>>
>>      # echo _ 0 0 0 > /sys/fs/smackfs/cipso2
>>      # echo NotFloor > /sys/fs/smackfs/ambient
>>
>> Will result in a situation where the two MAC systems will agree
>> much more often.
>
> Not sure that should be required given that SELinux doesn't enable 
> labeled networking at all by default,

SELinux doesn't. Smack does. Smack always enables labeled networking.


> so there is no real conflict until/unless someone configures labeled 
> networking for SELinux.

Labeled networking is independent of the security modules.
Netlabel provides mechanism and leaves policy up to whoever
might look at the lsm_secattr. Once Smack sets the default
labeling everyone get the labels.

> I'll defer to Paul on that question.
>
> Given this restriction, to what extent have you tested Smack+SELinux 
> together and what worked and didn't work? Everything except for 
> networking-related tests?

Exporting security information, either by netlabel, netfilter
secmarks or security contexts has always been the challenge.
User space has never had to deal with the possibility that
there might be more than one security module to deal with.
A system that assumes a particular security module, as do
Fedora and Ubuntu, will have some opportunities for improvement
in the full stacking world.

I have been using Fedora 29 as a primary testbed. The
Fedora user space expects SELinux and so long as SELinux
appears before Smack in the LSM list, it's happy except
for the networking. If you put Smack ahead of SELinux the
user space fails when it tries to get or set SELinux
attributes. This is because the kernel uses the first
module providing the interfaces like SO_PEERSEC, and the
code only wants to see SELinux attributes.

I'm not 100% sure I can explain the behavior of overlayfs
in the combined environment, but then I'm not sure I really
understand how it's expected to work in any case.


