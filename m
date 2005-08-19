Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7JM8tOb010578
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 18:09:10 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7JLwI5A002205
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 21:58:18 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 19 Aug 2005 23:59:20 +0200
Date: Fri, 19 Aug 2005 23:59:17 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Steve G <linux_4ever@yahoo.com>, SELinux-dev@tresys.com,
   James Morris <jmorris@namei.org>
Subject: Re: [RFC] Checking the loaded policy against a policy on disk
Message-Id: <20050819215916.GD7945@thorium.jmh.mhn.de>
References: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Smalley <sds@tycho.nsa.gov> [2005-08-19 14:50]:
> A related idea would be to also extend the binary policy format to
> include a field for an arbitrary text string label that could be set
> when the policy is generated, and have the kernel save that string and
> export it via another new selinuxfs node.  This would allow an
> identifier string to be associated with the policy image, such as the
> policy package's name and version (e.g.
> selinux-policy-targeted-1.17.25-3), and extracted later by userspace to
> determine which particular policy the one in memory is supposed to
> match.

I'd really like to see that. When managing many machines it is really
nice to see which policy they have loaded. Just yesterday I hacked the
makefile to insert the current revision of the policy (we manage policy
with tla) as a dummy boolean so it can be inspected at runtime; a proper
textfield would be better IMHO.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDBlY0xWIrrrL0q+cRAp+RAJ9JbBUaHelG+5qFE/SoAh4tFBFkAgCcDGfl
vK+qMZEBz+CNkuZE5y44zZY=
=kmlL
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
