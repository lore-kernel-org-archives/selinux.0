Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B09C433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DEB20714
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVlJDCaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgFOU0i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOU0h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 16:26:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA3C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 13:26:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n23so20769150ljh.7
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlStlxAv6kGGjyURrPiZjhHGaqnR2R2l6Q30AUljASA=;
        b=eVlJDCaCE+0fGxPu4GqFLBPpAMclBGvu0UvItAGZjy6Q75wxchptj2mnRUwFfc5M8y
         Osi2peEvCkWpFdu4B5TROXjQIrxLpcINIBdoVPh/TntDUwCXofPHAsTQ06HtRKg7DHF2
         AUhJ1BCZ160ufOIBbLMVFg+10Rmj+c8GlQylKUHx/I5qRPhKi5JqxLRqs51WWcqZ/NRz
         x3daj81F7Vb8kPX5+VhjYAa2qWAo0mL1hVNC6iCR8SuuoldCeku38sqog0kGewMjfzTg
         8aj86cjxxrrA/V2PGIHKo1ihE6nl2LdYR4Poke6lCJYsD4Qykc72vvTtxa4P9A5kCk7W
         lnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlStlxAv6kGGjyURrPiZjhHGaqnR2R2l6Q30AUljASA=;
        b=LzzycwgnOjCIua/dpaDRMIUGZeGPbz1sNopwNUvkKoRJWv+2MyqUoNRxeb/dACXRsA
         onYKYikLfQYtOzQC8ZMvVc2dBY7ExR3fbFtCNfrW8+5ncRpFfsCOQmpHZZ2R62Bl7qun
         uLk59RcXgrma1ysbQhS/yQPiew7S7M2Osx2ied3bHZshJ0SHY/y+z3lLW1PitdNFlbNs
         PTDvlsnUbYtPu61ZIUH43htomxj4ijLH9vVYF843c8b00zU6qaZUNqO0uJE9j8moVNO8
         mJQhG4Y4E3K8CUnudilPhpBNYPBL5ENK0ltVfSWVE7MyoIfRpeFOyJpXf1xa4iSUASlv
         K59g==
X-Gm-Message-State: AOAM532O60VSMr3aw0usnGS87SEC5FkLC5o4zGeLGHNUQNuiNEWK7KNm
        vyY8+wbOFdMw8V6TqhgY7z9lmg9G
X-Google-Smtp-Source: ABdhPJzUOmsP6GorK38iRmKB9C1dWNK7pSZY0u8nrO8T5mIucW6KZgsNpA3t3jBRVshkCQRbXiVkrw==
X-Received: by 2002:a2e:8250:: with SMTP id j16mr13528750ljh.140.1592252793582;
        Mon, 15 Jun 2020 13:26:33 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id r16sm4004882ljn.106.2020.06.15.13.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 13:26:32 -0700 (PDT)
Subject: Re: Better management of dynamic networks?
From:   Topi Miettinen <toiwoton@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
 <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
 <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
 <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com>
 <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
Message-ID: <3640d302-434c-9ab0-d5c6-f566bb91ca62@gmail.com>
Date:   Mon, 15 Jun 2020 23:26:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.6.2020 0.30, Topi Miettinen wrote:
> On 12.6.2020 12.21, Topi Miettinen wrote:
>> Perhaps instead this would work (I haven't tested it yet): don't use 
>> netifs or nodes for anything (label everything with generic types 
>> netif_t and node_t, which is actually the reference policy) but 
>> instead use netlabel tools to label peers according to interfaces and 
>> IP subnets.
> The problem here is that flow outwards is not restricted by peer rules. 
> The rules below don't prevent ping_t from sending packets to the local 
> network, only from receiving the responses:
> 
> type localnet_peer_t;
> allow ping_t localnet_peer_t:peer recv;
> 
> The peer was labeled like this:
> # netlabelctl unlbl add interface:wlan0 address:10.0.0.0/8 
> label:system_u:object_r:localnet_peer_t:s0
> 
> To stop sending, also nodes and/or netifs need to be used, for example:
> 
> type external_if_t, netif_type;
> type localnet_node_t, node_type;
> 
> allow ping_t external_if_t:netif egress;
> allow ping_t localnet_node_t:node sendto;
> 
> # semanage interface -a -t external_if_t -r s0 wlan0
> # semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
> 
> It would be most flexible if peers could be used to restrict outward 
> flow too (since semanage interface & node are slow and require writable 
> policy). Would this be possible?

It would seem to need a small change around 
security/selinux/hooks.c:5801 to add a check matching 
security/selinux/hooks.c:5024 but with PEER__SEND (which does not exist, 
so this would actually become a much bigger change). Would such a patch 
be acceptable? How should compatibility to earlier versions be handled, 
with policycaps maybe?

This would let me use rules like

allow ping_t localnet_peer_t:peer { recv send };

without node or netif rules and netlabelctl could be used to manage 
dynamic interfaces.

-Topi
