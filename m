Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIJxKIi015913
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:59:20 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIJvqiM026156
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:57:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 18 Nov 2004 20:59:22 +0100
Date: Thu, 18 Nov 2004 20:59:15 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patches without the can_network patch.
Message-Id: <20041118195914.GC2538@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de> <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil> <4192A029.5050909@redhat.com> <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil> <419CB27E.6080800@redhat.com> <20041118194313.GA2538@jmh.mhn.de> <419CFD0F.2060301@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
In-Reply-To: <419CFD0F.2060301@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-11-18 20:50]:
> Thomas Bleher wrote:
> >* Daniel J Walsh <dwalsh@redhat.com> [2004-11-18 15:32]:
> >>policy-1.19.2/domains/program/ldconfig.te
> >>--- nsapolicy/domains/program/ldconfig.te	2004-11-09=20
> >>13:35:12.000000000 -0500
> >>+++ policy-1.19.2/domains/program/ldconfig.te	2004-11-18=20
> >>08:48:23.918139878 -0500
> >>@@ -26,7 +26,7 @@
> >>allow ldconfig_t lib_t:lnk_file create_lnk_perms;
> >>
> >>allow ldconfig_t userdomain:fd use;
> >>-allow ldconfig_t etc_t:file { getattr read };
> >>+allow ldconfig_t etc_t:file { getattr read unlink };
> >>  =20
> >
> >Which files does it want to unlink? Is it possible that the file was
> >just mislabeled? (there's this line in the policy:
> >file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t, file)
> >so it should probably be ld_so_cache_t)
> >=20
> >
> Yes I added this because it gets, mislabeled and then can not change it=
=20
> back.
> A bug in RPM was causing it many times.   Booting in non enforcing=20
> mode,  non selinux mode
> This can easily happen on targeted policy, but could also happen on stric=
t,
> Allowing ldconfig_t from unlink etc_t files seems like a reasonable way=
=20
> around the problem.

Ah, OK. Best solution would probably be to make ldconfig create its files i=
n a
separate directory, but until then this seems like a good workaround.
How about a comment above this line like:
# allow ldconfig to work if /etc/ld.so.cache is mislabeled

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnP8SxWIrrrL0q+cRAl+fAJ0SIz4YwGm2BfMGltSgJuUBPgxfLwCfT2Ay
g50VP7dEEZ0azMS4RmnvMkg=
=4Uqb
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
