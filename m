Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2R0PORb026652
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 19:25:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2R0PNFV021363
	for <selinux@tycho.nsa.gov>; Sat, 27 Mar 2004 00:25:23 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
        by jazzband.ncsc.mil  with ESMTP id i2R0PM36021358 for <selinux@tycho.nsa.gov>; Sat, 27 Mar 2004 00:25:22 GMT
Message-Id: <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu>
To: Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>
Cc: selinux@tycho.nsa.gov
Subject: Re: make relabel: invalid context 
In-Reply-To: Your message of "Fri, 26 Mar 2004 22:27:20 +0100."
             <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be>
From: Valdis.Kletnieks@vt.edu
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be> <200403262039.i2QKdELb020746@turing-police.cc.vt.edu>
            <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1806743048P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 26 Mar 2004 19:25:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1806743048P
Content-Type: text/plain; charset=us-ascii

On Fri, 26 Mar 2004 22:27:20 +0100, Koen Vervloesem said:

> This is the first time I load the policy, I just did the SELinux 
> installation, of which the last step is the make relabel. When I do 
> what you suggest, I get this:

> /usr/sbin/load_policy /etc/security/selinux/policy.16
> /usr/sbin/load_policy:  security_load_policy failed

Not good..

> root@carnivore:~/policy-1.8# make relabel
> /usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]| xfs).*rw/{print $3}'`
> /usr/sbin/setfiles:  read 0 specifications

And even worse.

Is it possible that you've installed the SELinux software on the box, but
are still running on a non-SELinux kernel, and need a reboot?

--==_Exmh_1806743048P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAZMnwcC3lWbTT17ARAgPgAKDo9KyxZO641Ttv/HBPzg5Vu8LzfQCgzMNl
XIX60NgbQEhMKhdffaQs9rg=
=emwr
-----END PGP SIGNATURE-----

--==_Exmh_1806743048P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
