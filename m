Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HCqTW1022111
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 08:52:29 -0400
Received: by wibud3 with SMTP id ud3so38597791wib.1
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 05:52:27 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id bq7sm18238669wjc.31.2015.07.17.05.52.27
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jul 2015 05:52:27 -0700 (PDT)
Date: Fri, 17 Jul 2015 14:52:25 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Restricting samba to only talk to one network interface?
Message-ID: <20150717125224.GA27338@x250>
References: <VI1PR03MB1006B3B0EFB3FB97DC18A3AB9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <VI1PR03MB1006B3B0EFB3FB97DC18A3AB9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2015 at 10:46:04AM +0000, Colin Powers wrote:

<snip>

>=20
> Possible ideas:
> * take ownership of the whole policy rather than build on top of the defa=
ult RHEL policy, and customise the samba policy that is delivered?
> * make a copy or symlink of the smbd daemon and apply custom policy to it?
> * somehow relabel the existing smbd executable with a custom type that ca=
n only communicate on eth0_packet_t?
> 	* but what's the best way to "override" the default policy? must I unloa=
d the samba policy module with semodule to allow smbd to be labelled with s=
ome other type?
> * something else?

You could try to disable the existing samba module , and then load your mod=
ified samba module in its place

I theory that should work I believe. In practice you, may or may not end up=
 in dependency hell. Worth a try though.

semodule -d samba


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVqPqEAAoJENAR6kfG5xmcAqIL/Rw+XWP+Z+BEUOhkavPwNUB4
vFbaeHr5/cf2JIEDXfsBfuOy+qYKie5cvMrtGXgbKogVHqzXOjLFOLIPQbIlv2oJ
p+MW1yOUMtGbgWFjSZLktFFg8zqvbbKbdew6NzXuzOAxHe73hlcKa0c+G4uehymm
QpYqLyUEWKPFC4jdyvpJ8MbuqaD/xcwyHdKxEXXjy7pMA48+kI9+f5KdYcs37Sfs
IJwRkGpaP2WajnMpscnHTR6Ap2sDTJjfXnKO+KB0F4wrLxhkyIIINkx/m1/Z2Ayn
SimeLGNQPtMG8hsSWOTYQyHUO/gQ1Q7MxSIDT5mFLY6K/bcx/vaQOft3VHTpjmip
sDeQOSpAFjSTOrvMAI8y8jFpcZ42X6xkkA+bv/LtZgIMJkWaSCVeeT3I3eZqQ2/N
WvfljkJnlKGtIz43+5MGl8Ji7Lbt1Nz3PBHpGunt5QrGLzOrzm48H/UgI45KK/dw
lnh3B9qkT/VMWCj+tYcDoDHmV+A8DoxhSQjkKFEwVA==
=Ra3N
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
