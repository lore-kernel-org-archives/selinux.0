Message-Id: <200506102105.j5AL5ulD008435@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <gyurdiev@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script 
In-Reply-To: Your message of "Fri, 10 Jun 2005 21:18:14 BST."
             <20050610201814.GB8525@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com> <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
            <20050610201814.GB8525@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118437554_4545P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Jun 2005 17:05:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118437554_4545P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jun 2005 21:18:14 BST, Luke Kenneth Casson Leighton said:

>  how about "auto-file-domaining" on chown() and chgrp(), in
>  a similar way that exec() performs auto-domain-transitioning?

Ouch.

The major conceptual difficulty is that exec() is a logical and obvious place
to change domains in a manner similar to set(u|g)id binaries. Programmers are
*used* to the concept that "exec() splats everything" to the point that they
sometimes get bit when they encounter something that *isnt* reset by exec()
(the open file descriptor table is a common example).

However, that model doesn't extend easily to chown/chgrp.  The problem is twofold:

1) You may want this auto-file to happen in programs that have absolutely no
business going anywhere *near* chown/chgrp. (I'll go a step further and say
that doing this behind-the-scenes magic to a program that's *allowed* to
chown(), instead of fixing the program to DTRT, is a security mess just waiting
to happen).

2) Even if the code *is* doing chown/chgrp, you end up with lots of "magic" -
two chown() calls to set the same "user" may set different security contexts,
and two chown() calls that set different users may set the same context.

--==_Exmh_1118437554_4545P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCqgCycC3lWbTT17ARAgpJAKCJzgTS3j23W57KgJLx/icmmdm9fQCgg/SW
noBJ9o/R2h8n2JteOWaFlJU=
=ldA5
-----END PGP SIGNATURE-----

--==_Exmh_1118437554_4545P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
