Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C8C433E1
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E96920759
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dnSbuUaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOLvJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOLvI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:51:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37214C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:51:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so1953643ejd.8
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u0VBE5Qv3/Y4+1C/31sut5Y6R+WytaEi7iuXaRAUnyE=;
        b=dnSbuUaAmT/JITGyzwX3BbQJ5MEbWnxFGOrBzSHHsCYW1OOK40p2g61OZ6CVretMkI
         Zu/w9tTwtALyR/gOfGHfrOm8VBkVVMPUVnCVZCNfwQzSK2jT3FN0DMu43J31vvkBpxbn
         nPV0mOBum/R6IefWT7lCzJYgSGEOzhceLViUb8Mkos3IlS5Bb51N51EVW3DDgXtFJAus
         lC7kXUJ15kC4huK3lCHAudqMraoesIOY3wIt/6DDmoI96nWj438qoc7ShyOTkhxzwGgX
         Rk96EeEJls8KleklHYViOlooKEmqSV4P7SMU6mxcakbqUeJxzKfvsnMM7/eIKRd29T2R
         0Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0VBE5Qv3/Y4+1C/31sut5Y6R+WytaEi7iuXaRAUnyE=;
        b=U7GPxD6yrO04LGGZswrszSldwh7Wj8mdrx4uvFvOuTGwaAvAffc3a0+KE/j6c53cJW
         s7Zcn/rvxzCn060ld7G1S/HkijAh++5vlm7vO/howJIZKAoQJuJdMsGDS3YCF3aBxsdb
         oCuhjQpXO93Dz6poS1f7hXAtzkKhvTBHxYzP/Atnlar58QCKCe5ArC3iVXQMDnrzse/d
         ipdr9xb83/NjRcDJnRgbz1U0JrT1SHl9/Z5oDgeunZRCgPrkBpX5iGVi4ZoJrfqefQ2F
         74N5GC5vSlnLTL2Cr4nZawR57xTReM3Ly+UjsGKbXHKrJeOIg4CoiUkK87TYkWu0Cj1h
         wJTQ==
X-Gm-Message-State: AOAM531PZKxePhL4+DtFRterZs4OUKJ6U238Gtb8gDLCVE9VoUhb1Ft/
        MdG8whNH4h/sk5fZA1kvw2YjOXwFAVqTo87SPdg=
X-Google-Smtp-Source: ABdhPJyG/b/Q6BvFV9sXsZxw/e+hQXPY8J0YCdBrOtEbHIYUgRDVIaxDRDYPD9028IpCwUfg8HlG/CJsaTzQsE+p1lc=
X-Received: by 2002:a17:906:3944:: with SMTP id g4mr2350557eje.55.1589543465845;
 Fri, 15 May 2020 04:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
In-Reply-To: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 15 May 2020 13:50:54 +0200
Message-ID: <CAJ2a_DfBE3Mwxg-GHa4OZf6aq6D0W-Q5QxnM88qa_ZCXUFXs0A@mail.gmail.com>
Subject: Re: Wrong processes in AVC denials
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

for loopback labeling I use special rules, sot that the packet going
into and coming out of the loopback device have different labels.

iif lo meta secmark set tcp dport map @secmapping_in
iif lo meta secmark set udp dport map @secmapping_in
iif lo meta secmark set tcp sport map @secmapping_out
iif lo meta secmark set udp sport map @secmapping_out

oif lo meta secmark set tcp dport map @secmapping_out
oif lo meta secmark set udp dport map @secmapping_out
oif lo meta secmark set tcp sport map @secmapping_in
oif lo meta secmark set udp sport map @secmapping_in

The pid values in these audit messages are garbage values (and so the
derived command).

Am Fr., 15. Mai 2020 um 13:11 Uhr schrieb Topi Miettinen <toiwoton@gmail.co=
m>:
>
> Hi,
>
> After sending the previous message with 'git send-email', I noticed
> strange AVC denials in the logs. The first entry is correct, but the
> next have PID 0 and 16:
>
> time->Fri May 15 13:49:30 2020
> type=3DPROCTITLE msg=3Daudit(1589539770.992:1614):
> proctitle=3D2F7573722F62696E2F7065726C002F7573722F6C69622F6769742D636F726=
52F6769742D73656E642D656D61696C002D2D736D74702D6465627567002D2D616E6E6F7461=
7465002D2D746F0073656C696E757840766765722E6B65726E656C2E6F726700642F706F6C6=
96379636F72657574696C732E6769742F303030312D73
> type=3DSOCKADDR msg=3Daudit(1589539770.992:1614):
> saddr=3D020000197F0000010000000000000000
> type=3DSYSCALL msg=3Daudit(1589539770.992:1614): arch=3Dc000003e syscall=
=3D42
> success=3Dno exit=3D-115 a0=3D7 a1=3D5a00209eba80 a2=3D10 a3=3Dffffffffff=
fffa8b
> items=3D0 ppid=3D10011 pid=3D10012 auid=3D1000 uid=3D1000 gid=3D1000 euid=
=3D1000
> suid=3D1000 fsuid=3D1000 egid=3D1000 sgid=3D1000 fsgid=3D1000 tty=3Dpts0 =
ses=3D1
> comm=3D"git-send-email" exe=3D"/usr/bin/perl" subj=3Duser_u:user_r:user_t=
:s0
> key=3D(null)
> type=3DAVC msg=3Daudit(1589539770.992:1614): avc:  denied  { recv } for
> pid=3D10012 comm=3D"git-send-email" saddr=3D127.0.0.1 src=3D25 daddr=3D12=
7.0.0.1
> dest=3D45482 netif=3Dlo scontext=3Duser_u:user_r:user_t:s0
> tcontext=3Dsystem_u:object_r:smtp_server_packet_t:s0 tclass=3Dpacket
> permissive=3D0
> ----
> time->Fri May 15 13:49:32 2020
> type=3DAVC msg=3Daudit(1589539772.016:1615): avc:  denied  { recv } for
> pid=3D16 comm=3D"ksoftirqd/1" saddr=3D127.0.0.1 src=3D25 daddr=3D127.0.0.=
1
> dest=3D45482 netif=3Dlo scontext=3Duser_u:user_r:user_t:s0
> tcontext=3Dsystem_u:object_r:smtp_server_packet_t:s0 tclass=3Dpacket
> permissive=3D0
> ----
> time->Fri May 15 13:49:38 2020
> type=3DAVC msg=3Daudit(1589539778.096:1617): avc:  denied  { recv } for
> pid=3D0 comm=3D"swapper/1" saddr=3D127.0.0.1 src=3D25 daddr=3D127.0.0.1 d=
est=3D45482
> netif=3Dlo scontext=3Duser_u:user_r:user_t:s0
> tcontext=3Dsystem_u:object_r:smtp_server_packet_t:s0 tclass=3Dpacket
> permissive=3D0
> ----
>
> Could it be a bug in kernel somewhere (AVC generated from wrong context)
> or should this be expected? The version of kernel is 5.3.7 and Netfilter
> NFT rules label all packets with SECMARK.
>
> -Topi
