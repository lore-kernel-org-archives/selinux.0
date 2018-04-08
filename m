Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w38L13Kf026081
 for <selinux@tycho.nsa.gov>; Sun, 8 Apr 2018 17:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE71881A88A0
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 21:00:55 +0000 (UTC)
Received: from [10.40.204.23] (ovpn-204-23.brq.redhat.com [10.40.204.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2065A215CDAF
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 21:00:54 +0000 (UTC)
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
Date: Sun, 8 Apr 2018 23:00:53 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5wz972HwGvncohx6clRnIdFqjnEkiHsZT"
Subject: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5wz972HwGvncohx6clRnIdFqjnEkiHsZT
Content-Type: multipart/mixed; boundary="zSqeG5sRY3Cidt76tmoX26me1VExdTHEs";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
Subject: CIL namespaces and blockinheritfilter keyword.

--zSqeG5sRY3Cidt76tmoX26me1VExdTHEs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi All,

I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESIGN"
wiki page [1] and I'm interested in CIL namespaces. I tried several
examples related to blockinheritence and all works just great!

However, in following example I see keyword "blockinheritfilter":

(block logger
	(blockabstract logger)
	(type process)
	(type log)
	(allow process log (file (getattr append write))))

(block myapp
	(blockinherit logger)
	(blockinheritfilter myapp logger
		(allow process log (file (write)))))


If I understand it correctly, it should "remove" rule:
allow myapp.process log:file write;

So process type in myapp should have allowed:
allow myapp.process log:file {getattr append};

And process type in logger should have allowed:
allow logger.process log:file {getattr append write};

Which could be very cool feature, but I don't see any code in secilc
related to "blockinheritfilter". Are there any plans to implement also
this in CIL namespaces or is there any other way how to handle this
(DELETE statement is also not implemented) ?

Thanks for any help.
Lukas.


[1] https://github.com/SELinuxProject/cil/wiki

--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--zSqeG5sRY3Cidt76tmoX26me1VExdTHEs--

--5wz972HwGvncohx6clRnIdFqjnEkiHsZT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAlrKgwYACgkQRyAaxC8p
zgbQtAf9EISg5oZVmiLQoUqcojxSzP8tHaKpRo7Y0D5B5WfKRnafpCSxR3/dsBs0
RwiPIcAQtI45AxrVIukJfI3Zi4bJ5VQ+/aFQpVH1qlBeUEvg30v8mCB+GYfa4Ly9
DOrbapXnFXyieyvHFC7u3WZ/lAUqUxvA9b3uTP3qQBfxhNxOzacSFB9wWamdYFPb
Ee1WVjPn8HNRSACopmZEHy3iZYjaEO8GoTURpQeysJ7muC56QiFJA+vcZFrZ0NAb
wsTbumSY4VeUrs0ztg5LxFnGwaEE9L0DkKR8KtH/WsC4ybb478v45GExPDHx6LSD
pHeE2MaJOcY8PKJS7oz3FHIqrhrb+A==
=ArUE
-----END PGP SIGNATURE-----

--5wz972HwGvncohx6clRnIdFqjnEkiHsZT--
