Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAIJKGM9028314
 for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2014 14:20:16 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so7269408wgh.16
 for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2014 11:20:14 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id fa7sm57002034wjd.27.2014.11.18.11.20.13
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 18 Nov 2014 11:20:13 -0800 (PST)
Date: Tue, 18 Nov 2014 20:20:11 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC] systemd the userspace object manager
Message-ID: <20141118192010.GA32498@e145.network2>
References: <546B760D.8070407@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <546B760D.8070407@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> class init_service
> {
>     start
>     stop
>     status
> }
>=20

I cannot really substantiate but it look like these are also used to start/=
stop/get status of systemd (session) daemons, so i suppose start_init, stop=
_init, get_status_init

I suspect this is mainly for starting the systemd session daemons. Logind u=
ses these i believe.

so to start a systemd session daemon: allow ARG init_t:init start_init;  or=
 something maybe?

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUa5vlAAoJENAR6kfG5xmcQdEMAMrIi855H4hJ8QscORDXvnMX
zibcK6WcjivNh8WSog8skdiTUHELrqZ+aQAcdH9tAYu2jHQnX2cd9XEj2ONcYbH9
wlTQIIzOVDR674kDZT+ej2z7SnenuZiwDcQ2JT9PLAaZbNRdDWk2SjDwJFqvlVL8
GTaMiBq6gn1P0PujtyM4WwX6Dgjia6ZvgVxxkNz0oYcDhVsIOH8heYT21UF7bIvp
Jjh5jv1nZz06wXLsbJD8Gkaf260U3phYNMts9lZNrqs24MvYQmHFAYQJV80eE7nV
TWCD1OYwCdDMIOtkfyIaLNhWEgTkSv2Smetz53n2QV5ScCrJ0O/zX6sLUCafbBeq
zC9FQgoLfgGgqBDSjTz6+tzZA/JtY490Eslh2fNvEzMxwXSxwq8O06SpzVOPdQ3Y
iNnE/w5Tgr6USORG+EAU4bnK5oFE1He+ThhwBhdHlkPVLmEGgBwu+oJjhsiCCAa7
t4pixI98FKOrNHj5Efe0MF35Zb07nw2uSIGBcdWmpQ==
=5XCv
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
