Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8FBHXhx008155
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 07:17:33 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8FBGja0029179
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 11:16:45 GMT
Received: by ug-out-1314.google.com with SMTP id z36so1002957uge.17
        for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 04:17:32 -0700 (PDT)
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
From: Dominick Grift <domg472@gmail.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48CDC478.3050101@redhat.com>
References: <48C6236D.4020408@redhat.com> <48C67DCD.2030104@redhat.com>
	 <48CDBA0A.3000801@redhat.com>  <48CDC478.3050101@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wJjVRbbHckUPDA2IHdKN"
Date: Mon, 15 Sep 2008 13:17:31 +0200
Message-Id: <1221477451.13007.20.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wJjVRbbHckUPDA2IHdKN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-15 at 12:12 +1000, Murray McAllister wrote:

> What sudo access does staff_t have?

I think staff can transition to all privileged user domains

secadm,logadm,webadm,auditadm,unconfined,sysadm etc. You can verify this
in the staff role module in the source policy. staff_t may also be root
however this root as staff_t will have the same permission as staff_t as
unprivileged user.

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.
--=20
Dominick Grift <domg472@gmail.com>

--=-wJjVRbbHckUPDA2IHdKN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjOREgACgkQL00QnzrVtlzlWQCeJhI+vnHIpon/BZ8NVeYkQ80p
7m4AoKxgmm369EL1s8d0DVF8iWHAZ1aT
=6xUs
-----END PGP SIGNATURE-----

--=-wJjVRbbHckUPDA2IHdKN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
