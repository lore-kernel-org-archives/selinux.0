Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAANcpIi003616
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 18:38:51 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAANbRxZ012988
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 23:37:27 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 11 Nov 2004 00:38:52 +0100
Date: Thu, 11 Nov 2004 00:38:40 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patches without the can_network patch.
Message-Id: <20041110233840.GD2542@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de> <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil> <4192A029.5050909@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
In-Reply-To: <4192A029.5050909@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-11-11 00:12]:
> Removal of alot of kerberos and can_ypbind calls.  (Centralized under=20
> the auth call).

> --- nsapolicy/macros/admin_macros.te	2004-11-09 13:35:13.000000000 -0500
> +++ policy-1.19.1/macros/admin_macros.te	2004-11-10 17:30:03.466882997 -0=
500
> @@ -106,6 +107,7 @@
>  allow $1_t tty_device_t:chr_file rw_file_perms;
>  allow $1_t ttyfile:chr_file rw_file_perms;
>  allow $1_t ptyfile:chr_file rw_file_perms;
> +allow $1_t serial_device:chr_file setattr;

I recently thought if we should add
allow sysadm_t device_type:{ chr_file blk_file } setattr;
This is currently forbidden.
Most admins will want to change device permissions as to allow access to
specific users.
What do others think about this?

> --- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.19.1/macros/network_macros.te	2004-11-10 17:50:28.419688186 =
-0500
> @@ -0,0 +1,5 @@
> +define(`can_kerberos',`
> +can_network($1)
> +dontaudit $1 krb5_conf_t:file write;
> +allow $1 krb5_conf_t:file { getattr read };
> +')

This needs to be conditionalized. Most users don't use kerberos, they
should not have the can_network() for many different domains.
I'd like to have a file kerberos-client.te plus a boolean (optional).
That way, users who do not use kerberos can remove it completely from
policy (why should I have files labeled krb5_conf_t if I don't use
kerberos at all?)

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkqaAxWIrrrL0q+cRAsUMAKCxuu6G6WBoJPe2ekJwjJJolCM6LQCfdUyT
jMvtAyjHkwZGRY0nvTpoQtg=
=S2UE
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
