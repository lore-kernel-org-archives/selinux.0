Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BGUbrT006564
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 12:30:38 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5BGUWP2028202
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 12:30:32 -0400 (EDT)
Subject: Re: too many sysadmfile?
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
References: <1086884579.19414.30.camel@gorn.pebenito.net>
	 <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KUxW0IDxNX6E7+U55iq6"
Message-Id: <1086971434.19414.148.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 11:30:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KUxW0IDxNX6E7+U55iq6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-10 at 13:57, Stephen Smalley wrote:
> On Thu, 2004-06-10 at 12:22, Chris PeBenito wrote:
> > One thing that hasn't sat well with me for a long time is that just
> > about all file_types are sysadmfile in the strict policy.  To me, this
> > sounds like an excessive amount of access for sysadm_t (with exception
> > of the unrestricted_admin tunable being on).
[cut]
> A commendable goal, but you need to gradually migrate toward such a
> scheme, as existing usage assumes direct access by admins running common
> utilities, using shell redirection, etc.

How does not being able to write to bin_t files, for example, break the
existing usage?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-KUxW0IDxNX6E7+U55iq6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyd4qvI7kLeavkkMRAtE2AJ9o63YqW46OUhzVoCmqgX1wzJNNqACgiJGP
9oik07iEf3j096LnpDTCi7w=
=XYgh
-----END PGP SIGNATURE-----

--=-KUxW0IDxNX6E7+U55iq6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
