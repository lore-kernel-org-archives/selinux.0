Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91NZwrT005759
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 19:35:58 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91NYp4L011672
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 23:34:52 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i91NZttE005698
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 18:35:55 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 41D404A658
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 18:35:55 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24491-01 for <selinux@tycho.nsa.gov>;
	Fri, 1 Oct 2004 18:35:55 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id D0FE04A650
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 18:35:54 -0500 (CDT)
Date: Fri, 1 Oct 2004 18:35:54 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: need advice for ld_so_cache_t errors
Message-ID: <20041001233554.GA26550@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

OK, I've finally reached a point where I'm switching my system from
permissive to enforcing mode (and there was much rejoicing! ;-).  Things
seem to be working pretty well, but I'm noticing a number of
ld_so_cache_t errors logged...  in particular, restarting postfix causes
an absolute FLOOD of messages such as the one below (reformatted for my
own sanity).

   Oct  1 17:16:34 sasami kernel: audit(1096668994.071:0): avc:
     denied  { execute } for  pid=3D3039 path=3D/etc/ld.so.cache
     dev=3Dhda5 ino=3D1022 scontext=3Dsystem_u:system_r:postfix_master_t=20
     tcontext=3Dsystem_u:object_r:ld_so_cache_t tclass=3Dfile

This happens for a number of other domains as well, but postfix seems to
have an exceptional affinity.  Should I just go ahead and grant execute
privileges to all the various domains (it seems like this would be a
pain to manage)?  If not, what's the preferred way of squashing these
messages?  I've browsed through CVS, but didn't notice any policy
updates which would obviously affect this issue.


The system in question is an old Pentium II box running Debian sid, with=20
the SELinux packages from Russell Coker's repository.  The kernel=20
version is 2.6.9-rc3.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXenagrEMyr8Cx2YRAhJZAJ9JTzFgqKNxCxQP/TD711vZkzsy2ACg2Ec3
MCkl8vrEq+bu2FpcHU3MCjM=
=jp1G
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
