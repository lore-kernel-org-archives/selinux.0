Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IC7HBF001463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 08:07:17 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IC7GAI015090
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 12:07:16 GMT
Received: by wx-out-0506.google.com with SMTP id i26so155286wxd.30
        for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 05:07:16 -0700 (PDT)
Subject: Re: firefox3
From: Dominick Grift <domg472@gmail.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30807171539m772f87fh64f706e8f9cf0e9e@mail.gmail.com>
References: <dd18b0c30807171539m772f87fh64f706e8f9cf0e9e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aKIDq664HJj0vy+Kr6iG"
Date: Fri, 18 Jul 2008 14:07:12 +0200
Message-Id: <1216382832.8282.27.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aKIDq664HJj0vy+Kr6iG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-17 at 22:39 +0000, Justin Mattock wrote:
> I'm trying to tighten up firefox, from what I can see over here:

I do not encourage people to run Firefox as sysadm_t, and i recommend
you use staff_t as your default domain. Sysadm_t is a domain specific
just for sysadmin tasks. Plus sysadm_t is being (kind of) replaced by
unconfined_t in the targeted policy.=20

Also i think sysadm, user and staff do not transition once they run
Firefox, but that they run Firefox in the user domain by default.

In Fedora 9 only xguest_t domain by default can run Firefox in the
Mozilla domain by setting the boolean.

However Nsplugin is now by default confined to the nsplugin_t domain and
so even though you may not transition to mozilla_t as staff or user, you
will still be protected by nsplugin_t.

To see in what domain Firefox is running execute ps auxZ | grep -i
firefox.
--=20
Dominick Grift <domg472@gmail.com>

--=-aKIDq664HJj0vy+Kr6iG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiAh20ACgkQL00QnzrVtlzDJgCfTxq7WECH/62MbVm2n0ylg0MS
D1wAoJ4vkmtOC0O/LMux5meTqJT2AVKw
=bJ+A
-----END PGP SIGNATURE-----

--=-aKIDq664HJj0vy+Kr6iG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
