Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5U8TrrT024276
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 04:29:53 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5U8TpWY012601
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 08:29:51 GMT
Date: Wed, 30 Jun 2004 10:29:35 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: SELinux on Debian (Sid), second try
Message-ID: <20040630082935.GK1688@philips.com>
References: <20040624163900.GB3290@philips.com> <200406282347.41232.russell@coker.com.au> <20040628150448.GF1688@philips.com> <200406291533.10068.russell@coker.com.au> <20040629085928.GH1688@philips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmUrFcWP4LYae1gV"
In-Reply-To: <20040629085928.GH1688@philips.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--rmUrFcWP4LYae1gV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2004 at 10:59:28AM +0200, Magnus Therning wrote:
>On Tue, Jun 29, 2004 at 03:33:09PM +1000, Russell Coker wrote:
>>On Tue, 29 Jun 2004 01:04, Magnus Therning <magnus-work@therning.org> wro=
te:
>>> >/etc/selinux is supposed to be a sym-link
>>> >to /usr/share/selinux/policy/current/ .
>>> >
>>> >Does /usr/share/selinux/policy/current/ exist?
>>>
>>> Nope, it doesn't. All I have is /usr/share/selinux/policy/default/
>>
>>Change line 12 of /etc/dpkg/postinst.d/selinux to be the following and
>>things should work.  I'll upload a new version of
>>selinux-policy-default to fix this shortly.
>>if grep -q selinuxfs /proc/mounts && test -e /etc/selinux ; then
>
>That got me a bit further. I get asked a slew of questions about domains
>:-) After answering them to the best of my ability (this is to be a test
>setup only, so I answer yes to a lot of stuff) I get stuck at the
>following:
>
>Installing the new SE Linux policy
>mount: none already mounted or /selinux busy
>dpkg: error processing selinux-policy-default (--configure):
> subprocess post-installation script returned error exit status 32
>Errors were encountered while processing:
> selinux-policy-default
>E: Sub-process /usr/bin/dpkg returned error code (1)

Some more information (that might be interesting).

/etc/fstab has an entry like this:

 none /selinux selinuxfs noauto 0 0

'mount' doesn't report it mounted though. Should it?

Calling 'mount /selinux' results in

 mount: none already mounted or /selinux busy

'ls /selinux' reveals that it already is populated with the following:

total 0
-rw-rw-rw-    1 root     root            0 Jun 28 13:35 access
dr-xr-xr-x    1 root     root            0 Jun 28 13:35 booleans
--w-------    1 root     root            0 Jun 28 13:35 commit_pending_bools
-rw-rw-rw-    1 root     root            0 Jun 28 13:35 context
-rw-rw-rw-    1 root     root            0 Jun 28 13:35 create
--w-------    1 root     root            0 Jun 28 13:35 disable
-rw-r--r--    1 root     root            0 Jun 28 13:35 enforce
-rw-------    1 root     root            0 Jun 28 13:35 load
-r--r--r--    1 root     root            0 Jun 28 13:35 mls
-r--r--r--    1 root     root            0 Jun 28 13:35 policyvers
-rw-rw-rw-    1 root     root            0 Jun 28 13:35 relabel
-rw-rw-rw-    1 root     root            0 Jun 28 13:35 user

/M

--=20
-----------------------------------------------------------------------
Magnus Therning                 Philips Research Laboratories Eindhoven
Phone: +31 40 2745179           (OpenPGP: 0x4FBB2C40)

Advice is what we ask for when we already know the answer but wish we
didn't.
     -- Erica Jong

--rmUrFcWP4LYae1gV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4nnvYcKlB0+7LEARAuzsAJ48aROJCWLzfalIQL3fqWmbSTMd3gCeKmwR
1SNXPqmi6CXAkzp8vEWIOmc=
=YkNR
-----END PGP SIGNATURE-----

--rmUrFcWP4LYae1gV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
