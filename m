Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92GourT009094
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 12:50:56 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92GoslM003131
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 16:50:55 GMT
Date: Sat, 2 Oct 2004 11:50:41 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041002165041.GB30426@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <200410021309.46413.russell@coker.com.au> <20041002043740.GA28765@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <20041002043740.GA28765@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm not sure if this will help, but here's a quick look at the generated=20
rules.  There are a lot more entries, of course, but they all seem to be=20
granting the exact same privileges against ld_so_cache_t (except for=20
ldconfig_t itself, of course).

   $ grep ld_so_cache_t policy.conf | head -5
   # ld_so_cache_t is the type of /etc/ld.so.cache.
   type ld_so_cache_t, file_type, sysadmfile;
   allow sysadm_t ld_so_cache_t:file { read getattr lock ioctl };
   allow sysadm_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
   allow sysadm_mail_t ld_so_cache_t:file { read getattr lock ioctl };

Could you check one of your Debian machines, and see if "execute" is=20
being included somehow?  I'm not sure how we'd have different results,=20
tho, as I'm using your selinux-policy-default package (1.14-2).

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXtxhgrEMyr8Cx2YRAuS8AJwOXlVCRhGjLa7D/dgZcLV4ZVL6IACg3hCs
mgbyiEv68TzXTEjJ6TWA0bs=
=xc6O
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
