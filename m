Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBM476Ii025595
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 23:07:07 -0500 (EST)
Received: from h80ad248a.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBM45JCo023044
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2004 04:05:20 GMT
Message-Id: <200412220406.iBM46g0D019149@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: paranoid FC3 setup: banning all login access (!) 
In-Reply-To: Your message of "Mon, 20 Dec 2004 16:00:39 GMT."
             <20041220160039.GE24188@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20041220160039.GE24188@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1423228900P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 21 Dec 2004 23:06:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1423228900P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <22001.1103688385.1@turing-police.cc.vt.edu>

On Mon, 20 Dec 2004 16:00:39 GMT, Luke Kenneth Casson Leighton said:
> hi,
> 
> i have a requirement for setting up a server that might even ban
> logins - even admin logins.
> 
> the only things that should be allowed are reboot (ctrl-alt-delete at
> console) and services (e.g apache).

Umm.. how about this:

# chkconfig sshd off
# chkconfig telnetd off

and then 'grep -v getty' to remove those from /etc/inittab?

Leave the ctrl-alt-del entry in inittab, and have a grub entry
that boots with init=/bin/bash or similar single-user setup.


--==_Exmh_-1423228900P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFByPLQcC3lWbTT17ARAi6NAKCiB8nnes2eASzUOwzNwhAm4K+rPgCghXTU
Otbh1RVZ9hg4LtoB+vLiIfg=
=R8tT
-----END PGP SIGNATURE-----

--==_Exmh_-1423228900P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
