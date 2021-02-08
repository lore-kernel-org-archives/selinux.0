Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709AC433DB
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF2664EA1
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhBHThU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhBHTgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 14:36:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F024C061356
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 11:35:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q2so20173316edi.4
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiW/e273jQZXlxBn9N+qxX5d2Ibu85Qi15o7bQQ2pGI=;
        b=X+OprvyXrDpsFK0MvFlRDD2lEwNWEQS6cUtRbCDc/XAisPD07fTvL2PoQow+O9pdVy
         3mmbnSyLRu/Vm9uXAxuCVoCSPqOuLOxNnXx/dUHSP5NGWHzsPORkaEHeT4Bdd2FWsEOs
         n2aFCtEBJDRtAECuomq0M0+6Uh8ZuD77Bplb901SdBhaSBCjdSzmoGPMNKMU3qT/Uhii
         SoVQYdxUdBZtBkCc0YGwjvJcLQhrQNsXAoLHsMz0GagiD2eYkNBaielZquPJ4P9y//0V
         hmWSEun7V5U7SmizxAy4OOO91cBQkoWCrj0/4MSZTtg2cWthXwyVeOAOc/oNI0/bjjXJ
         Yenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiW/e273jQZXlxBn9N+qxX5d2Ibu85Qi15o7bQQ2pGI=;
        b=mAKYybAVfV7LSHfsdSKVBGoS4jaeO7kqoO3rnPYjUijqL/23Y70/abIOGORuIegav6
         J6V7xK8kReK3fIvexL5C3AbJxNUvbyYhxx+tIIDJX5RTjfGGv6ysDkZ3UjD659YplG3a
         WbqVAIM+4Rj+FCVFcLEKtSyEoDJJGHJxZKVeYHNCJque/gjVM8G0UR7LvWfuXLpR6qek
         Sg9ut8xyyxtfxUoPT7p2TrghI1miEY5Gn6ddVJ2BREW+Ak4Sarh2iBWOrAJDaF/GMXZR
         YtwhQN7f/R6GturrtSqLiavQHGUoyJK2xc1zJBVcFh5aPFNpBu9/iy5xZYnss9MlULmz
         EnXA==
X-Gm-Message-State: AOAM532+3NHbWWFi/qVYq3VkN9Ux39gVKVUWNnORiZNe50krCy01O7U/
        baIeupWrt7XVBQRE46T2YN+vrrRcDO4=
X-Google-Smtp-Source: ABdhPJwwCU2prAIpHzuv7oYk8sXEtefUa023gVNRL+0V4442xfi4HgWe6WXCb8xKVz2LCftaNwx98Q==
X-Received: by 2002:a50:e186:: with SMTP id k6mr13389116edl.215.1612812946433;
        Mon, 08 Feb 2021 11:35:46 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id hc40sm3434674ejc.50.2021.02.08.11.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:35:45 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
 <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com>
 <CAP+JOzQBiEHBS7TFAGpyJJ0+G3u2aGKpkDRTxH_PgU7pQrogVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] secilc/docs: add syntax highlighting for secil
Message-ID: <79fcad29-da9c-7084-c081-b5d4b529f04f@gmail.com>
Date:   Mon, 8 Feb 2021 20:35:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP+JOzQBiEHBS7TFAGpyJJ0+G3u2aGKpkDRTxH_PgU7pQrogVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/21 6:43 PM, James Carter wrote:
> On Sat, Feb 6, 2021 at 4:05 PM bauen1 <j2468h@googlemail.com> wrote:
>>
>> +    <list name="function">
>> +        <item>blockinherit</item>
>> +        <item>call</item>
>> +        <item>in</item>
>> +        <item>macro</item>
>> +    </list>
>> +
> 
> I am not sure it adds a lot to have these as separate colors.

I would at least like to have `macro`, `call` and `blockinherit` as separate colors, as these behave very differently from "normal" keywords / statements and more like function calls from a programming language.
They are usually also quite important when looking over policy so I think it's warranted.

I'm less sure about the arrangement of `in`, but due to its special interaction I've also included it.

> Also, when call is used as a permission, it is highlighted. It would
> be nice if that could be fixed.

I don't think this could be fixed easily, the same is also true if e.g. `allow` (a keyword) is used as permission, e.g.

 (allow t1 (file (call)))
 (allow t1 (file (allow)))

This is harder to fix as currently the syntax has no concept of what a "permission" is and I don't want to make things too complicated.

-- 
bauen1
https://dn42.bauen1.xyz/
