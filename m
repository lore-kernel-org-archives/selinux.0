Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D41C35254
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABC12085B
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBJS46 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:56:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJS45 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 13:56:57 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1j1EEk-0002Ki-UK; Mon, 10 Feb 2020 18:56:51 +0000
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Simon McVittie <smcv@collabora.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <418a9deb-fecc-4040-efb9-469bc8f4625a@canonical.com>
Date:   Mon, 10 Feb 2020 10:56:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 6:55 AM, Stephen Smalley wrote:
> On 2/10/20 8:25 AM, Stephen Smalley wrote:
>> On 2/10/20 6:56 AM, Simon McVittie wrote:
>>> On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
>>>> The printable ASCII bit is based on what the dbus maintainer requested in
>>>> previous discussions.
>>>
>>> I thought in previous discussions, we had come to the conclusion that
>>> I can't assume it's 7-bit ASCII. (If I *can* assume that for this new
>>> API, that's even better.)
>>>
>>> To be clear, when I say ASCII I mean a sequence of bytes != '\0' with
>>> their high bit unset (x & 0x7f == x) and the obvious mapping to/from
>>> Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F). Is
>>> that the same thing you mean?
>>
>> I mean the subset of 7-bit ASCII that satisfies isprint() using the "C" locale.  That is already true for SELinux with the existing interfaces. I can't necessarily speak for the others.
> 
> Looks like Smack labels are similarly restricted, per Documentation/admin-guide/LSM/Smack.rst.  So I guess the only one that is perhaps unclear is AppArmor, since its labels are typically derived from pathnames?  Can an AppArmor label returned via its getprocattr() hook be any legal pathname?
> 

yes sadly, as much as I would like to depracate/remove it the pathname based profile names are a byte string. AppArmor supports a more restricted profile name and I have been trying to get people to move to it for 12 years with only limited success.

>>> I thought the conclusion we had come to in previous conversations was
>>> that the LSM context is what GLib calls a "bytestring", the same as
>>> filenames and environment variables - an opaque sequence of bytes != '\0',
>>> with no further guarantees, and no specified encoding or mapping to/from
>>> Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
>>> but nobody knows which one, and they could equally well be some binary
>>> encoding with no Unicode meaning, as long as it avoids '\0').
>>>
>>> If I can safely assume that a new kernel <-> user-space API is constrained
>>> to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friendly
>>> APIs for user-space features built over it. If that isn't possible, the
>>> next best thing is a "bytestring" like filenames, environment variables,
>>> and most kernel <-> user-space strings in general.
>>>
>>>      smcv
>>>
>>
> 

