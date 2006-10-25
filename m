From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, "GeorgeC.Wilson" <ltcgcw@us.ibm.com>,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s8Ki0kV9E9wFDz6qAjHx"
Date: Wed, 25 Oct 2006 09:50:51 -0400
Message-Id: <1161784251.667.28.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-s8Ki0kV9E9wFDz6qAjHx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-25 at 08:22 -0400, Stephen Smalley wrote:

> To elaborate, as I understood it, seusers (managed via semanage login)
> was to provide per-Linux-user authorizations for MLS/MCS ranges, while
> multiple such Linux users might be mapped to a single SELinux user that
> was authorized for the full system range.  The login-style programs
> would then ensure that the range in the initial security context for the
> Linux user's session was limited by the value defined in seusers, and
> SELinux policy would subsequently ensure that processes in that session
> can not escalate outside of that range via newrole -l (or other
> mechanism).

 My understanding is that while security_check_context() allows it, the
setexeccon() will fail. Which seemed to be good enough.

> It isn't sufficient to check the validity of the context with the
> user-supplied level, because from the kernel's POV, any level might be
> authorized for the underlying SELinux user identity, whereas seusers
> might have defined a more restricted range for the Linux user identity.
> You need a check between the user-supplied level and the seusers-defined
> value (more generally, this could be an avc_has_perm or
> security_compute_av check between contexts containing those levels, and
> the underlying policy could define a mlsconstrain on the corresponding
> permission).=20

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-s8Ki0kV9E9wFDz6qAjHx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFP2u711eXTEMrxtQRAiE9AJ9JUQNxpvO6zFzGkdyqiyFeKVx8vgCeMmIT
Gji8Gx9apgKYo2U/geAGWhA=
=ZDhL
-----END PGP SIGNATURE-----

--=-s8Ki0kV9E9wFDz6qAjHx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
