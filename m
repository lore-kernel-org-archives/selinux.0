Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAT8MPlc030115
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 03:22:25 -0500
Received: by mail-wm0-f47.google.com with SMTP id l141so4369664wmg.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 00:22:19 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id z56sm821060edb.72.2017.11.29.00.22.16
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Nov 2017 00:22:17 -0800 (PST)
Date: Wed, 29 Nov 2017 09:22:15 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171129082215.GA1225@julius.enp8s0.d30>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 09:33:31AM +0530, Aman Sharma wrote:
> Hi Stephen,
>=20
> Below is the output of command :
>=20
> * sestatus -v output*
> *SELinux status:                 enabled*
> *SELinuxfs mount:                /sys/fs/selinux*
> *SELinux root directory:         /etc/selinux*
> *Loaded policy name:             targeted*
> *Current mode:                   enforcing*
> *Mode from config file:          permissive*
> *Policy MLS status:              enabled*
> *Policy deny_unknown status:     allowed*
> *Max kernel policy version:      28*
>=20
> *Process contexts:*
> *Current context:
> system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> *Init context:                   system_u:system_r:init_t:s0*
> */usr/sbin/sshd                  system_u:system_r:sshd_t:s0-s0:c0.c1023*
>=20
> *File contexts:*
> *Controlling terminal:           system_u:object_r:sshd_devpts_t:s0*
> */etc/passwd                     system_u:object_r:passwd_file_t:s0*
> */etc/shadow                     system_u:object_r:shadow_t:s0*
> */bin/bash                       system_u:object_r:shell_exec_t:s0*
> */bin/login                      system_u:object_r:login_exec_t:s0*
> */bin/sh                         system_u:object_r:bin_t:s0 ->
> system_u:object_r:shell_exec_t:s0*
> */sbin/agetty                    system_u:object_r:getty_exec_t:s0*
> */sbin/init                      system_u:object_r:bin_t:s0 ->
> system_u:object_r:init_exec_t:s0*
> */usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0*
> */lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> system_u:object_r:lib_t:s0*
> */lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> system_u:object_r:ld_so_t:s0*
>=20
> *Also I am using ssh session for login.*
>=20
> *Please let me know how to change id command context to unconfined_u or
> Sysadm_u.*
>=20
> Thanks in advance
> Aman

not sure and shot in dark, but:

root is assoc. with sysadm_u. sysadm_u is only authorized to use sysadm_r.
if you have the boolean ssh_priv_login set to off then sysadm_u:sysadm_r:sy=
sadm_t:s0 is inaccessible
pam_selinux attempts to use any other contexts that are accessible, and it =
appears that system_u:system_r:unconfined_t was it.

Do you have the ssh_priv_login boolean set to off? `getsebool -a | grep ssh`

>=20
> On Mon, Nov 27, 2017 at 9:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
>=20
> > On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:
> > >
> > >
> > > Hi All,
> > >
> > > Currently Working on Cent OS 7.3 and login as a root User and my Id
> > > command output is :
> > >
> > > id
> > > uid=3D0(root) gid=3D0(root) groups=3D0(root)
> > > context=3Dsystem_u:system_r:unconfined_t:s0-s0:c0.c1023
> > >
> > > I want to change System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> > > or unconfined_u:unconfined_r.
> > >
> > > Also showing the output of following command :
> > >
> > > semanage user -l
> > >
> > >                 Labeling   MLS/       MLS/
> > > SELinux User    Prefix     MCS Level  MCS Range
> > > SELinux Roles
> > >
> > > admin_u         user       s0         s0-s0:c0.c1023
> > >  sysadm_r system_r
> > > guest_u         user       s0         s0
> > >  guest_r
> > > root            user       s0         s0-s0:c0.c1023
> > >  staff_r sysadm_r
> > > specialuser_u   user       s0         s0
> > >  sysadm_r system_r
> > > staff_u         user       s0         s0-s0:c0.c1023
> > >  staff_r sysadm_r system_r
> > > sysadm_u        user       s0         s0-s0:c0.c1023
> > >  sysadm_r
> > > system_u        user       s0         s0-s0:c0.c1023
> > >  system_r
> > > unconfined_u    user       s0         s0-s0:c0.c1023
> > >  system_r unconfined_r
> > > user_u          user       s0         s0
> > >  user_r
> > > xguest_u        user       s0         s0
> > >  xguest_r
> > >
> > >
> > >  semanage login -l
> > >
> > > Login Name           SELinux User         MLS/MCS Range
> > > Service
> > >
> > > __default__          sysadm_u             s0-s0:c0.c1023       *
> > > ccmservice           specialuser_u        s0                   *
> > > cucm                 admin_u              s0-s0:c0.c1023       *
> > > drfkeys              specialuser_u        s0                   *
> > > drfuser              specialuser_u        s0                   *
> > > informix             specialuser_u        s0                   *
> > > pwrecovery           specialuser_u        s0                   *
> > > root                 sysadm_u             s0-s0:c0.c1023       *
> > > sftpuser             specialuser_u        s0                   *
> > > system_u             sysadm_u             s0-s0:c0.c1023       *
> > >
> > >
> > > Can anybody Please help me.
> >
> > What is your sestatus -v output?  How are you logging in (console, gdm,
> > ssh, ...)?
> >
> > You don't appear to be running the default policy, or if you are,
> > someone has heavily customized your user and login mappings.
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

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAloebjIACgkQJXSOVTf5
R2nFNgv9FcUXvcmBKW2ITW4jpXFE4Wg9Id09b3VhRBy8PpgJko/C5m2xhv/zbIuM
hFv2RlpvRdw1eoByZCFEh7FCWibcNORj1Oh9AX4agHRfOmPsCu8/pdfHUvCO0w20
fYv4gLAQeaNPMWFOXRkyfPk2xSHHkV5Lcl+eFZwhiZsQOGb3lGH+7shcuon/PYzx
OhiHv8U0RMKjssOK4exJfwSb/0cLk2sHpDUTTz7r75MO/tndYx/rJ8z+vFwgaJ7r
iECjpkLyUdmo+Yqtbjo1wTha/nhqUmHxF8gaZu7MjHo951QBHlTBLTfPRoPEOTWu
5l09R0/xx9RXuZhdnw0w5LaWJ/uHI8HRZxJjtSUjfnhZLIxebsiGJ9oSnKaCi3Gn
yKCOgCXkko7OYVo8/0G0cOINZzrc1MIUSn1jvUgu1gs+QODtA4PIHTNNLch/HQv1
8iafLG38OFmQBhOvhX9mqVIcVluLY03URD1VfUN4dH43HpjGKAWkZsBcLEjZ3ZHw
Z4fwwq1Q
=CnRy
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
