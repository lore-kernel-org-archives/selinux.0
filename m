Return-Path: <SRS0=p2GP=R6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC573C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 07:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925DB20811
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 07:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tahdc1jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfC0H46 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:56:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45786 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0H46 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Mar 2019 03:56:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so13093684edd.12
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2019 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SXoPNWzh7Fq4sWIUlCWQLu0e9O8CBenmIkv07aNNtLY=;
        b=Tahdc1jvcX6fz+dNUu/ZKT7RfKRipA3BQiS9CD/HhTsqqvElyMSQfvgZcaHeYiuXkf
         QRECoE7PrWGmga/1xZSepxo0xgHr1G79/pQuXnJwE/tq+PcAWumvw7wJsFpY1kyNs4/c
         xb708XHxqpE+CmoyP13oDehHYvrt/0VhQNa66FdZbwAusSQja6t4/TTMQAPMZPOVX4T+
         4Wv1vzuALirxiFPlNLobbqF6wh0nCVkQpEl7Z67p0sVmM8YBWCJm+EhwmZateV/YGJUE
         meRr/EWSjL627T/bw/04OGlIWmX1cnkhQD0tW7SP9ZK1u8qNYUeikI27bQxqkmfmDo9Y
         /tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=SXoPNWzh7Fq4sWIUlCWQLu0e9O8CBenmIkv07aNNtLY=;
        b=CFcmtcWTBntE1eTSZoqGDx2DA+Izbawb2ZiENTe3MBjVdX+un0FEyk6lo2En/t1iXD
         P//y/7lMv6O72kKqc3aGScgJQ5CDqtNkwXX9ydzjzsB0AY/Gj0zL5y2z/1qpPoG3dvFE
         lq2pT5Tr4RnuuFcWJwE6zDGPqF2qqfNOsyplPouXK3KnCvebeESDS8IklguVsQFzryLc
         BeMkIfo+qfKNrHmLgEQk3n+3cC+Xkihg/riqVYcMbv6w1Uxv7qS1vsDgfxTSmP1af6di
         1RHJODI+DU1x1FMM7ToxH7dsRf7fqRywUSufpUp3GWxvDEBiwxSzlcMcd4rEfJP1GD3S
         ZacA==
X-Gm-Message-State: APjAAAWFhHFNez0GEtLhyNpnUP65D/AP0mBgCd7wSx4X2xk/RwASDuy0
        qOUJbRroeGZSTU8cnsFbRI4QzDsq
X-Google-Smtp-Source: APXvYqxX1jsslMsi2E/tvMLnQmII8oknbNiQgFGtymlraWX1iDOykNFSO7RRruEAlIYvXxsMhhyEGw==
X-Received: by 2002:a50:b3bc:: with SMTP id s57mr14839973edd.206.1553673416430;
        Wed, 27 Mar 2019 00:56:56 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x20sm6405407eda.40.2019.03.27.00.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 00:56:55 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/1] restorecond: use /run instead of /var/run
References: <20190318210913.2392-1-nicolas.iooss@m4x.org>
        <pjdlg18ihf8.fsf@redhat.com> <877ecspgz0.fsf@gmail.com>
        <CAJfZ7=kN1CUYGiePHoE_HYw9NVRWErTKuWyet35_EMEiChMqgQ@mail.gmail.com>
Date:   Wed, 27 Mar 2019 08:56:54 +0100
In-Reply-To: <CAJfZ7=kN1CUYGiePHoE_HYw9NVRWErTKuWyet35_EMEiChMqgQ@mail.gmail.com>
        (Nicolas Iooss's message of "Tue, 26 Mar 2019 22:33:53 +0100")
Message-ID: <87k1gkn41l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Mar 21, 2019 at 1:08 PM Dominick Grift <dac.override@gmail.com> w=
rote:
>>
>> Petr Lautrbach <plautrba@redhat.com> writes:
>>
>> > Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>> >
>> >> On most distributions, /var/run is a symbolic link to /run so using
>> >> /var/run or /run lead to the same result. Nevertheless systemd
>> >> started
>> >> to warn about using /var/run in a service file, logging entries such
>> >> as:
>> >>
>> >>     /usr/lib/systemd/system/restorecond.service:8: PIDFile=3D
>> >> references
>> >>     path below legacy directory /var/run/, updating
>> >>     /var/run/restorecond.pid =E2=86=92 /run/restorecond.pid; please
>> >> update the
>> >>     unit file accordingly.
>> >>
>> >> Switch to /run in order to follow this advice.
>> >>
>> >> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>
>> There are other occurances of "/var/run" tree-wide. Some more important
>> than others: cd selinux; grep -r "/var/run" .
>
> Are all distribution using /run instead of /var/run with a symlink
> from /var/run to /run? For me, it is all right to move a PID file,
> which is only shared between the service and the service manager, but
> moving files such as the Unix socket /var/run/setrans/.setrans-unix
> could cause issues on systems where /var/run and /run are different
> directories.

FHS still mentions /var/run, so i suppose from that perspective it
should be supported. but using /var/run can slow down boot time plus
lets say mcstrans would be socket activated, then we would need a fc spec
for /var/run or else systemd would create the socket with a wrong label
and then you get into a chicken and egg situation and we will still be
using /var/run in the next decade.

>
> Also, policycoreutils/scripts/fixfiles currently contains:
>
> find /var/run \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run
> {} \;
>
> This command does not do anything useful when /var/run is a symlink
> (either a slash needs to be added to the path, in order to use
> /var/run, or /run needs to be specified too). Right now I do not have
> much time to investigate how several distributions configure their
> /run and /var/run directories (I am writing a research paper related
> to Dell's iDRAC system, which appears to be using SELinux since its
> version 9). If nobody else does this, I plan doing this work in April.
>
> Thanks,
> Nicolas
>

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift
