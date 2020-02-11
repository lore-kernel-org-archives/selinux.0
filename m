Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BCC35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C8620873
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W/xxFfUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgBKTMm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:12:42 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38027 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgBKTMm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 14:12:42 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so7048812vso.5
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VHMXIarMsKeRQ9b5T1J1vnk3kOcKOJasKGs7SUe6fIs=;
        b=W/xxFfUhYbNdb9ERqk4PM5dZHFn2+iN4/0syAWJV9F9U/ITya/oW/Pmd8HsAA4Vmkn
         lflOCuwn2p1SA4YfHzflU/WWiSUTqwN1KaZ+8+f0IqDJCMbNRQpxPSxMt7jO+P9hKe9Y
         qatXoVR/fOmGEVTa3WtNa+8fV9IXhEY3S12lXQCtEDWr/JYFlxeeYqsB/rlG355Ufbe9
         nf1oZNszW3X/ZD0WYAfddUbIEGo34pxg/KY54jyTNL0FDVe40CqVKA9ahl3cF5ezOQr3
         e8ZeygNtXiwtZwPkbjUmThK/i212R9d+GuQt/o+iX4jLPtI9s76d7PBK7erIy9XvhzKg
         6wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VHMXIarMsKeRQ9b5T1J1vnk3kOcKOJasKGs7SUe6fIs=;
        b=tkP36YKbcERXl+ql1Yv2ABxynoHz7YJ0w5wDhkFo38vVZfg1QmrcXq9BH1OpaKU+Fs
         QSdrd2nEMQ8z3Ploq0AH+S2ClYWz5bHlBAjPmIKKiCbSBU7EqQpi8aAvuG0WKvy7sz5z
         sNJ11b0tDbVQIhFybXb3P/AHZGDhz9GOp/Kh9P6UXkIafMkuHrLYQ4mLwRqlDuW4EuYq
         Dq1CaJoVltQClISwcIZGsOdTWAjfTzbKIypokEErRuMA1ySBTNYjHATPwv0dz7wHCnZr
         EpuC3jKRJhGSXE3BX9KfF568xQVTzQBX1VCcq8/LMXQZPy9XQX/LAtExV3b24ElzMZLe
         j15Q==
X-Gm-Message-State: APjAAAUxmq4xgyKBDtQL/F6HAOSecuqF/h7WinZOb8daHRLicaJbL+tu
        i9UuxQxmaZ+H+aH5dRzMHjU7BllaexmZ8uuHwW0=
X-Google-Smtp-Source: APXvYqxTE+CdoVDsspGmGhfRn5SVPQZN75kg+85aBxqaU3JgRgGycQuIJbKvJ5/6Z3RV5KDiP4CzQVEMnhMYhc68LSQ=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr10155047vsb.200.1581448361080;
 Tue, 11 Feb 2020 11:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20200207143744.9944-1-cgzones@googlemail.com> <pjd36bm4dat.fsf@redhat.com>
 <53df5cb3-798c-66da-604b-94e7e48c5803@tycho.nsa.gov>
In-Reply-To: <53df5cb3-798c-66da-604b-94e7e48c5803@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 11 Feb 2020 20:12:30 +0100
Message-ID: <CAJ2a_Dc4Ud9EeP6WN9xHP0sn9vsgjgZWz7LM2xF_2_kLV9AydA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled.3
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Fr., 7. Feb. 2020 um 18:51 Uhr schrieb Stephen Smalley <sds@tycho.nsa.go=
v>:
>
> On 2/7/20 10:39 AM, Petr Lautrbach wrote:
> >
> > Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
> >
> >> is_selinux_enabled() does never return -1, do not say so in the manpag=
e.

I am having second thoughts about this:
With the current inaccurate documentation the worst effect are dead
error handlers in client code.
But when removed now, after a potential SELinux rework (either kernel
or userland) in some years it might be way harder to re-introduce
error checking in all client applications.
