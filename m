Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5B0HWgA024200
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:17:33 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5B09Q1O009841
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 00:09:26 GMT
Message-Id: <200506110009.j5B09XXa016042@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>, gyurdiev@redhat.com,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script 
In-Reply-To: Your message of "Fri, 10 Jun 2005 21:21:26 BST."
             <20050610202126.GC8525@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <1118426293.3720.14.camel@dhcp83-8.boston.redhat.com> <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
            <20050610202126.GC8525@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118448572_4545P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Jun 2005 20:09:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118448572_4545P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jun 2005 21:21:26 BST, Luke Kenneth Casson Leighton said:

>  and a solution to the "i can't do that because there are so many
>  applications implicitly utilising /tmp/orbit-$USER, /tmp/gconfd-$USER,
>  /tmp/.ICE-unix, /tmp/.font-unix, /tmp/.X11-unix, is to create a
>  runtime-configurable library that can be told "use
>  /tmp/<DIR>/.xxx-$USER instead of /tmp/.xxx-$USER".
> 
>  once all programs use the library, change the location.

You'd *THINK* that a simple 'export TMPDIR=/tmp/$USER' would fix everything,
but NOOOOO.. ;)

(I wonder if Chad Seller's polyinstantation patches to build a small tree of
/tmp mounts per user, combined with fscontext= mounts, would do any good...

--==_Exmh_1118448572_4545P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCqiu8cC3lWbTT17ARAn4EAJsGVp/AV6tSecJADkE89DQTlQ04QQCcCfDi
FLEziGUI+OCwTCbs+oH9XA0=
=P1p3
-----END PGP SIGNATURE-----

--==_Exmh_1118448572_4545P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
