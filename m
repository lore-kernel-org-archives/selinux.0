Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAP1GDIi023766
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 20:16:13 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAP1Eggi017151
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 01:14:42 GMT
Subject: Re: xen 2.0 - adding selinux permissions
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041124201950.GA15740@lkcl.net>
References: <20041123220352.GF5146@lkcl.net>
	 <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124150927.GP5146@lkcl.net>
	 <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124154936.GB14100@lkcl.net>
	 <1101319995.30763.11.camel@nexus.verbum.private>
	 <20041124201950.GA15740@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iiuC9+M7as1iIBsjdi61"
Date: Wed, 24 Nov 2004 20:15:46 -0500
Message-Id: <1101345346.1543.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iiuC9+M7as1iIBsjdi61
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-24 at 20:19 +0000, Luke Kenneth Casson Leighton wrote:
> On Wed, Nov 24, 2004 at 01:13:15PM -0500, Colin Walters wrote:
> > On Wed, 2004-11-24 at 15:49 +0000, Luke Kenneth Casson Leighton wrote:
> >=20
> > >  okay, regarding the second argument to avc_has_perm(),
> > >  i asked the nice xen developers if it'd be possible to
> > >  associate a sid with each virtual machine.
> >=20
> > When would you want a process to be able to control one Xen machine but
> > not another?
> =20
>  i described such a scenario in an earlier message today to stephen:
>  giving an operator-admin the right to reboot a VM running a SQL server
>  but NOT giving that same operator the right to reboot the master OS
>  which, if you rebooted that, would take down every single VM with it.

The most flexible approach would be to make the management daemon a
userspace object manager, like dbus and nscd.  Give it a config file
(like the dbus <associate>) which maps VMs to security contexts.  Then
label the /proc/xen interface specifically, and ensure that only the
daemon can interact with it.


--=-iiuC9+M7as1iIBsjdi61
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBpTJCOIkJWWp2WGURApQSAJ9dTrZvqCzxmErdVGRPoPz9BDo8dgCeO/sB
3VNOHNJbiP0H03x5Lvg/M4E=
=dfK3
-----END PGP SIGNATURE-----

--=-iiuC9+M7as1iIBsjdi61--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
