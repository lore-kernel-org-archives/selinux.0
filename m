Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072ECC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE95220758
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h35ths/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgEOLLP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgEOLLP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:11:15 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94720C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:11:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j3so1783451ljg.8
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lwpXRihyMhXM9skzEXARTeCiv3oQYEBf1ZwqeTyutHs=;
        b=h35ths/YbQ6ymR54kXFPvw/lXwjbGtG8nlzbLM2sSbjaiV9Hq3GO1dyotqkhFcs2YV
         O0clBNqHkC/bFN6El4JZynATH+8kAEN2UU3BI+fEaOThhzUv53axnFFx9FmEY0nd6bRp
         wYY22oYoIUe5LrCBzyor+WHLxH+Ek05PmczpNPxGdXzinJxpDPAcZPNx5ZH+Y0+3hrJf
         Siu8nNn/7AxXX7wHrRUEHZB4+HpSPXP9J5q7GJZ2ITuV3bi5W0woFGc5P6A9JoVb8MeW
         K4nH760hQoVjCcrLxYyiAxqhXyntpZ3wC8s+LngUS2UhqYzFUCE2xfT5hXikeon97rEy
         X6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lwpXRihyMhXM9skzEXARTeCiv3oQYEBf1ZwqeTyutHs=;
        b=kfr4n0V5Byun7NCO12ja6JrLT+jyB4yKa5CUnlCNvwXNq/grFVfFYATJuxsKjAuYK1
         Y7/hHgxoUUfMMWrlSQsIn6BP2PY9zaLFLX8sPrW+mrFe0zT6auGabdkEvWimvKlbiPBD
         ihBkHM94Zq+4esCbEQUHvUbYBTuosR0BFwWy1eM0kzND5PEx8VJtcgaMzqEx0NgwLlrd
         Z8qupDH0nIoZRah4+3XLvqojkyloS0cNBKriQT44+hg5VrB4jcdGMj3AvTsW8vPPZtt3
         im6FO1w6DgM/TVMC0H7G4g/Gz4VeL6NjXCWnF7iEkFQ5aS9AwWNEueIk1LypkJESUpXT
         ekZA==
X-Gm-Message-State: AOAM531yQfCYWHc6iyr5psr/FtPsVNVvPOQh/2d5fPG7fWkekOitA+Nh
        I4cosqN/+6dAeI6Ild88ZS8eLX7C
X-Google-Smtp-Source: ABdhPJyn2IQUyhbGr0PPkG9WK8/lL+nxec+daejw4idAW2kbe8EbiAee7If9pkMgpwWMieFYQCoQ2A==
X-Received: by 2002:a05:651c:119a:: with SMTP id w26mr1967844ljo.53.1589541072000;
        Fri, 15 May 2020 04:11:12 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i124sm988808lji.95.2020.05.15.04.11.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 04:11:11 -0700 (PDT)
To:     selinux@vger.kernel.org
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Wrong processes in AVC denials
Message-ID: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
Date:   Fri, 15 May 2020 14:11:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

After sending the previous message with 'git send-email', I noticed 
strange AVC denials in the logs. The first entry is correct, but the 
next have PID 0 and 16:

time->Fri May 15 13:49:30 2020
type=PROCTITLE msg=audit(1589539770.992:1614): 
proctitle=2F7573722F62696E2F7065726C002F7573722F6C69622F6769742D636F72652F6769742D73656E642D656D61696C002D2D736D74702D6465627567002D2D616E6E6F74617465002D2D746F0073656C696E757840766765722E6B65726E656C2E6F726700642F706F6C696379636F72657574696C732E6769742F303030312D73
type=SOCKADDR msg=audit(1589539770.992:1614): 
saddr=020000197F0000010000000000000000
type=SYSCALL msg=audit(1589539770.992:1614): arch=c000003e syscall=42 
success=no exit=-115 a0=7 a1=5a00209eba80 a2=10 a3=fffffffffffffa8b 
items=0 ppid=10011 pid=10012 auid=1000 uid=1000 gid=1000 euid=1000 
suid=1000 fsuid=1000 egid=1000 sgid=1000 fsgid=1000 tty=pts0 ses=1 
comm="git-send-email" exe="/usr/bin/perl" subj=user_u:user_r:user_t:s0 
key=(null)
type=AVC msg=audit(1589539770.992:1614): avc:  denied  { recv } for 
pid=10012 comm="git-send-email" saddr=127.0.0.1 src=25 daddr=127.0.0.1 
dest=45482 netif=lo scontext=user_u:user_r:user_t:s0 
tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet 
permissive=0
----
time->Fri May 15 13:49:32 2020
type=AVC msg=audit(1589539772.016:1615): avc:  denied  { recv } for 
pid=16 comm="ksoftirqd/1" saddr=127.0.0.1 src=25 daddr=127.0.0.1 
dest=45482 netif=lo scontext=user_u:user_r:user_t:s0 
tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet 
permissive=0
----
time->Fri May 15 13:49:38 2020
type=AVC msg=audit(1589539778.096:1617): avc:  denied  { recv } for 
pid=0 comm="swapper/1" saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=45482 
netif=lo scontext=user_u:user_r:user_t:s0 
tcontext=system_u:object_r:smtp_server_packet_t:s0 tclass=packet 
permissive=0
----

Could it be a bug in kernel somewhere (AVC generated from wrong context) 
or should this be expected? The version of kernel is 5.3.7 and Netfilter 
NFT rules label all packets with SECMARK.

-Topi
