Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAUIboRb003292
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 13:37:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAUIbnqY015400
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 18:37:49 GMT
Received: from wavehammer.waldi.eu.org (hornet.berlios.de [195.37.77.140])
        by jazzband.ncsc.mil  with ESMTP id hAUIbh0o015397 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 18:37:48 GMT
Date: Sun, 30 Nov 2003 19:37:01 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: policy problems
Message-ID: <20031130183701.GA14242@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

i found the following problems with the policy:
- admins on the local console are not allowed to write to /dev/console
  background: s390 don't know about vts, so this is the only console.
- noone is allowed to use nfs, maybe you should add some examples.
- inetd don't get the correct domain. the correct policy, inetd.te is
  included and the file is labeled correcly but the process remains in
  initrc_t.
| # ls -al --context /usr/sbin/inetd
| -rwxr-xr-x  root     root     system_u:object_r:inetd_exec_t /usr/sbin/in=
etd
| # ps aux | grep "[i]netd"
| root       916  0.0  0.4  1624  540 ?        S    18:28   0:00 /usr/sbin/=
inetd
| # cat /proc/916/attr/current;echo
| system_u:system_r:initrc_t

bastian

--=20
Without facts, the decision cannot be made logically.  You must rely on
your human intuition.
		-- Spock, "Assignment: Earth", stardate unknown

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj/KOM0ACgkQLkAIIn9ODhEDZACg3OmNz/3En+ZQZbEobddjr4QL
wBMAn0CDqo3aXoq6HqjdrV1DEGA2YdyN
=yM0J
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
