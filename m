Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ACC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 17:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C06120734
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 17:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ7mrAN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFIRIA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:08:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728376AbgFIRH7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 13:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591722478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=kz6XM8AD1Uuy/LY3OLqyzWEueG8u05UbPM4mfJNq79M=;
        b=OQ7mrAN/kHwWjCF49metBkffd435IeGx3MbcEOL1FlqE/iQiJ9coRfoquiiRx3zak8h/1l
        CJC9SQm5z9Djna+77VPI8Of4FvC8ldNMDhK0zYRALNuJXErEizxj3GkeXj6oY5fqau/oR2
        f3Os+R836wEPmod3xNKwP4lrDkD8hSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-uP3j1u1cPAGsnqvv7I9xDA-1; Tue, 09 Jun 2020 13:07:53 -0400
X-MC-Unique: uP3j1u1cPAGsnqvv7I9xDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EA018A8221;
        Tue,  9 Jun 2020 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C289A6298C;
        Tue,  9 Jun 2020 17:07:50 +0000 (UTC)
Date:   Tue, 9 Jun 2020 19:07:47 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Cristian Ariza <cariza@collaborative.li>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: RE: No window opening when running sandbox -S
Message-ID: <20200609170747.GA139421@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 09:02:08AM -0400, Stephen Smalley wrote:
> On Tue, Jun 9, 2020 at 4:05 AM Cristian Ariza <cariza@collaborative.li> w=
rote:
> >
> > $ sandbox -H sandbox/home -T sandbox/tmp -S
> >
> > shows a few Gtk warnings (which I am assuming means Gnome loaded
> > somewhere) but no window opens. In the man page I can't find much
> > information about how sandbox -S actually works so not sure if I am
> > missing something or it's just a bug.
> >
> > I am using Fedora 32 with Gnome.


Do you use X session or Wayland?

Anyway, -S uses gdm, gdm depends on systemd and dbus, and this is blocked b=
y
policy. But gdm session in sandbox doesn't work for me in permissive mode n=
either so it
seems to be completely broken.

On the other hand you should be able to run a specific application like fir=
efox:

$ sandbox -t sandbox_web_t -H sandbox/home -T sandbox/tmp -w 1920x1048 -X f=
irefox


> You are using sandbox as packaged by Fedora in
> policycoreutils-sandbox?  If so, please file a bug against their
> package.
> To be honest, I don't use sandbox myself and I am not sure it is being
> very well maintained these days.  It was originally created by Red
> Hat.
> It seems like it has been OBE by other efforts to sandbox apps on
> Linux e.g. flatpak or snaps although I don't know that any of those
> are leveraging SELinux.  I'd be tempted to remove it upstream unless
> it is getting proper care and feeding.
>=20

I'd actually agree to move sandbox and seunshare out of SELinuxProject/seli=
nux repo. If it's
maitained as an independet project it could also ship and install it's own
policy, has it's release cycle or just die.

Btw few years ago I wrote support for bubblewrap in sandbox so it's uses it
instead of seunshare [1] but I haven't finished it and sent for review.


https://github.com/bachradsusi/SELinuxProject-selinux/commit/5158ea1f552fc0=
98647d4c503f646bdcb6d0737f

Petr
--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7fwdwACgkQviIJHj72
InXiaw//d88jgyOWRoK4JF/+l5zg6rYBSErGgTfFogzsGgA0TOPKIjkTVfB1fRQq
c+LhYDHB31pH3JZR0N8yRy5G1je+0NzUu8v42DgVynUJmNWAPYATEPYoBlNmLf0s
WByOngylG4k30PV1dM++ycKNwaQm8vg7TShlB9aco8COxc0vCfDZbBb3eF5UWB89
yLm0KQmHFP3dJgeCp1Km/phg2IrVJSPk+8RuEUmro9Io3js0tQw1sQQrfD/BcUnw
3Ibfk+zBK0NL5A+100Ee12SRyr2FOngbulKCy9/fHSWlplM53/mVLWXL3zglhkLa
9oivJ1bTMqi6XGo/WkmCMA+Bqtel9vToMyATacDfGxdeODbdABSSA8e9hJOa24zp
pjufK+sQC9Xyy/PNllyy2Y9lLqSwkpQL3syhQCMH96929d04HIJHes6PBuhE/Vb8
KO3RoFhrrtxZ1iN6JsraZBOQJqz4BNqXUxkI//Z+PbHa6+Y1o404lyrSNpaE36li
PZGrNIL1bYitfZbWtXIqOkutR+EQvQ2F+AQ7C/+btiujwDMg+8HeoIUwfhPLdCEF
5QH0GMeKyCjRMgGYeiKhuLGTe4RV3A2nNnmbzDfqQgHfdYFuBIFHJ+EPcV5LHHkB
RZ/EfsFBlE0/T8AZzjAU4+g0dl192M4ZPN7x7U9RZ9XB4IqfjRA=
=94kL
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

