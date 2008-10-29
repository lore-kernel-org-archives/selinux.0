Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9T9MUNc025162
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 05:22:30 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9T9MTxr025498
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 09:22:30 GMT
Received: by ug-out-1314.google.com with SMTP id 36so599327uga.17
        for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 02:22:28 -0700 (PDT)
Subject: Re: user guide: troubleshooting chapter
From: Dominick Grift <domg472@gmail.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>
In-Reply-To: <4907D37F.3090404@redhat.com>
References: <4907D37F.3090404@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-aHiIdovz9mIjeHcLrLE6"
Date: Wed, 29 Oct 2008 10:22:17 +0100
Message-Id: <1225272137.26092.2.camel@rawhide.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aHiIdovz9mIjeHcLrLE6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-10-29 at 13:07 +1000, Murray McAllister wrote:

> Thanks for any ideas.

Issues often happen due to bad labels. You may want to touch on
autorelabel, fixfiles, restorecon and invalid types like unlabeled_t,
file_t etc. The first thing i always check is to see if the source and
target context look valid.

--=-aHiIdovz9mIjeHcLrLE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkIK0QACgkQL00QnzrVtlwC3wCgrgOcnuUclEDY3ZAZAd9vZ2R2
eZ4AnidKsqeWRoGj2UjwZ53BBhfeLItu
=AnSs
-----END PGP SIGNATURE-----

--=-aHiIdovz9mIjeHcLrLE6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
