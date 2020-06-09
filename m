Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B288C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515920774
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOFv0ZgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFIPEi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIPEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 11:04:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155BC05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 08:04:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i27so14539535ljb.12
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g6Yjuagb+1onoI2lCv0mePlYyI3vyBXJuUsSjLEvhk0=;
        b=YOFv0ZgQG351GBIazquykdW/vgR+vc03YNVRyz7nuWCiavNygHT0Kw7C1C2hYAkgMg
         9woynqPTFtdT/+BRowHCi453wwlljWVj+lPwy9saoD45yomdOjEESSQLFh1C4faj2MAt
         9BSJtFmw/Yg9CAgsXI0/fBa3urvPjdDrufoSDpuY6FYz4zmhX/IcrXx3aP0tF2dXxns8
         s1IhIZtbdRkzYw/Wx9iZne8FLBSfqRUC0IwEWrrdvAwQIjTU1yCHxyLk23b0CZe7Vpht
         YNzIL+P3wA7/lgNnf9wNMlvnpI4M5pIsgUpxVm0Qnpyti+eYbB7lczjyEqUGSqV7ZW1G
         b/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6Yjuagb+1onoI2lCv0mePlYyI3vyBXJuUsSjLEvhk0=;
        b=dnAz7T2pHdZLCvK12dNGTODdlJgw0+54cbPx56rtNmjlB/CJ1SC6dhPF7RHOAF8e+S
         voVb9DZeWCi9RnKALSuPkrblNR/zOi7Ke0LcxopJj2YpceSgvpn05KXqlDNPMPXBBZJU
         kmuTyFUNU0+2gKYqMEnzO4DqkqImvqY6nGtEfHziAXCRu9aQHlNqmWn8zz+ar70G+A01
         jCPaF1OWaH19pr1vagk1sULqweKxAJaFUxYLfgzr0pyjcXuR9DwkFvMEfhSwX7xB3y3j
         kOaAC6RGexB5uSgAdNhl7W7XBl5nf+bFeTotCXqFcOkAmoYozTJwUZqMG+64SLvEp/DM
         sxmg==
X-Gm-Message-State: AOAM532KlVAU+6bXqneq4EZewDfECf/XtG7y1I9T53XK+DSJPApJIma2
        /X6SBUJcH/WY5nVOpngKtDUdJbJR
X-Google-Smtp-Source: ABdhPJxlOFLi6lupEqj7OL0N7jK7nP94wTGTOWBAlo51KBnt9I8KwtLZKkgAaW8VqWxsYxTpdyxUlA==
X-Received: by 2002:a2e:350a:: with SMTP id z10mr13632053ljz.104.1591715075020;
        Tue, 09 Jun 2020 08:04:35 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id b26sm5140321lfp.40.2020.06.09.08.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 08:04:34 -0700 (PDT)
Subject: Re: No window opening when running sandbox -S
To:     Cristian Ariza <cariza@collaborative.li>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
 <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
 <e99ea6cf-8970-057a-4dad-1d9c5d973ba1@collaborative.li>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <61832df5-4aba-dacd-644b-b8e8eead0fe9@gmail.com>
Date:   Tue, 9 Jun 2020 18:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e99ea6cf-8970-057a-4dad-1d9c5d973ba1@collaborative.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9.6.2020 17.05, Cristian Ariza wrote:
> I have been fiddling with a few alternatives for sandboxing apps but I 
> haven't really found anything that comes close. Probably the best I've 
> seen is firejail and its defaults are not too good (too permissive IMO). 

Please report Firejail issues on Github so they may get attention. 
Current (unreleased) Firejail also supports SELinux labeling, so 
existing SELinux rules apply even if the file system is heavily manipulated.

-Topi
