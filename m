Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9BEkZrT006169
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 10:46:36 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9BEjOfG029031
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 14:45:25 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 11 Oct 2004 16:46:33 +0200
Date: Mon, 11 Oct 2004 16:47:12 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: cleanup: domain self references
Message-Id: <20041011144712.GE15844@jmh.mhn.de>
References: <20041011085450.GA15844@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
In-Reply-To: <20041011085450.GA15844@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VdOwlNaOFKGAtAAV
Content-Type: multipart/mixed; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2004-10-11 12:15]:
> I just did a global search and replace to clean up rules of the form
>         allow some_domain_t some_domain_t:capability setuid;
> This makes the policy easier to read.

Attached is a small patch to audit2allow in order to make this ugliness
less frequent in the future.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="audit2allow.diff"

--- audit2allow.old     2004-10-11 16:36:18.760329072 +0200
+++ audit2allow 2004-10-11 16:37:20.472947328 +0200
@@ -124,6 +124,9 @@
 foreach $k (sort keys %rules)
 {
     my ($a,$scontext,$tcontext,$tclass) = split /\|/, $k;
+    if ($scontext eq $tcontext) {
+        $tcontext = 'self';
+    }
     print OUT  "allow $scontext $tcontext:$tclass {";

     my $access_types = $rules{$k};


--mSxgbZZZvrAyzONB--

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBapzwxWIrrrL0q+cRAjTBAKCw2U3DY9Cy9/tYN7iPbEFJyFBSUQCfd6Dr
0fKzCBL2DpdfeAPVvxV3xUc=
=Y/sf
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
