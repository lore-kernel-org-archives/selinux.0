Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KMeBAe020895
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 17:40:11 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KMe6MM008640
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 22:40:06 GMT
Message-ID: <47BCAC42.50003@redhat.com>
Date: Wed, 20 Feb 2008 17:40:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FC8 enforcing auditd, mcstransd, NFS statd fail to start
References: <cadfc0e40802201124l5f8b2330x159eb3f7485687c4@mail.gmail.com>
In-Reply-To: <cadfc0e40802201124l5f8b2330x159eb3f7485687c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
> type=AVC msg=audit(1197625021.926:66): avc:  denied  { write } for
> pid=1494 comm="audispd" path="socket:[7238]" dev=sockfs ino=7238
> scontext=system_u:system_r:auditd_t:s15:c0.c1023
> tcontext=system_u:system_r:auditd_t:s0-s15:c0.c1023
> tclass=unix_stream_socket
> 
> type=AVC msg=audit(1203524274.667:562): avc:  denied  { use } for
> pid=19909 comm="mcstransd" path="/lib/ld-2.7.so" dev=dm-0 ino=2359430
> scontext=system_u:system_r:setrans_t:s15:c0.c1023
> tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=fd
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Looks like you have an MLS constraint problem.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke8rEIACgkQrlYvE4MpobP0CACgqFCF2JTlJQVyHNNTpfx5pJpo
8poAoJlMUL0Qp529P5+jLhpOV/yJFNUl
=GfHP
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
