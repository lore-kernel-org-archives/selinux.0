Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AC43rT026655
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:04:06 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AC3sP2019177
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:03:54 -0400 (EDT)
Received: from smtpscan-eur4.philips.com (smtpscan-eur4.mail.philips.com [130.144.57.167])
	by gw-eur4.philips.com (Postfix) with ESMTP id C26AD49906
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:03:49 +0000 (UTC)
Received: from smtpscan-eur4.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 7ED50A6
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:03:49 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur4.philips.com (Postfix) with ESMTP id 42C04F8
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:03:49 +0000 (GMT)
Received: from prle4.natlab.research.philips.com (prle4.natlab.research.philips.com [130.145.137.96])
	by smtprelay-eur1.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id MAA28252
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:03:49 GMT
Received: from smtpmon (smtpmon [130.145.137.150])
	by prle4.natlab.research.philips.com (8.11.6/8.11.6) with ESMTP id i5AC3mW17320
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:03:49 +0200
Received: from therning by pc67148596.ddns.htc.nl.philips.com with local (Exim 4.34)
	id 1BYOHY-0003Bb-6Q
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 14:03:44 +0200
Date: Thu, 10 Jun 2004 14:03:44 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040610120344.GM5477@philips.com>
References: <20040609144404.GJ5477@philips.com> <200406101817.28861.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
In-Reply-To: <200406101817.28861.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I forgot to mention the contents of my /etc/apt/sources.list:

 deb http://ftp.uk.debian.org/debian/ testing main non-free contrib
 deb http://ftp.uk.debian.org/debian-non-US testing/non-US main contrib non=
-free

 deb http://ftp.uk.debian.org/debian/ unstable main non-free contrib
 deb http://ftp.uk.debian.org/debian-non-US sid/non-US main contrib non-free

 deb http://www.coker.com.au/newselinux/ ./

This together with the following line in /etc/apt/apt.conf should give
me a Sid system:

 APT::Default-Release "unstable";

I did a 'apt-get update' and a 'apt-get dist-upgrade' after this.

On Thu, Jun 10, 2004 at 06:17:28PM +1000, Russell Coker wrote:
>On Thu, 10 Jun 2004 00:44, Magnus Therning <magnus-work@therning.org> wrot=
e:
>> Installing selinux-default-policy failed, make complains about
>> 'chsid' not being present. These are the problems I run into when
>> trying to complete the installation of the policies:
>
>Sounds like you have old SE Linux, that is ancient and no longer being
>supported.  It is only supported to kernel 2.4.21 upstream and 2.4.22
>on my web site (in the section that is no longer maintained).  I
>strongly recommend the new SE Linux.

The selinux-default-policy came from the apt-repository mentioned above.

My initial attempt to get things working was a few weeks ago, and then I
had even more problems, that time with the Makefile not being able to
handle the output from 'checkpolicy' (a cut -f 1 -d ' ' was needed).
This was apparently fixed.

>>  3. 'make relabel' fails on a standard kernel:
>>
>>       load_policy: security_load_policy failed
>>
>>     After rebooting using my SE-kernel 'make relabel' also fails:
>>
>>       security:  policydb magic number 0x8 does not match expected magic
>> number 0xf97cff8c load_policy: security_load_policy failed
>
>Sounds like you have new SE Linux in the kernel and old SE Linux in the
>utilities.  Don't use the packages in woody.  Start with Brian's
>back-ports if you want to use SE Linux in woody, but they haven't been
>maintained for a while either.  It's best to use Debian/unstable (the
>next version of Debian will be out soon so there seems little point in
>starting with the old version now).

Again all packages come from your repository.

I'll take a look at it again later today, to see if there has been any
new packages uploaded since my last attempt.

/M

--=20
-----------------------------------------------------------------------
Magnus Therning                 Philips Research Laboratories Eindhoven
Phone: +31 40 2745179           (OpenPGP: 0x4FBB2C40)

Certum est, quia impossibile. (It is certain, because it is impossible.)
     -- Tertullianus

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyE4gYcKlB0+7LEARArPcAJ41VCFK+HKo2NZgBt12PqGRN9pvdgCgqs8H
WSlPZICjKn6flCte6ieqyD4=
=CbA6
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
