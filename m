Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7JHaSrT028394
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 13:36:31 -0400 (EDT)
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7JHZgpw000976
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 17:35:47 GMT
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Bxqpq-00005K-00
	for selinux@tycho.nsa.gov; Thu, 19 Aug 2004 19:36:22 +0200
Received: from pd953a685.dip.t-dialin.net ([217.83.166.133] helo=localhost)
	by mrelayng.kundenserver.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1Bxqpp-0003yx-00
	for selinux@tycho.nsa.gov; Thu, 19 Aug 2004 19:36:21 +0200
Date: Thu, 19 Aug 2004 19:36:20 +0200
From: Stefan SF <stefan@sf-net.com>
To: selinux@tycho.nsa.gov
Subject: policy for scponly - need help
Message-ID: <20040819173620.GA8543@crux.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm trying to build a policy for a program called "scponly". The rudimentary things went all right! Here are the files:

# domains/program/scponly.te
type scponly_exec_t, file_type, exec_type, sysadmfile;

ifdef(`ssh.te',`
allow sshd_t scponly_exec_t:file { getattr execute read };
allow user_t scponly_exec_t:file { entrypoint };
')


# file_contexts/program/scponly.fc
/usr/bin/scponly                system_u:object_r:scponly_exec_t
/usr/sbin/scponlyc              system_u:object_r:scponly_exec_t


When I'm using the scponly program all things went fine, but when I'm trying to use the scponlyc program I get this message:

audit(1092936373.217:0): avc:  denied  { dac_override } for  pid=5220 exe=/usr/sbin/scponlyc capability=1 scontext=test:user_r:user_t tcontext=test:user_r:user_t tclass=capability
audit(1092936373.217:0): avc:  denied  { dac_read_search } for  pid=5220 exe=/usr/sbin/scponlyc capability=2 scontext=test:user_r:user_t tcontext=test:user_r:user_t tclass=capability


Is there a way to put the restrictions dac_* to the scponly-policy or do I have to modify the user-policy? Because the scontext and the tcontext belongs alway to the user-policy.

ciao, Stefan

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJOUUUEn3BeoPvtwRAuLdAJ97PHPhJidWWPBMx4oDdwWVRPNQsgCdFR7b
HDpjHAX4ym4eH/nd5RtbLB8=
=JSqx
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
