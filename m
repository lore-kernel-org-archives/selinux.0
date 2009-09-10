Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AG3CIi030699
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 12:03:12 -0400
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AG4XhB013738
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:04:33 GMT
Received: by ey-out-1920.google.com with SMTP id 3so61078eyh.32
        for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 09:03:10 -0700 (PDT)
Date: Thu, 10 Sep 2009 18:03:08 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: XACE: tclass malformed
Message-ID: <20090910160307.GA6469@notebook3.grift.internal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some XACE avc denials end up in /var/log/messages as opposed to /var/log/audit/audit.log. These particular XACE avc denials appear with a malformed tclass field:

Example:

Sep 10 17:50:31 notebook3 Xephyr: Can't send to audit system: USER_AVC avc:  denied  { get_property } for request=X11:GetProperty comm=/usr/bin/xterm resid=102 restype=WINDOW scontext=dgrift_u:dgrift_r:sandbox_x_client_t:s0:c29,c36 tcontext=dgrift_u:object_r:sandbox_xserver_t:s0:c29,c36 tclass=x_drawable#012: exe="/usr/bin/Xephyr" sauid=0 hostname=? addr=? terminal=?

note the: tclass=x_drawable#012:

I believe this may be the reason why these avc denials end up in /var/log/messages instead of /var/log/audit/audit.log , but i am not sure.



--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqpIzsACgkQMlxVo39jgT/g0ACdE37RnUwfxR2E3vJA65TKZbcV
MY4An0ZyNpc4hEaj3GAt1VcDpCoUmpNf
=uYuk
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
