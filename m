Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MIhEdW024829
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 13:43:14 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MIcWMK023878
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 18:38:33 GMT
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   James Morris <jmorris@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tIINWu6Q9IyXw+tHQ5VU"
Date: Tue, 22 Feb 2005 13:40:47 -0500
Message-Id: <1109097647.3858.14.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tIINWu6Q9IyXw+tHQ5VU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-22 at 13:02 -0500, Stephen Smalley wrote:
>Are there any
>other changes to these two hooks that should be made at the same time?

One thing I wonder is if there's any other issues tied to legacy
binaries that would possibly make sense to control via this interface.
checkreqprot is a fairly specific name; You had suggested legacycompat
earlier?

>Should the default value for /selinux/checkreqprot be configurable?

I think having e.g. a sysctl would be nice.  For Fedora we will probably
want it enabled by default to maximize compatibility.  But with the new
execmod/execmem bits, it would be nice to add an entry to the SELinux
FAQ or a Fedora security guide about these so users who don't have
issues with legacy binaries can toggle these bits and get the stronger
protection.


--=-tIINWu6Q9IyXw+tHQ5VU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCG3yvOIkJWWp2WGURAmzkAJwPPl8qog8l2G7uweXzduWyW7m/4QCdH5rz
xDmyZlT9IA6ywYKITKtjPy0=
=VcJ/
-----END PGP SIGNATURE-----

--=-tIINWu6Q9IyXw+tHQ5VU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
