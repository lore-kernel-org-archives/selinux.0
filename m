Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5T8xarT017959
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 04:59:36 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5T8xK6c025554
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 08:59:21 GMT
Date: Tue, 29 Jun 2004 10:59:28 +0200
From: Magnus Therning <magnus-work@therning.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid), second try
Message-ID: <20040629085928.GH1688@philips.com>
References: <20040624163900.GB3290@philips.com> <200406282347.41232.russell@coker.com.au> <20040628150448.GF1688@philips.com> <200406291533.10068.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
In-Reply-To: <200406291533.10068.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2004 at 03:33:09PM +1000, Russell Coker wrote:
>On Tue, 29 Jun 2004 01:04, Magnus Therning <magnus-work@therning.org> wrot=
e:
>> >/etc/selinux is supposed to be a sym-link
>> >to /usr/share/selinux/policy/current/ .
>> >
>> >Does /usr/share/selinux/policy/current/ exist?
>>
>> Nope, it doesn't. All I have is /usr/share/selinux/policy/default/
>
>Change line 12 of /etc/dpkg/postinst.d/selinux to be the following and
>things should work.  I'll upload a new version of
>selinux-policy-default to fix this shortly.
>if grep -q selinuxfs /proc/mounts && test -e /etc/selinux ; then

That got me a bit further. I get asked a slew of questions about domains
:-) After answering them to the best of my ability (this is to be a test
setup only, so I answer yes to a lot of stuff) I get stuck at the
following:

Installing the new SE Linux policy
mount: none already mounted or /selinux busy
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 32
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned error code (1)

/M

--=20
Magnus Therning  Philips Research  +31-40-2745179
WDC2.52, Prof. Holstlaan 4, 5656AA Eindhoven, The Netherlands
mailto:therning@gforge.natlab.research.philips.com  OpenPGP:0x4FBB2C40
http://pww.innersource.philips.com/magnus/

Finagle's Fourth Law:
Once a job is fouled up, anything done to improve it only makes it
worse.

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4S9wYcKlB0+7LEARAqnIAJ9O0VrCVF/uHbd6fkYqfrKdBkFulgCfUfUA
fUCGBUlILNYv/W2sfYd5tfo=
=S7Uv
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
