Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14869
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 10:43:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16363
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 14:41:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA16359
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 14:41:16 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23193
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 10:42:47 -0400 (EDT)
Received: from ultraviolet.org ([192.215.175.10])
	by tycho.ncsc.mil (8.9.3/8.9.3) with SMTP id UAA09983
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 20:55:04 -0400 (EDT)
Date: Tue, 1 Oct 2002 17:54:22 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021001175422.A18667@ultraviolet.org>
References: <20021001153638.J5416@ultraviolet.org> <200210020201.46223.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <200210020201.46223.russell@coker.com.au>; from russell@coker.com.au on Wed, Oct 02, 2002 at 02:01:46AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 02:01:46AM +0200, Russell Coker spake thusly:
> Yes, but you can get my packages for unstable from:
> deb http://www.coker.com.au/selinux/ ./

Ok, I'll do this just to keep things consistant.

> > But the new ps, ls, sshd, etc. do not seem to be included here. Where d=
o I
> > get those? Are they not in a deb?
>=20
> They are in coreutils, fileutils, shellutils, textutils, cron, dpkg, ssh,=
=20
> login, logrotate, procps, and psmisc packages.

Yes, but these are the non-SE Linux patched utils, right?

> It looks like you are missing the run_program_macros.te file.  It should =
be in=20
> /etc/selinux/macros/programs , you can copy it manually from=20
> /usr/share/selinux/policy/default/macros/program/run_program_macros.te .

Ok, I copied that file into place. Now the error I get is:

/usr/sbin/checkpolicy:  loading policy configuration from
/etc/security/selinux/src/policy.conf
ERROR 'name conflict for type run_deb_t' at token ';' on line 121201:
#
type run_deb_t, domain, privrole, privuser, privlog, auth;
/usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.12] Error 1

Upon doing some digging in policy.conf I see that type run_deb_t is indeed
declared twice. It is declared in all.te and in all_domains.te but those
are in /usr/share/selinux/policy/current and default. What is the
relationship of those two dirs to /etc/selinux/domains? Looks like stuff
has been moved around compared to the RedHat version.

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2aQ70ACgkQ9PIYKZYVAq2TdgCeI5j9RP9sWdfqPem16dWUThrI
vjcAnRmoi9c0HZdVWqBRw392BXHoiHPW
=y0+i
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
