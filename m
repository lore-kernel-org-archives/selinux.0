Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i37A8kRb008304
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 06:08:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i37A6lUZ016557
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 10:06:47 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
	by jazzswing.ncsc.mil  with ESMTP id i37A6lmT016554
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 10:06:47 GMT
Message-Id: <200404071008.i37A8d9U011172@turing-police.cc.vt.edu>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: Sepcut Relabel problem 
In-Reply-To: Your message of "Tue, 06 Apr 2004 16:31:12 PDT."
             <p06100503bc98ecccb8c1@[128.115.96.64]>
From: Valdis.Kletnieks@vt.edu
References: <p06100503bc98ecccb8c1@[128.115.96.64]>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1587838220P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 07 Apr 2004 06:08:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1587838220P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Apr 2004 16:31:12 PDT, Mark Shakespeare <mshakes@llnl.gov>  said:
> --============_-1130828223==_ma============
> Content-Type: text/plain; charset="us-ascii" ; format="flowed"
> 
> Trying to relabel file system from within Sepcut ( most current version )
> 
> getting a weird error....
> 
> 
> couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory
> couldn't open "/tmp/sepcut-zrqWs8Ew": no such file or directory

> Sepcut hangs....then no other X-based apps can run. A reboot clears things.
> 
> Any ideas?

Seen in /etc/security/selinux/src/policy/Makefile:

relabel:  $(FC) $(SETFILES)
        @echo "Cleaning out /tmp"
        -rm -rf /tmp/.??* /tmp/*

which is where your /tmp/sepcut-* and /tmp/.X11-unix/ went (the first
explaining your sepcut error, the second explaining your X11 problem).

I'll let somebody else address the question of whether that 'rm' command
is over-zealous, as I'm not sure what it's trying to do.  If it's trying to
make sure there's no symlink attacks, it's going about it wrongly, as all
that does is close down the race conditions a bit.

Most likely, what it *should* be doing is a mkdir and working inside that
directory for temp files.

--==_Exmh_1587838220P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAc9MmcC3lWbTT17ARAhQNAKCUMTzjGDfxKCGcwCrkRL0pTXf08wCgozr6
rNYxiwyRxf7GXZZPQBX+He0=
=Ox6G
-----END PGP SIGNATURE-----

--==_Exmh_1587838220P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
