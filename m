Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IGQeRb002994
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:26:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IGOFB2029977
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:24:15 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
	by jazzswing.ncsc.mil  with ESMTP id i4IGNTwk029903
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:24:14 GMT
Message-Id: <200405181625.i4IGPpIa012129@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now? 
In-Reply-To: Your message of "Tue, 18 May 2004 13:02:44 -0000."
             <20040518130244.GB24917@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
            <20040518130244.GB24917@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-172491627P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 18 May 2004 12:25:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-172491627P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 May 2004 13:02:44 -0000, Luke Kenneth Casson Leighton said:

>  given the number of errors i am seeing, and given that they won't
>  go away, perhaps there is some breakdown in communication between
>  the rules being in the policy.conf file and their application to
>  packages.
> 
>  for example, should i be doing a make relabel every time i add
>  some new rules?

If you add new *rules* (allow foo_t bar_t...), you need to do a 'make reload'
to get the new policy in place.

If you add new file contexts, that requires a 'make relabel'.

Remember :  *.te changes -> make reload;  *.fc changes -> make relabel.

(If you're clever, you'll invoke setfiles by hand so you only relabel the
file system(s) you need to - if all the stuff you need is on /usr, you don't
need to redo all the other file systems...)

--==_Exmh_-172491627P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAqjkPcC3lWbTT17ARAk/SAKCnQyyANILXK+xXb7u5MlczooiRTgCfUSMG
RaRyivrlTDBEZkCGLczUEiM=
=C9Fr
-----END PGP SIGNATURE-----

--==_Exmh_-172491627P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
