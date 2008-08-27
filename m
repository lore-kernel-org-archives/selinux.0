Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RJwpEm013266
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 15:58:51 -0400
Received: from exprod7og101.obsmtp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7RJwLiN028221
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 19:58:21 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id m7RJwnWv004860
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 14:58:49 -0500
Received: from garak.ads.sparta.com (garak.sparta.com [157.185.63.81])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id m7RJwnuU005131
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 14:58:50 -0500
Date: Wed, 27 Aug 2008 15:58:39 -0400
From: Robert Story <rstory@sparta.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setroubleshoot problems with MLS policy in enforcing mode
Message-ID: <20080827155839.08c93565@sparta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1Kg5+RXQOiHb6xY=LWwsU/0";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/1Kg5+RXQOiHb6xY=LWwsU/0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I'm having some issues with enforcing mode for the MLS policy. I've
been able to get around a few issues by simply feeding avcs through
audit2allow, but this is and MLS range issue, so I think something else
is needed...  Here is the AVC

type=3DAVC msg=3Daudit(1219865658.259:224923): avc:  denied  { write } for =
 pid=3D1332 comm=3D"audispd" path=3D"socket:[7463]" dev=3Dsockfs ino=3D7463=
 scontext=3Dsystem_u:system_r:audisp_t:s15:c0.c1023 tcontext=3Dsystem_u:sys=
tem_r:audisp_t:s0-s15:c0.c1023 tclass=3Dunix_stream_socket

This message is repeated quite frequently, driving the load up and
filling the log file. The audispd processing is running at SystemHigh,
and I haven't found a way to kill it without dropping to permissive
mode. (Any suggestions on that appreciated as well.. "newrole -r
sysadm_t; newrole -l s15; kill 1332" didn't work..)

I'm wondering if audisp/setroubleshoot are needed for auditing to work,
or if they are helps for X applications, in which case they aren't
needed at all, since X doesn't run in MLS enforcing.


--=20
Robert Story
SPARTA

--Sig_/1Kg5+RXQOiHb6xY=LWwsU/0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFItbHv7/fVLLY1mngRAq4FAJ46ukm7b3l0ufVUSiOXF4oNN0vThQCfb5Yn
7jzri8E5KJilqW6pfGKcRgk=
=e+N2
-----END PGP SIGNATURE-----

--Sig_/1Kg5+RXQOiHb6xY=LWwsU/0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
