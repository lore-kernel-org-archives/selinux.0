Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NHmegA009572
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 13:48:40 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NHhkhG009011
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 17:43:46 GMT
Message-Id: <200505231621.j4NGL5pS016223@turing-police.cc.vt.edu>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Time estimate to create Debian enforceable policy 
In-Reply-To: Your message of "Mon, 23 May 2005 06:26:11 PDT."
             <20050523132611.20533.qmail@web60425.mail.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20050523132611.20533.qmail@web60425.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116865265_3973P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 23 May 2005 12:21:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1116865265_3973P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 May 2005 06:26:11 PDT, Roger Brunell said:
> Folk;
>   I am looking for some SWAGs in [days|weeks|months]
> for:
> Given moderately smart person, w/:
...
>       appropiate resources (SELinux running on system)
> 
> To create, test and verify a meaningful, workable and enforceable
>    policy for a <<elided>> (Mish-Mash of Debian parts)
>    system.

You *have* omitted "step 0" - creating a "meaningful" policy requires that
you have some *goals* of what the policy does and does not even attempt to
address (the difference of 'strict' and 'targeted' policies are an
indication of how much the goals impact the end product - similar issues will
arise for things like "should XYZ have a boolean or not?").

Assuming that you can use 'strict' or 'targeted' as a rough baseline, the
biggest time consumer there will be "getting a Debian system with SELinux
running".  Once you actually *get* all the pieces (the policy, the policy
utils, the hooks for 'init' to load it at boot, setools so you can create
labelled users, and so on), you're probably looking at "several long afternoons
fixing the file_contexts for things Debian installs in places different from
Fedora", and probably a day for each package that needs SELinux support that
doesn't already (although a few, such as "stuff run from httpd", are a bigger
challenge).

(No, I don't know what state the Debian support is currently - I'm merely providing
feedback on the specifications themselves....)

--==_Exmh_1116865265_3973P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCkgLxcC3lWbTT17ARAs/CAKDpBxMqxMFT05f1Xx0YHScvwHfxmwCgmGlY
2zh9zsBHfJaXsUOG2JghcRs=
=abN8
-----END PGP SIGNATURE-----

--==_Exmh_1116865265_3973P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
