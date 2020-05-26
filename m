Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F10C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCC320787
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 09:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHLFLLeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgEZJIv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 05:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgEZJIv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 05:08:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD5C03E97E;
        Tue, 26 May 2020 02:08:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so691066wmn.1;
        Tue, 26 May 2020 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=D9wfhCD13viX76m43SED+Jj6BeIdQ6QwBRVJn5ceVDk=;
        b=eHLFLLeF6LA8ioOE6mAOdFGFzSHCMFsv7X3H0JBkkI+wR+F140cZ4YZKeZRCGPOY5Z
         mEV03n2nYK1Df3A4NHPSSnwgG+hEvACSQkNhUqpg2hgOSOTJmzRLcsRuT4yvIGhCVdmU
         fp2aDTK1YrV0p8GVhZDkW5UqEdAL+2Pb6n+1Xtb51jhVfOfZGg1Hvn8Y7SjoEKxS0vAF
         UhbFa26bX1/llMcSZDrOiJ94gF/Tf7KGF5vwZ68bNi9oumZJcBGoBOeyqVPCh8Hr7GNs
         36x6M7er+HoZMweI/hfnz6nszsjUvu35bKHeRgId/U/FkGDmomxNJOeH0C6HxAW1LZlu
         PD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D9wfhCD13viX76m43SED+Jj6BeIdQ6QwBRVJn5ceVDk=;
        b=MvcxssyoS1GlcKbrDz/+51QTesURg9irm7Eb/k3sL1Qiyxy3K5zp19maV+PoV4m3sl
         Paq/Ou2QxXBa1HPtBqxZ8QQnLDtjxIHI0uxzGg5qF7f6hXoQJQplnwWZBHesHMMRL10y
         xR2+cUkgh7vL26/GWKNb++M9UcPPANwzkk86nA+7N1YVxwcLjI2UhBxNtREhNdi87FLE
         W+jmOYz8+IeJ7WXM62VRBGfgWnlU/Kp/cGvCYeeS8lf3HwqhlvknSBCreJXiCfYX9fP2
         38wZ28zr1xa5uRYLdDR4tT8bslakRQo0i1WhOfMQz0qPLVEZyBkbAtBZ0HVjjwpQFALZ
         VfvA==
X-Gm-Message-State: AOAM532Myz11dY9uco5M+6qD3NRASti+nBTFC6WGH2HFJO6/fczrQhL1
        dZgxJT+Ml9c3/U62aQ4bxZ8=
X-Google-Smtp-Source: ABdhPJyQagEWrqlFAtpxcHsU8JrmYjmMriWqc2P4j2/epVFNiQq+AIPx9zdirJi+3hgc3xmfYK5HWA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr306052wma.96.1590484129590;
        Tue, 26 May 2020 02:08:49 -0700 (PDT)
Received: from [192.168.196.177] (gw-eduroam.dar.cam.ac.uk. [131.111.194.10])
        by smtp.gmail.com with ESMTPSA id u23sm21889146wmu.20.2020.05.26.02.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 02:08:48 -0700 (PDT)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Jann Horn <jannh@google.com>, Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
References: <20200522055350.806609-1-areber@redhat.com>
 <CAG48ez3rh2a3PYRRkcu50LU9qPCaeOE8BJL=AmTwDD3qcA+xFA@mail.gmail.com>
From:   Radostin Stoyanov <rstoyanov1@gmail.com>
Message-ID: <dad30f72-7db0-062f-d9ae-e813176ba7d2@gmail.com>
Date:   Tue, 26 May 2020 10:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3rh2a3PYRRkcu50LU9qPCaeOE8BJL=AmTwDD3qcA+xFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 25/05/2020 22:53, Jann Horn wrote:
> On Fri, May 22, 2020 at 7:55 AM Adrian Reber <areber@redhat.com> wrote:
>> This enables CRIU to checkpoint and restore a process as non-root.
>>
>> Over the last years CRIU upstream has been asked a couple of time if it
>> is possible to checkpoint and restore a process as non-root. The answer
>> usually was: 'almost'.
>>
>> The main blocker to restore a process was that selecting the PID of the
>> restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.
> And if you were restoring the process into your own PID namespace, so
> that you actually have a guarantee that this isn't going to blow up in
> your face because one of your PIDs is allocated for a different
> process, this part of the problem could be simplified.
>
> I don't get why your users are fine with a "oh it kinda works 99% of
> the time but sometimes it randomly doesn't and then you have to go
> reboot or whatever" model.
Transparent checkpoint and restore of a process tree is not simple, 
especially when it is done entirely in user-space. To best of my 
knowledge, CRIU is the only tool out there that is able to achieve this, 
it is actively being tested and maintained, and it has been integrated 
into several container runtimes. Like any other software, CRIU has 
limitations but, as said in the README file, contributions are welcome.
