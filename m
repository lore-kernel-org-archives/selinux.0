Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GLjYrT028456
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 17:45:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GLjXsh028966
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 21:45:34 GMT
Subject: Re: SELinux policy discussion.
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, selinux@tycho.nsa.gov
In-Reply-To: <414A03BC.80707@redhat.com>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
	 <1095307503.4231.152.camel@nexus.verbum.private>
	 <1095318426.32510.30.camel@localhost.localdomain>
	 <1095356254.4231.188.camel@nexus.verbum.private>
	 <414A03BC.80707@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3XiVVdTXKQe2A8SayDFk"
Date: Thu, 16 Sep 2004 17:46:57 -0400
Message-Id: <1095371217.4231.203.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3XiVVdTXKQe2A8SayDFk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 17:21 -0400, Daniel J Walsh wrote:

> One argument for allowing users to read most of these files, is we are=20
> forcing a user in strict policy to run in a higher domain then he might=20
> otherwize.  IE if a user wants to regularly look at files in /etc,=20
> he might decide to add admin privs to his user account=20
> and login as sysadm_r.

True, but no one has yet explained a reason why access to any of the
files being discussed would be needed if you weren't going to log in as
sysadm_r and *do* something with them anyways.




--=-3XiVVdTXKQe2A8SayDFk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBSgnROIkJWWp2WGURAhdvAJ41/MYUXqwggAqvzZr3A/oqgxETYgCfXE59
n2s0xiysrvk6fteNjZoTnS4=
=CqVg
-----END PGP SIGNATURE-----

--=-3XiVVdTXKQe2A8SayDFk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
