Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5SF5MrT013368
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 11:05:22 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5SF57VC028707
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 15:05:08 GMT
Date: Mon, 28 Jun 2004 17:04:48 +0200
From: Magnus Therning <magnus-work@therning.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid), second try
Message-ID: <20040628150448.GF1688@philips.com>
References: <20040624163900.GB3290@philips.com> <200406251908.56334.russell@coker.com.au> <20040628094230.GB1688@philips.com> <200406282347.41232.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
In-Reply-To: <200406282347.41232.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2004 at 11:47:41PM +1000, Russell Coker wrote:
>On Mon, 28 Jun 2004 19:42, Magnus Therning <magnus-work@therning.org> wrot=
e:
>> Everything goes well until I get to the selinux-policy-default package.
>> The version I get is 1:1.12-3 (from Sid). The installation ends with the
>> following:
>>
>> make: *** /etc/selinux: No such file or directory.  Stop.
>> run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
>> "/bin/run-parts --arg=3Dselinux-policy-default /etc/dpkg/postinst.d" fai=
led:
>> 256 dpkg: error processing selinux-policy-default (--configure):
>>  1Error running trigger postinst: No such file or directory
>> Errors were encountered while processing:
>>  selinux-policy-default
>> E: Sub-process /usr/bin/dpkg returned error code (1)
>>
>>
>> Indeed, there is no directory called /etc/selinux. When should it have
>> been created? (By what package?)
>
>/etc/selinux is supposed to be a sym-link=20
>to /usr/share/selinux/policy/current/ .
>
>Does /usr/share/selinux/policy/current/ exist?

Nope, it doesn't. All I have is /usr/share/selinux/policy/default/

/M

--=20
Magnus Therning  Philips Research  +31-40-2745179
WDC2.52, Prof. Holstlaan 4, 5656AA Eindhoven, The Netherlands
mailto:therning@gforge.natlab.research.philips.com  OpenPGP:0x4FBB2C40
http://pww.innersource.philips.com/magnus/

Never be afraid to try something new. Remember, amateurs built the
ark; professionals built the Titanic.
     -- Anonymous

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4DOQYcKlB0+7LEARAuq+AKC69Pkul4Ma57aBiHsZ4QUZHw6axACfR9wx
lnbaqlTvaAc0MNB/ySUxULw=
=A6Ba
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
