From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        "GeorgeC.Wilson" <ltcgcw@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-64tgHhbMyGec7AzNHZOq"
Date: Wed, 25 Oct 2006 15:15:24 -0400
Message-Id: <1161803724.29689.57.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-64tgHhbMyGec7AzNHZOq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-25 at 09:59 -0400, Stephen Smalley wrote:
> On Wed, 2006-10-25 at 09:50 -0400, James Antill wrote:
> >  My understanding is that while security_check_context() allows it, the
> > setexeccon() will fail. Which seemed to be good enough.
>=20
> No, it won't.  Suppose that I have two Linux users A and B, with A
> authorized for category c0 and B authorized for category c2 in seusers,
> but both A and B are mapped to SELinux user U who is authorized for all
> categories in the kernel policy.  The login-style programs are naturally
> going to be authorized to transition to any of those contexts since they
> have to deal with user logins at any level, so the setexeccon() will
> succeed.  The SELinux security context will have U as the user identity,
> so it will always be valid.  You need an explicit check.

 Ok, I had assumed that "U" would always be different in this case. I
think this update to the patch solves the problem ... it gets the list
of valid roles/levels from get_ordered_context_list() (which I think is
complete, but I'm not 100%) and compares what is entered against that.
 I'm not 100% sure this is right (it means there would be huge lists
returned for MCS, no?), but I don't see what else I can call that would
validate the role/level-range for a specific login.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-64tgHhbMyGec7AzNHZOq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFP7fM11eXTEMrxtQRAkRxAKCOOI0Fepa4RGZdxkHrL2YW+yuUsgCfdU8K
ASPFIA6Ue/47c2N8m7SSQaQ=
=JQmp
-----END PGP SIGNATURE-----

--=-64tgHhbMyGec7AzNHZOq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
