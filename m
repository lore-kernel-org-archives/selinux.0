Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NJUCrT020687
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 15:30:13 -0400 (EDT)
Subject: Re: conflict between libselinux and libsepol
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093288981.27211.262.camel@moss-spartans.epoch.ncsc.mil>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093288981.27211.262.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YytxoHaYOQKvQvKi4XqY"
Date: Mon, 23 Aug 2004 15:31:09 -0400
Message-Id: <1093289469.5353.0.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YytxoHaYOQKvQvKi4XqY
Content-Type: multipart/mixed; boundary="=-vBl9IwsDiAbBwc6Z4iNv"


--=-vBl9IwsDiAbBwc6Z4iNv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 15:23 -0400, Stephen Smalley wrote:
> On Fri, 2004-08-20 at 15:37, Colin Walters wrote:
> > Here's an updated patch against setfiles.
>=20
> Likely bug:  if the context is valid in the specified binary policy but
> not in the currently loaded policy on a SELinux system, then it fails
> the validation check since you fall through to the
> security_check_context call even if policyfile is set.

Ah, good catch.  This should fix that then.



--=-vBl9IwsDiAbBwc6Z4iNv
Content-Disposition: attachment; filename=setfiles-fix-fix.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=setfiles-fix-fix.patch; charset=utf-8

LS0tIHBvbGljeWNvcmV1dGlscy0xLjE1Ljcvc2V0ZmlsZXMvc2V0ZmlsZXMuY34JMjAwNC0wOC0y
MCAxNToyNzo0Mi4wMDAwMDAwMDAgLTA0MDANCisrKyBwb2xpY3ljb3JldXRpbHMtMS4xNS43L3Nl
dGZpbGVzL3NldGZpbGVzLmMJMjAwNC0wOC0yMyAxNToyOToyNi40OTY4MDk4MzIgLTA0MDANCkBA
IC03MDUsOCArNzA1LDggQEANCiB7DQogCWludCB2YWxpZCA9IDE7DQogDQotCWlmIChwb2xpY3lm
aWxlICYmIHNlcG9sX2NoZWNrX2NvbnRleHQgKChjaGFyICopIGNvbnRleHQpIDwgMCkgew0KLQkJ
dmFsaWQgPSAwOw0KKwlpZiAocG9saWN5ZmlsZSkgew0KKwkJdmFsaWQgPSAoc2Vwb2xfY2hlY2tf
Y29udGV4dCAoKGNoYXIgKikgY29udGV4dCkgPj0gMCk7DQogCX0gZWxzZSBpZiAoc2VjdXJpdHlf
Y2hlY2tfY29udGV4dCgoY2hhciAqKSBjb250ZXh0KSA8IDAgJiYgZXJybm8gIT0gRU5PRU5UKSB7
DQogCQl2YWxpZCA9IDA7DQogCQlpbmNfZXJyKCk7DQo=


--=-vBl9IwsDiAbBwc6Z4iNv--

--=-YytxoHaYOQKvQvKi4XqY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBKkX9OIkJWWp2WGURAqIvAJ97zCux1b0ubGpqz71XIXqb2ey++ACfcGH9
0hHeVdvAc+mpSEEXTuhnJGM=
=CUbz
-----END PGP SIGNATURE-----

--=-YytxoHaYOQKvQvKi4XqY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
