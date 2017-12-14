Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBE8GWdB020855
 for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2017 03:16:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3yy5xS0ymSzJ3JJ
 for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2017 08:16:28 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3yy5xR35SjzJ3JP
 for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2017 08:16:27 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id t8so9554506wmc.3
 for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2017 00:16:26 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g20sm3101791edb.75.2017.12.14.00.16.24
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Dec 2017 00:16:25 -0800 (PST)
Date: Thu, 14 Dec 2017 09:16:23 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171214081623.GB17558@julius.enp8s0.d30>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
 <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
 <1513192514.25026.5.camel@tycho.nsa.gov>
 <CAPMH7-9F4H_e-VmHqOzdpCq0JkN-y71-ye152yBixZrHHmOd5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <CAPMH7-9F4H_e-VmHqOzdpCq0JkN-y71-ye152yBixZrHHmOd5g@mail.gmail.com>
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1. cat /etc/selinux/targeted/contexts/users/specialuser_u
2. priv logins are allowed as per the ssh_priv_logins boolean?
3. do you get the same result when you associate "sftpuser" with selinux us=
er "user_u"?

On Thu, Dec 14, 2017 at 12:48:42PM +0530, Aman Sharma wrote:
> Hi All,
>=20
> Below is the output of semanage USer command output for sftpuser:
>=20
> *specialuser_u   user       s0         s0
>  sysadm_r system_r*
>=20
> and for command semanage login -l , output is :
>=20
> *sftpuser             specialuser_u        s0                   **
>=20
> *and also, after adding the debugging option, its showing the below error
> message as :*
>=20
> Dec 13 15:46:10 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session): Unable
> to get valid context for sftpuser
>=20
> Dec 13 15:46:10 cucmSUB authpriv 5 sshd: pam_selinux(sshd:session): Open
> Session
>=20
> Dec 13 15:46:11 cucmSUB authpriv 7 sshd: pam_selinux(sshd:session):
> Username=3D sftpuser SELinux User=3D specialuser_u Level=3D s0
>=20
> Dec 13 15:46:11 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session): Unable
> to get valid context for sftpuser
>=20
>=20
> also Selinuxdefcon command is showing error while running for sftpuser i.=
e.
>=20
> *sudo /usr/sbin/selinuxdefcon sftpuser system_u:system_r:sshd_t:s0*
>=20
> */usr/sbin/selinuxdefcon: Invalid argument*
>=20
>=20
> *Please let me know your comments on this.*
>=20
>=20
> *Thanks*
>=20
> *Aman*
>=20
> On Thu, Dec 14, 2017 at 12:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>=20
> > On Wed, 2017-12-13 at 21:40 +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > Yes , I am using open env_params for it. But for this, my sftp is not
> > > working and getting the below error message :
> > >
> > > Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session):
> > > Unable to get valid context for sftpuser
> > > Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
> > > opened for user sftpuser by (uid=3D0)
> > >
> > > Please let me know if you have any idea on this.
> >
> > Do you have any semanage login mapping for sftpuser or is it just using
> > the __default__ entry? (what does semanage login -l show)  How was
> > sftpuser created?
> >
> > You could add the debug option on the pam_selinux.so line to try to get
> > more information.
> >
> > You could run selinuxdefcon to query what context would be used for
> > that user, e.g.
> > selinuxdefcon sftpuser system_u:system_r:sshd_t:s0-s0.c0123
> >
> > >
> > > On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > wrote:
> > > > On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> > > > > Hi All,
> > > > >
> > > > > just wanted to know the meaning of line session    required
> > > > >  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> > > > > Actually I am facing one issue related to this. When I changed
> > > > this
> > > > > env_params to restore then my Sftp is not working.
> > > > >
> > > > > Can anybody Please guide me on this.
> > > >
> > > > man pam_selinux describes the options and what they mean.
> > > > Why did you change it to restore?  Per the man page, restore is to
> > > > temporarily restore the contexts and would be a separate entry in
> > > > the
> > > > PAM stack before the module that needs the original contexts,
> > > > followed
> > > > by a pam_selinux.so open env_params after that module to set them
> > > > up
> > > > again.  But don't use restore unless you actually need it for some
> > > > reason.
> > > >
> > > >
> > > >
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

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAloyM1MACgkQJXSOVTf5
R2nCbAv+P6gCCU/RFgS17LzmVuYceT8bQRpHr00pZLRzXOlRjLwWc/K+UMURD88J
I+Z/+a4plREGl6iFPxXdjexOQFBhSRzeBieo3tArG8chw7yoftcRVLro8b1KxvEd
2lpxtpq7a2h3cPdB+w+ZDdrOsdrVUAc4z2YOeC/PBKy3VSZwQC0jSdW/WWdvvlwt
sOmHkIFA4odmhs5bsctr1xgNlQctx49AG2gKTSAGm5duwroO9DqRi776ecQY1QKV
WCT/j8vWqngBjo0a0jr74DL7KCZwa+JaYf4Kb9RV1HWUwssdVO+3lIBwzem1Qx7W
CbqsW+8wbUuliYlbVJgMgfDGAZKDFiqD4NepHRQjr1frn67b58ztg0huak4eiDV/
efHttN0TpcQLQxGhNA71MV/B3x2thgEBOKsrTQh5IWc0dyzXhaXeKgFde9+Ow6iM
xoO7/BAexutWBxFNAdzWzz3sf4k423DqYmvF2nWixyrigyyWqgn5wgl3o6GZ0dho
AXFueEBx
=1yXq
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
