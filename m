Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A06C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2C720720
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 22:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCWt1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:49:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWt1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 17:49:27 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iykWw-00023o-29; Mon, 03 Feb 2020 22:49:22 +0000
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <cfb7a1c1-0e74-d012-7e88-c3879ddbf696@canonical.com>
 <ad8c9dce-7078-a53f-ac8a-56f069d7290b@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <617a46a2-3b31-2fff-8761-5be4d2c237de@canonical.com>
Date:   Mon, 3 Feb 2020 14:49:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ad8c9dce-7078-a53f-ac8a-56f069d7290b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 1:43 PM, Casey Schaufler wrote:
> On 2/3/2020 1:02 PM, John Johansen wrote:
>> On 1/24/20 12:16 PM, Stephen Smalley wrote:
>>> ...
>>>
>>> Aside from the trailing newline and \0 issues, AppArmor also has a whitespace-separated (mode) field that may or may not be present in the contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".  Not sure what they want for the new interfaces.
>>>
>>
>> It is not needed for the new interface. And if I could go back and remove it from the old interface I would.
> 
> So, what would the "context" for this case be? "/usr/sbin/cupsd" or "enforce"?
> 

"/usr/sbin/cupsd"

"enforce" is the profile mode which can be looked up separately using "/usr/sbin/cupsd" if it is really needed.



