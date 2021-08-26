Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C52C4320A
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FC560551
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbhHZLd4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234382AbhHZLdz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629977588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mz356938IR4rW5sXJhiayALMXMcBwIGvM/TDEbUhy24=;
        b=R18KQuvAIMVt7T1es7aqEgVVj2ZDt0fvsMUeCMLkk6PxcC6NT/iHCaCFR2qcaF1G7WF2WR
        a39gqeLk+aIl9jrpEWevqVsBjCWaAJ2rCHFQ6okTlvOC5hUnps6YDOCri4jKsG8utOfo83
        UMaM0h+qj1jph04+xJempJmp8b79bYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-JwE1RpUAPOya2fQKXXBKAQ-1; Thu, 26 Aug 2021 07:33:06 -0400
X-MC-Unique: JwE1RpUAPOya2fQKXXBKAQ-1
Received: by mail-wm1-f69.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso2892221wmx.0
        for <selinux@vger.kernel.org>; Thu, 26 Aug 2021 04:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=mz356938IR4rW5sXJhiayALMXMcBwIGvM/TDEbUhy24=;
        b=cGBtZcythX54k35gEj+WLN2hrk9aYlVxHibwO5VsE1q4yKvpGNi54vxNjmk/ITOzzx
         NOUHw+u9ATbJM97Mh9nhNX6iVY//I3/J16fTlMIzAvJSaNfuM70cSMEX+u/DY5mG5jd7
         ui9jkNaACd+pe43tO7oGRcjL3l5a+kVCrIahuHGli3wiBeQ1PmLRozrlzA6gK5NZb2lR
         QmUZNFDJ0xtO5y2Ln/CtheszwSGmL5cozSzZKwFw/Pvl6EJReq0c+8P1YY8f9RK0cpa7
         wS0U2ZLinpq6/DDh0WkVmZYZV6KoS7GMPd7ledMdnbHt5pvUnkbLqW4KI0jQFYypbmCq
         jg6Q==
X-Gm-Message-State: AOAM5333oFHxVxs8NBmFDMxAYyv4tJWM4DWSnj7CBM1mz5oKRL7prfeM
        R2vjK3jhlQIQNAmkEHC2TBry03/+ekVRL3xxsK0bqXB8HZTT/2puHl8vqYH/tGrTqeCyFbcZILa
        mq4z5X4OMPntUpJI77g==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr3462528wrt.413.1629977585028;
        Thu, 26 Aug 2021 04:33:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9ZDAU3Q+itesaDjk1URw4IokwD+Tp9yNFTs5k46NEuJFEZSC3tSfqnIXFAG24UP2If9pHdA==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr3462513wrt.413.1629977584882;
        Thu, 26 Aug 2021 04:33:04 -0700 (PDT)
Received: from [192.168.0.108] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id j17sm2793591wrh.67.2021.08.26.04.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 04:33:04 -0700 (PDT)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Lukas Vrabec <lvrabec@redhat.com>
Subject: Cil block inheritance
Message-ID: <81ea2624-ace9-4d86-9506-d6527a770cf6@redhat.com>
Date:   Thu, 26 Aug 2021 13:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,
recent changes in block inheritance broke our use case where we use 
block inheritance for generating container policies 
(https://github.com/containers/udica/tree/main/udica/templates). 
Basically the policy is composed by inheriting selected "template" 
blocks, all of which inherit "container" block, so that they can use 
types defined there.

Reproducer:
(block template1 (type t) )
(block template2 (blockinherit template1))
(block b (blockinherit template1) (blockinherit template2))

#semodule -i test.cil
Re-declaration of type t
Previous declaration of type at 
/var/lib/selinux/targeted/tmp/modules/400/test/cil:1
Failed to copy block contents into blockinherit
Failed to resolve AST
semodule: Failed!

This used to work just fine.

The following workaround seems to be working as intended, but I'm not 
sure if it's the best approach. Types are only defined in template1 and 
the rest contains "optional" block, so that I can use types defined in 
template1).

(block template1 (type t))
(block template2
      (optional o
          (allow t t ( file ( read )))
      )
)
(block b (blockinherit template1) (blockinherit template2))

#semodule -i test.cil
#sesearch -A -s b.t
allow b.t b.t:file read;

Any pointers would be appreciated.

Thank you.

Vit

