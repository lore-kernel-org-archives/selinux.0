Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2AC3F2D2
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9822072D
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCESAV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:00:21 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:47488 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCESAV (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Mar 2020 13:00:21 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 63415132004B;
        Thu,  5 Mar 2020 19:00:19 +0100 (CET)
Date:   Thu, 5 Mar 2020 19:00:17 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: strange pam selinux issue
Message-ID: <20200305180017.GJ1032355@brutus.lan>
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
 <20200305175000.GI1032355@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Content-Disposition: inline
In-Reply-To: <20200305175000.GI1032355@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 06:50:00PM +0100, Dominick Grift wrote:
> On Thu, Mar 05, 2020 at 06:39:41PM +0100, Dominick Grift wrote:
> > On Thu, Mar 05, 2020 at 06:33:55PM +0100, Petr Lautrbach wrote:
> > >=20
> > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > >=20
> > > > On Wed, Mar 4, 2020 at 9:36 AM Dominick Grift
> > > > <dominick.grift@defensec.nl> wrote:
> > > >>
> > > >> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> > > >> > Are you using libselinux with or without the commit to stop using
> > > >> > security_compute_user()?
> > > >> > If still using security_compute_user(), what does compute_user
> > > >> > sys.id:sys.role:sys.isid:s0 wheel.id display?
> > > >> > If you don't have compute_user (it is in libselinux/utils but no=
t sure
> > > >> > Fedora packages it), you can also just
> > > >> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.r=
ole:sys.isid:s0
> > > >> > and see what it read back from /sys/fs/selinux/user.
> > > >>
> > > >> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/cont=
exts/users/wheel.id...
> > > >> I am not if my libselinux has or has not security_compute_user():
> > > >>
> > > >> # rpm -qa libselinux
> > > >> libselinux-3.0-3.fc32.x86_64
> > > >>
> > > >> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) =3D 3
> > > >> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) =3D -1 ERANGE=
 (Numerical result out of range)
> > > >
> > > > This shows that your libselinux is still calling
> > > > security_compute_user() from get_ordered_context_list().
> > > > In this case, because the source context is allowed to transition to
> > > > many other contexts, the result returned via
> > > > /sys/fs/selinux/user would exceed the maximum size supported by the
> > > > kernel interface (one page of contexts),
> > > > and therefore it fails.  Then get_ordered_context_list() falls back=
 to
> > > > the failsafe_context.
> > > >
> > > > If you update to libselinux git, you will stop using
> > > > security_compute_user() and hence /sys/fs/selinux/user entirely.
> > >=20
> > > FYI I've just built libselinux-3.0-4.fc32 [1] and libselinux-3.0-4.fc=
33
> > > [2] with the security_compute_user() patch applied.
> > >=20
> > > [1] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474378
> > > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474377
> >=20
> > Thanks, trying it out
>=20
> [root@myguest ~]# strace -s 4096 -o trace.txt selinuxconlist wheel.id sys=
=2Eid:sys.role:sys.isid:s0
> wheel.id:wheel.role:user.systemd.subj:s0
> wheel.id:sys.role:sys.isid:s0
>=20
> So that result looks promising, but when I login I still get wheel.id:sys=
=2Erole:sys.isid:s0
> Is that some compatibility related thing, or does something else need to =
be rebuilt against this libselinux for it to work?

Never mind , seems i needed a reboot. works now, Thanks!

>=20
> > >=20
> > > --=20
> > > ()  ascii ribbon campaign - against html e-mail=20
> > > /\  www.asciiribbon.org   - against proprietary attachments
> > >=20
> >=20
> > --=20
> > gpg --locate-keys dominick.grift@defensec.nl
> > Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> > Dominick Grift
>=20
>=20
>=20
> --=20
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift



--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5hPisACgkQAlFoDzf+
eROLsQ//QWCLs/6YkqSDId1AOdTM1i5YHRD6+NhsZN/epo37m8z7wukBxf2Du46x
t7pOlyJg8Z/XvnrUulXdVvh3PdIMMCbKqvSKRTwgO4DB1ekVSfn6wGo2CHubsyg6
uFXnWzMsEF+te33+UoRcrd3cgLsU6sq6f/TFC78LvEG7EJtWXMc4ZkSgjcIzQEZJ
XzfoNyK0cP4zhe4dzj40EWj0itrAr8fAOylxCc/gkUTABrFwfBmYCmPcs5LtEMWY
E3GqcWd9rqtXuIs7ZbEuVOS22dxftgQlJCslD+luPBQWaphcLqbtXBFwqAUBbMw0
BkZXFyEe/Vjg4e+4Y9uu/BMRMqZ+aFnd7+P1Vqa42BxbYpGLm7okFthpi+0LtNk0
5ZYVwdg+GQbKg3r/CWocCxuF3+Yy3ispUNfHr3G1rO5Efb8v5+OYwgUPX1gh3kBI
4hE8g6HVUJ3/Y3SFgk+syvQv85wJPGccf4E2joqHN0ER/bB0p0dTHAu+MeRCGKn8
6q3T8qdIRcWEEZISxPC6Qwk3XagAkqmHlLp54HMRF913IBvXHazM7psANWyXOO4r
6cShVnpOE/vMf+ubC640iKmDzUFMXahkGKSqvpY3IbZ1M7l8+8pSWVPP2hsTNCHJ
DwRHDob2o7t/kSFt5Yn2NDJuC2PZK5tF3eks496qLt2S18sltfo=
=BB3p
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--
