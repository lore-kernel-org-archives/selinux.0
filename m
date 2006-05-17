Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4HGubIo018205
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 12:56:37 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4HGuaju006664
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 16:56:36 GMT
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
From: James Antill <jantill@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446B4D13.8080605@redhat.com>
References: <446AFED3.9010800@redhat.com>
	 <1147879972.3469.139.camel@code.and.org>  <446B4D13.8080605@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Tv9EcfOfMtoEbNB54fSs"
Date: Wed, 17 May 2006 12:56:35 -0400
Message-Id: <1147884995.3469.154.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Tv9EcfOfMtoEbNB54fSs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 12:19 -0400, Daniel J Walsh wrote:

> Only reason strdup fails is ENOMEM.  With ENOMEM you are almost=20
> garanteed you are going to crash anyways.  gstrdup does a exit when it=20
> runs out of memory.
> So we can messy up the code with a lot of checks that end up doing=20
> little.  Your choice.

 Well, it doesn't currently fail that way ... and it's relying on a side
effect that sometimes happens.
 Also the grep's I can see show the malloc/realloc/strdup failures being
handled, so without bugs in the application layer ENOMEM doesn't
currently mean a crash.

 I'd be happy to do the diffs to add an internal
xstrdup()/xmalloc()/etc. which calls abort(), if that's the route we
want to go. As you say, this would significantly reduce the failure
paths ... although it might get libselinux banned from some
applications.
 I'll also volunteer to do an audit and add the failure paths, if we
want to handle ENOMEM.

--=20
James Antill
<james.antill@redhat.com>


--=-Tv9EcfOfMtoEbNB54fSs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEa1XC11eXTEMrxtQRAnDUAJ9RzwHTzHfHgRboVB0NSZ6apiLGSgCbBkjY
wTV/lH9WRmykoRIvRtUJcJk=
=z4K7
-----END PGP SIGNATURE-----

--=-Tv9EcfOfMtoEbNB54fSs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
