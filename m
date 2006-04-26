Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3QKJNeW026338
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 16:19:23 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3QKJNvp011460
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 20:19:23 GMT
Message-Id: <200604262019.k3QKJ4en010190@turing-police.cc.vt.edu>
To: "Dinardo, Michael (Xetron)" <Michael.Dinardo@ngc.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: login error with strict modular ref pol in RHEL4 
In-Reply-To: Your message of "Wed, 26 Apr 2006 15:58:55 EDT."
             <85A664F2F3F2D1409EE003C7D3D52EE4038A01F0@xcgoh901.northgrum.com>
From: Valdis.Kletnieks@vt.edu
References: <85A664F2F3F2D1409EE003C7D3D52EE4038A01F0@xcgoh901.northgrum.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146082744_8443P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 26 Apr 2006 16:19:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1146082744_8443P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Apr 2006 15:58:55 EDT, "Dinardo, Michael (Xetron)" said:

> 1. Installed the following (along with all other tools at
> ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR/i386/):
> 	selinux-policy-2.2.28-1.rhel4.src.rpm
> 	selinux-policy-2.2.28-1.rhel4.noarch.rpm
> 	selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm
> 2. Installed the source from /usr/src/redhat:
> 	rpmbuild -bp /usr/src/redhat/SPECS/selinux-policy.spec
> 	cd /usr/src/redhat/BUILD/serefpolicy-2.2.23
> 	make install-src

Umm.. why are you installing a 2.2.23 policy like this, when you just downloaded
2.2.28?  Why isn't the 2.2.28-1 RPM installable as is, and what problems are you
setting yourself up for by doing this behind RPM's back?

> 4. Renamed /etc/selinux/targeted to /etc/selinux/strict

No good can come from this.  Especially since rpm thinks the 2.2.28.1 strict
policy is installed....

--==_Exmh_1146082744_8443P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFET9W3cC3lWbTT17ARAhaDAKClj/d4cuQ4b6OnsWg+UCfQls1LvACffJ8I
w3al13ac4J1KGXEYCIaahgw=
=Z3uJ
-----END PGP SIGNATURE-----

--==_Exmh_1146082744_8443P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
