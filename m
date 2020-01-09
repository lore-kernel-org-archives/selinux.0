Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20929C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB5E20661
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QJ00X1rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgAINnQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:43:16 -0500
Received: from mout.web.de ([212.227.15.14]:49871 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgAINnQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jan 2020 08:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578577363;
        bh=SBn27swcsN3GDi/4Ahf9pwXLU58htDfFdZUFvxyKEmU=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=QJ00X1rMvy0CH4ZEaVZwotpicJfQCeaHrQVpk46KYHLoCq3pprFVAZZWQ9S7GOyiF
         xNE4B54FOf+wvMi08QdamvDm6bjhIk3UYi6u0ysfBi4w6x7XcAaOZI9CK7LzjdX9Hw
         Q5WcJ2skSoFObmJFPPhTYNtBunVLUItEHEYZTa8k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.1.10]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M69CU-1jdoNt0v3y-00y8UY; Thu, 09
 Jan 2020 14:42:43 +0100
To:     yangliuxm34@gmail.com, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuyang34@xiaomi.com,
        Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
References: <ba3290e18f9867e110b77d058c3f8c7015bd868b.1578274288.git.liuyang34@xiaomi.com>
Subject: Re: [PATCH] selinuxfs: use scnprintf to get real length in
 sel_read_class
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0f920e15-2462-2a0b-ced2-40ee60132839@web.de>
Date:   Thu, 9 Jan 2020 14:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ba3290e18f9867e110b77d058c3f8c7015bd868b.1578274288.git.liuyang34@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G1e4C0uMFU7Dbziczexg/U4qJ+TjxHLsHUI9I6veH1KnUXg633j
 nO77b+9O7HBL8oY4VpkKHZLM/NYoVJwU0YC3A8ps0kQZRYDETykKYx/SBFFhGLDjz5kdCOK
 CBEzHXbvHdnNdbIf6AtQCdwE17HyYY7Qpg0szz7ogMjk2W/EB15xMSgUQOhizyNalYOmpRt
 oYwJ3AkWEonXSd7zviw4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vt4vREgRi4U=:NUQiAWl128HZMWDpJg/uPf
 JXzoCvOTI+fOYLnp1dDXpc3cncPdENMsLjUErvPru5eU3jN5PWNovIsAkfQ2a/8pPX/Welt+a
 u6YFaJMLhdiA9h0ckF5BbaQ2jlexv7aBkXPtoGBsHO+ac1QEGQIODnd7fiyuLAq+dULoXF9z5
 zE8WE8YGXRy5umZQrQglS3lEmEpvP25Lb1885sPuDm76jOmjECdz6TskCCnGPZpyXPdXIOKpL
 eiXKoU3mPP38BaxFdBG6u/m2DzxgNoDIfDIFIz1EpjbUvtlDJWBqY8shFl/rW5/aBwH0BiJ+y
 IDSyFRC9zBVuOnyuEsSjwO14EwOdrCl51WlbLAjydJ0uvozwwvY+CBmXvuOdDw/Pqxsa8uH7q
 JHQayOLJ/Ppx7OZlpuX46B7cvOydj8NTctUGBInn5rKki2801ncL8qj+KunLLzpbGFqzDgdNS
 XYGP+FPggHiOQ5KTwDvykQZ2K2P6rgCZ5kk+aXq8xmKaPRaIGBydtSF9S1S/+00+Ig2DA9uk4
 OHnG7nrigv7dzd9/LULhQpO6deXo2vNo0SN2zx0YrG7Dr5Xpz0dAuKXnsDDHjfkAfDCa9I4YU
 zmmGNmkUxaLIvlAGa3p1uuTdaSsGQG2xHCdEPnbEQQf2tLOwEJhArmAdHey0r4WGZRdMW0N0u
 AtPGvTGdW9yjeoqwKoHjt/n8SDtvHGi01bwwHeWD8cS+s/f20SEK+Bo6XfL5XLpGOkt53Fkxb
 dXZn1GQayqSimWQ0hI/DtRS0/Dp0ztH1/H65D1PK5koSNGXHOQ8sLzBw0KWs2wsBudD4qLqOe
 3SnTHOpysE15XYGubSG27hTyDHfJf//A7mblGhCaySYVCQCI9xtDBCD+RtmTEFLnRaPWoUA2s
 6WXGuNDLuMa377x5mI+mH6dIuBYNzmGqx/RVM0VYOaA6omWn25RfOjCrTnEnC7VbmZgPOBC5K
 tDN6mukg2sIPcha7QgCeV+IJbIk4JkLTZIcesCbhDhgMp8z3RInK5nVcnbQ2/USRUDRcVBCIi
 wAaZaPqcaQQnfStqIHe3jY3uuXq9Ub27byX5gyL362Ak1XqCV8c6h3/YKF9rSuqfNSy0f83XL
 bcThXkN7N3WTsZ6EFgtS32mu0g5JaLlL7D15BO7rOZf3NOsoVzIXBeNnpg3GCtDoFguQKe9Bg
 1vhYrW44BxjIwXDG6qIo222YKns8MScDdM97tzP7n13CvcVZehoBS3or2PFQhrPx0Q67MuCYO
 NV/AlBhHGWfFijrX+jmLod+XMXLmy4/hgRauHb1AvcyhJSYtyvEuilS/uCbg=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> as the return value of snprintf maybe over the size of TMPBUFLEN,
> use scnprintf to instead of it

Please improve your commit message.


> Signed-off-by: liuyang34 =E2=80=A6

Will this information need also an adjustment for the desired specificatio=
n
of a real name?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db07f636fca1c8fbba124b00824=
87c0b3890a0e0c#n458

Regards,
Markus
