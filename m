Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59AFC35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E891206D7
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgBKTMJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:12:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57399 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgBKTMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 14:12:08 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1j1ax0-0000Pg-JT; Tue, 11 Feb 2020 19:12:02 +0000
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
 <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
 <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
 <37fa9076-6f15-0261-3bcf-1883236f9c3f@schaufler-ca.com>
 <422e5db4-1b61-0048-b608-78881f5fa4b4@canonical.com>
 <af6b224c-4a32-40fa-77ae-1e2a5580054f@tycho.nsa.gov>
 <d3dfd552-cab1-f50e-f207-b6308d0d5990@canonical.com>
 <397af078-a44b-6fcd-e125-8fdb0b441097@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <3082a7ec-9c09-d5a3-c83f-0afec8595afe@canonical.com>
Date:   Tue, 11 Feb 2020 11:11:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <397af078-a44b-6fcd-e125-8fdb0b441097@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 10:35 AM, Casey Schaufler wrote:
> On 2/11/2020 9:58 AM, John Johansen wrote:
>> On 2/11/20 7:59 AM, Stephen Smalley wrote:
>>> On 2/10/20 2:00 PM, John Johansen wrote:
>>>> On 2/10/20 10:32 AM, Casey Schaufler wrote:
>>>>> Because attr/context (and later, SO_PEERCONTEXT) are new interfaces
>>>>> there is no need to exactly duplicate what is in attr/current (later
>>>>> SO_PEERSEC). I already plan to omit the "mode" component of the
>>>>> AppArmor data in the AppArmor hook, as was discussed earlier. I would
>>>>> prefer ASCII, but if AppArmor needs bytestrings, that's what we'll
>>>>> have to do.
>>>>>
>>>>
>>>> sadly, to not break userspace its a byte string because that is what the path based profile names are. AppArmor does support a more limited non path based profile name but I can't guarantee that is what userspace is using in policy.
>>>
>>> Ok, so /proc/pid/attr/context and SO_PEERCONTEXT have to be defined as returning bytestrings.
>>>
>>> So far we've talked about having AppArmor drop the trailing newline, be consistent with regard to whether the terminating NUL is included or excluded, and drop the mode field from what it returns for /proc/pid/attr/context and SO_PEERCONTEXT versus the current /proc/pid/attr/current and SO_PEERSEC.  Is that correct?
>>>
>>> How do we envision a liblsm processing the value returned from /proc/pid/attr/context or SO_PEEERCONTEXT?
> 
> There hasn't been any serious thought put into liblsm. To date
> there hasn't been an LSM level interface to worry about except
> for /sys/kernel/security/lsm. My notions of what a liblsm ought
> provide would seem archaic to most of the people here. I can make
> proposals if there's a notion that liblsm makes sense.
> 
> 
>>> It can certainly split it up per LSM.  But can it then take the apparmor portion of the context and pass that to existing libapparmor interfaces without breakage?  Or will the changes to the format described above create issues there?
>>>
>>>
>> libapparmor can handle the changes. It does not require the mode string, currently anything unconfined does not include it, and we have already done experiments with dropping it in other cases. The trailing '\n' is handled conditionally so only if its there; this is well tested as the currently out of upstream af_unix socket mediation that is used by dbus does not include a trailing '\n' on the SO_PEERSEC.
> 
> So it doesn't seem that there would be significant difficulties
> switching from "current" to "context". It won't be transparent,
> but we're providing "display" to address that.
> 
> 
right

