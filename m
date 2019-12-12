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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E6C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D482067C
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7+Y/5ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfLLOby (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:31:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfLLOby (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 09:31:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so3751371wmj.1
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 06:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZ+3AfsC6TE4txYGGUXXKTCyRG3FmXKKH73Q53j2YbM=;
        b=o7+Y/5ERpRRfGFCVY8AyLJap8Kh8FmiDpNU855jLJhi4bozWfUx0am2sK84Pn8HuKW
         MrGQFQEm+Nw+HG4zP8jPq7siPn3Plo+Xp65rMVh+/3eDtXrN6xdTO28DsY6A7JziqFkj
         tHDVRZPqHkT4n3W4AS6JHf29WV6IgOFKmawe8WpQXs4NbMChjzBJyFQUJ+C4r8hipRVi
         46lxYWDSv0J/+LxL/U2MMZ14LyaQX7sCwqKuj0dRla0DWWAKzRyOMoILPiDYm+1U9ylv
         a9Izq5gpGuT92PJaeFJnIcNP1qULRtGxPPY3ogNo8Z5fVjBBpRFWJM7bMNFPf7SAr3rR
         R9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZ+3AfsC6TE4txYGGUXXKTCyRG3FmXKKH73Q53j2YbM=;
        b=i393vSXtRnhDU05l9fCE9Qhi0sIH4xuN36oBtmtvnB//dgXyoBX6WBuzTRI+aKZIdB
         QSUN9IJCGE29pMbDjkjhmiIDlg09gnzN0nJgzZltc7Io8XDLPxMIRMydwvTmoUB8JW72
         O/Z+5UbqinQhI7M0BLE4QJybBmGUTH7GP1PliaJgrkwdOndHChkU9v5PNMkJJ4U2RoAG
         w1wtRnFIQPRe8q+cOe3JXj/Cn9zlXrHPowluZJzFFlfWOohZao1BsCSNesPGuH6DF0lO
         PROGXGZ5/j4XgeFQIaFowkANpooqRdhYp3HbPghSnTrS52nIxvFr23t+7uIhMSYRmk+r
         im4g==
X-Gm-Message-State: APjAAAVzIM5XFWbkRXyGyix98n0mdMa5Hzi3lsMWRlxnOaZz/yYsNrrN
        0yAn2KlfiCJ6eaK/kvTDQFAphGEE
X-Google-Smtp-Source: APXvYqzm+JTZyiVDQwWw0ZIO/gfQdwuVltpy6vN84q2M/V1EH5NoxSr3zfpNL/11SIqBUKHelJmhSw==
X-Received: by 2002:a1c:204c:: with SMTP id g73mr7182563wmg.33.1576161111275;
        Thu, 12 Dec 2019 06:31:51 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id d12sm6175152wrp.62.2019.12.12.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:31:50 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:31:48 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: [PATCH v2] mcstrans: start early and stop late
Message-ID: <20191212143148.GB2670272@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191211134423.2357254-1-dac.override@gmail.com>
 <20191211142124.GB2233813@brutus.lan>
 <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
 <20191212142436.GA2670272@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20191212142436.GA2670272@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 03:24:36PM +0100, Dominick Grift wrote:
> On Thu, Dec 12, 2019 at 08:45:29AM -0500, Stephen Smalley wrote:
> > On 12/11/19 9:21 AM, Dominick Grift wrote:
> > > On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
> > > > It stopped too early, exposing a bug in sudo selinux_restore_tty():
> > > >=20
> > > > SELINUX_ERR op=3Dsetxattr invalid_context=3D"wheel.id:wheel.role:us=
ers.terminals.pty.pty_file:SystemLow"
> > > > avc:  denied  { mac_admin } for  pid=3D859 comm=3D"sudo" capability=
=3D33 scontext=3Dwheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=3Dwheel.id=
:wheel.role:sudo.wheel.subj:s0 tclass=3Dcapability2 permissive=3D0
> > > >=20
> > > > If we want to be able to reference human readable contexts in SELin=
uxContext=3D and nspawn -Z and -L then we need mcstrans ASAP
> > >=20
> > > Unfortunately it does not quite seem to address this challenge, at le=
ast currently, but still
> > > I think systemd would need to refresh its label cache when mcstrans i=
s started, as per systemd v245 that should be a little less painful than it=
 is today
> > > Something like a: ExecStartPost=3D/bin/systemctl daemon-reload would =
do that then
> >=20
> > I'm a little unclear on where the bug lies - you show a sudo denial, but
> > refer to systemd as the culprit?
>=20
> The sudo bug is fixed here: https://github.com/sudo-project/sudo/commit/7=
18e6997fcaae6ea065ce74d08dd4aae5917df5e
>=20
> >=20
> > If we don't care about being able to use translated contexts in systemd=
 unit
> > files or options, it could always use the _raw interfaces to ensure tha=
t it
> > is always dealing with the raw kernel contexts.  The translated context=
s are
> > mostly for display purposes for MLS labels/policies.

The bevavior of mcstrans seems to  contradict your suggestion that its most=
ly for display purposes.

If you reference a set of categories in the raw manner then mcstrans seems =
to not resolve that until that same set of categories is referenced in huma=
n readable form.
It think it actually makes sense that people reference catagories in human =
readable form rather than in a raw manner when they opt in for mcstrans.

>=20
> The thing with systemd is that since systemd runs before mcstrans is star=
ted it doesnt use mcstrans.
> So if you try to reference translated contexts using systemd then it will=
 refuse.
> Running a systemctl daemon-reexec after mcstrans is started fixes that is=
sue but that is not really an option.
>=20
> I am wondering what causes this behavior, i suppose this is some libselin=
ux thing.
>=20
> Regardless of all the above though, i think it makes sense for mcstrans t=
o start early and stop late.
>=20
> >=20
> > >=20
> > > >=20
> > > > v2: stop late, but do stop
> > > > Signed-off-by: Dominick Grift <dac.override@gmail.com>
> > > > ---
> > > >   mcstrans/src/mcstrans.service | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.=
service
> > > > index 09529432..c13cd09a 100644
> > > > --- a/mcstrans/src/mcstrans.service
> > > > +++ b/mcstrans/src/mcstrans.service
> > > > @@ -2,6 +2,9 @@
> > > >   Description=3DTranslates SELinux MCS/MLS labels to human readable=
 form
> > > >   Documentation=3Dman:mcstransd(8)
> > > >   ConditionSecurity=3Dselinux
> > > > +DefaultDependencies=3Dno
> > > > +Before=3Dshutdown.target sysinit.target
> > > > +Conflicts=3Dshutdown.target
> > > >   [Service]
> > > >   ExecStart=3D/sbin/mcstransd -f
> > > > --=20
> > > > 2.24.0
> > > >=20
> > >=20
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3yT1AACgkQJXSOVTf5
R2mVNAv8DA5xg11qASDziLCL/J76/xD34/aiSYAVyQW6Lz5IKrYIC3gUTEakxyci
oW+r+NiRhMrzwH7nm0kQLWlJD/pJFoXFr0h2qSzHlKT5fCJSDslrH8pVq+SbnUcd
3KCDxcnABk8VUUytIcGM6voM/zgE89IXUKUzKse3FKq0Lj+tENtyeufDmGYoApT2
JGl5qL0bDbJveOPFUipySkJz9JYvBmsRSpcR0cctRz/1R59VH43jXJI7Nn88j9hr
OP0N/ohSxTuXQd2H0ExgOBsXhi6DHUm+NKexGiJuZgHO4+pL/gHo0ztvVcE5MS2m
6KPJ/j09HbywqvP4dnIFXZB2X2ZeyyQkAIsqtvzHmi5qWEkeEMrBUq9rOStEntG1
PhrwHrzR6ePli4At47NMTsTRUvI2t12tuAbRB7kjf5lg/13yTB+dcfTDO5Fe7ZsH
w0FzLXWKFRyYiaA4gCfycivJ0qjIVfSK+2EUorapHLgta1gJO9VT/qEv0ivZhEdb
dyR0LOor
=1hXG
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
