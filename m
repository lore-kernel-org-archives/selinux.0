Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE454C433E3
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DF32075E
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSEjgZ+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHSMGi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgHSMG3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:06:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12EBC061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:06:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h21so17503390qtp.11
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZLhunzEAegEfP02vvSv3TwXRKTpQiTMzMYXghy/imdQ=;
        b=KSEjgZ+9Pz4hdPMl8mxOcIE+n15W+R94A2Eqm12Uqn7wEVTOGGNkcquyyecWp7oIno
         hSZ14TWKm99NYJ2WXxdx7IHqVPU49BvWqWNKrHoJroxDReLp/bWHyWm7P2XLuMZWmZYn
         qVmtC9iJezwknjxciCnXayhzUh4gHtVd1wYj57GxotvS+3+hp3BgJv9CUk10WTng4GrX
         hhWHbpc2zNPxcLsCAjkBIU86aySxMNYx1Wvv/hI7MZEJTjRnljAugbRkSv+Jk1sUO0jW
         SU+LtyE6Q3jckDSfnb4xTGO5OoxCjNtGvOtg0jAgW+P0vbc4J9EcA3rd1D6EIOyJULO/
         Vmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZLhunzEAegEfP02vvSv3TwXRKTpQiTMzMYXghy/imdQ=;
        b=W6SIrhqXqoUzxRKDiUPh6lQ2QRQbkk+vWTtfa6fyKC+BlEYNpcOihNhKia/wcnOI/j
         5Lq6W8W2itXYIpK2VzwwKsUB8U0E3HsviPQ0SaEyXbo3VMcDgzwoplXw7nAg/1u28c5O
         sQ8bYPOfst5HUo+r70mrZPNSkE+sz8ODdiTEPyoJRp+4QuPZouAbBDbFN7TBzNK/LcgE
         LnmJAMRV5htvYn21LZqThaXcgsujmi+FDqGDUql2LGk8K10EE5DdCK+0gQ1sFgzCnKmh
         uFaIDoNsgaJY7iuR11TsoBhr/Oq/H9DTFcG7KJnlK0EagPmVn3IN608nI7m5pBImVqgP
         zsPg==
X-Gm-Message-State: AOAM5306Go7SVQTJy9kVFdiyNdAhEt40qcfzwYMJRFuDlGm2ejLlIAoo
        YusJo9LK/EfB5DQzQNLb7gNQmJymRnc=
X-Google-Smtp-Source: ABdhPJwfrSX8idiVvjuH+yBPLDD5mYpW080wIHYxjFVEyPOKiO2UaKiXrk2xE/f8oPAgzN5TPCWmKA==
X-Received: by 2002:ac8:65cd:: with SMTP id t13mr22954895qto.368.1597838787123;
        Wed, 19 Aug 2020 05:06:27 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id d143sm23346026qkc.59.2020.08.19.05.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:06:26 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     peter enderborg <peter.enderborg@sony.com>, paul@paul-moore.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <7fe5f8e9-1fd9-2a65-4117-5b0d35c3973e@gmail.com>
Date:   Wed, 19 Aug 2020 08:06:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 4:32 AM, peter enderborg wrote:

>  From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
> From: Peter Enderborg <peter.enderborg@sony.com>
> Date: Wed, 19 Aug 2020 10:20:28 +0200
> Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
>
> This patch adds call_rcu that moves sycronize out
> out call path. In the callback we can no call
> cond_resched so they have to be remvoed.

If you look at the first version of my patch, I used call_rcu() but in a 
manner that avoided the need to remove cond_resched() or kvfree() calls 
from the freeing code by having the rcu callback just schedule_work() to 
free it later.  That follows the pattern used for freeing user 
namespaces, for example.  However, in re-reading the RCU documentation, 
my understanding is that one should use synchronize_rcu() followed by 
direct freeing whenever possible and this is possible from both the 
policy load and setting booleans.  Neither of them are very frequent 
operations nor so performance-critical that the cost of 
synchronize_rcu() would be considered unacceptable IMHO.  Thus, I don't 
believe we need to do this.


