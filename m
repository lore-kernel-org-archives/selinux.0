Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4O67UgA014418
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 02:07:30 -0400 (EDT)
Received: from h80ad2641.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4O62Wlt019945
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 06:02:33 GMT
Message-Id: <200505240602.j4O62bJv014537@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Kurt Wall <kwall@kurtwerks.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit 
In-Reply-To: Your message of "Mon, 23 May 2005 23:37:36 BST."
             <20050523223736.GX8953@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com> <20050522202555.GR10156@lkcl.net> <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu> <20050523171422.GQ8953@lkcl.net> <200505231758.j4NHwkxZ020399@turing-police.cc.vt.edu>
            <20050523223736.GX8953@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116914556_4024P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 24 May 2005 02:02:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1116914556_4024P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 May 2005 23:37:36 BST, Luke Kenneth Casson Leighton said:

>  i have a bit more confidence to try it :)

The hardest part will be figuring out how depinit fits into the init_t/initrc_t
model - the RedHat/Fedora way has 'init' running in init_t, and any /etc/rc*.d/
scripts get launched in initrc_t, and then initrc_t is able to transition to
whatever fooserver_t the daemon runs in.  If depinit runs scripts to start stuff,
just labeling everything so depinit runs as init_t and the scripts as initrc_t will
probably be a lot closer to done than you might imagine....

And the *nice* thing is that once you're fairly confident that you've got it
at least somewhat close, you can boot in 'permissive' mode, catch all the 'avc'
messages, and use 'audit2allow' to help sort out the wreckage.

--==_Exmh_1116914556_4024P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCksN8cC3lWbTT17ARAokaAJ0aGrGgd+XMO5TSbTKu+xNqqLWPnwCgvnGr
1k3EuK9h0e2vWHENSMh+UBI=
=0MgV
-----END PGP SIGNATURE-----

--==_Exmh_1116914556_4024P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
