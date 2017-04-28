Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3SDARmO001247
 for <selinux@tycho.nsa.gov>; Fri, 28 Apr 2017 09:10:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so10865863wmi.2
 for <selinux@tycho.nsa.gov>; Fri, 28 Apr 2017 06:10:25 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w45sm2937550edd.41.2017.04.28.06.10.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Apr 2017 06:10:23 -0700 (PDT)
Date: Fri, 28 Apr 2017 15:10:21 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH V2] libselinux: Add permissive= entry to avc audit log
Message-ID: <20170428131021.GA13764@julius>
References: <20170428130516.4021-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <20170428130516.4021-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 02:05:16PM +0100, Richard Haines wrote:
> Add audit log entry to specify whether the decision was made in
> permissive mode/permissive domain or enforcing mode.
>=20
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 changes: Remove utilities and follow the kernel way of detecting
> whether permissive or not.
>=20
>  libselinux/src/avc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index b1ec57f..96b2678 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -723,6 +723,10 @@ void avc_audit(security_id_t ssid, security_id_t tsi=
d,
> =20
>  	log_append(avc_audit_buf, " ");
>  	avc_dump_query(ssid, tsid, tclass);
> +
> +	if (denied)
> +		log_append(avc_audit_buf, " permissive=3D%u", result ? 0 : 1);
> +
>  	log_append(avc_audit_buf, "\n");
>  	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> =20
> --=20
> 2.9.3
>=20

I hope you will still submit the utils as well. I think/hope that the selin=
ux_check_access util can be used with shell scripts to create a simple user=
 space object manager example

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkDPzkACgkQJXSOVTf5
R2mDDQv8CVZUYp4wB71NmU0zFqba69LaVUBzzkpzsP1k0GooACoVXZK5M+8JcWYA
OpoGGlc476r3FsnKVnAXfkibs0BsEaOU3FyGUZGv4qV/RPoMdlvrN6s+6l9G0YZ7
h1xDtz467EBwNIeXsMkMWYcFmJiMI7aIRMIXcQb55f6q3QWVwG20mSZUzjHRbanb
cjxP1RjEao00K329md7dLCa8y149tA+I+4i4uAosF+PIHgapi4cZVS2J1rCxxtAj
yYaGgOyQjLkt5X550nQDxFgO5niGR/eB/TyNTpKTkr5rZAco6V//0A+Vz8oLWP6r
Kx9bD/NZo+N3j46nrrywp/3NMZK1FB3LqyEgPCVkMlAQxBcpugkmh/1mZvZ+QRJH
ZpvP6viGABYXEz/2Xo4aH1hZ4IQQW4RwaW5lFGX4n2LbugY+XqAbA0Sd8S6wmDmW
eelfJStVDI21AaHYcDItpfF9NYWfu/h/BP1BUpcvQScz0Ocr8GAvYvaiDOzOywve
9l7D3J+C
=ykBu
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
