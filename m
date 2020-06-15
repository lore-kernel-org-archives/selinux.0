Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D867BC433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 22:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A996420739
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 22:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoJynTwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgFOWM5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFOWM4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 18:12:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FFC061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 15:12:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so2908272lfb.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XwPfzQY/fV3fBI+/q4ZmmDs4ClcUTiLV3A5DhjSsfkY=;
        b=qoJynTwlALCTaXypoVmQBz9LmbhSodatRWReieYMwXvfPXE5BDApk7x7KkROAo3Ush
         iaS+kkaaAC8DfalmaNEo6dvLHkWRA7iFy+O5CXA5MbR6pGER3cuGhFpLotxQEKgBGbdd
         Dbr852MLvRK9tAFQtke10OiCJlgsMNoaLa7vdXHL1A+OMpdUEj9WK1AzHEWYxGoJPuPx
         H9Hsr+Cfsp46NLwt9Iprps0IZ4bAQAZKl865zk+uJ/AKI1r7FbI6oaj0T/mADMmzIHIq
         xlJZB7Mrd0Q1FoqNUyjmdAQq801Tmbo6xZAhtz/P2rtumU2ZFE9yAAjCrPf3YOj+rWnx
         kKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XwPfzQY/fV3fBI+/q4ZmmDs4ClcUTiLV3A5DhjSsfkY=;
        b=mRf6vVRViWT7jZidvs86pDNHq+3N1m01V9axlqYpO1rtz2GbKeQeugA98Y3yS+AZKt
         0Ku2HF9J6/r+s3LSs2ImA06XEkx2GJniWJxBrC2i6woImdLO+ABqxc6qki24r253m43t
         K0F+ONMx+8Kf4TgHpsTlcgqL/GVNWKzf8EkpU7+tVppqqfly8aMoFBGa2fyO3QFMmpFJ
         aqvVx2/uXQjhTeGegG5TWIUowqAFHVIZUhNVmoqRaIrEB2xmjliOQki/Y3SVAqEK5EWi
         SrD0pUQ4/99XztTOmS7C52iIYj0Rl2knGePn9zqOKKJyb7Louj7uCD8Co8FRZW3ib7NB
         bJUg==
X-Gm-Message-State: AOAM533EhVazOzjm+OmpQ2xE/+j3V5iyn7gFTvym1ihbEz3PDpRPEZQW
        Zn5rfIB/x2qv3kIAluBsZKLCC1k5
X-Google-Smtp-Source: ABdhPJxtVOhowFjw38AAXFIJS7BMcIZew+2L/oK4Te18vzjlReeg0+qUxQRry8SGbhELT21OmxCroQ==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr49057lfd.83.1592259173506;
        Mon, 15 Jun 2020 15:12:53 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 26sm4016919ljp.22.2020.06.15.15.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:12:52 -0700 (PDT)
Subject: Re: Better management of dynamic networks?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
 <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
 <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
 <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com>
 <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
 <3640d302-434c-9ab0-d5c6-f566bb91ca62@gmail.com>
 <CAEjxPJ5tmn8fsd9xhkUKRogbWU6dQQccE5NH1h=Hv+-1nDKeAg@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <65a97bfd-bdea-e27b-c780-8cdb996d0f8a@gmail.com>
Date:   Tue, 16 Jun 2020 01:12:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5tmn8fsd9xhkUKRogbWU6dQQccE5NH1h=Hv+-1nDKeAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.6.2020 23.33, Stephen Smalley wrote:
> On Mon, Jun 15, 2020 at 4:26 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> On 15.6.2020 0.30, Topi Miettinen wrote:
>>> On 12.6.2020 12.21, Topi Miettinen wrote:
>>>> Perhaps instead this would work (I haven't tested it yet): don't use
>>>> netifs or nodes for anything (label everything with generic types
>>>> netif_t and node_t, which is actually the reference policy) but
>>>> instead use netlabel tools to label peers according to interfaces and
>>>> IP subnets.
>>> The problem here is that flow outwards is not restricted by peer rules.
>>> The rules below don't prevent ping_t from sending packets to the local
>>> network, only from receiving the responses:
>>>
>>> type localnet_peer_t;
>>> allow ping_t localnet_peer_t:peer recv;
>>>
>>> The peer was labeled like this:
>>> # netlabelctl unlbl add interface:wlan0 address:10.0.0.0/8
>>> label:system_u:object_r:localnet_peer_t:s0
>>>
>>> To stop sending, also nodes and/or netifs need to be used, for example:
>>>
>>> type external_if_t, netif_type;
>>> type localnet_node_t, node_type;
>>>
>>> allow ping_t external_if_t:netif egress;
>>> allow ping_t localnet_node_t:node sendto;
>>>
>>> # semanage interface -a -t external_if_t -r s0 wlan0
>>> # semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
>>>
>>> It would be most flexible if peers could be used to restrict outward
>>> flow too (since semanage interface & node are slow and require writable
>>> policy). Would this be possible?
>>
>> It would seem to need a small change around
>> security/selinux/hooks.c:5801 to add a check matching
>> security/selinux/hooks.c:5024 but with PEER__SEND (which does not exist,
>> so this would actually become a much bigger change). Would such a patch
>> be acceptable? How should compatibility to earlier versions be handled,
>> with policycaps maybe?
>>
>> This would let me use rules like
>>
>> allow ping_t localnet_peer_t:peer { recv send };
>>
>> without node or netif rules and netlabelctl could be used to manage
>> dynamic interfaces.
> 
> This seems more along the lines of what SECMARK is for, along with the
> PACKET__SEND check.

SECMARK gives the ability to limit sending packets to ports but if 
sending is allowed, all destinations are possible. Maybe the Netfilter 
rules could label packets differently based on the destination (or 
source) addresses, at the expense of N_packet_types * 
N_destination_classes rules but this would not be compatible with 
reference policy. Perhaps this could be optimized for simple cases, so 
that localhost ports use refpolicy labels and only the external access 
ports (which should be few) are renamed. I think PEER__SEND would be 
simpler.

-Topi
