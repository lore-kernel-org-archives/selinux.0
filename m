Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAT9BENB021451
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 04:11:14 -0500
Received: by mail-wm0-f52.google.com with SMTP id t8so4620975wmc.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 01:11:07 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id b30sm1327021ede.53.2017.11.29.01.11.05
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Nov 2017 01:11:05 -0800 (PST)
Date: Wed, 29 Nov 2017 10:11:03 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171129091103.GB1225@julius.enp8s0.d30>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <20171129082215.GA1225@julius.enp8s0.d30>
 <CAPMH7-9r-TTzrjVYMNCQftnFyz1N2cAT7dYQufUhSs91hszsQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
In-Reply-To: <CAPMH7-9r-TTzrjVYMNCQftnFyz1N2cAT7dYQufUhSs91hszsQg@mail.gmail.com>
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 02:21:46PM +0530, Aman Sharma wrote:
> Hi ,
>=20
> Check the output for the same.
>=20
> * getsebool -a | grep ssh*
> fenced_can_ssh --> off
> selinuxuser_use_ssh_chroot --> on
> ssh_chroot_rw_homedirs --> off
> ssh_keysign --> off
> ssh_sysadm_login --> on

Thanks. That means I was wrong.

>=20
>=20
> On Wed, Nov 29, 2017 at 1:52 PM, Dominick Grift <dac.override@gmail.com>
> wrote:
>=20
> > On Wed, Nov 29, 2017 at 09:33:31AM +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > Below is the output of command :
> > >
> > > * sestatus -v output*
> > > *SELinux status:                 enabled*
> > > *SELinuxfs mount:                /sys/fs/selinux*
> > > *SELinux root directory:         /etc/selinux*
> > > *Loaded policy name:             targeted*
> > > *Current mode:                   enforcing*
> > > *Mode from config file:          permissive*
> > > *Policy MLS status:              enabled*
> > > *Policy deny_unknown status:     allowed*
> > > *Max kernel policy version:      28*
> > >
> > > *Process contexts:*
> > > *Current context:
> > > system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > > *Init context:                   system_u:system_r:init_t:s0*
> > > */usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> > s0:c0.c1023*
> > >
> > > *File contexts:*
> > > *Controlling terminal:           system_u:object_r:sshd_devpts_t:s0*
> > > */etc/passwd                     system_u:object_r:passwd_file_t:s0*
> > > */etc/shadow                     system_u:object_r:shadow_t:s0*
> > > */bin/bash                       system_u:object_r:shell_exec_t:s0*
> > > */bin/login                      system_u:object_r:login_exec_t:s0*
> > > */bin/sh                         system_u:object_r:bin_t:s0 ->
> > > system_u:object_r:shell_exec_t:s0*
> > > */sbin/agetty                    system_u:object_r:getty_exec_t:s0*
> > > */sbin/init                      system_u:object_r:bin_t:s0 ->
> > > system_u:object_r:init_exec_t:s0*
> > > */usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0*
> > > */lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > > system_u:object_r:lib_t:s0*
> > > */lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > > system_u:object_r:ld_so_t:s0*
> > >
> > > *Also I am using ssh session for login.*
> > >
> > > *Please let me know how to change id command context to unconfined_u =
or
> > > Sysadm_u.*
> > >
> > > Thanks in advance
> > > Aman
> >
> > not sure and shot in dark, but:
> >
> > root is assoc. with sysadm_u. sysadm_u is only authorized to use sysadm=
_r.
> > if you have the boolean ssh_priv_login set to off then
> > sysadm_u:sysadm_r:sysadm_t:s0 is inaccessible
> > pam_selinux attempts to use any other contexts that are accessible, and=
 it
> > appears that system_u:system_r:unconfined_t was it.
> >
> > Do you have the ssh_priv_login boolean set to off? `getsebool -a | grep
> > ssh`
> >
> > >
> > > On Mon, Nov 27, 2017 at 9:29 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > >
> > > > On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:
> > > > >
> > > > >
> > > > > Hi All,
> > > > >
> > > > > Currently Working on Cent OS 7.3 and login as a root User and my =
Id
> > > > > command output is :
> > > > >
> > > > > id
> > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root)
> > > > > context=3Dsystem_u:system_r:unconfined_t:s0-s0:c0.c1023
> > > > >
> > > > > I want to change System_u:system_r:unconfined_t to sysadm_u:sysad=
m_r
> > > > > or unconfined_u:unconfined_r.
> > > > >
> > > > > Also showing the output of following command :
> > > > >
> > > > > semanage user -l
> > > > >
> > > > >                 Labeling   MLS/       MLS/
> > > > > SELinux User    Prefix     MCS Level  MCS Range
> > > > > SELinux Roles
> > > > >
> > > > > admin_u         user       s0         s0-s0:c0.c1023
> > > > >  sysadm_r system_r
> > > > > guest_u         user       s0         s0
> > > > >  guest_r
> > > > > root            user       s0         s0-s0:c0.c1023
> > > > >  staff_r sysadm_r
> > > > > specialuser_u   user       s0         s0
> > > > >  sysadm_r system_r
> > > > > staff_u         user       s0         s0-s0:c0.c1023
> > > > >  staff_r sysadm_r system_r
> > > > > sysadm_u        user       s0         s0-s0:c0.c1023
> > > > >  sysadm_r
> > > > > system_u        user       s0         s0-s0:c0.c1023
> > > > >  system_r
> > > > > unconfined_u    user       s0         s0-s0:c0.c1023
> > > > >  system_r unconfined_r
> > > > > user_u          user       s0         s0
> > > > >  user_r
> > > > > xguest_u        user       s0         s0
> > > > >  xguest_r
> > > > >
> > > > >
> > > > >  semanage login -l
> > > > >
> > > > > Login Name           SELinux User         MLS/MCS Range
> > > > > Service
> > > > >
> > > > > __default__          sysadm_u             s0-s0:c0.c1023       *
> > > > > ccmservice           specialuser_u        s0                   *
> > > > > cucm                 admin_u              s0-s0:c0.c1023       *
> > > > > drfkeys              specialuser_u        s0                   *
> > > > > drfuser              specialuser_u        s0                   *
> > > > > informix             specialuser_u        s0                   *
> > > > > pwrecovery           specialuser_u        s0                   *
> > > > > root                 sysadm_u             s0-s0:c0.c1023       *
> > > > > sftpuser             specialuser_u        s0                   *
> > > > > system_u             sysadm_u             s0-s0:c0.c1023       *
> > > > >
> > > > >
> > > > > Can anybody Please help me.
> > > >
> > > > What is your sestatus -v output?  How are you logging in (console, =
gdm,
> > > > ssh, ...)?
> > > >
> > > > You don't appear to be running the default policy, or if you are,
> > > > someone has heavily customized your user and login mappings.
> > > >
> > > >
> > > >
> > >
> > >
> > > --
> > >
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >
> > --
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
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

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAloeeaQACgkQJXSOVTf5
R2lNjAv/ZMmN5itY76HcMArTJRY+qfPo5PuU+UJR/NuO/faGsrX2IrxnNAgTanEp
ZeTYmsOuDnrDo1KfkShR3xxcq99cbcbSJBXmlk/xb4yFK3wF/u8dx256FvljiB80
qA4yaDN9UUdoFbQFOGzUy5xmSaGh1alz4qkiHEJpvDIzTmdIzAwt1vCGjkCi/eie
wd+CjjxCggcbnZ7ScBAgu38q9e9CPnTV3y3x3sQQ0D5bx3gcCc7LQ8q2OCRjk/8a
pl/ScMk924U/9nG1ha4DfRJVN6FDDM0S+jCjR9Qm6CfDXUs5Ay+KUXVpmVaesAL7
I/yoDJDv+Ybl9JD69fdp9apX7FpPjDzD/SMdhI3OBtZ4779JdjqigBvUj9fWlDcF
hGWx93hr/54CAOpZwrbESElWfnZF9EbcnjoAxvP4wcymvdGH86e+7AmXSHSCBMV+
dnWmK52Ntxl51OUf4Jxqtu1hGkHW12FY/+OCMuGoGIROVziudzOG5/7RI4Pes5aC
8xjMc9mf
=bO4y
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
