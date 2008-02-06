Subject: Re: Why am I not transitioning correctly?
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202331674.27371.185.camel@moss-spartans.epoch.ncsc.mil>
References: <1202328961.2801.354.camel@bluejay.goodinassociates.com>
	 <1202329308.27371.181.camel@moss-spartans.epoch.ncsc.mil>
	 <1202331187.2801.379.camel@bluejay.goodinassociates.com>
	 <1202331674.27371.185.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hPt/R4zWPEzlbXZBK9rl"
Date: Wed, 06 Feb 2008 15:09:41 -0600
Message-Id: <1202332181.2801.388.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hPt/R4zWPEzlbXZBK9rl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-02-06 at 16:01 -0500, Stephen Smalley wrote:
> On Wed, 2008-02-06 at 14:53 -0600, Jeremiah Jahn wrote:
> >=20
> > On Wed, 2008-02-06 at 15:21 -0500, Stephen Smalley wrote:
> > > On Wed, 2008-02-06 at 14:16 -0600, Jeremiah Jahn wrote:
> > > > I get this error in the audit log:
> > > > type=3DSELINUX_ERR msg=3Daudit(1202327606.098:732): security_comput=
e_sid:  invalid context system_u:system_r:monetra_t:s0 for scontext=3Dsyste=
m_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:monetra_server_exec_t=
:s0 tclass=3Dprocess
> > > > type=3DSYSCALL msg=3Daudit(1202327606.098:732): arch=3D40000003 sys=
call=3D11 success=3Dno exit=3D-13 a0=3D9d9f650 a1=3D9d9f5d8 a2=3D9d8c728 a3=
=3D9d9ff20 items=3D0 ppid=3D2575 pid=3D2593 auid=3D4294967295 uid=3D0 gid=
=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) c=
omm=3D"S99monetra" ex
> > > > e=3D"/bin/bash" subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)
> > >=20
> > > Missing role system_r types monetra_t; statement.
> > >=20
> > > > I was under the assumption that the following would work:
> > > > allow initrc_t monetra_server_exec_t:file { read execute getattr};
> > > > allow monetra_t monetra_server_exec_t:file { entrypoint };
> > > > type_transition initrc_t monetra_server_exec_t:process monetra_t;
> > >=20
> > > Also need:
> > > allow initrc_t monetra_t:process transition;
> > this results in the following error:
> > libsepol.check_assertion_helper: assertion on line 0 violated by allow =
initrc_t monetra_t:process { transition };
>=20
> That means you didn't declare monetra_t as a domain, i.e.
> domain_type(monetra_t)
thanx. I did initially use the refpolicy interfaces, but they were a
little broad, and allowed sysadm_t to read some files just because
initrc_t could. So I'm trying to simplify/ do explicitly what I
understand.

>=20
> The best way to start is to look an existing .te file and follow its
> example.  refpolicy has pretty extensive documentation of all of its
> interfaces, although it can be hard to find the one you want.  SLIDE
> seems promising; possibly you should try using it and its domain
> builder.
None of the .te files I could find really did what I wanted, or they
interface that were a little vague in what they did. I'm learning to
build the policy, and see how the macro expands to see what it does.=20

>=20
> SELinux by Example does walk you through writing a simple domain from
> scratch, I think.
It does, but leaves a few things out, and nobody has an example of
creating a whole separate domain that root/sysadm_t can't use, but can
start up at boot.=20

>=20
> Nothing wrong with domain_auto_trans() AFAIK, and I see it used
> throughout refpolicy.
>=20
this was my bad, domain_dyntrans_type( domain ) was what I was thinking
of.=20


There can be no twisted thought without a twisted molecule. -- R. W.
Gerard

--=-hPt/R4zWPEzlbXZBK9rl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHqiIV6caZY8jbHDkRAtRbAJ9e/SK6Jc8VEYOP5l4tak5qMPvuugCeLpGp
Odhv4jlbxHip6djtn8JgtMA=
=l/W3
-----END PGP SIGNATURE-----

--=-hPt/R4zWPEzlbXZBK9rl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
