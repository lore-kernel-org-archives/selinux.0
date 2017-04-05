Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v35EvkOZ023136
 for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2017 10:57:46 -0400
Received: by mail-lf0-f41.google.com with SMTP id x137so10683797lff.3
 for <selinux@tycho.nsa.gov>; Wed, 05 Apr 2017 07:57:43 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 c7sm5386791wrc.20.2017.04.05.07.57.41 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Apr 2017 07:57:41 -0700 (PDT)
Date: Wed, 5 Apr 2017 16:57:39 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: security_bounded_transition
Message-ID: <20170405145739.GA18110@t450.enp8s0.d30>
References: <CAJ2a_DeZ+7yTWgipgvbXeymZwYyz0RrwanRWSszQtjCVgnWW6w@mail.gmail.com>
 <1491404048.15479.13.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
In-Reply-To: <1491404048.15479.13.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 10:54:08AM -0400, Stephen Smalley wrote:
> On Wed, 2017-04-05 at 14:58 +0200, cgzones wrote:
> > Hi list,
> >=20
> > when running `apt update` i'm getting a bunch of the following
> > security_bounded_transition audits:
> >=20
> > type=3DPROCTITLE msg=3Daudit(05/04/17 14:47:20.268:219) :
> > proctitle=3D/usr/bin/dpkg --print-foreign-architectures
> > type=3DPATH msg=3Daudit(05/04/17 14:47:20.268:219) : item=3D1
> > name=3D/lib64/ld-linux-x86-64.so.2 inode=3D132140 dev=3D08:01 mode=3Dfi=
le,755
> > ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
> > nametype=3DNORMAL
> > type=3DPATH msg=3Daudit(05/04/17 14:47:20.268:219) : item=3D0
> > name=3D/usr/bin/dpkg inode=3D131862 dev=3D08:01 mode=3Dfile,755 ouid=3D=
root
> > ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:dpkg_exec_t:s0
> > nametype=3DNORMAL
> > type=3DCWD msg=3Daudit(05/04/17 14:47:20.268:219) :
> > cwd=3D/root/selinux/policy
> > type=3DEXECVE msg=3Daudit(05/04/17 14:47:20.268:219) : argc=3D2
> > a0=3D/usr/bin/dpkg a1=3D--print-foreign-architectures
> > type=3DSYSCALL msg=3Daudit(05/04/17 14:47:20.268:219) : arch=3Dx86_64
> > syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x56455b39a820 a1=3D0x5645=
5b39e6d0
> > a2=3D0x7ffdfaf43cd0 a3=3D0x2 items=3D2 ppid=3D2328 pid=3D2329 auid=3Dde=
bianuser
> > uid=3D_apt gid=3Dnogroup euid=3D_apt suid
> > =3D_apt fsuid=3D_apt egid=3Dnogroup sgid=3Dnogroup fsgid=3Dnogroup tty=
=3Dpts0
> > ses=3D1 comm=3Ddpkg exe=3D/usr/bin/dpkg
> > subj=3Dstaff_u:sysadm_r:apt_t:s0-s0:c0.c1023 key=3D(null)
> > type=3DSELINUX_ERR msg=3Daudit(05/04/17 14:47:20.268:219) :
> > op=3Dsecurity_bounded_transition seresult=3Ddenied
> > oldcontext=3Dstaff_u:sysadm_r:apt_t:s0-s0:c0.c1023
> > newcontext=3Dstaff_u:sysadm_r:dpkg_t:s0-s0:c0.c1023
> >=20
> > I do not use any type-/role-bounds rules, and apt and dpkg are
> > working
> > without (noticeable) issues.
>=20
> This means that the process or one of its ancestors had set
> NO_NEW_PRIVS, and then tried to execve a program that normally would
> have triggered a domain transition.  Domain transitions are only
> allowed under NO_NEW_PRIVS if the new domain is bounded by the calling
> domain, since this ensures that no privilege escalation is possible
> (originally we did not allow domain transitions at all under
> NO_NEW_PRIVS; this was relaxed to allow them if bounded to support the
> SELinux sandbox when it began using NO_NEW_PRIVS).  Unless the program
> explicitly requested the domain transition (via setexeccon), this is
> treated as a non-fatal error and the process just stays in the calling
> domain.
>=20
> Hence, at present, apt will continue running in apt_t rather than
> transitioning into dpkg_t when running dpkg (at least in cases where
> apt has set NO_NEW_PRIVS prior to execve - I do not know whether it
> does this universally when running dpkg or only in specific instances).
> This could be a problem for labeling of any files created by dpkg if
> relying on type transitions or it could prevent dpkg from performing
> operations only allowed to dpkg_t (or it could expose dpkg to
> performing operations only allowed to apt_t).
>=20
> Adding typebounds rules (ala typebounds apt_t dpkg_t; typebounds
> apt_exec_t dpkg_exec_t; typebounds apt_tmp_t dpkg_tmp_t; ...) would
> allow the transition to occur, but would then require dpkg_t to be a
> strict subset of permissions allowed to apt_t.  This does not appear to
> be the case in current policy, so it would likely break other uses of
> dpkg.
>=20
> This is an issue for the Debian SELinux maintainers to resolve.

Also note that the NNP flag is inherited. So if dpkg_t also in turn runs th=
ings with domain transitions then you will have to bound those types to the=
 parents as well and so forth and so forth.

>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljlBd8ACgkQJXSOVTf5
R2n+3Qv/dHG5ERtFkDW14UP6DFaHHb9olCI5GOvW8wguA/GoLD7R2nRXy45ce3BQ
wQc8MpNkaCVUmXgP3+eT21oBhkckPELMqsVeRRgoZBaYzROwUGycYidXGcubdpcW
mpRiYU32lC8Sbtf7wrJSqsR0dYHdH2gjXs0AJXq6Q0aAI1IWcqi7NF3bXsDnWoLa
/KRAuHePkDTupC8Q2xRWeqTCY218d9eo1nC7ZsL/4mFu/6iMtHaDBw9/L51Mn2mx
Jf5M/bb0dt2lHOlFm07uE5KljemJd4W/tvGdqZ+2HHN3C3A04bIhnHu+zbHGJiHo
xfaHMyzzhj9sJSYSgptFP3f/UDxGZij21EQLz7jjcVIdu0UGa301wBgUiNgLdeAj
U9wrITWYRKpSFEQ4bMVjDT4U7wmodw5DlPoYQ1dQBaOsC5X+9+rSRpa0D4tr9BX+
UviDu07Zbdfu+Cmki8TmUw5XR0RE+el/gWOjcJXJtR98BqrHjg3u10RPvnIoTad5
x1iCSlk3
=spam
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
