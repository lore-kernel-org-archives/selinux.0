Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAUKJfuT009917
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 15:19:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3ynpfL0qQZz630p
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 20:19:38 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3ynpfD5kBGz630P
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 20:19:32 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id l141so15378297wmg.1
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 12:19:23 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id r4sm5163525edd.4.2017.11.30.12.19.21
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Nov 2017 12:19:22 -0800 (PST)
Date: Thu, 30 Nov 2017 21:19:20 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171130201920.GA32637@julius.enp8s0.d30>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
 <1511971345.10464.14.camel@tycho.nsa.gov>
 <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
 <1511972400.10464.16.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 11:10:43AM +0530, Aman Sharma wrote:
> Hi Stephen,
>=20
> After reseting Selinux targeted folder also (the steps you mentioned in t=
he
> earlier mail), Still its showing the same Id context i.e.
>=20
> *id*
> *uid=3D0(root) gid=3D0(root) groups=3D0(root)
> context=3Dsystem_u:system_r:unconfined_t:s0-s0:c0.c1023*
> *[root@cucm2 ~]# id -Z*
> *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
>=20
> *And semanage login -l is showing blank output. *
>=20
> *Do you have any idea about this.*
>=20
> *Thanks*
> *Aman*

Try the same procedure again but this time also do before reinstalling:

mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old

>=20
>=20
> On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>=20
> > On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:
> > > After resetting boolean also, showing the same id context.
> >
> > And did you try fully resetting your policy as I suggested:
> > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > yum reinstall selinux-policy-targeted
> > reboot
> >
> > >
> > >
> > > On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > wrote:
> > > > On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> > > > > Hi Stephen,
> > > > >
> > > > > After enabling the unconfined module and after reboot also, Still
> > > > > showing the same id context.
> > > > >
> > > > > Is there any way to make the id context to normal state again ?
> > > >
> > > > Hmmm...try resetting all booleans too?  semanage boolean -D
> > > >
> > > > Or you could be drastic and completely reset your policy:
> > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > yum reinstall selinux-policy-targeted
> > > >
> > >
> > >
> > >
> > > --
> > >
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >
>=20
>=20
>=20
> --=20
>=20
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlogZ8QACgkQJXSOVTf5
R2kjgwv/eYOX3qAV+ksjqRt4A2iJ4fczjJ68oN4f+10aRo8L+mnttd55JMKAl3rA
lZEBKgg5Qo4u44cWOCK1qLcPRGoGdRY0CpWrlqhKyTO6Yz5qq/wjNOWDjhAuHODe
DSL8c6e2p2Sa+gAhtq5lse0aD/jh/ZEDaxTtl723FxD8nJ85/SHSK97s8u+wHY6+
3cKVBnZN0IACWeHmPZ836OnVV8nxA7ThBmoGGoSD9Amy2FWzdMQcPk9RirUeOqId
Al+En+f3C5xTasBPSApWusa+TmsxmUpV+sh43qqyZRD9A/jh2Vdcn2ScKy4QmaAv
0IXgjlNtakcQyQM/N/97Db+vGh1bHueZm+mpRzWCZM1ZJpzv0j/U3MpNQp8nzmwr
DiddAaTJSjFCrgEKHkINUy0u3TUJN6j7OxJ27WhSwbphqog+dDrLutM/iAU567fo
h1X+FMdiN8kiXVQ2icOtPu7sPVJ3E+GZ9zOoMyPvx8vjD+vG2h7xDTmeXep0ridB
U1uDmydR
=BHfx
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
