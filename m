Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATC3kRb000043
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 07:03:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATC3jqY024439
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:03:45 GMT
Received: from drowsy.ifokr.org (puddle155.drizzle.com [216.162.217.155])
        by jazzband.ncsc.mil  with ESMTP id hATC3i0o024436 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:03:44 GMT
Date: Sat, 29 Nov 2003 04:03:37 -0800
From: Brian Hatch <bri@ifokr.org>
To: Russell Coker <russell@coker.com.au>
Cc: Petre Rodan <petre.rodan@ravantivirus.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: policies for DJ Bernstein tools
Message-ID: <20031129120337.GB26433@ifokr.org>
References: <20031128164612.GA32668@peter.rav.local> <200311292147.58963.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPJubUC1OEhHGyA2"
In-Reply-To: <200311292147.58963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UPJubUC1OEhHGyA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



> What is clockspeed?

clock skewer.  Think ntpd.

> What is publicfile?  Some sort of ftp-like service?

publicfile's ftpd is a chrooted read-only anonymous FTP server.
  (not pizza-thief enabled)

publicfile's httpd is a virtual-host-aware read-only
  (only GET/HEAD supported) chrooted HTTP server with
  no bangs or whistles.

> Also isn't ucspi-tcp is conceptually another version of inetd?

tcpserver is like a single-port inetd.  ucspi-tcp also
includes tcpclient, which connects to a host and runs a
program to talk to the peer (read/writing on fd's 6/7, IIRC)
A few other helper programs are in there too, I think.

> currect summary then perhaps the correct solution would be to macroise th=
e=20
> inetd policy to support multiple versions of inetd and consider ucspi-tcp=
=20
> just another version of inetd (with a different set of ports that it is=
=20
> permitted to bind to).
>=20
> What is svc?

used to start/stop/etc a service being monitored by supervise processes.

And, before you ask:

What's supervise?  Like a single-process init.  Watches/spawns only
one process.

Supervise prcoesses are spawed by svcscan. Svscan looks through /service
for symlinks that indicate supervise processes to be run.

IE svsscan is akin to /sbin/init (with /service directory instead of
/etc/inittab), supervise is like a single-process-watching init,
and svc is used to start/stop those supervise processes, akin to
'vi /etc/inittab; kill -HUP 1'




--
Brian Hatch                  "You do not make history.
   Systems and                You can only hope to survive it."
   Security Engineer
http://www.ifokr.org/bri/

Every message PGP signed

--UPJubUC1OEhHGyA2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/yIsZidaA3abfMooRAjWfAJ9frEUIpzEQJfH2YvSflUhbH7HlkACgh3Hv
oIKbDTpA3BxD9psy9hhtpkw=
=KGYp
-----END PGP SIGNATURE-----

--UPJubUC1OEhHGyA2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
