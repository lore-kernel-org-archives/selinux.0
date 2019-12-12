Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BDC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0E321655
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQ48Y6KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfLLOYm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:24:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54822 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbfLLOYm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 09:24:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2564854wmj.4
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4CkG7opYyUKToCwOChTkAZCMCx+uERXRKw/sWACDL4=;
        b=uQ48Y6KEW/n8ctdncuA/vfciWraOkL6NkTOzw1/eQTVkN6MoiHs1xVYoYzOySOf+hm
         o3PMYs6lzlOuA8VKLaVaaFLJYy965Hx2vo+WdZaWX81KbbbrndWydQg+AFIe24y/nZED
         vTkOFTAHIn0DC4sFbHqbchbUuvvnGfqzL9H04LhI/3gt5mAii5wBATHyrVeYChzwKwlY
         yVuU48W1Qz0x/AuoHXXBCavU7bI6CRz553hEHUv0JoIL+QzZvDN1qwExj0L+GuDz/hSL
         mP5ME084TJ1cuEKFA9a8K1ak5/LPEmaUUYHoyuEJTKFtYsS/2BpR+KFW4xqsLRQgmMtk
         JqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=J4CkG7opYyUKToCwOChTkAZCMCx+uERXRKw/sWACDL4=;
        b=Pkjr22KaZbjx/247QxZZn4YfzX8Gl7G2Kl6n3FEEOe18kBJSM23opJCQ7CLB8qAFMH
         jFhHEOJgj9MBPI6OUim3+B5MjbT680dPvLPDS83T4z/QwrmukADdi9/U2IBG6ApT1sbz
         RlFd4aVxrFZuVdnZHrezw2Qeop+vYHZ0y314lEd8ppURhfuZ7v4AUWQoAtY4KqjrAUjm
         rMrnld4JCMtSy1MXLyeKBP1AGa549vbh9x0jt9G38qHJ4UKRkRtuD21Q60HwjVvYd+W7
         4jnY/VYkOWoRKjgQynm8DuJGKvchRfJ2aArW0g74doD4lbVG1wFrw6jpHnFkcHXNlf+5
         SKEg==
X-Gm-Message-State: APjAAAX7n0zyAdm4pjjhK2+1ez292ED/ZmxzpD6ncJkFcLrpjD1nWfus
        kYVBAjvGn6zmU6tYKd/UTN6n66/j
X-Google-Smtp-Source: APXvYqwhJfNi+8Xv74VgsYiyePQSOvSQFGdRgHfsAwhYetaRrvf9l7tsaQ4f9hIBujc/iAn9fmS5MQ==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr7413840wmk.46.1576160679025;
        Thu, 12 Dec 2019 06:24:39 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id r15sm6158211wmh.21.2019.12.12.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:24:37 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:24:36 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] mcstrans: start early and stop late
Message-ID: <20191212142436.GA2670272@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191211134423.2357254-1-dac.override@gmail.com>
 <20191211142124.GB2233813@brutus.lan>
 <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 08:45:29AM -0500, Stephen Smalley wrote:
> On 12/11/19 9:21 AM, Dominick Grift wrote:
> > On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
> > > It stopped too early, exposing a bug in sudo selinux_restore_tty():
> > >=20
> > > SELINUX_ERR op=3Dsetxattr invalid_context=3D"wheel.id:wheel.role:user=
s.terminals.pty.pty_file:SystemLow"
> > > avc:  denied  { mac_admin } for  pid=3D859 comm=3D"sudo" capability=
=3D33 scontext=3Dwheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=3Dwheel.id=
:wheel.role:sudo.wheel.subj:s0 tclass=3Dcapability2 permissive=3D0
> > >=20
> > > If we want to be able to reference human readable contexts in SELinux=
Context=3D and nspawn -Z and -L then we need mcstrans ASAP
> >=20
> > Unfortunately it does not quite seem to address this challenge, at leas=
t currently, but still
> > I think systemd would need to refresh its label cache when mcstrans is =
started, as per systemd v245 that should be a little less painful than it i=
s today
> > Something like a: ExecStartPost=3D/bin/systemctl daemon-reload would do=
 that then
>=20
> I'm a little unclear on where the bug lies - you show a sudo denial, but
> refer to systemd as the culprit?

The sudo bug is fixed here: https://github.com/sudo-project/sudo/commit/718=
e6997fcaae6ea065ce74d08dd4aae5917df5e

>=20
> If we don't care about being able to use translated contexts in systemd u=
nit
> files or options, it could always use the _raw interfaces to ensure that =
it
> is always dealing with the raw kernel contexts.  The translated contexts =
are
> mostly for display purposes for MLS labels/policies.

The thing with systemd is that since systemd runs before mcstrans is starte=
d it doesnt use mcstrans.
So if you try to reference translated contexts using systemd then it will r=
efuse.
Running a systemctl daemon-reexec after mcstrans is started fixes that issu=
e but that is not really an option.

I am wondering what causes this behavior, i suppose this is some libselinux=
 thing.

Regardless of all the above though, i think it makes sense for mcstrans to =
start early and stop late.

>=20
> >=20
> > >=20
> > > v2: stop late, but do stop
> > > Signed-off-by: Dominick Grift <dac.override@gmail.com>
> > > ---
> > >   mcstrans/src/mcstrans.service | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.se=
rvice
> > > index 09529432..c13cd09a 100644
> > > --- a/mcstrans/src/mcstrans.service
> > > +++ b/mcstrans/src/mcstrans.service
> > > @@ -2,6 +2,9 @@
> > >   Description=3DTranslates SELinux MCS/MLS labels to human readable f=
orm
> > >   Documentation=3Dman:mcstransd(8)
> > >   ConditionSecurity=3Dselinux
> > > +DefaultDependencies=3Dno
> > > +Before=3Dshutdown.target sysinit.target
> > > +Conflicts=3Dshutdown.target
> > >   [Service]
> > >   ExecStart=3D/sbin/mcstransd -f
> > > --=20
> > > 2.24.0
> > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3yTZ8ACgkQJXSOVTf5
R2l2VgwAinA56FB8gdYP1XSlx/msY5wtS5mzF326Gm7bRIG6iPR+7IeSlxoWkmVg
33IgzWwzxFjdteJb2SLIRdbztOrauXNZgU2+GQBAA5mIPpXufv3WACdsuUd6oO/U
d020LR8bZcv8MCDXmzlEeRPApQXEGCBwaJjAtyu1Fls2gLMCe1vnWERd03pEIvgQ
/IhgzKgme44xN9Te7YKps26JuAkcBPY2R42gazBrcKPqQb3tITJLEXVypQ12rqWu
FKmqNDV6dYoU1xkwKjHg6Rc28ij5D6jtKM2mPzmeV+HDP4ufT6i2yCBm2MekeTo3
xW+7774rfquHH0jJRbK660/0oO5S0X8wH2s3nrOdZSLjh5noW8zlumXfpOwrHbPs
SfY4e58H0LLOXPIJu0X2iXdcssDcZfoEDdW7TS3BXIDNtyhgaqzru/vp2CtlEUvE
y8bib80NqD+JZ92c3Oacb7gQrg2GSgvBLx53LpmdG7OEyqp+/7bPASs6r2sB8CiG
itPGGFYA
=gZBR
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
