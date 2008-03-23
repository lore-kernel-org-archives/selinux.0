Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2N5IWSk007347
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 01:18:32 -0400
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2N5IUKO010056
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 05:18:30 GMT
To: David Howells <dhowells@redhat.com>
Cc: akpm@linux-foundation.org, torvalds@osdl.org, Trond.Myklebust@netapp.com,
        chuck.lever@oracle.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: Performance degradation measurement [was Re: [PATCH 06/37] Security: Separate task security context from task_struct [ver #34]]
In-Reply-To: Your message of "Wed, 19 Mar 2008 17:12:08 -0000."
             <17688.1205946728@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <20080229004405.4142.32147.stgit@warthog.procyon.org.uk> <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
            <17688.1205946728@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1206249437_3492P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 23 Mar 2008 01:17:17 -0400
Message-ID: <25920.1206249437@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1206249437_3492P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Mar 2008 17:12:08 -0000, David Howells said:

(Sorry - finally catching up)

>  (1) SELinux enabled, none of the security patches:
> 
> 	(gdb) p (1.119+1.110+1.104+1.106+1.095+1.112+1.094+1.091+1.112)/9
> 	$3 = 1.104777777777777

>  (4) LSM/SELinux disabled, none of the security patches:
> 
> 	(gdb) p (1.121+1.136+1.137+1.121+1.122+1.131+1.121+1.131+1.118)/9
> 	$7 = 1.1264444444444437

What's up with *that*?  The *fastest* run with it disabled is 1.118, and
the *slowest* with it enabled is 1.119.  At that point, I have to wonder
what we're really measuring here....

--==_Exmh_1206249437_3492P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFH5efdcC3lWbTT17ARAg2qAJwKHeKqOVtSgql6bvnN+qdx6dg5ywCfQrPf
5uPBBxeg5QOLo8zbaUxDe+0=
=gNsw
-----END PGP SIGNATURE-----

--==_Exmh_1206249437_3492P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
