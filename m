Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CBQsIi014366
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 06:26:54 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CBOn8I006009
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 11:24:54 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j0CBQUWj016635
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 05:26:39 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id A73704A626
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 05:26:30 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02245-06 for <selinux@tycho.nsa.gov>;
	Wed, 12 Jan 2005 05:26:30 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 6589D4A624
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 05:26:30 -0600 (CST)
Date: Wed, 12 Jan 2005 05:26:30 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: lots of execmem failures with 2.6.10
Message-ID: <20050112112630.GA12730@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When trying to boot a 2.6.10 kernel, with the SELinux patch from the NSA
website applied, I'm getting a LOT of denial messages such as the ones
shown below.  This hoses the boot process to the point where the box is
essentially unusable (no networking, impossible to logon at the console,
etc.).  Under 2.6.9, the same policy works just fine.

   audit(1105293465.527:0): avc:  denied  { execmem } for  pid=3D237 comm=
=3Duname scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_u:system_r=
:initrc_t tclass=3Dprocess
   audit(1105293465.663:0): avc:  denied  { execmem } for  pid=3D240 comm=
=3Dtouch scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_u:system_r=
:initrc_t tclass=3Dprocess
   audit(1105293466.661:0): avc:  denied  { execmem } for  pid=3D259 comm=
=3Dsync scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_u:system_r:=
initrc_t tclass=3Dprocess
   audit(1105293466.716:0): avc:  denied  { execmem } for  pid=3D262 comm=
=3Duname scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_u:system_r=
:initrc_t tclass=3Dprocess

I haven't seen any mention of this on the list... any idea what's going
on?  My policy source files are from cvs, as of three weeks or so ago.=20
I don't mind updating to current cvs if necessary, but don't see any
obvious updates relating to execmem.  The server is an old Pentium II
box (nothing at all unusual about it), running Debian sid.

I can update my policy to allow the execmem easily enough, but would
expect to find it already in cvs if this was an expected issue.  Any=20
thoughts?

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5QlmgrEMyr8Cx2YRAg08AJ9/v1Rm4Qzl3vUE1STzoioj5tDmsACeIXjm
Q7mx60kQVNiVJNSDseiwunc=
=Uw2k
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
