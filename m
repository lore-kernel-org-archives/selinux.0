Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A3C001B0
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 19:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGST3k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGST3j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 15:29:39 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2C199A
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 12:29:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-577412111f0so925827b3.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689794977; x=1692386977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMngaDaaztd5+XI/R9UATq+VWN88HLdoVPWXj+T1ScI=;
        b=Gv2nwRJuokDGMwXXovn6+6jULYMGIx07RWAcGjidr4N1gmWXjXEOaXfV3q7UmjdSIT
         htjQbE8wIxvYg+hJTm4KYied8dPNLH20tvf30ia6T5GZ3uFNkFGqhnKGA6CePyqcXgsE
         9HwRmtrs1brPCbvszbV6LNz3V/QWNyPv6hY3h+xdB5e4JFYgBXLi7nFX+pFCumSA/0cs
         SG8vaRE7vM3xTjayjl03fLTRSXkL3k3P2XM3eGtQ0O+ySjZS5uCCDbwG4F4q2cyx/TOB
         4DiMHxlrQ+0rlv7bK+GFbu6lQIh2VMulpfziR8b6TLgu5Lzp+PcnUTUMST8GXMwMaxuu
         t/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794977; x=1692386977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMngaDaaztd5+XI/R9UATq+VWN88HLdoVPWXj+T1ScI=;
        b=U9pyQ5QcBL10+Raf1LlaHy7HUEzwudhWB6rOR5LHfT2UPlF6k3hbD8BMx6uYJwREom
         iM2uYWpG3qx1X8EQ+YHSuNiuia2m/I92kvWwANZk6hkoAXz7naz3feyIgxWvTqFm3pki
         1fbmGqn5rGpPfxinx/IhFPocTBflJeVf0K+LXjbSM7HWL9GABItKP1o2HkRU6XofBGPv
         MsC5M73X2lasFiwaNCZ5qAud/FjU2y/N6RM5ei/IMRgg3K1Vejvo9mLiQuaq+MMdyZqz
         yJ76z18NZOGxmGEIofhIKvW6ge4rkBvUtCwz+jrQX/+SG6sbgk7d31rHS6695wkpOif4
         Y6pQ==
X-Gm-Message-State: ABy/qLbDiOjscjojTGgTstZt8FdypVVDmpfVBQws3Ed/BPF2Aj9WtsY0
        peyyICRInCvsYL0iE9WiR4nHCwqRAx+vPYK9+lrGysjD7rMWsxw=
X-Google-Smtp-Source: APBJJlGukGXI7Kl+vAS9n1L1UeCVRGtlTv7Tvk8lGgb1vUZPXlh45r0VD9DmOl9BgEy/rw/oioXCo2iAKWhfzKp0rKU=
X-Received: by 2002:a81:4e43:0:b0:577:1909:ee16 with SMTP id
 c64-20020a814e43000000b005771909ee16mr6454767ywb.30.1689794977325; Wed, 19
 Jul 2023 12:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPQCZivM+qGve5eUekri3_iEzAPE5o3ymqOunYMjQJ=4mRwPUg@mail.gmail.com>
In-Reply-To: <CAPQCZivM+qGve5eUekri3_iEzAPE5o3ymqOunYMjQJ=4mRwPUg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 15:29:26 -0400
Message-ID: <CAHC9VhQWnXyL0n=qCZTHE3jz848CQti5dp9MwiEet2FMzJaz+g@mail.gmail.com>
Subject: Re: SELinux Mascot/Logo
To:     Brett Anderson <brett@bzdzb.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 2:42=E2=80=AFPM Brett Anderson <brett@bzdzb.com> wr=
ote:
>
> Hello!
>
> I made an SELinux logo for my own purposes and figured I would share
> it with you in case you would like to use it. I'm putting this into
> the public domain and you can do with it as you see fit; attribution
> would be cool, but not required.
>
> https://imgur.com/a/khkSEux.png
>
> Cheers!

That's pretty cool Brett, thanks!

--=20
paul-moore.com
