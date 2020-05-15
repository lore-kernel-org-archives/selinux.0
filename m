Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF33C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 00:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F3F20709
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 00:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nBO1vZL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgEOA3w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 20:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727805AbgEOA3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 20:29:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE6C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 17:29:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h16so488510eds.5
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V60ZEkbmgOMZM07FStPO67t5954t9J3OaDzUJJj+zvQ=;
        b=nBO1vZL8vJsnyFNc3HsMMREi03tihrUYWfUVS/HzrZiVvJ/HiBEOd2oyxOKfO0byt4
         +urXIxGa4/rUpMWEwtQrG3mQ1Gdi0zxZJm6wcxSeGXaebZouGn/2kMPEHWTNsx9JYYN9
         Og97RjCNluKt1x4iAzbQMru0XjmGzVRNzhzhzfDGGhrGfNDwYIK11kQAwtiKPiyspP/M
         70sf+2eSK/W0dNE8FXyOddA8s97EqJwWfzBZYpxGujgJDk6rGz4hljM4bM1EwsJSRgDZ
         ueU9g18ymkTE6FtWVu2SDi6WCk8OkU/VzkR+1yRvg3JL2QwrqnV/1+Q+/N05LAoX8Go/
         lCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V60ZEkbmgOMZM07FStPO67t5954t9J3OaDzUJJj+zvQ=;
        b=hHKC/jrEdmCRPOCz9GpYj4Jnn6ughpWDu1jPg2QNAXcbMHLtFPSSmZ1qCW/SJBLp5/
         abWi9fezM2cPCclsXmsT5pbTWOIkiK5GgJwaELjupqUiiWHA/MEVSHE+mhSNow7cDwSC
         2W2RLNhysxm5gB3C11O6Q96Rk4zYyKG0eJyVzlZ78Ji25A/TUt5Dhb/7r64ztD8MOTaK
         RfeMBVPUL0Dlsh57DVK1Hnky7C6ikPQLLY1Oul4RqcPC+DVJ3gFmVuNg1X17jY0NY1jD
         O14O0D0fkZEqGKTM39cRIiET/Zam9fuRYBd1ssyE3NhbnblXauB4Y8sbDgOs3YtAUIqp
         Dw9Q==
X-Gm-Message-State: AOAM533qoe4fyVLzQvYjf0QJegQ7bmbEwlZEOKc0tRArbELIP10bX068
        pPL/+nFmoT1eIO0/TiXXHPrJUMuxr4SM/nRFtNw67Co=
X-Google-Smtp-Source: ABdhPJx78ccxpAlojCTsRQWQf/F0s5sXLEDOJMUWlVVRYLwhXJlUo9i3iXcd9/XX5GwCiCbXHP8RY/2asUm86BHAa9g=
X-Received: by 2002:aa7:c887:: with SMTP id p7mr567131eds.269.1589502590090;
 Thu, 14 May 2020 17:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200514160922.37513-1-cgzones@googlemail.com> <CAEjxPJ45DbP_JmJO72s76TEuzvSA7E3qzaW9A=HwuaS+nU9ckA@mail.gmail.com>
In-Reply-To: <CAEjxPJ45DbP_JmJO72s76TEuzvSA7E3qzaW9A=HwuaS+nU9ckA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 May 2020 20:29:39 -0400
Message-ID: <CAHC9VhSRCmZJj2CiWZfX94xQqgHOmjRXnkzd4AEtkh-FOzz=Pw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add note to avoid permissions with _perms suffix
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 12:36 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, May 14, 2020 at 12:09 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The suffix "_perms" is used in Referency Policy style policies for
> > permission macros, bundling several single raw permissions.
> >
> > Add a note to not confuse policy writers/readers.
>
> I don't really see a valid justification and I wouldn't recommend
> doing this via a comment alone if it were justified.
> The kernel shouldn't be tied to refpolicy since refpolicy is merely
> one SELinux policy configuration albeit widely used as the base for
> most Linux distros (but not Android). If we were going to enforce a
> naming convention on the classes/permissions, we should do it via a
> build-time check using the existing scripts/selinux/genheaders program
> that generates the symbols from classmap.h that are used by the kernel
> code.  And this particular case seems highly improbable - who would
> name a permission with a "_perms" (plural) suffix especially since no
> other kernel permission has been so named to date.  The comment is
> also a bit confusing since it occurs immediately before a macro that
> ends in _PERMS is defined, but that macro presents no problem since it
> is purely kernel-internal.  Absent some motivating example of where we
> have broken refpolicy in the past, I can't see why we need this.

Not that Stephen's points really need a "+1", but yes, +1.

--=20
paul moore
www.paul-moore.com
