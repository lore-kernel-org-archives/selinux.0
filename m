Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8LEfBrT024918
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 10:41:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8LEeCaY026185
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 14:40:12 GMT
Subject: Re: File types that are not sysadmfiles...
From: Colin Walters <walters@redhat.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409211508.59158.russell@coker.com.au>
References: <414DA0A7.1000708@gentoo.org>
	 <1095695627.4431.157.camel@nexus.verbum.private>
	 <414F4113.1000208@redhat.com>  <200409211508.59158.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/qC79lwV+ZGyo0sGIpMz"
Date: Tue, 21 Sep 2004 10:42:30 -0400
Message-Id: <1095777750.5427.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/qC79lwV+ZGyo0sGIpMz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-21 at 15:08 +1000, Russell Coker wrote:
=20
>  # The sys configuration used for the /etc/vmware configuration files
> -type vmware_sys_conf_t, file_type, sysadmfile;
> +type vmware_sys_conf_t, file_type, sysadmfile, sysadmfile;

Also, typo here.

--=-/qC79lwV+ZGyo0sGIpMz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBUD3WOIkJWWp2WGURAid6AJ9GoPzF6l+75Fiho5FtKmqgBzAlhgCcCExd
8dDiFk2ubL4+m8vi82V3TjU=
=qsY/
-----END PGP SIGNATURE-----

--=-/qC79lwV+ZGyo0sGIpMz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
