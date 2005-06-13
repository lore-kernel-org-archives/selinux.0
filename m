Message-Id: <200506131337.j5DDb6Ro021818@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Mon, 13 Jun 2005 11:01:58 BST."
             <20050613100158.GA6610@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu> <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
            <20050613100158.GA6610@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118669823_4308P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 13 Jun 2005 09:37:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118669823_4308P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 11:01:58 BST, Luke Kenneth Casson Leighton said:

>  because what happens if there _is_ no network by which you can access
>  or validate the domain policy such that you can trouble-shoot the
>  network interface?

The guys who build Juniper routers have an interesting solution for that - when
yo make a config change, it doesn't go permanently live.  If you don't enter a
*second* 'commit' command, after 5 mins or so it auto-reverts to the previous
config.  Really handy when you bork a routing table and hose your SSH session
into the router - our IOS guys immediaely made that their number 1 "We wish
Cisco did this too.." request ;)


--==_Exmh_1118669823_4308P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrYv/cC3lWbTT17ARArcNAKD3Px/M063+Q1bUn1ObXliq7r6WCQCggepE
836625CqOWrMScQH8Sh9zRg=
=bM9Z
-----END PGP SIGNATURE-----

--==_Exmh_1118669823_4308P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
