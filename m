Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA61C433E0
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5397206BE
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 02:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWESkVoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgF2CR3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgF2CR3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Jun 2020 22:17:29 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF45C03E979
        for <selinux@vger.kernel.org>; Sun, 28 Jun 2020 19:17:28 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k6so9280861oij.11
        for <selinux@vger.kernel.org>; Sun, 28 Jun 2020 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zJruAIkWhCKqAP/dR/WFM62SNB0lGZgq8Qjb0D2pQgU=;
        b=sWESkVoaZhOf6J7zL4a8djSE0E8hz3U7k8uXVuMmqFYWf4JjYNF9qIr9O3GrXkYuQq
         DhOLX9MRF9cyRf3r3I13hD0J2wCwREIG5paaR5dc7gA6MUfe3mrhKGILcul3dQ7/huGa
         4I+dhDUsExqGh2BpvFH8n8oCRCk6DKFP6yn3KWokdKC5p9/kdyMjdRuw+8MJite7Czad
         Yio1RHDBxqeOglSzUOuejIzYmuMZcZgnN09SD/UsxB5rro10Y+F7k/G9OlZ4WfHlEdjR
         KSFGM/qC7D3vDEHU460jfSShXdRhlFf/52P54HKEPQrYRufCFuFujf4B3J2U741is+qj
         vOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zJruAIkWhCKqAP/dR/WFM62SNB0lGZgq8Qjb0D2pQgU=;
        b=UJn3q/DJ9jERITMU2xMT+NNEc7YnUQdhzniEPAF0y0qPSg70f25UVO3EvSsPpop0N6
         Nby0bFr1rZ+4y18a7r0v6hu8Sh05oJklP5v/aGNSYjUViLTpEL2w7+Jh3JqIX1FEwa8y
         eRCF/h0A4ar3AbKRycICebfpaRcY1/ESkirlyIWiQPyi3qBYUzHftuJ9iDhCBTTPOuL6
         H9G3tuln9GRdSU8rWuvkvPwEwMjU0iGqV+0+JAMkMEsD0CrxkEquqQ14RfuiVoeADunI
         NQAJIWkFm0icSPiHYSEVyFqixyyy0a+N+7Zcp6cgFVfnUkU4/GweePLRidvNabcbiFKy
         DXnw==
X-Gm-Message-State: AOAM530zVmaccgXTDtPG8ZpybRdBqnG3XQ+mxOYLQWjAV9cZ1vKKGKqQ
        DeYnTuvzp2veI54sqbfyJQLYOeKs
X-Google-Smtp-Source: ABdhPJzzkm6I99z+4rvCKR4VyuoQODjlPcQD9GsYq9dk3VcIIn0tqfHAUFYVfD2sh5QkW+96oYWojg==
X-Received: by 2002:aca:cdd6:: with SMTP id d205mr10604997oig.39.1593397047738;
        Sun, 28 Jun 2020 19:17:27 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id d11sm1064491oom.6.2020.06.28.19.17.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 19:17:27 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Daemon's child getting weird denial
Message-ID: <e6cec631-afb5-da5e-c12a-b8496cbeba3c@gmail.com>
Date:   Sun, 28 Jun 2020 21:17:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm in the (hopefully) final stages of creating the policy module for a
daemon that I've written to monitor my home NAS.

The daemon is started by systemd (init_t) and runs as its own type
(freecusd_t).  In order to read the SMART attributes of the NAS drives,
the daemon runs a helper application, which has its own type
(freecusd_smart_t).  So:

   systemd (init_t) --> freecusd (freecusd_t)
                            --> freecusd_smart_helper (freecusd_smart_t)

This is all working (although I can't help but think that there's likely
a macro that I could have used to define the helper type that would have
made things a lot easier).  Every time that the daemon starts, however,
I'm getting this denial repeated 4 times:

type=AVC msg=audit(1593392372.230:9215): avc:  denied  { sigchld } for 
pid=1 comm="systemd" scontext=system_u:system_r:freecusd_smart_t:s0 
tcontext=system_u:system_r:init_t:s0 tclass=process permissive=0

(Note that the daemon spawns the helper repeatedly while it runs, but I
only ever see the denial 4 times when the daemon first starts.)

It appears that the helper process is trying to send SIGCHLD, which
doesn't seem right, as its parent is still running.  (I've already given
the helper permission to send SIGCHLD to its parent, freecusd_t.)

Has anyone ever seen this behavior or have any idea what could cause it?

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
