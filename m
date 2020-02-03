Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1160C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C00A20CC7
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBCU7r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:59:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54479 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCU7r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 15:59:47 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iyioq-0002tg-1V; Mon, 03 Feb 2020 20:59:44 +0000
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <e6e2f466-5553-b3ad-7856-f422713dfb21@canonical.com>
Date:   Mon, 3 Feb 2020 12:59:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 11:28 AM, Casey Schaufler wrote:
> On 1/24/2020 8:20 AM, Stephen Smalley wrote:
>> On 1/24/20 9:42 AM, Stephen Smalley wrote:
>>> On 1/23/20 7:23 PM, Casey Schaufler wrote:
>>>> Add an entry /proc/.../attr/context which displays the full
>>>> process security "context" in compound format:'
>>>>           lsm1\0value\0lsm2\0value\0...
>>>> This entry is not writable.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> Cc: linux-api@vger.kernel.org
>>>
>>> As previously discussed, there are issues with AppArmor's implementation of getprocattr() particularly around the trailing newline that dbus-daemon and perhaps others would like to see go away in any new interface.  Hence, I don't think we should implement this new API using the existing getprocattr() hook lest it also be locked into the current behavior forever.
>>
>> Also, it would be good if whatever hook is introduced to support /proc/pid/attr/context could also be leveraged by the SO_PEERCONTEXT implementation in the future so that we are guaranteed a consistent result between the two interfaces, unlike the current situation for /proc/self/attr/current versus SO_PEERSEC.
> 
> I don't believe that a new hook is necessary, and that introducing one
> just to deal with a '\n' would be pedantic. We really have two rational
> options. AppArmor could drop the '\n' from their "context". Or, we can
> simply document that the /proc/pid/attr/context interface will trim any
> trailing whitespace. I understand that this would be a break from the
> notion that the LSM infrastructure does not constrain what a module uses
> for its own data. On the other hand, we have been saying that "context"s
> are strings, and ignoring trailing whitespace is usual behavior for
> strings.
> 
> 

AppArmor can drop the trailing '\n' it is not required. I would say it
could be dropped from /proc/pid/attr/current except there may be some
third party code that requires it.

