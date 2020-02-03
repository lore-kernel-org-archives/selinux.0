Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B2C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23720720
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCUyZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:54:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCUyZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 15:54:25 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iyija-0002dK-3R; Mon, 03 Feb 2020 20:54:18 +0000
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Simon McVittie <smcv@collabora.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
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
 <20200127200558.GA1657845@horizon>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <ab595e41-a269-3c27-4d55-ead548755c2a@canonical.com>
Date:   Mon, 3 Feb 2020 12:54:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127200558.GA1657845@horizon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/20 12:05 PM, Simon McVittie wrote:
> On Fri, 24 Jan 2020 at 15:16:36 -0500, Stephen Smalley wrote:
>> Aside from the trailing newline and \0 issues, AppArmor also has a
>> whitespace-separated (mode) field that may or may not be present in the
>> contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".
> 
> My understanding from last time I worked with AppArmor is that this
> is genuinely part of the context, and whether it is present or absent
> does not vary according to the kernel API used to access contexts.
> AppArmor-specific higher-level APIs parse it into a label and an optional
> mode, but LSM-agnostic user-space APIs (like the one in dbus) pass the
> whole string through as-is.
> 
> (In practice it seems to be present if and only if the context is
> something other than "unconfined", although I don't know offhand whether
> that's an API guarantee.)
> 

Correct, currently it is always included unless the context is unconfined.
There is no guarantee that I am aware of beyond that is what the code
did in the past and so as to not break things we continue to do exactly
that.

The mode certainly does not need to be included in a newer interface.
