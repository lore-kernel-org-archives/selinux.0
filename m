Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42831C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155D0207FF
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlsY5a1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfI0NIK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:08:10 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:36359 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NIK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 09:08:10 -0400
Received: by mail-ed1-f48.google.com with SMTP id h2so2285934edn.3
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jk+vFMiW2+vm6kbuOZOp6eiEkoG/75dUdG0MyQEgcUI=;
        b=YlsY5a1CEGDcFwSWEDNsQ9dLD1jauJzimDMjQ5H1dIP9ujq8e8PumpNza0x55dw9DQ
         kWcOZC1RvThydrtvlGQPXogO3L0ywJ0vXqHGfu/Ht1BXn7WbwLUeoeLPvGD9TaQtmpb0
         dvjBE9rY5CP3ttth7/zpO22kgYxVadmyNC1kqWVt3yJBh88x4H4DSneSezPvwdpgwicr
         o5HiOh3BRY3jTHIq2soSBM9DIxlq0KnwUgKK4WHSXSA3OKom4I+XPOaMLg0Ib1dLTwWM
         HQcf18nRQxyWccfR/6AvUia5vndbcyLhKjHDwNVBgxUNvGVqTY275s975IE3ZU5RTijM
         YIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jk+vFMiW2+vm6kbuOZOp6eiEkoG/75dUdG0MyQEgcUI=;
        b=o2yP5IjOucr5Ylub5TjTnlzkqIN18icAayz3HJa1r5BYAOk6f3pZyAizj8baQIoywy
         7P93tqMShygGT6/hqjHtntU9N2sftoT82EH2scEWpl47RcydIHDkkLpZFHLe1O1bm2hI
         jChNTIoRY3PjvXujxZXZWx8nn+X+5IU5vEdAZAoj6obSexC0BzbM3rPvnKIFj6+5oZ/W
         6M5yIi6/RcLwNzdRw68KRPp4nVOUCsdR7bxOdM2F3loTSeZ0yK2BANJ4FmnQuNRMRV4m
         S5HGsY6cvsluYAQVNYgelKYYx/fWcq8iNd0C1Yja3g8N80s8kTuBnQoq7ZuU0RJlkXTb
         pvvw==
X-Gm-Message-State: APjAAAXPhGLwMrzosfuQXm4Q+dDo4mybGkkiabWRZuPr8Tl7qWId/WGp
        8D4qx2bNjglxwU+FJETDR+BYN0g3
X-Google-Smtp-Source: APXvYqzPVpgIN7/mxeaWMfAfTxtT40V7LF4bXlNb/xRDFsACdIYHjGZ35lj5DXRA/29FkJ2VfRIBtw==
X-Received: by 2002:a50:a41c:: with SMTP id u28mr4382876edb.185.1569589688739;
        Fri, 27 Sep 2019 06:08:08 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id b12sm516690edq.75.2019.09.27.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:08:07 -0700 (PDT)
Date:   Fri, 27 Sep 2019 15:08:05 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927130805.GA22281@seamus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
> On 9/27/19 3:55 AM, Dominick Grift wrote:
> > sudo does not reset the role of my tty properly [1], and i was wonderin=
g if anyone is able to determine what is causing this [2]
> >=20
> > [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> > [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>=20
> Are you sure sudo is calling selinux_restore_tty()?
>=20
>=20

running sudo with:

Debug sudo /var/log/sudo_debug all@debug
Debug sudoers.so /var/log/sudo_debug all@debug

Yields:

grep selinux /var/log/sudo_debug
Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ ../../../lib/util/key_v=
al.c:61 :=3D selinux_role=3Dsysadm.role
Sep 27 15:06:29 sudo[3417]     7: selinux_role=3Dsysadm.role
Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
Sep 27 15:06:29 sudo[3447] -> get_exec_context @ ../../src/selinux.c:274
Sep 27 15:06:29 sudo[3447] <- get_exec_context @ ../../src/selinux.c:328 :=
=3D 0x564eed3621b0
Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
Sep 27 15:06:29 sudo[3447] <- relabel_tty @ ../../src/selinux.c:253 :=3D 0
Sep 27 15:06:29 sudo[3447] -> audit_role_change @ ../../src/selinux.c:76
Sep 27 15:06:29 sudo[3447] <- audit_role_change @ ../../src/selinux.c:98 :=
=3D 6
Sep 27 15:06:29 sudo[3447] <- selinux_setup @ ../../src/selinux.c:395 :=3D 0
Sep 27 15:06:29 sudo[3447] -> selinux_execve @ ../../src/selinux.c:405
Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ ../../src/selinux.c:114
Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ ../../src/selinux.c:142=
 :=3D 0

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2OCbEACgkQJXSOVTf5
R2mc+Av+OLvuvKPkPKYqcuZ+cbXLvljUGLhvGmf8+2yHGgynvgVGfr6W7fr33Oh4
G6b5H85wdky9Z6wgg/vrMsMGEfcaKDMCiA0yrMutY1Vm8Otnca8vMNnJIM08daDE
1S/LUI+EYiFwtSBj9LsxGexPVdZdA24t9NT7UtoH3qL6ekSH+kt483XBAMjrOxB7
q6Fu3gasQ/kY7tMZw1Q6wek1dqlwayDsqhJhsm5/e2Hqs/C6mk4Tmn2M3Aba9biY
4l27UkVV6YcsBe4WtPv+XuN24Zpsj93SrYp7+LSw3d9KWkld+EW176iSZC1IJ/wH
dJnSXExJvKwmveb6cl9Pr6rcgUl+mg/Q7ui5FV8TKU5XDG66oXnPDGDdzMmWwVcN
Tt6LDkZa9p+u4p6rJQ1cLmQ0+xlShC5sW85IK/HtB0KGHps9qya3y2GaptOVdVYH
rBxSJTSSRZwWxo6+qTEqPVmy2nSSJzQg3dLFd7TwUkXBU6FoRZ8w+csltE087Dvv
/PITE2mI
=IXOn
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
