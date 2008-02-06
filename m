Subject: Re: Why am I not transitioning correctly?
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202329308.27371.181.camel@moss-spartans.epoch.ncsc.mil>
References: <1202328961.2801.354.camel@bluejay.goodinassociates.com>
	 <1202329308.27371.181.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VgeZKm7vJjQJodJ18HQQ"
Date: Wed, 06 Feb 2008 14:53:07 -0600
Message-Id: <1202331187.2801.379.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VgeZKm7vJjQJodJ18HQQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On Wed, 2008-02-06 at 15:21 -0500, Stephen Smalley wrote:
> On Wed, 2008-02-06 at 14:16 -0600, Jeremiah Jahn wrote:
> > I get this error in the audit log:
> > type=3DSELINUX_ERR msg=3Daudit(1202327606.098:732): security_compute_si=
d:  invalid context system_u:system_r:monetra_t:s0 for scontext=3Dsystem_u:=
system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:monetra_server_exec_t:s0 =
tclass=3Dprocess
> > type=3DSYSCALL msg=3Daudit(1202327606.098:732): arch=3D40000003 syscall=
=3D11 success=3Dno exit=3D-13 a0=3D9d9f650 a1=3D9d9f5d8 a2=3D9d8c728 a3=3D9=
d9ff20 items=3D0 ppid=3D2575 pid=3D2593 auid=3D4294967295 uid=3D0 gid=3D0 e=
uid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) comm=3D=
"S99monetra" ex
> > e=3D"/bin/bash" subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)
>=20
> Missing role system_r types monetra_t; statement.
>=20
> > I was under the assumption that the following would work:
> > allow initrc_t monetra_server_exec_t:file { read execute getattr};
> > allow monetra_t monetra_server_exec_t:file { entrypoint };
> > type_transition initrc_t monetra_server_exec_t:process monetra_t;
>=20
> Also need:
> allow initrc_t monetra_t:process transition;
this results in the following error:
libsepol.check_assertion_helper: assertion on line 0 violated by allow init=
rc_t monetra_t:process { transition };


>=20
> But why not just use policy interfaces to do that?
Here lies my major problem. My level of understanding is based generally
on what I can track down in books. O'reilly's SELinux and Tresys's
SElinux by example. The ORA book is incomplete at best, with little or
no actual reference value. The Tresys book is far better, and takes a
good deal of time explaining PRE-refpolicy. Although it goes into the
general ideas behind the refpolicy and some of the macros, that's about
it. No where can I find information about the actual format of the .te
files for example, perhaps I missed it, but hey. When I look online for
something more update from Tresys or the NSA, the documentation seems to
focus on very specific things. For example the Interface docs have no
real overview of the .te format, "roles seem to need be at the bottom,
right before users". Also there seems to really be no docs other than
the books that really describe what "non interface" macros are out
there. There no really good starting point for someone trying to do
something outside all of the examples. In my case, "don't let the sysadm
read or touch credit card data."

</rant>


I truly am grateful for the amount of hard work everyone has put into
SELinux, it's a huge undertaking, and makes my job possible. But ohy vey
is it confusing.=20





>=20
> > I can't do init_daemon_domain(monetra_t,monetra_server_exec_t) because =
I
> > can't let sysadm_t read anything involving monetra_t. And I'd thought
> > I'd read in "selinux by example" that
> > domain_auto_trans(initrc_t,monetra_server_exec_t,monetra_t) is generall=
y
> > a bad idea.
>=20
> Why?
don't have my book in front of me..:) Couldn't tell you.


>=20
If you think the United States has stood still, who built the largest
shopping center in the world? -- Richard M. Nixon

--=-VgeZKm7vJjQJodJ18HQQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHqh4z6caZY8jbHDkRAqwaAJ93OrNTfBReROegGohUE3j7XQ5znQCeO8OJ
ZBy9sTqDGxOns6YRm2mqk0w=
=tQkd
-----END PGP SIGNATURE-----

--=-VgeZKm7vJjQJodJ18HQQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
