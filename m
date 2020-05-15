Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEBC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8220657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao1dDcDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgEOMNj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgEOMNi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 08:13:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B5C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 05:13:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a68so1678272otb.10
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dexAj21SquJsS11TInnflzyTvOYwS9wq6JNbFeN7sEU=;
        b=ao1dDcDWwU5jsCeWsqRVfM4KRg88Z3g8yUrIL1A8KWPvp8ymnHLE4Ukvn4n9P5Dd/O
         3cXgj4SUrzwf7KbLXSlkVJtaOl/T0nfQPFROkiTgbFLb3d3Y3/VN/SxJQzxLpGO+esoE
         fCJEShg46ioF6p8H0O+61Vc5cx0iffE/rHTgSemYPUj5wiI6I6RsB9l2bTuO+rXvOZuH
         AGMeb4f7Dh6lkdfFP1Q5bJEhmQNVZCPPLuIhRWp1nDTKpZTh3x/KFATJkXuOlOG+qoUA
         NSWwq/Cm8ZlmC30ymokBDO9uSw8ggr2v6NdSzVrRQUbbaNlgwWOWsXg3/5no1t5iAXZ7
         EArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dexAj21SquJsS11TInnflzyTvOYwS9wq6JNbFeN7sEU=;
        b=mr20h+MM/xLI/rSSJ1gJUWG1TBogkhO2rJX5ybEJhJhcY8r/vdd4/E2GeqhKtNhcS4
         G6lO+RNeAr4A6Sltpmlx6ugnaDdYugSayjIxbmHStLhOplCx2lbbpEt3NGDb4dPryIMF
         jjrF5OymMAD4qcwnJfRKqGHumxjXqo9CcfFUPSZzq3kG3wCpdqa4YoBuGs9vYKKE1FBS
         63RgqUpcaN3SAosqG2B7lG6aw5S0gdSjF8qhp6t0bro6jwxScPz5tKglfBgHvRuxSkMG
         LxkBIdVvH3og/1Z4QX+pUHJp1w9ZzXr5D8sg6fRal62/EqcqyPFBd1UWCOZqu3+s567U
         824A==
X-Gm-Message-State: AOAM533NRnM2cNVTra7qh/WirqpRIWeucKRCeF8oPJMoIdRnV5kryar4
        X0WJnY2fHNaprrueGMzmm5GI/AZbrabxKfNCsfo=
X-Google-Smtp-Source: ABdhPJwWvXph1+yQj6YUUNt80+k7FGk2ch2uKgHFALUtB4JMJ5QsPmoEy312tBLmAn9kRvz7jhla74jGLCHZX2O3y3s=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr2075071ota.162.1589544816506;
 Fri, 15 May 2020 05:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
In-Reply-To: <41f9bc7e-d48e-503c-e298-5aba4d7c8e32@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 15 May 2020 08:13:25 -0400
Message-ID: <CAEjxPJ7SfRcc-8D4m7yKwVmx0MY=6qd86LGcf3t-rQvrvqXJdg@mail.gmail.com>
Subject: Re: Wrong processes in AVC denials
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 7:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
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

Certain permission checks (like network input processing) can occur
outside of process context, e.g. softirq or hardirq,
and therefore the pid/comm information can be seemingly random and
unrelated to the security contexts.  The security contexts however are
correct.
