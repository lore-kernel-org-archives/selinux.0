Subject: Re: RES: Problem with SELinux and Squid+Winbind+Samba
From: Colin Walters <walters@verbum.org>
To: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "(SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
In-Reply-To: <5D201EB6E3041946BC4F8F6A14296132607EEB@svnt4-5.inepar.com.br>
References: <5D201EB6E3041946BC4F8F6A14296132607EEB@svnt4-5.inepar.com.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-au9AOiz5T5VFdCMjIK8J"
Date: Wed, 08 Dec 2004 10:18:54 -0500
Message-Id: <1102519134.4401.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-au9AOiz5T5VFdCMjIK8J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-12-08 at 08:36 -0200, Luis Fernando C. Talora wrote:
> That=C2=B4s the problem: I have no idea of how to build policies for SELi=
nux...
> Is there a way to remove SELinux features without reinstaling the OS from
> the scratch?=20

You can disable SELinux enforcement just for Squid.
http://fedora.redhat.com/docs/selinux-faq-fc3/index.html#using-s-c-security=
level

> Or (maybe it=C2=B4s better) could you please tell me where to find
> some documentation about SELinux?=20

http://fedora.redhat.com/docs/selinux-faq-fc3/index.html
And there's a lot of other links from there.


--=-au9AOiz5T5VFdCMjIK8J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtxteOIkJWWp2WGURAkbcAJ4/6Zg2i5Bbmu2FD/LpWYqgo7OLRQCfcJo9
ePyArtvcacD/DGDL4eqG0xw=
=DIJ4
-----END PGP SIGNATURE-----

--=-au9AOiz5T5VFdCMjIK8J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
