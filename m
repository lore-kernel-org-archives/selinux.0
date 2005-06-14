Subject: Re: general selinux questions
From: Colin Walters <walters@verbum.org>
To: antoine <antoine@nagafix.co.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118769876.10262.52.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fwnXW0j9UnJXG2xmtRB2"
Date: Tue, 14 Jun 2005 13:37:18 -0400
Message-Id: <1118770638.3422.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fwnXW0j9UnJXG2xmtRB2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-14 at 18:24 +0100, antoine wrote:
> > > ping [whatever] >& tempfile
> (...)=20
> > Likely needed to redirect stdin too.
> DOH. I'll try that.
>=20
>=20
> [Note]:
> Just about anything (ie: ssh login) seems to require:
> 'allow sysadm_t devpts_t:chr_file getattr;'
> (I've put it in admin.te for now)

That should be harmless.

> I've only got 2 problems left I *really* cannot figure out:
> 1)
> audit(1118762231.596:0): avc:  denied  { transition } for  pid=3D28871
> exe=3D/usr/lib/postfix/master path=3D/usr/lib/postfix/pipe dev=3Dmd3
> ino=3D670776 scontext=3Dsystem_u:system_r:postfix_master_t
> tcontext=3Dsystem_u:object_r:postfix_pipe_t tclass=3Dprocess
> So I've added this to postfix.te (from audit2allow):
> allow postfix_master_t postfix_pipe_t:process transition;
> But it has no effect and the same audit message keeps coming up!
> I have absolutely no idea where to go from here...

Tried audit2why?  Could be constraints or RBAC denial.

> Here are some related rules:
> domain_auto_trans(postfix_master_t, postfix_pipe_exec_t, postfix_pipe_t)
> I tried adding these:
> role_transition system_r postfix_pipe_exec_t object_r;
> allow postfix_master_t postfix_pipe_t:process transition;
> role object_r types postfix_pipe_t;

This should be system_r, not object_r, I'm pretty sure.

> 2)
> All similar to the one above (any code that calls sendmail):
> audit(1118761207.922:0): avc:  denied  { transition } for  pid=3D28648
> exe=3D/bin/bash path=3D/usr/sbin/sendmail dev=3Dmd3 ino=3D783481
> scontext=3Dsystem_u:system_r:myscript_exec_t
> tcontext=3Dsystem_u:object_r:sysadm_mail_t tclass=3Dprocess

Similarly, try audit2why.


--=-fwnXW0j9UnJXG2xmtRB2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrxXOOIkJWWp2WGURApsQAJ9q6hWFYCNl9GsEZMZ6N8GFYYAQsQCfWU94
yS3J4Xcln74T1pPQacGEx9Y=
=J2d1
-----END PGP SIGNATURE-----

--=-fwnXW0j9UnJXG2xmtRB2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
