Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lADGRT0R013220
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 11:27:29 -0500
Received: from mail1.exo2.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lADGRNH4027534
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 16:27:29 GMT
From: Steven Harp <steven.harp@adventiumlabs.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: pcscd and serial readers
Date: Tue, 13 Nov 2007 10:27:13 -0600
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711131027.14488.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


The pcscd policy (daemon for smart card readers) handles USB 
readers fine, but balks--for me--when a serial port reader is 
configured (the daemon quietly dies).  

Module rev 1.1.0 includes a line:
 term_dontaudit_use_unallocated_ttys(pcscd_t)

Should this perhaps be:
 term_use_unallocated_ttys(pcscd_t)
?

# Steve Harp <steven.harp@adventiumlabs.org>


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHOdBiPcFX9H2zuSkRAnHlAJ94G1DuYjS4EjpH1aqTK2jrQlCLAgCgjveg
kNMNxJo+TeL5eW6uAqHJdPQ=
=HQFb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
