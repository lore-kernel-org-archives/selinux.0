Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC6C3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A8320866
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCDOkb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:40:31 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:46850 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgCDOkb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 09:40:31 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 0AEA3132006F;
        Wed,  4 Mar 2020 15:40:29 +0100 (CET)
Date:   Wed, 4 Mar 2020 15:40:27 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: strange pam selinux issue
Message-ID: <20200304144027.GC1032355@brutus.lan>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200304072940.GA1026144@brutus.lan>
 <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
 <20200304143650.GB1032355@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20200304143650.GB1032355@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 03:36:50PM +0100, Dominick Grift wrote:
> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> > On Wed, Mar 4, 2020 at 2:44 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > >
> > > On Wed, Mar 04, 2020 at 08:29:40AM +0100, Dominick Grift wrote:
> > > > The easiest way to explain this is as follows.
> > > >
> > > > Consider this scenario:
> > > >
> > > > # seinfo -xuwheel.id
> > > >
> > > > Users: 1
> > > >    user wheel.id roles wheel.role level s0 range s0;
> > > >
> > > > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > > > wheel.id:wheel.role:user.systemd.subj:s0
> > > >
> > > > Now consider this scenario:
> > > >
> > > > # echo '(userrole wheel.id sys.role)' > hack.cil && semodule -i hac=
k.cil
> > > >
> > > > # seinfo -xuwheel.id
> > > >
> > > > Users: 1
> > > >    user wheel.id roles { wheel.role sys.role } level s0 range s0;
> > > >
> > > > Here is the issue:
> > > >
> > > > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > > > wheel.id:sys.role:sys.isid:s0
> > >
> > > For completeness:
> > >
> > > # cat /etc/selinux/dssp3-mcs/contexts/users/wheel.id
> > > sys.role:login.subj:s0 wheel.role:user.subj:s0
> > > sys.role:ssh.daemon.subj:s0 wheel.role:user.ssh.subj:s0
> > > sys.role:sys.isid:s0 wheel.role:user.systemd.subj:s0
> >=20
> > Are you using libselinux with or without the commit to stop using
> > security_compute_user()?
> > If still using security_compute_user(), what does compute_user
> > sys.id:sys.role:sys.isid:s0 wheel.id display?
> > If you don't have compute_user (it is in libselinux/utils but not sure
> > Fedora packages it), you can also just
> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:sys=
=2Eisid:s0
> > and see what it read back from /sys/fs/selinux/user.
>=20
> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contexts/us=
ers/wheel.id...
> I am not if my libselinux has or has not security_compute_user():

Scratch that, the reference to /sys/fs/selinux/user in the trace below impl=
ies that security_compute_user() is still there
>=20
> # rpm -qa libselinux
> libselinux-3.0-3.fc32.x86_64
>=20
> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) =3D 3
> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) =3D -1 ERANGE (Numer=
ical result out of range)
> close(3)                                =3D 0
> openat(AT_FDCWD, "/etc/selinux/dssp3-mcs/contexts/failsafe_context", O_RD=
ONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D21, ...}) =3D 0
> read(3, "sys.role:sys.isid:s0\n", 4096) =3D 21
> close(3)                                =3D 0
> openat(AT_FDCWD, "/sys/fs/selinux/context", O_RDWR|O_CLOEXEC) =3D 3
> write(3, "wheel.id:sys.role:sys.isid:s0\0", 30) =3D 30
> close(3)                                =3D 0
> fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(0x88, 0), ...}) =3D 0
> write(1, "wheel.id:sys.role:sys.isid:s0\n", 30) =3D 30
>=20
> --=20
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift



--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5fvdUACgkQAlFoDzf+
eRPM9Q//Y523P4CxpIk1fH56it1pZ65qWvHlgbJomf27Dijtf+y+xvYTKuKOof3p
uPHFbGhf0nkv0IydXOCOzMuGgcSHdY0HtFlU/tpQl2VA3Q+t6UCzsvgKNRzgq+U2
oAJCv+/MNLL25VXpaiU/TY422VqhD4SlxnnRsUBuBK1JYIg6l83PD8LxyLsW/rNX
WabYP0E+NILZbOwqvg5Gt2teVBeyWqaKuE1prkVFFuptHYDFvaXMyy22Xz9922NY
bUKW9GZCG4yHVPPmJM/8jkItD7Jz2gi4yV799fTpJ45FbDRrREZzjQ/5y6KKEMj/
D5vlMhBSJkgt1EmPzuKTZYUbAOFriN6YSG6rbe6zvP5e+achGQfV6og7Y2SevS6X
7Uv4gjhtkCi3WbpQvOOwRiBProcuIleXAK9XGBpnEL4fQARP4XJSWslHoHpDNsql
SpVS1jGALxhBIEdsZja5AIIEga8+sXGHJDkHts0qfnUoaiVFqwTwO5Jj5B0eg0dI
Cw412SXwOfEOpsmqaMqovveKp2qbz34Zh9kpBVa5fIrvQm3FriJ4RlYCrW7Y+PEI
1EH8VblynClPxYska+92AOIZzFYV6X54hW60gpMWxUtDIi3h0bFkSaW6KLEowBmP
RqRB5RK1plvugAHkSYSPCYlZ4QjM3KRzo12/SL4Dgtbvg8vqe8U=
=ugJB
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
