Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5S9gnrT011201
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 05:42:49 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5S9gYVC007192
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:42:35 GMT
Received: from smtpscan-eur6.philips.com (smtpscan-eur6.mail.philips.com [130.144.57.169])
	by gw-eur4.philips.com (Postfix) with ESMTP id 7D70A499B9
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:42:34 +0000 (UTC)
Received: from smtpscan-eur6.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 40A49108
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:42:34 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur6.philips.com (Postfix) with ESMTP id E6FF6C0
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:42:33 +0000 (GMT)
Received: from prle4.natlab.research.philips.com (prle4.natlab.research.philips.com [130.145.137.96])
	by smtprelay-eur1.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id JAA12226
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:42:33 GMT
Received: from smtpmon (smtpmon [130.145.137.150])
	by prle4.natlab.research.philips.com (8.11.6/8.11.6) with ESMTP id i5S9gXL27850
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 11:42:33 +0200
Received: from therning by pc67148596.ddns.htc.nl.philips.com with local (Exim 4.34)
	id 1Besek-0001X9-PV
	for selinux@tycho.nsa.gov; Mon, 28 Jun 2004 11:42:30 +0200
Date: Mon, 28 Jun 2004 11:42:30 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid), second try
Message-ID: <20040628094230.GB1688@philips.com>
References: <20040624163900.GB3290@philips.com> <200406251908.56334.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
In-Reply-To: <200406251908.56334.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2004 at 07:08:56PM +1000, Russell Coker wrote:
>On Fri, 25 Jun 2004 02:39, Magnus Therning <magnus-work@therning.org> wrot=
e:
>> Should they be installed in some specific order (i.e. SELinux packages
>> before the others, or the other way around)?
>>
>> Does it matter when I install the kernel with SELinux support?
>
>Install everything apart from selinux-policy-default and then boot the
>SE Linux kernel.  Then install selinux-policy-default last and reboot.

Everything goes well until I get to the selinux-policy-default package.
The version I get is 1:1.12-3 (from Sid). The installation ends with the
following:

make: *** /etc/selinux: No such file or directory.  Stop.
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
"/bin/run-parts --arg=3Dselinux-policy-default /etc/dpkg/postinst.d" failed=
: 256
dpkg: error processing selinux-policy-default (--configure):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned error code (1)


Indeed, there is no directory called /etc/selinux. When should it have
been created? (By what package?)

I've tried to keep track of all the steps I've taken, and all packages
that have been installed as a result of them, when trying to convert a
Sid system to SELinux. Let me know if you need any more info regarding
versions of packages and so on.

/M

>
>--=20
>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
>http://www.coker.com.au/~russell/  My home page
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov w=
ith
>the words "unsubscribe selinux" without quotes as the message.

--=20
-----------------------------------------------------------------------
Magnus Therning                 Philips Research Laboratories Eindhoven
Phone: +31 40 2745179           (OpenPGP: 0x4FBB2C40)

You can't depend on your judgement when your imagination is out of focus.
     -- Mark Twain

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3+gGYcKlB0+7LEARAi89AJ42uR4COdRsg1D4DWdt4cxgo/FjtQCfYFmb
U9jTf2VE9DuKjbdRwRihBCs=
=ubZH
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
