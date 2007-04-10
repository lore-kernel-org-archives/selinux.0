Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3ADl7uD000690
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:47:07 -0400
Received: from passage.avira.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3ADl4gn006424
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:47:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by passage.avira.com (Postfix/AVIRA) with ESMTP id 000351249FF
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 16:47:01 +0300 (EEST)
Received: from naliboat.bu.avira.com (dasapass.avira.com [81.12.221.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.avira.local", Issuer "AVIRA Registration Authority" (verified OK))
	by passage.avira.com (Postfix/AVIRA) with ESMTP id E4DE41249FC
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 16:47:01 +0300 (EEST)
Date: Tue, 10 Apr 2007 16:45:25 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: djbdns patch
Message-ID: <20070410134524.GA8211@peter.bu.avira.com>
References: <460431FA.6050101@redhat.com> <1176209199.9840.13.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
In-Reply-To: <1176209199.9840.13.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

On Tue, Apr 10, 2007 at 08:46:39AM -0400, Christopher J. PeBenito wrote:
> On Fri, 2007-03-23 at 16:00 -0400, Daniel J Walsh wrote:
> > Make     ucspitcp_service_domain optional
>=20
> Perhaps this should be made an init_daemon_domain() too?

axfrdns runs under tcpserver [1], it is not a stand-alone daemon, so I see =
no reason why it should be an init_daemon_domain().

also I wonder what use would it be to have the djbdns module loaded without=
 also loading the ucspitcp one.

[1] http://cr.yp.to/djbdns/axfrdns.html

"Normally axfrdns runs under tcpserver to handle TCP connections on port 53=
 of a local IP address. tcpserver is responsible for rejecting connections =
=66rom hosts not authorized to perform zone transfers. axfrdns can also run=
 under secure connection tools offering an UCSPI-compliant interface."

> > differences
> > between files
> > attachment
> > (djbdns.patch),
> > "djbdns.patch"
> >=20
> > --- nsaserefpolicy/policy/modules/services/djbdns.te    2007-01-02 12:5=
7:43.000000000 -0500
> > +++ serefpolicy-2.5.10/policy/modules/services/djbdns.te        2007-03=
-22 15:06:59.000000000 -0400
> > @@ -44,4 +44,7 @@
> >  libs_use_ld_so(djbdns_axfrdns_t)
> >  libs_use_shared_libs(djbdns_axfrdns_t)
> > =20
> > -ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> > +optional_policy(`
> > +       ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> > +')
> > +

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQFGG5T0GSBEIeh4AEYRAuB4AJ9H2DRDO+aqdDcmMZQA27dX45EYtQCfSdU6
ueBvegDEX3f/u3XdT9pHNxs=
=DENa
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
