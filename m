Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4FNSKRb018339
	for <selinux@tycho.nsa.gov>; Sat, 15 May 2004 19:28:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4FNSIMi018673
	for <selinux@tycho.nsa.gov>; Sat, 15 May 2004 23:28:18 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
        by jazzband.ncsc.mil  with ESMTP id i4FNSHpI018667 for <selinux@tycho.nsa.gov>; Sat, 15 May 2004 23:28:17 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 16 May 2004 01:28:15 +0200
Date: Sun, 16 May 2004 01:27:57 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: Re: Suse
Message-Id: <20040515232756.GB2095@jmh.mhn.de>
References: <1084540729.17741.61.camel@moss-spartans.epoch.ncsc.mil> <20040514224053.9377E3A404F@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
In-Reply-To: <20040514224053.9377E3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ed Street <edstreet@street-tek.com> [2004-05-15 02:09]:
> As was suspected it appears that suse 9.1 pro (shipping) has all the seli=
nux
> userland patches in place but no policy and no kernel support. I see the
> same startup in suse 9.1 as I do in fedora fc2t3 so it's disabled.

I just glanced over the SuSE 9.1 packages and made the following
observations (Note: didn't test or install anything):
Most relevant packages have SELinux support included. Things that are
still missing: cron, init and util-linux (vipw, chfn, context mount support)

It should not be all too difficult to add the missing pieces by looking
at the Fedora packages and mine for 9.0.
Updating policycoreutils, libselinux and checkpolicy (at version 1.8 in
SuSE 9.1) should be very easy, I just took the fedora packages and
recompiled them on SuSE.

Please note that I will support the SuSE 9.0 packages but won't update
to 9.1 in the forseeable future (6-9 months).

Another thing is policy: The included policy contains some SuSE-specific
cleanup but otherwise is very old (v1.4). I have been working on a proper
policy for SuSE for some time now in the background. It still has some
rough edges which I want to smooth before I submit the policy for
inclusion. If you or anyone else wants an intermediate copy, just drop
me a note!

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFApqd8xWIrrrL0q+cRAguCAKClold0HJircdgrCN7/Ytj+8hzF0QCfasp+
MqpVsk+HX671cuwd8xSpkcY=
=kJUa
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
