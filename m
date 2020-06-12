Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70638C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431B52068E
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 09:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/bgW/3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLJVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJVY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 05:21:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE2C03E96F
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 02:21:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q19so10303208lji.2
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ud+CfTBhLf4bbyQIORJNDTtqKrpItoi7nSugEGXToc=;
        b=p/bgW/3xX6QpMARBQ7eO18jmCdoYilpHFdkODo31bT/6WwS+rljIvmxFNeGoJ3anwk
         GVdC4+FjwnaE5jLtEL0uwsDET62CjQTMq5GbPmRI1VZnl2rHi35EN1sQDS/2+sWnVTDZ
         8fO/Z/zRhdx4pjKvpqh2lnObrqXzgjikweLC1/opciQcDvn/JyUmn7AV2X6qg/SGLZYQ
         bdmDNJ+W29Zw3WjnX+FiiicDlGAK11v/XFbGJZtphJfDjpuwpJCPxrhEmtRq87OlzCJC
         R3OWHvq9QaLhvHEfV4Y2MAUlJs/c2CHkjyT5pOF3y4V44sy5rfQ9wDczLAi5XFN8z8aK
         rHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ud+CfTBhLf4bbyQIORJNDTtqKrpItoi7nSugEGXToc=;
        b=AS3tM4e+SA9g2E13o4Gw+ItzqSfF7+uHrzkFzlnJfWQoLRiDpbWF8wvalfrLI4LMsH
         f7qfDgz2O9dBHOK6dQp/6p5hD/jn2w15G8dQGR2lygYDt7XIxlIP2bw4Y0YBXzg0JV+4
         LXgTkzKhBfWJtkYpkeO5pyGLK+FLj1xQI6xI26s4JFZF6bQdj9Uzj5kwVEaTs4wWTnmz
         k0Nx+WlJif3JPvJCLAPrbJ/g/fWcxF0tYWBqPRC+SqgoFPcVeCfR6nUU5drrJl0Ru2h9
         E7879xfcn5V0smiWtxZ+3kwW8amK78XK7ZC6Kdf9EaXXo/0kUSJiIpADgpBYmAR6iJG9
         FmFw==
X-Gm-Message-State: AOAM532vaz2Iu91paktoIGknNK5yIfBTUkTaF4RwTXUie0nJXHLtmnSV
        7IwDi8/sLxTsGfRYJ94INT7rWpl2
X-Google-Smtp-Source: ABdhPJzQJXP7w2i7GgqidemhKCPIq8wbEptNC+UjiUMewqJ9QYp1AWleiUyaBPpn9FE92M2Ve5KRYw==
X-Received: by 2002:a2e:8e82:: with SMTP id z2mr6087734ljk.71.1591953680367;
        Fri, 12 Jun 2020 02:21:20 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id y1sm1438590lja.13.2020.06.12.02.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 02:21:19 -0700 (PDT)
Subject: Re: Better management of dynamic networks?
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
 <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
 <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com>
Date:   Fri, 12 Jun 2020 12:21:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12.6.2020 1.19, Paul Moore wrote:
> On Tue, Jun 9, 2020 at 10:05 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Tue, Jun 9, 2020 at 4:39 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>> On 9.6.2020 0.16, Paul Moore wrote:
>>>> I can't say I'm an expert on all the various userspace device
>>>> managers, network or otherwise, but so long as they can execute an
>>>> arbitrary command then one should be able to use them to label the
>>>> device when it is added to the system.  Although perhaps we could make
>>>> this easier with docs and/or tools.
>>>
>>> Perhaps this could be solved at least partially by adding a layer of
>>> indirection. So instead of directly assigning TE rules to interfaces,
>>> nodes and peers, the rules could apply to type attributes (or something
>>> else). Then the interfaces, nodes and peers would be tagged somehow with
>>> suitable attributes. Preferably tagging should be a faster operation
>>> than rebuilding the policy, but the operation should still be controlled
>>> by policy.
>>>
>>> So, instead of assigning for example localnet_node_t directly to subnets
>>> (which may have different levels of trust depending on the location)
>>> with commands (which rebuild the policy) like:
>>>
>>> semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
>>>
>>> there would be a static TE rule which states that networks with type
>>> (attribute?) 'trusted_localnet' get the label localnet_node_t. Then
>>> something else (what, how?) would assign the address ranges with the
>>> attributes when the network configuration (like interface up/down
>>> status, SSID, routing tables...) changes.
>>>
>>> Likewise, instead of direct assignment like
>>> semanage interface -a -t external_if_t -r s0 wlan0
>>>
>>> there would be static TE rules which state that only interfaces with
>>> type attributes 'company_approved_model', 'not_random_usb_device',
>>> 'company_authenticated_vpn' can get the label external_if_t. Then when
>>> new interfaces appear, something else (udevd? how?) would tag the
>>> interfaces with the attributes.
>>>
>>> Would this solve anything?
> 
> I'm still not entirely sure this really solves the problem, it just
> changes it slightly.  You would now need to worry about making sure
> you have the right types defined in the policy, and I'm not sure we
> can generalize the world's network configurations into a reasonable
> set of types.  Not to mention the problem of mapping the
> subnets/interfaces to those types.

Yes, probably the network rules can't be generic enough to cover every case.

>> The kernel doesn't label objects with attributes; it labels them with types.
>> Attributes are only used within rules (and originally they didn't even
>> exist in the kernel policy; they were entirely expanded by the policy
>> compilation process, first as a preprocessor stage and later directly
>> in checkpolicy/libsepol).

OK, let's forget this idea.

Perhaps instead this would work (I haven't tested it yet): don't use 
netifs or nodes for anything (label everything with generic types 
netif_t and node_t, which is actually the reference policy) but instead 
use netlabel tools to label peers according to interfaces and IP 
subnets. Then udevd etc. would invoke netlabel-config (or something 
similar) when network configuration changes. This would not require any 
changes to kernel, SELinux userspace except for netlabel tools, nor 
reference policy. The policy can be also read-only. Also, if it is 
determined that the IPSec etc. should be used in the local network, 
netlabel tools are needed to manage the case anyway.

-Topi
