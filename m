Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KKsRrT007211
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 16:54:27 -0400 (EDT)
Subject: Re: conflict between libselinux and libsepol
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093030667.4212.4.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vaPl+GGC6j4SZ/N7SGb3"
Date: Fri, 20 Aug 2004 16:54:55 -0400
Message-Id: <1093035295.4212.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vaPl+GGC6j4SZ/N7SGb3
Content-Type: multipart/mixed; boundary="=-uRpzFKDdNUFpoj2z/r5X"


--=-uRpzFKDdNUFpoj2z/r5X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-20 at 15:37 -0400, Colin Walters wrote:
> On Fri, 2004-08-20 at 15:00 -0400, Stephen Smalley wrote:
> > On Fri, 2004-08-20 at 11:24, Stephen Smalley wrote:
> > > Hence, I would recommend that we add a function to libsepol to provid=
e a
> > > higher level interface for context validation against a given binary
> > > policy, add it to libsepol.map, and declare the prototype in sepol.h =
for
> > > use by setfiles.
> >=20
> > Patch for libsepol attached, along with a sample program.  I'll add it
> > to the sourceforge CVS.

And a patch for the policy Makefile to cause it to verify the file
contexts under the "policy" target.  I think this makes sense because
conceptually the file contexts is part of the whole system security
policy.

--=-uRpzFKDdNUFpoj2z/r5X
Content-Disposition: attachment; filename=policy-fc-validate.patch
Content-Type: text/x-patch; name=policy-fc-validate.patch; charset=utf-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjE1LjE2L01ha2VmaWxlfgkyMDA0LTA4LTIwIDE1OjQxOjMyLjI1MTc4NTY0
OCAtMDQwMA0KKysrIHBvbGljeS0xLjE1LjE2L01ha2VmaWxlCTIwMDQtMDgtMjAgMTU6NDE6Mzcu
ODgzOTI5NDMyIC0wNDAwDQpAQCAtODgsNyArODgsOSBAQA0KICMgTm90ZTogQ2FuJ3QgdXNlIGlu
c3RhbGwsIHNvIG5vdCBzdXJlIGhvdyB0byBkZWFsIHdpdGggbW9kZSwgdXNlciwgYW5kIGdyb3Vw
DQogIwlvdGhlciB0aGFuIGJ5IGRlZmF1bHQuDQogDQotcG9saWN5OiAkKFBPTElDWVZFUikNCitw
b2xpY3k6ICQoUE9MSUNZVkVSKSAkKEZDKQ0KKwlAZWNobyAiVmFsaWRhdGluZyBmaWxlX2NvbnRl
eHRzIC4uLiINCisJc2V0ZmlsZXMgLWMgJChQT0xJQ1lWRVIpICQoRkMpDQogDQogJChQT0xJQ1lW
RVIpOiAgcG9saWN5LmNvbmYgJChDSEVDS1BPTElDWSkNCiAJJChDSEVDS1BPTElDWSkgLW8gJEAg
cG9saWN5LmNvbmYNCg==


--=-uRpzFKDdNUFpoj2z/r5X--

--=-vaPl+GGC6j4SZ/N7SGb3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJmUfOIkJWWp2WGURApw3AJ9i415z6YylLs7VhclX0pm4/91mFACfQ+tM
GezhMVdOUMk86tEspfyKsJE=
=AiBP
-----END PGP SIGNATURE-----

--=-vaPl+GGC6j4SZ/N7SGb3--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
