Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n885wHZK024848
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 01:58:17 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n885vZan021791
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 05:57:36 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n885w7o7007714
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 07:58:07 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n885w6sR027288
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 07:58:07 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 8 Sep 2009 07:58:06 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: MCS and default labels
Message-ID: <20090908055806.GA24297@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I have implemented a simple MCS based system for hosting SVN
repositories. I was happy with the performance until I found out that
the s0-s0:c1 processes will happily create new revisions (ie. new files)
as s0 inside a s0:c1 directory. According to various sources, new files
are always created using the lowest security level in the range of the
creating process, despite an inheritance mechanism already working for
types. What is the reasoning behind this?

I tried to mitigate this by forcing a ssh session into a certain MCS
range, as in ssh user/foo_r:foo_t:s0:c1, however this only works for
changing roles but not for MCS. Not even setting the MCS level in
default_contexts works as one would expect. Again, why?

Running out of ideas, my solution for now is to hope that a s0 process
cannot search / modify the s0:c1 directory, even with s0 files present
and to periodically "restorecon" the whole dir (no, restorecond does not
seem to be working on dirs recursively). So the third question is, are
there any better ways?

Regards,
Michal Svoboda

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkql8m4ACgkQg/fU9pp1uX5OPgCeM7dO9yAw+tgn4XGd0WcAjRXj
mTMAn0t3U/9IashN+wgz3MdgVK8K4rOp
=fmGY
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
