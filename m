Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBDIHlad016651
 for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2017 13:17:47 -0500
Received: by mail-wm0-f52.google.com with SMTP id b76so6973876wmg.1
 for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2017 10:17:38 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id n3sm1934199edb.46.2017.12.13.10.17.34
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Dec 2017 10:17:34 -0800 (PST)
Date: Wed, 13 Dec 2017 19:17:33 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171213181733.GA17558@julius.enp8s0.d30>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
 <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 09:40:25PM +0530, Aman Sharma wrote:
> Hi Stephen,
>=20
> Yes , I am using open env_params for it. But for this, my sftp is not
> working and getting the below error message :
>=20
> Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session): Unable to
> get valid context for sftpuser
> Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
> opened for user sftpuser by (uid=3D0)

Not sure if this is actually the issue but:

AFAIK the user must have access to "context contains" for env_params

See if the context assoc. with the sftpuser process has access to context c=
ontains

>=20
> Please let me know if you have any idea on this.
>=20
> On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
>=20
> > On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> > > Hi All,
> > >
> > > just wanted to know the meaning of line session    required
> > >  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> > > Actually I am facing one issue related to this. When I changed this
> > > env_params to restore then my Sftp is not working.
> > >
> > > Can anybody Please guide me on this.
> >
> > man pam_selinux describes the options and what they mean.
> > Why did you change it to restore?  Per the man page, restore is to
> > temporarily restore the contexts and would be a separate entry in the
> > PAM stack before the module that needs the original contexts, followed
> > by a pam_selinux.so open env_params after that module to set them up
> > again.  But don't use restore unless you actually need it for some
> > reason.
> >
> >
> >
> >
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

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAloxbrkACgkQJXSOVTf5
R2mrMAv9GBQNIy/6Q0k0paUKFnS7D9IyKPowObsBaEZRHvuVJbalWurEWI6RZnow
78IZ4DS8zbvqHnL3XZA7vjI4sXztMlonvkG1t5I7pRDAu2k9knhTq/oPkY0khiy8
+CO1vLrpTlH0cBkrYF7/IknLaEaLWnFOiKlu9SDLSoLXqQ1Mh3Vv+IU0UMXpJMSE
gKMpAF+Fck9N3aELAobtpB6TmVS2RF3i+1VFel0ZHiJW7rRObo45e2/rwrxKtta1
raz/xntEgVfO0ry9ivoGVBP+UUSb6Zf4myWI8zDX5M8lJJJHqMyYkXuG0YlY4719
VSJSmlrJdrG4pSoCzBDwkYun9tDJBIm7+/oGKvV447CmmFzRMHi3N/CIumRMbUD1
MyPze+FobrWBcbOt3KNAfseMZfj0fuuLgDzsmOYAMd6Ws+q/MqcHVF92TDA39rJW
JF4JtgA0pyZp3t9N6PE3HFPQFKIpPdD+Ynzt7+5zcZascrmTLi9Q8MFozu48ibWg
sNEOrv+T
=5CFp
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
