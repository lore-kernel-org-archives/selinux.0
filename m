Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EGV2Yu025966
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 12:31:02 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EGUVMM002284
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 16:30:31 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3EGUgZO013630
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 18:30:42 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3EGTOgT087835
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 18:29:24 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 14 Apr 2010 18:30:42 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
Message-ID: <20100414163042.GE21894@myhost.felk.cvut.cz>
References: <C7EA5D61.B6871%csellers@tresys.com>
 <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net>
 <4BC5B6AC.1040101@redhat.com>
 <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net>
 <4BC5D183.20403@redhat.com>
 <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
In-Reply-To: <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

James Cammarata wrote:
> Understood, I'm just surprised that running SElinux in strict mode
> breaks sudo isn't more of a priority.  Are that few people using
> strict mode?

RHEL 5 selinux manual specifically says that strict mode is YMMV, ie.
not officially supported.

By the way, debian lenny has the same problems with sudo. Recompiling
the package from source with selinux support on did not help since the
policy to do its deeds was also missing. Maybe on RHEL5 you'd encounter
the same problem.

I simply instructed my co-admins to execute 'newrole' and 'sudo -i' in
order to gain administrative privileges (root + sysadm_r) from their
staff_r shell.


Michal Svoboda


--C94crkcyjafcjHxo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvF7bIACgkQg/fU9pp1uX4p7ACgq+LFWkFIJfhcV3mPLhx2lZW2
u0gAoLFAaHY+XFc3x0fFdk1b0KPS8iAN
=ClJ8
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
