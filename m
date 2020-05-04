Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9103C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E75206D7
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTk6s8hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEDIqh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 04:46:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22240 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDIqh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 04:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588581995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPOOabtacgfGFszvAU4UwD7Xq62fxCPafy2wMKwPiLg=;
        b=FTk6s8hM8KwmKIvyKlYepYucoqBYvfro5OQdjP1aEpDrsG0t+b87U5wGHMe3wEYdA8feOJ
        9lX8THJiDQ3HPVF4Nhxws1FjhglIqJCfWXPi2UKSOlWsZDkxxTjwJxsyfpvvaDdKwoYGtL
        LEIp9Ry7wPDfvx43RlHMQiD+uTxgApI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-MqV_jEnXPmiy40EDuj82dQ-1; Mon, 04 May 2020 04:46:31 -0400
X-MC-Unique: MqV_jEnXPmiy40EDuj82dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108C246B;
        Mon,  4 May 2020 08:46:30 +0000 (UTC)
Received: from workstation (unknown [10.40.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D5A910002A8;
        Mon,  4 May 2020 08:46:27 +0000 (UTC)
Date:   Mon, 4 May 2020 10:46:23 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Laurent Bigonville <bigon@bigon.be>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] restorecond: Use pkg-config to get locations for
 systemd units
Message-ID: <20200504084623.GB245818@workstation>
References: <20200430110835.138643-1-plautrba@redhat.com>
 <20200430110835.138643-2-plautrba@redhat.com>
 <CAJfZ7==TsNc0+0FSH4tdm5xGgMrkns2sQBcPhSs0hqtc2Pnatw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==TsNc0+0FSH4tdm5xGgMrkns2sQBcPhSs0hqtc2Pnatw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 09:45:03AM +0200, Nicolas Iooss wrote:
> On Thu, Apr 30, 2020 at 1:08 PM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > The user systemd service file could be installed in an other location t=
han the
> > system ones. In debian for example, the system files are installed
> > /lib/systemd/system and the user ones in /usr/lib/systemd/user.
> >
> > Suggested-by: Laurent Bigonville <bigon@bigon.be>
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> I confirm the pkg-config commands work on Arch Linux too. By the way,
> on Debian this patch makes building restorecond now require systemd to
> be installed (because /usr/share/pkgconfig/systemd.pc is provided by
> package "systemd"), but I guess this shouldn't be an issue.
>=20
> For both patches:
>=20
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> You can merge them when you want, or I will do so on Monday.
> Thanks,
> Nicolas

Thanks.

Both applied.=20


>=20
> > ---
> >  restorecond/Makefile | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/restorecond/Makefile b/restorecond/Makefile
> > index 4de9642b0f6a..8e9a5ef1cfa1 100644
> > --- a/restorecond/Makefile
> > +++ b/restorecond/Makefile
> > @@ -7,7 +7,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> >  AUTOSTARTDIR =3D /etc/xdg/autostart
> >  DBUSSERVICEDIR =3D $(PREFIX)/share/dbus-1/services
> > -SYSTEMDDIR ?=3D $(PREFIX)/lib/systemd
> > +SYSTEMDSYSTEMUNITDIR ?=3D $(shell $(PKG_CONFIG) --variable=3Dsystemdsy=
stemunitdir systemd)
> > +SYSTEMDUSERUNITDIR ?=3D $(shell $(PKG_CONFIG) --variable=3Dsystemduser=
unitdir systemd)
> >
> >  autostart_DATA =3D sealertauto.desktop
> >  INITDIR ?=3D /etc/rc.d/init.d
> > @@ -48,10 +49,10 @@ install: all
> >         install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/re=
storecond.desktop
> >         -mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
> >         install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBU=
SSERVICEDIR)/org.selinux.Restorecond.service
> > -       -mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
> > -       install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/syst=
em/
> > -       -mkdir -p $(DESTDIR)$(SYSTEMDDIR)/user
> > -       install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDDIR)=
/user/
> > +       -mkdir -p $(DESTDIR)$(SYSTEMDSYSTEMUNITDIR)
> > +       install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDSYSTEMUNI=
TDIR)
> > +       -mkdir -p $(DESTDIR)$(SYSTEMDUSERUNITDIR)
> > +       install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDUSER=
UNITDIR)
> >  relabel: install
> >         /sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond
> >
> > --
> > 2.26.2
> >
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6v1loACgkQviIJHj72
InX5Mg/+J2nMrzX62vMDok0lLm6kFN0eIlZNA9LvMcuS0Ln4viGIo63VaM+WRxC3
7VtDk73YiMq0a4eILSZj36fgcLgxZMyQdQO/uZ2hFJDvCkEHWWeDEEQ2zcciCI5y
+QdYx8iTD407nBjnLJASD/8HNJgE6QoKzMLrcV9XUfSH2qN83RN5lvjdrYAv9CUV
fN1XEAGu3y8nbLdTLg0SoX5iYDUJ9jLnactold9T6R06iE/rMk0oqqLBXZOVgxfW
9C/TsR3nWT24a0Dqff4E4HwCZ5Z7MnULtO+qskKCHCsdidOBa9rTK+J1009bTCDl
jS0rOBsP5qNU+xClNKDXFYqcDjNZgQTvvnSWAn1b0zn2U2uYp1ghtO4yChTj58l1
824YHCdSzspuCEZCTvFag6wZT2c8Q/aeTFJFToA8GiVOM3pRb0YiDvId8tfS2hMC
fKg5NJMXtgNyvgrp9edAHpb26+1vwgYXVnOITDkZI+Dx3YTIl1+lC0ycqwJvJ3Az
KCyfJ4gDgouDwIvnLMkMdOgjHAjVySP6W2ETLAoocx2pHL7fT6BNCv1HTHuD/UAS
Vsr2cAGMvFBBb3x/fm4FaV6BNkQ0uUi0UEpRG7Ch6Hur3m+PnjTeGkXq8n98/9Ic
XepyaqZoyW3txWb3vrWWMayLZKXL1hQxT4RV9gmcEQw0F1ds7lw=
=67Xz
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

