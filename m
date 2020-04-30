Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C79C83001
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 06:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1CB214D8
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 06:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsbFJS41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgD3GS1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgD3GS1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 02:18:27 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D4EC035494
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 23:18:27 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id b17so1037828ooa.0
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=As0CUg3RkzwqWzvL3XCWtUu8/Q5Mwzvhaa0JICb2FTo=;
        b=hsbFJS41MVdhIm2lKjNBSo5SyRplcq4Ocqj72UEH/5qFW7IxO3KUsQMG0b11j5M/MK
         AW/eqWbLM2sGQspeato3xLtwnrrWozTP+/sB9DXiULgbvpDVSWReW+YzWpcMNM4Ui/5e
         tXHRfjsDUvna9rOfC0Sde0Xz+WP9Nxqn/bCYJJzREplPpj0uejZJkS+xJTm0o8mACgXQ
         rzS3b3YCbm98gxPQdR01YcK0T8m138nT2I/PpDhBM3wnKywnhcDXPnYy5d+piJycCfxt
         t8PCB75lhN87CsSbxZnHvTPykm5FGu+SHh5tysHX6tBUn89IN3TEBkwSIy8pgCm8aUxz
         W1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=As0CUg3RkzwqWzvL3XCWtUu8/Q5Mwzvhaa0JICb2FTo=;
        b=PS38hy2+Yobbfnu+Ugf+/vIgGUGnmHjhexHzFtLFK/Pkc/CpWdEUvIBubwgLw3gY5C
         3jT+f5kO56L2SxuNt2N5ZjAPsAUY2iwCJ8Xmkz6a88ID9qseKTl1IqjBZAqLwISdL9Oo
         4csOX1YQp54YIoBj5bERL1omU1BSYW29DDE7UEkl4HGkiRHTwayStcv3m/VPb987ijKi
         T4uY8yJWhtTTF1+TfGqBfAy83LTMr6WAsq/JN37pPt4vzA/u5wuZrm+NaRI5YkxxZeU5
         dDAhOyXVCPNMwEc7QRlNSjn7i9HbpisJ0tbavSux6J8R5FOAFrlN+HLc/8B9GKSsYzY3
         0HNg==
X-Gm-Message-State: AGi0PuakPKZngLiIxJRXdpvOCFISLtkufAszQDQ7FIJnRySnQZDmo8D1
        LwM/atoNTIs/T6yFQlWnzK10pWUx
X-Google-Smtp-Source: APiQypISkKHcP7k5L+kpbYEUeQ+NR0k1b7Qyi6ZN0CTIQASdxq/rbJ6g8OtzZGcTdzk/5I0XzgbHkA==
X-Received: by 2002:a4a:7346:: with SMTP id e6mr1477870oof.89.1588227506227;
        Wed, 29 Apr 2020 23:18:26 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id g13sm988555otk.62.2020.04.29.23.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 23:18:25 -0700 (PDT)
Subject: Re: Daemon cannot execute python
From:   Ian Pilcher <arequipeno@gmail.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
 <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com>
 <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
 <CAEjxPJ56Y1NM_4hsTLvVsxucWmmu9Ny22ao_gpR6Z1JBPxi5Hg@mail.gmail.com>
 <2f01b564-dc93-2aa5-8d77-455f30876876@gmail.com>
Message-ID: <b6943521-f46f-6a7f-00f2-efaea4c8d04b@gmail.com>
Date:   Thu, 30 Apr 2020 01:18:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2f01b564-dc93-2aa5-8d77-455f30876876@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/29/20 6:29 PM, Ian Pilcher wrote:
> On 4/29/20 3:04 PM, Stephen Smalley wrote:
>> On Wed, Apr 29, 2020 at 3:25 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>>> Slight update for posterity.  It looks like it's possible to use a
>>> symbolic link, so ...
>>
>> I don't see how that could work.  Symbolic link should be resolved and 
>> its
>> context only ever used to determine whether you could follow/read it.  
>> Not
>> for the execute check.
>>
> 
> I can't speak to how it works, but it does work on CentOS 7.8.  I
> suppose it's entirely possible that it would fail on a more up-to-date
> distribution.
> 

I was incorrect.  It doesn't work.

The service does start, but it's running as unconfined_service_t (which
makes even less sense to me).  So back to making an actual copy of the
interpreter.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
