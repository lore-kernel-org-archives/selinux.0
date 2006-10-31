From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
	 <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1162306839.31104.23.camel@code.and.org>
	 <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D7+pH6gg2nW2BiWz6o2j"
Date: Tue, 31 Oct 2006 11:04:12 -0500
Message-Id: <1162310652.31104.46.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-D7+pH6gg2nW2BiWz6o2j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-31 at 10:11 -0500, Stephen Smalley wrote:

> As I understood it (and the code in pam seems to match this), you were
> going to generate two security contexts for the user session, one based
> on seusers and one based on the provided range, otherwise identical in
> all respects, and apply a permission check between those two contexts.
> So for example, if my seusers-defined default context would be
> staff_u:staff_r:staff_t:s0-s0:c0.c255 and I entered a level of s0:c3 as
> input, there would be a permission check made by pam_selinux between
> staff_u:staff_r:staff_t:s0-s0:c0.c255 and staff_u:staff_r:staff_t:s0:c3.

 This should all be true.

> Thus, the TE rule would have to be between staff_t and itself (i.e. the
> user domains), not between local_login_t and anything.

 Right. Does the mlsconstrain line not do that?

> We aren't checking whether login can do anything (or using its context
> anywhere); we are checking whether the seusers-defined default context
> for the user contains the user-supplied context.

 Right my understanding was that the policy line:

allow $1 domain:context transition

...meant that the login program could make security call:

 security_compute_av(src, dst, SECCLASS_CONTEXT, CONTEXT__TRANSITION, &avd)

--=20
James Antill <jantill@redhat.com>

--=-D7+pH6gg2nW2BiWz6o2j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFR3P711eXTEMrxtQRArgqAKCyU9OUR9i37vAlYxe/Gg0xbcKl5gCgySFN
qurBoB/xQznS94NSMqaE2SM=
=m3zi
-----END PGP SIGNATURE-----

--=-D7+pH6gg2nW2BiWz6o2j--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
