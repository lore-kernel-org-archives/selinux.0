Message-Id: <200406021856.i52IuNV8000745@turing-police.cc.vt.edu>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: issue on binary & source compatibility 
In-Reply-To: Your message of "Tue, 01 Jun 2004 06:34:57 PDT."
             <20040601133457.24158.qmail@web51508.mail.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20040601133457.24158.qmail@web51508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1382351162P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 02 Jun 2004 14:56:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1382351162P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 06:34:57 PDT, Park Lee <parklee_sel@yahoo.com>  said:

> It says: At present SE Linux provides binary compatibility with existing
> applications, and source compatibility with kernel modules.

> Then, I want to ask what the meaning and differences of 'binary compatibility'
> and 'source compatibility' are? and why it said so?

Binary compatibility means that you don't have to recompile user programs to
take advantage of the support (as opposed to, for instance some range-checking
extensions to GCC which require a recompile, or the PaX stuff that doesn't add
any protection to binaries that weren't linked with a modified binutils to add
the PaX-defined elf header....


--==_Exmh_1382351162P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAviLXcC3lWbTT17ARAjODAKCWq0XJYkTRSXRHCYuOwiF8HmGzGwCfQagd
ir9u620vsg5PaDnmu3vV+7c=
=ss2D
-----END PGP SIGNATURE-----

--==_Exmh_1382351162P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
