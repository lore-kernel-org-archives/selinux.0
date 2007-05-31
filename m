Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VANMdQ029393
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 06:23:22 -0400
Received: from seeker.avira.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VANKWZ024679
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 10:23:21 GMT
Date: Thu, 31 May 2007 13:24:57 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: dwalsh@redhat.com
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: Re: djbdns needs optional_policy
Message-ID: <20070531102457.GA16057@peter.simplex.ro>
References: <200705301451.l4UEpKo6008223@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <200705301451.l4UEpKo6008223@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Daniel,

On Wed, May 30, 2007 at 10:51:20AM -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/djbdns.te	2007-05-29 14:10:57.=
000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/djbdns.te	2007-05-30 07:35:=
54.000000000 -0400
> @@ -44,4 +44,7 @@
>  libs_use_ld_so(djbdns_axfrdns_t)
>  libs_use_shared_libs(djbdns_axfrdns_t)
> =20
> -ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> +optional_policy(`
> +	ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> +')
> +

http://marc.info/?l=3Dselinux&m=3D117621284727331&w=3D2

what is the reason for your tweak?=20

bye,
peter


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQFGXqJzGSBEIeh4AEYRAjiEAJ9n6r8C+RFik7NHyY+T2Ij3gq27IQCeOE4W
+GItipXgmY7ZzAmb9tPd4Fs=
=+xSg
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
