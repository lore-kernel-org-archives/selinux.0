Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A02C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE95420BED
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 23:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL1QGL7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD2X3U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2X3U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 19:29:20 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA414C03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 16:29:19 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id t12so851908oot.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5K9UcV8fq3x63m/Tu+mkoSgQ6vnV8YfwQOndSbF0mEc=;
        b=gL1QGL7NkElDkgqMSK8UeOqSPpgS9VpV3sC5hf4itVD3J+gNjsPFRtGZlgxY1DH4Qv
         xLZ2jD6vrVm0hwB18WY+pCX7kU18fOjoSSrHMkutnVxN1gPTCnUhiNhfe5u3F5JMKEp9
         de6labZsBuFW+rmcObdIhJXncukpZDg9yfOO9g4FJ9Sbn96W5r2VFQQ2JDUpIT5AEFex
         XSZv2H53KExnJL8ix+iX0n24TX+bU7P16pkHp6VEthsUDFM30NB3zLc8pRSoKcJSDnen
         fhwj5l/mb37WResv/hArjC3cyAWn7yMOePLSFwKaEpfKL+Ttm+azulWRo75pMdHrliDS
         nitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5K9UcV8fq3x63m/Tu+mkoSgQ6vnV8YfwQOndSbF0mEc=;
        b=P6DYUzjXcMqGWlJzvDic9roE+lx4k8Jt1Bbt2kVNqZtsuG8EH9ZRLqFH2iWgVacXq1
         VpRn2/CTUfcrzNk3afC1tzzLPnb+lGI9cmsdUPr5uwJ4fqoQCRqr0GjxB+ixwZZwj3zQ
         4gXYz+5K2pVgiZ9pqVK9uAPV/yd6J3/4PGus4jCqvFsw6l6wesN4kpUBvsaYt4neQm98
         VTMrcA6A3s+5Xy8a0NhuyW4ORxJkBQZ7HHJTpsBF4phLJLApMZNq8I2Vg7Yna0eCgHHj
         cgL+0UNLv2sowXAADKBigduyxBXmWLo4RrW3XmMAw/hrIUXGE2Yytp7IZvVAtPb4vcYA
         sG9w==
X-Gm-Message-State: AGi0PuYS/sW0u31yrXcfcGy9Q3ByUuf7A/1wNKz6L6gTNY2Hjh7hbt6o
        WHdF9xH7c003Cqm2oOfNrYMgx4BW
X-Google-Smtp-Source: APiQypIGYHCRlJyEiRZXsiwrc/E97+A49rgqCMN0mbi4FtYwaEYafP9sc5zCgDknLfjdVcpnFgYeBw==
X-Received: by 2002:a4a:a209:: with SMTP id m9mr455011ool.62.1588202958940;
        Wed, 29 Apr 2020 16:29:18 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id t20sm766791ott.51.2020.04.29.16.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 16:29:18 -0700 (PDT)
Subject: Re: Daemon cannot execute python
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
 <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com>
 <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
 <CAEjxPJ56Y1NM_4hsTLvVsxucWmmu9Ny22ao_gpR6Z1JBPxi5Hg@mail.gmail.com>
From:   Ian Pilcher <arequipeno@gmail.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Message-ID: <2f01b564-dc93-2aa5-8d77-455f30876876@gmail.com>
Date:   Wed, 29 Apr 2020 18:29:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ56Y1NM_4hsTLvVsxucWmmu9Ny22ao_gpR6Z1JBPxi5Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/29/20 3:04 PM, Stephen Smalley wrote:
> On Wed, Apr 29, 2020 at 3:25 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>> Slight update for posterity.  It looks like it's possible to use a
>> symbolic link, so ...
> 
> I don't see how that could work.  Symbolic link should be resolved and its
> context only ever used to determine whether you could follow/read it.  Not
> for the execute check.
> 

I can't speak to how it works, but it does work on CentOS 7.8.  I
suppose it's entirely possible that it would fail on a more up-to-date
distribution.

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
