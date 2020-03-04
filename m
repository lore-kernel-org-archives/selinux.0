Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B6EC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4440B20838
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgCDOgx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:36:53 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:46820 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgCDOgx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 09:36:53 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2E421132006F;
        Wed,  4 Mar 2020 15:36:51 +0100 (CET)
Date:   Wed, 4 Mar 2020 15:36:50 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: strange pam selinux issue
Message-ID: <20200304143650.GB1032355@brutus.lan>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200304072940.GA1026144@brutus.lan>
 <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> On Wed, Mar 4, 2020 at 2:44 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > On Wed, Mar 04, 2020 at 08:29:40AM +0100, Dominick Grift wrote:
> > > The easiest way to explain this is as follows.
> > >
> > > Consider this scenario:
> > >
> > > # seinfo -xuwheel.id
> > >
> > > Users: 1
> > >    user wheel.id roles wheel.role level s0 range s0;
> > >
> > > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > > wheel.id:wheel.role:user.systemd.subj:s0
> > >
> > > Now consider this scenario:
> > >
> > > # echo '(userrole wheel.id sys.role)' > hack.cil && semodule -i hack.=
cil
> > >
> > > # seinfo -xuwheel.id
> > >
> > > Users: 1
> > >    user wheel.id roles { wheel.role sys.role } level s0 range s0;
> > >
> > > Here is the issue:
> > >
> > > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > > wheel.id:sys.role:sys.isid:s0
> >
> > For completeness:
> >
> > # cat /etc/selinux/dssp3-mcs/contexts/users/wheel.id
> > sys.role:login.subj:s0 wheel.role:user.subj:s0
> > sys.role:ssh.daemon.subj:s0 wheel.role:user.ssh.subj:s0
> > sys.role:sys.isid:s0 wheel.role:user.systemd.subj:s0
>=20
> Are you using libselinux with or without the commit to stop using
> security_compute_user()?
> If still using security_compute_user(), what does compute_user
> sys.id:sys.role:sys.isid:s0 wheel.id display?
> If you don't have compute_user (it is in libselinux/utils but not sure
> Fedora packages it), you can also just
> strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:sys.i=
sid:s0
> and see what it read back from /sys/fs/selinux/user.

Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contexts/user=
s/wheel.id...
I am not if my libselinux has or has not security_compute_user():

# rpm -qa libselinux
libselinux-3.0-3.fc32.x86_64

openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) =3D 3
write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) =3D -1 ERANGE (Numeric=
al result out of range)
close(3)                                =3D 0
openat(AT_FDCWD, "/etc/selinux/dssp3-mcs/contexts/failsafe_context", O_RDON=
LY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D21, ...}) =3D 0
read(3, "sys.role:sys.isid:s0\n", 4096) =3D 21
close(3)                                =3D 0
openat(AT_FDCWD, "/sys/fs/selinux/context", O_RDWR|O_CLOEXEC) =3D 3
write(3, "wheel.id:sys.role:sys.isid:s0\0", 30) =3D 30
close(3)                                =3D 0
fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(0x88, 0), ...}) =3D 0
write(1, "wheel.id:sys.role:sys.isid:s0\n", 30) =3D 30

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5fvPwACgkQAlFoDzf+
eRNVTA/+PIQSXis/b/uWMetc+ReavfxEJBGcUQ0hkKZLNrX0pClni3IadnLdqyTP
MlIbiDv/XpntECKZIqsmLJ9NhGD1Cq2Fs+dzuXZOHl5T+XT5UB7sRREcXhDg2ctN
6hYIwMua4rAj1oYhCZZ/rIn3Mgn7sE+wx74DQbbP/NNKSwq5pDbW9G9jdQt8UDne
2orsVN8F2Fw8TlgMjLIVUAn+xbjvfbW/aZnVrsFIA1dSI2UUeWtDlYLPAtHcjCri
BlGbrTdhwa//MpATCLsZTc7yku33jVugejFHZNUImRGC2CS8Bk3Bm5biWAzsK6uA
9GylCMMV6chYPuZu9jNzq9Deen7+Tq4wk8Q2TpsdQ4c9u7cCc1QEbsNL4C3iTFA8
HFjbd810pYuHEtmwu02i48lvZ71AH9Jg4AVTa5824qC8/ujVGM0vPFYFKnfu+G83
jMOOxUut+r6yovZ0klAIpiU8BAms9zbpITiEUDXbJcNRpRzUdORBKqlJAP3ZU3WE
2MEd6q9Id4HMElUo+ha23zmkr18tstPY/DXAxl+0PmMIcIqzKlfEAtomimK5/sC8
STY8wK6LOfg/UGUMsN5lbDgTYhzLcpxE3c0ANUDuh2ioZKwtfjpbT3ydG8cbMdNB
xBbua1Sfw3WEFaHXb7OF/tw8/ftrashx5KelXzSVYjROxWiFV+M=
=4G5N
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
