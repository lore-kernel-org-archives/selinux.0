Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70869C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0F6205C9
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN3/Pupv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2TYu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TYt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 15:24:49 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14635C03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 12:24:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m13so2737222otf.6
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2NjmXRNJbDp4otReFkEiINv9yOkcobJeLYePKSZLMek=;
        b=nN3/Pupv5OqD9Te/33vpJRktX241CJXoxMGzQUzuVHySNT0sE0ZpqktxA77T98iMk8
         NEOgstJuEXRnWVQSSoyAoyBj2xQlKDLIr6xx0xW9ZwvgLe7KR8m+LYpEmlziMpz0hBjX
         VtWPzeIdS6K7xDpndZucxbGnGoaEKxnFpeZN1ExtNICyY7IrGHWj7+i0adBnk45XxPie
         qWoXt3Z9EK1k35/7WPwgRNwiNvCPo3UvPFXruHOkpMpdZnMoZuaBXHcnuDWIY/6HOxt+
         r3d8GgqcuLOw/iMaGFTNOy3rmvSUbOWQOa5liVDo4g9UfWEg4mqDuzl9oPOP1yKb1W7j
         05Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NjmXRNJbDp4otReFkEiINv9yOkcobJeLYePKSZLMek=;
        b=iPINXtjFzMfA0C+OecBU4Z8OhQEaddKiHAydqfO2rm4hHcddPJIEVs4lPwmVYVJuWc
         xltxqP5ZlWHZ207BMUIjxYBzbShLSCR1WNINfsMJriB2AJieIAljCTV525Y+pTMXWv23
         9g2V+nfI9kVkNyw+BIgsYInNf/g28idlsSiwRd71O2fR0WqZuu2Scf2U0t1qfHwUenw/
         BJ+mxZs4IqHbRIiuSQ1WqezRd3BimpR4VUE5MRkIJrQRSlCEdGAUZz2fZbSEXz5+Y2ym
         pDgp0X8ckBg+wrlM4YkUAl+op4hmSsiykILp5Dw42SF4qYO/72K3tKnuG+UloFsMj6iZ
         nFXw==
X-Gm-Message-State: AGi0Pub6KlAnr6/HN5DIdGncVCHgo8eV4SvSc6jNM3LhfuawHi59rcoX
        PFR5gKtPJJWeqj4PI0kL65YSJQGV
X-Google-Smtp-Source: APiQypLQoXQ4jfI0fuZIX0Qk3bIRTvRLPaaFtEwlZivlAIZGgOk/HggrJMR8LhAkYLeHJZH7bdehQw==
X-Received: by 2002:a05:6830:2328:: with SMTP id q8mr2654424otg.268.1588188288215;
        Wed, 29 Apr 2020 12:24:48 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id c24sm644620oov.48.2020.04.29.12.24.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 12:24:47 -0700 (PDT)
Subject: Re: Daemon cannot execute python
From:   Ian Pilcher <arequipeno@gmail.com>
To:     SElinux list <selinux@vger.kernel.org>
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
 <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com>
Message-ID: <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
Date:   Wed, 29 Apr 2020 14:24:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/29/20 1:02 PM, Ian Pilcher wrote:
> That would undoubtedly be painful!  For now, I've modified my systemd
> service file to make a copy of the Python executable with the required
> context, i.e.:
> 
>    [Service]
>    Type=simple
>    PrivateTmp=true
>    ExecStartPre=/usr/bin/cp /usr/bin/python2 /tmp/python.denatc
>    ExecStartPre=/usr/bin/chcon -t denatc_exec_t /tmp/python.denatc
>    ExecStart=/tmp/python.denatc /usr/local/bin/denatc -d
>    ExecStartPost=/usr/bin/rm /tmp/python.denatc

Slight update for posterity.  It looks like it's possible to use a
symbolic link, so ...

  [Service]
  Type=simple
  PrivateTmp=true
  ExecStartPre=/usr/bin/ln -s /usr/bin/python2 /tmp/python.denatc
  ExecStartPre=/usr/bin/chcon --reference=/usr/local/bin/denatc 
--no-dereference /tmp/python.denatc
  ExecStart=/tmp/python.denatc /usr/local/bin/denatc -d

(Deleting the copy of the interpreter seems to be racy, so it's
probably best to rely on systemd to delete the whole private temporary
directory.)

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
