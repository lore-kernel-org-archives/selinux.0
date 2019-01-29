Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441EDC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F31B2147A
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 22:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xsSs3vvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfA2Wul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:50:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46160 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfA2Wul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jan 2019 17:50:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so15887437lfc.13
        for <selinux@vger.kernel.org>; Tue, 29 Jan 2019 14:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpWSgYa/7S+pAvDxPuCopoALvuYMy8zjg8u27/xsx1M=;
        b=xsSs3vvChsC2yu6PfblgwyJ1noPUWoNG3YVh5euxNMtc4pwfzqkttwVAA3HYmo5Bcq
         MosjzZiw/is4HgjUZzu3Cn+H/rQjJRG4a8eXTaCaEvm8VA210hfW0n+zTJCgTaHg5sYP
         0nI8krLLv5PyfEEScn1hX3IYho7AH/o2NXXJIAuOvtdDzqpygbcmxj5kKt0Fzx1Xf6Jy
         xl/Avs87WyMYZPm94TCfaUlNxc+hjkne8JHvCBM/yPgKt+GvxqYf9CXCUZ7LSMAqQQXz
         EqG48og9/+UUHobkwGff6+a1aj3egEt8lQSjqK8ympBeRes5FLk6q+N3qytxQdhnLhiG
         DmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpWSgYa/7S+pAvDxPuCopoALvuYMy8zjg8u27/xsx1M=;
        b=FSnS7Z63ttoeh+CvIS2NViVbrlH/glG9/tNWyACxl/iUs6z222nLwPX4nNQOEpMNd7
         mwMgmsXC7CYfX0Jrrs+iRZITpXGnPP4yGwyLEeSSmTmQg98hMQ48QT4zbEm/yjpmAim/
         5x7qkVZTTNG+YFzP80Rl8c2AjZxdhJnZdIfe6BZVou5JBQ+hhBptrBog3u0DtSDyEKvj
         /uFjBVtScJYKpmO0ZWn/cKPeDn+GLOdMcGBq8lbiI+lEnmA5SXr6aQ7aUeTLtVuo1kwv
         CFWVTjeSsOZaF+VLwwdenY/JdJh3b7uyfe+fj0cqft1a3OuRYvorLFvgCYvb1oE6r5Dw
         seUg==
X-Gm-Message-State: AJcUukcFIFdUBp68Zmyjiyr1W/6xVzCelz/NpdYXH3wMpAcii3Hdyeq0
        1UNZaUNjkqPm99jNL7rGrnrp5NYDPuCzJ0p7m1Gw
X-Google-Smtp-Source: ALg8bN70QtPPJ4mq98azyk9Y1ANoH1tccdLC+UJ0hYdkUOKJsPqBNljN9qqIhFT5c2FVvshkKsrgS2SmVFg8AIcmmQI=
X-Received: by 2002:a19:c995:: with SMTP id z143mr21167506lff.79.1548801755558;
 Tue, 29 Jan 2019 14:42:35 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
 <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
 <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
 <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net>
In-Reply-To: <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 17:42:24 -0500
Message-ID: <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 29, 2019 at 2:23 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 29.01.2019, 01:18, "Paul Moore" <paul@paul-moore.com>:
> > If we don't pass a skb into ip_options_compile(), meaning both "skb"
> > and "rt" will be NULL, then I don't believe the option data will
> > change. Am I missing something?
>
> I mean, in cipso_v4_error we copy option data from skb before ip_options_compile call:
> +       memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
> But skb IP header data could be already changed by first call of ip_options_compile
> when packet received.

There are several cases where the stack ends up calling icmp_send()
after the skb has been through ip_options_compile(), that should be
okay.

-- 
paul moore
www.paul-moore.com
