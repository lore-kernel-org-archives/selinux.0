Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2658C35254
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 19:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FAD20873
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJTAc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:00:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgBJTAb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 14:00:31 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1j1EIH-0002gE-3A; Mon, 10 Feb 2020 19:00:29 +0000
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <422e5db4-1b61-0048-b608-78881f5fa4b4@canonical.com>
Date:   Mon, 10 Feb 2020 11:00:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <37fa9076-6f15-0261-3bcf-1883236f9c3f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 10:32 AM, Casey Schaufler wrote:
> On 2/10/2020 6:55 AM, Stephen Smalley wrote:
>> On 2/10/20 8:25 AM, Stephen Smalley wrote:
>>> On 2/10/20 6:56 AM, Simon McVittie wrote:
>>>> On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
>>>>> The printable ASCII bit is based on what the dbus maintainer requested in
>>>>> previous discussions.
>>>>
>>>> I thought in previous discussions, we had come to the conclusion that
>>>> I can't assume it's 7-bit ASCII. (If I *can* assume that for this new
>>>> API, that's even better.)
>>>>
>>>> To be clear, when I say ASCII I mean a sequence of bytes != '\0' with
>>>> their high bit unset (x & 0x7f == x) and the obvious mapping to/from
>>>> Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F). Is
>>>> that the same thing you mean?
>>>
>>> I mean the subset of 7-bit ASCII that satisfies isprint() using the "C" locale.  That is already true for SELinux with the existing interfaces. I can't necessarily speak for the others.
>>
>> Looks like Smack labels are similarly restricted, per Documentation/admin-guide/LSM/Smack.rst.  So I guess the only one that is perhaps unclear is AppArmor, since its labels are typically derived from pathnames?  Can an AppArmor label returned via its getprocattr() hook be any legal pathname?
> 
> Because attr/context (and later, SO_PEERCONTEXT) are new interfaces
> there is no need to exactly duplicate what is in attr/current (later
> SO_PEERSEC). I already plan to omit the "mode" component of the
> AppArmor data in the AppArmor hook, as was discussed earlier. I would
> prefer ASCII, but if AppArmor needs bytestrings, that's what we'll
> have to do.
> 

sadly, to not break userspace its a byte string because that is what the path based profile names are. AppArmor does support a more limited non path based profile name but I can't guarantee that is what userspace is using in policy.


>>
>>>> I thought the conclusion we had come to in previous conversations was
>>>> that the LSM context is what GLib calls a "bytestring", the same as
>>>> filenames and environment variables - an opaque sequence of bytes != '\0',
>>>> with no further guarantees, and no specified encoding or mapping to/from
>>>> Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
>>>> but nobody knows which one, and they coould equally well be some binary
>>>> encoding with no Unicode meaning, as long as it avoids '\0').
>>>>
>>>> If I can safely assume that a new kernel <-> user-space API is constrained
>>>> to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friendly
>>>> APIs for user-space features built over it. If that isn't possible, the
>>>> next best thing is a "bytestring" like filenames, environment variables,
>>>> and most kernel <-> user-space strings in general.
>>>>
>>>>       smcv
>>>>
>>>
>>
> 

