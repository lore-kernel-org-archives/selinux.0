Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809FC4741F
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6272073A
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KlFZfn5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgKEOSw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgKEOSw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 09:18:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2EC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 06:18:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id i12so1156037qtj.0
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=URs199CiGMSfdY5ulOSyQXf/IoWxjp7/9l7rPi3eMAs=;
        b=KlFZfn5sifMMONpj+OenE+cnggd5i42MTYQQkbB0zchZdUAUFvh1XYBEZsQL8T5X8k
         3eFeNei4VTFXI7nfzeRpSVP+3X7y9MkUi+CdpJ5DYwLbALgYhwL0LSfZOKttJNeVFGEG
         cdRXwo8iac7C1XgwFj2pErm0tzjdgrsq0Ct6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URs199CiGMSfdY5ulOSyQXf/IoWxjp7/9l7rPi3eMAs=;
        b=QnyXhLJV51et04wyjH1sxuOem45tiLlEUIFdtW6sKBkD++8uZ43Sh9nq3YNTFSd+Hb
         g2cRpUq+vxmS6E9nHPnsFwYmEOwEWDBOBsdqhG/hlC+qAjcrIu5PCBDuIusEP1vBixIu
         4hdvL79iqEkPmXCNpEMF0wRIo3icA4GmtrHg17G4L8MjrTu/7WajL1VRI9pBDsumyApV
         B+uFGe5TUIQnYiVxumZUzG+MpRlC36vzXBG6Bul/7rd/V3nqwyIQL6b5ZXMEETW/hPuH
         C2WRcJBYt0CfnMAKqRlvfAvbtwV3q8tL0R2ExP2nmSWTryL5mcopCuiepafj+jFUitro
         MqYA==
X-Gm-Message-State: AOAM5327uh7p+Wf0sX/ih32lMLg/RsPFbsLtTiZZvXOnBqCWj8zp+Xlv
        wSYPc94hmXwdCEfAv9HRkqZpCEwAcufGlw==
X-Google-Smtp-Source: ABdhPJx/uUad4pzXCjszksYbblw4u6A2YTQmsRKp5SglqDCDMb9d4Rl+2TXqCzANNiiXsaQn18i0fw==
X-Received: by 2002:a05:622a:1cb:: with SMTP id t11mr2176272qtw.378.1604585930684;
        Thu, 05 Nov 2020 06:18:50 -0800 (PST)
Received: from fedora.pebenito.net (pool-96-234-173-17.bltmmd.fios.verizon.net. [96.234.173.17])
        by smtp.gmail.com with ESMTPSA id t70sm1055920qke.119.2020.11.05.06.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 06:18:50 -0800 (PST)
Subject: Re: Changes to Travis Usage
To:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <3373735e-595a-9c50-7d33-163e377fcbd0@ieee.org>
Date:   Thu, 5 Nov 2020 09:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/4/20 10:35 AM, William Roberts wrote:
> TL;DR
> Travis is limiting us to 1000mins of build and we should file for an
> opensource exception so we don't have to pay/throttled. We may want to
> consider migrating to Github Actions.

Looks like our build times average:

  * userspace: 70 build minutes
  * testsuite: 25 build minutes
  * refpolicy: 55 build minutes
  * setools: 18 build minutes

Lately the build times have increased, but I don't know how much of that is due 
overall slowdowns due to the abuse they're having.

The initial 1000 minutes of credit they're talking about won't take long to 
deplete, especially with PRs triggering builds possibly multiple times.  We 
could request a renewable amount according to that blog article.  If we can't 
get that, then it seems tedious to manually request credit allotments and we 
should evaluate new options.


> Travis is changing, as pointed out before:
>    - https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t
> 
> We had to migrate from .org to .com. Apparently, their usage and
> billing changes are about to occur, see:
> https://blog.travis-ci.com/2020-11-02-travis-ci-new-billing
> 
> Dockerhub[1] *was* doing the same thing with pulls, but just switched
> their stance back. I recently changed some of my projects from
> dockerhub to Github Container Registry and used Github Actions to
> build the containers. Github Actions should be a replacement to
> Travis, and includes Ubuntu 16-04, 18-04, 20-04, Windows and Mac[2]. I
> am not sure if it has KVM enabled.
> 
> 1. https://www.docker.com/blog/what-you-need-to-know-about-upcoming-docker-hub-rate-limiting/
> 2. https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on
> 


-- 
Chris PeBenito
