Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC4C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B212920759
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCYm8tnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOMrL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOMrL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 08:47:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E9C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 05:47:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g1so2091982ljk.7
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ocv90+jNXZFVllwLA6OeV9JESkdi3aIilc7iyT8YBis=;
        b=DCYm8tnZMB+UxgjRT8nx71TQT3UQLEvCXASIwJ138hc/8TYh4bE9+2ICVVgFkPA1m4
         XKRxZl8dmKF/t/PeYbsfoufom/sQyUglpYwBcLqWuEwFjrjxfWxrU5UfVPCKzkQSjG6w
         0A4oxCHvi8TbeLtMsoWNqwIm7xH1LT3fQy1O+c/RK/pRl1RIz3xcGwy5zNoZFzOoABNh
         //F59BxVtAAswzLKSof12Fat7fARn9M5iZ/CC+P+9AnjMwa+IZOKRozYuJw4w/5M+FC3
         BpxSJ2osmRuLEJPxn0O0equ6c0e4OJEa2SRI8+/av2Si2eDEUx+rrjBq0VNyOxe7zRCC
         xDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ocv90+jNXZFVllwLA6OeV9JESkdi3aIilc7iyT8YBis=;
        b=pgBLbrrj1tZhSmEwQ6yEJSyE+WHWbPnN8IP4aacOCEpaIT5moUDBklRxUaA8FgVYGH
         CBH+nZ4KwPO5T0oJvsn8qV65A07fnXcw+nEOhnEsvZRkxQ0mJjtyUT3NtR0+0Pb1bGC/
         Du/KmsWP2S7Ucj3te0EKNiiMRTkt2Vv/9b/J5KjihCE0pTrZ335mT2EpAZoCqnq0ixug
         FPo+rmwO7BRNDsrlY6d1pt9R++0O2D+l9FIPBgxreNCXqnmibpr/3JhoRjHPyh7cdcOu
         Px+YvyT+Zf8DTdAhwTcbg/S7ErcJ2WhCyaGTKDWJsKONYxrlc7xgzparzBTbTdjuioX3
         NrKw==
X-Gm-Message-State: AOAM5313ayMQ1cevjUfeu197N/xDSJsmcvyBTcCFFDCFDMYbJTXoOuSG
        mL7cLrYQanGkBIdrhJA0HKXdrFu0
X-Google-Smtp-Source: ABdhPJyfQJRItcMGZ9PO8jAkqstQD37wmS5Dj1AGGNzkcDniLOMsHX9BRnAZPVjo5bkB/gxryrf3RQ==
X-Received: by 2002:a2e:3204:: with SMTP id y4mr2319357ljy.85.1589546828673;
        Fri, 15 May 2020 05:47:08 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id f4sm1130596ljm.11.2020.05.15.05.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 05:47:08 -0700 (PDT)
Subject: Re: Wrong processes in AVC denials
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
 <CAJ2a_DfBE3Mwxg-GHa4OZf6aq6D0W-Q5QxnM88qa_ZCXUFXs0A@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <0611b014-a6ec-f151-1feb-e5c1f88a3a4d@gmail.com>
Date:   Fri, 15 May 2020 15:47:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DfBE3Mwxg-GHa4OZf6aq6D0W-Q5QxnM88qa_ZCXUFXs0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.5.2020 14.50, Christian Göttsche wrote:
> Hi,
> 
> for loopback labeling I use special rules, sot that the packet going
> into and coming out of the loopback device have different labels.

I'm relying on INPUT chain for labeling incoming packets and vice versa. 
Doesn't that work for loopback?

> 
> iif lo meta secmark set tcp dport map @secmapping_in

I think there's some limit for the size of NFT maps, so I was not able 
to use them for labeling all packet types known by the policy.

-Topi

> iif lo meta secmark set udp dport map @secmapping_in
> iif lo meta secmark set tcp sport map @secmapping_out
> iif lo meta secmark set udp sport map @secmapping_out
> 
> oif lo meta secmark set tcp dport map @secmapping_out
> oif lo meta secmark set udp dport map @secmapping_out
> oif lo meta secmark set tcp sport map @secmapping_in
> oif lo meta secmark set udp sport map @secmapping_in
> 
> The pid values in these audit messages are garbage values (and so the
> derived command).
> 
> Am Fr., 15. Mai 2020 um 13:11 Uhr schrieb Topi Miettinen <toiwoton@gmail.com>:
>>
>> Hi,
>>
>> After sending the previous message with 'git send-email', I noticed
>> strange AVC denials in the logs. The first entry is correct, but the
>> next have PID 0 and 16:
>>
>> time->Fri May 15 13:49:30 2020
>> type=PROCTITLE msg=audit(1589539770.992:1614):
>> proctitle=2F7573722F62696E2F7065726C002F7573722F6C69622F6769742D636F72652F6769742D73656E642D656D61696C002D2D736D74702D6465627567002D2D616E6E6F74617465002D2D746F0073656C696E757840766765722E6B65726E656C2E6F726700642F706F6C696379636F72657574696C732E6769742F303030312D73
>> type=SOCKADDR msg=audit(1589539770.992:1614):
>> saddr=020000197F0000010000000000000000
>> type=SYSCALL msg=audit(1589539770.992:1614): arch=c000003e syscall=42
>> success=no exit=-115 a0=7 a1=5a00209eba80 a2=10 a3=fffffffffffffa8b
>> items=0 ppid=10011 pid=10012 auid=1000 uid=1000 gid=1000 euid=1000
>> suid=1000 fsuid=1000 egid=1000 sgid=1000 fsgid=1000 tty=pts0 ses=1
>> comm="git-send-email" exe="/usr/bin/perl" subj=user_u:user_r:user_t:s0
>> key=(null)
>> type=AVC msg=audit(1589539770.992:1614): avc:  denied  { recv } for
>> pid=10012 comm="git-send-email" saddr=127.0.0.1 src=25 daddr=127.0.0.1
>> dest=45482 netif=lo scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet
>> permissive=0
>> ----
>> time->Fri May 15 13:49:32 2020
>> type=AVC msg=audit(1589539772.016:1615): avc:  denied  { recv } for
>> pid=16 comm="ksoftirqd/1" saddr=127.0.0.1 src=25 daddr=127.0.0.1
>> dest=45482 netif=lo scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet
>> permissive=0
>> ----
>> time->Fri May 15 13:49:38 2020
>> type=AVC msg=audit(1589539778.096:1617): avc:  denied  { recv } for
>> pid=0 comm="swapper/1" saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=45482
>> netif=lo scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet
>> permissive=0
>> ----
>>
>> Could it be a bug in kernel somewhere (AVC generated from wrong context)
>> or should this be expected? The version of kernel is 5.3.7 and Netfilter
>> NFT rules label all packets with SECMARK.
>>
>> -Topi

