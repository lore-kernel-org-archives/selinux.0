Return-Path: <SRS0=VSbf=73=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45398C433DF
	for <selinux@archiver.kernel.org>; Sun, 14 Jun 2020 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C72065C
	for <selinux@archiver.kernel.org>; Sun, 14 Jun 2020 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1TZHQNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgFNVaL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVaL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Jun 2020 17:30:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC6C03E97C
        for <selinux@vger.kernel.org>; Sun, 14 Jun 2020 14:30:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n24so16753517lji.10
        for <selinux@vger.kernel.org>; Sun, 14 Jun 2020 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jt/s63aiNvQj4gXJ++MAB5lkqbaUfHV1YO9IhfNGpFM=;
        b=R1TZHQNe2gqAKXZa4X4JJyOAo8rIJx0mYDdK8V9fMCAobikpYEJLmFocFLjwwZ8jAX
         gnZAjIRQUsY8JbZtmIf8RXB+jritT+kNmW7aQ+geNkc7IvX7smetfDYGvWuT6UX6NAFw
         2QqmSFpGLx6qzOgu6wrCbQM5KBcWVVbYYRj6FNtDzVedOq6pjcREVipahl1Grtcfrtla
         LxLbdGFBsejEOeY0CcTgWZn2mwr4L+TodcBrZGfxyEBnev2OS9I0mrz5ofFKWBg5lOX1
         R5zSttRTBHZ2ZMHDuPmJP2yroxSRhRJ2/fbMReD2UgBgcPQu/E7fQBaC64uaUfuL/b2m
         Oy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jt/s63aiNvQj4gXJ++MAB5lkqbaUfHV1YO9IhfNGpFM=;
        b=iOFuceq9cKbyNMgyQpo4ujEhMx9W+Vkpt5qSSoworpWpeiaR3Ha99M/goGhfHNr1Fb
         hW1WnHWNT27hE183BX6z1VY8cxz9EV68Qf6QGQaJ3gn7R19r1RTLgOrJYs7W4wee2L4U
         e554o8yp5UMwXc4LOq6DHarqD3SZ5p/hasjfv3Wu+m1q3+rkcmnBAgv+PANpzGlNoOW6
         +O1MOl9QwoNNj88eu8fIYSQqKq+uXweXo3oEM3Qq4Kv32QqTL6joIvDOeDt3elOo1dGG
         jfKhokVWbpaO3vBfUluCJppxwuvvY08aeLT5cKfSZZkyFxMFH/hMpHgUYvkfmozxzhWJ
         Mfsw==
X-Gm-Message-State: AOAM532eBNAoiNQp5pmj/dwKitkrDLuc5SKeSFyZLZzCBgXc/hyOKSXg
        dRELWKfN1TZU8jWhqK4Xqe1Qop+y
X-Google-Smtp-Source: ABdhPJy8oHdWgiiFayzF1/SuMuLRjVNtyi9vdVd9R4nDftTpr0hiFQbDeq4CfsVn/f1CkKGY7/fkqQ==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr10910692ljd.52.1592170208673;
        Sun, 14 Jun 2020 14:30:08 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id h26sm3461823lji.42.2020.06.14.14.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 14:30:08 -0700 (PDT)
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
Message-ID: <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
Date:   Mon, 15 Jun 2020 00:30:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12.6.2020 12.21, Topi Miettinen wrote:
> Perhaps instead this would work (I haven't tested it yet): don't use 
> netifs or nodes for anything (label everything with generic types 
> netif_t and node_t, which is actually the reference policy) but instead 
> use netlabel tools to label peers according to interfaces and IP 
> subnets.
The problem here is that flow outwards is not restricted by peer rules. 
The rules below don't prevent ping_t from sending packets to the local 
network, only from receiving the responses:

type localnet_peer_t;
allow ping_t localnet_peer_t:peer recv;

The peer was labeled like this:
# netlabelctl unlbl add interface:wlan0 address:10.0.0.0/8 
label:system_u:object_r:localnet_peer_t:s0

To stop sending, also nodes and/or netifs need to be used, for example:

type external_if_t, netif_type;
type localnet_node_t, node_type;

allow ping_t external_if_t:netif egress;
allow ping_t localnet_node_t:node sendto;

# semanage interface -a -t external_if_t -r s0 wlan0
# semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0

It would be most flexible if peers could be used to restrict outward 
flow too (since semanage interface & node are slow and require writable 
policy). Would this be possible?

-Topi
