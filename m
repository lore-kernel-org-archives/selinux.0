Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A255DC3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B05420848
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCERuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:50:03 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:47464 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgCERuD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Mar 2020 12:50:03 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A2B11132004B;
        Thu,  5 Mar 2020 18:50:01 +0100 (CET)
Date:   Thu, 5 Mar 2020 18:50:00 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: strange pam selinux issue
Message-ID: <20200305175000.GI1032355@brutus.lan>
Mail-Followup-To: Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20200304072940.GA1026144@brutus.lan>
 <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
 <20200304143650.GB1032355@brutus.lan>
 <CAEjxPJ4OPGWnc1uPDmqSuFnbFhzGYxenSyZ7WmxtnJ3Y2BdAzQ@mail.gmail.com>
 <pjdblpa7lks.fsf@redhat.com>
 <20200305173941.GH1032355@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <20200305173941.GH1032355@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 06:39:41PM +0100, Dominick Grift wrote:
> On Thu, Mar 05, 2020 at 06:33:55PM +0100, Petr Lautrbach wrote:
> >=20
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >=20
> > > On Wed, Mar 4, 2020 at 9:36 AM Dominick Grift
> > > <dominick.grift@defensec.nl> wrote:
> > >>
> > >> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> > >> > Are you using libselinux with or without the commit to stop using
> > >> > security_compute_user()?
> > >> > If still using security_compute_user(), what does compute_user
> > >> > sys.id:sys.role:sys.isid:s0 wheel.id display?
> > >> > If you don't have compute_user (it is in libselinux/utils but not =
sure
> > >> > Fedora packages it), you can also just
> > >> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.rol=
e:sys.isid:s0
> > >> > and see what it read back from /sys/fs/selinux/user.
> > >>
> > >> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contex=
ts/users/wheel.id...
> > >> I am not if my libselinux has or has not security_compute_user():
> > >>
> > >> # rpm -qa libselinux
> > >> libselinux-3.0-3.fc32.x86_64
> > >>
> > >> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) =3D 3
> > >> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) =3D -1 ERANGE (=
Numerical result out of range)
> > >
> > > This shows that your libselinux is still calling
> > > security_compute_user() from get_ordered_context_list().
> > > In this case, because the source context is allowed to transition to
> > > many other contexts, the result returned via
> > > /sys/fs/selinux/user would exceed the maximum size supported by the
> > > kernel interface (one page of contexts),
> > > and therefore it fails.  Then get_ordered_context_list() falls back to
> > > the failsafe_context.
> > >
> > > If you update to libselinux git, you will stop using
> > > security_compute_user() and hence /sys/fs/selinux/user entirely.
> >=20
> > FYI I've just built libselinux-3.0-4.fc32 [1] and libselinux-3.0-4.fc33
> > [2] with the security_compute_user() patch applied.
> >=20
> > [1] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474378
> > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474377
>=20
> Thanks, trying it out

[root@myguest ~]# strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.i=
d:sys.role:sys.isid:s0
wheel.id:wheel.role:user.systemd.subj:s0
wheel.id:sys.role:sys.isid:s0

So that result looks promising, but when I login I still get wheel.id:sys.r=
ole:sys.isid:s0
Is that some compatibility related thing, or does something else need to be=
 rebuilt against this libselinux for it to work?

> >=20
> > --=20
> > ()  ascii ribbon campaign - against html e-mail=20
> > /\  www.asciiribbon.org   - against proprietary attachments
> >=20
>=20
> --=20
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift



--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5hO8IACgkQAlFoDzf+
eROmhQ/8Dl7t45/K+uIMQdxjNv2cEvwxO95wSYhdwsaMnAXK5dMDkxrArNuIGSFj
Q1viZrMSncOZgSuobHm3kdS4SxFJBpeVIQX0Apsd2ZPkvfDl0Mx6hS7EcuFoAwp9
Q+ewiDNYyZgm8NcnN2BVIJ+ZTJVyn6Ui9/s3i4a9UfdtGN3I2VeDO4qSvPIEa9Wg
z8lpuXWl83Jsmc9cURrzZ6DMg4Onwm/ru1GS4Z4vjDJwFLwZJ6+UvcBuWQqY7b0S
gb2rFun4I06jOcRY53X328OYHk35aV7SXaD7EpY5Qs/NLcJhtNmmbIaim2hDncu9
lBclA+yaUy2Gvpq42H/OGzpQ9HeffVuqQbz1nInc4XnuMt8MRAMgCnxUCyVMLWA8
6OyPJohGgD1xHTS6E+j9EyNP2YmGq/cWgYzaIAAAeIhVspL+FwYbf2KiMHvnQIfR
NBDxosoT6udxQqIAezuaFAxnKxH2BszYsfvnix/hCH3plZbaHfTHHRqjQtXjL7mg
qXfYFtSlvPhA3su8VxmzDLuNx1gEeu5vFvgLpHi3MfBr+PzLTlgBkPCFERn7Up3l
vRk8aFtOhPltZ8qj3z1/sUEkhfLiXSB0K9Ylp39nXqe3mNME5CNYFopLX+qdXecR
fVnfH+u2McsY8yv84vxpYmYtmAALrDvsEV2Uq7J1M+j27T41/L4=
=a+yl
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
