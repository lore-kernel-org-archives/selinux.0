Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t69A4ucJ023480
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 06:04:56 -0400
Received: by wgjx7 with SMTP id x7so218748115wgj.2
 for <selinux@tycho.nsa.gov>; Thu, 09 Jul 2015 03:04:54 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id dt1sm7423553wib.7.2015.07.09.03.04.53
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jul 2015 03:04:53 -0700 (PDT)
Date: Thu, 9 Jul 2015 12:04:51 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix typo in semanage args for minimum policy store
Message-ID: <20150709100450.GA20638@x250>
References: <1436429776-32450-1-git-send-email-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <1436429776-32450-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 10:16:16AM +0200, Petr Lautrbach wrote:
> ---
>  policycoreutils/semanage/semanage | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage=
/semanage
> index dd63010..dd1010a 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -788,7 +788,7 @@ def createCommandParser():
> =20
>  def make_io_args(args):
>      # import/export backward compability
> -    args_origin =3D ["-S", "-o", "-i", "targeted", "minumum", "mls"]
> +    args_origin =3D ["-S", "-o", "-i", "targeted", "minimum", "mls"]

Hard coding policy models is not very user friendly. Besides the minimum po=
licy model is fedora specific.

>      args_file =3D []
>      args_ie =3D []
>      args_subcommand =3D []
> --=20
> 2.4.3
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVnkc+AAoJENAR6kfG5xmcj6kL/0eAdX0rcBQHjlo+Gu98gs9W
yJx8/m51uxV31OmhI8dDv1gJMvVpf1GJYVD1g7Y1UiNSE1H2oC1E1jGrEc93v8HZ
mbrJ72AqwZ0d8N4od9STMJtHcv/ppPWSFkob2MZi5RJEPaz0BUO3s5vjRl7Wf+/B
83lAlUHAxA1pb37pzVz5nkkMslkHpfpp1RJwT3oUHoV4w6Cx39Uy2Yoj5PzUtUKV
DpGurXA8SdxzXjtGPk6v6oYi5XppGADYaQ8ng9nDBaro6mkVUigH1/rGtcfdHEPi
3eH1Ja5X93KYt9UosCmyZ8pxjghOGHp9DyJZLe8VcQVv8Igmzg+x26bB7DxEzlum
DLyOUU5jC8mNvLrxU/6utJDqSFnRupVkxzn9v4srr0yNOKlH8PizionewXVSObxJ
QrnETlMiE2+PoZxRSYOasXH4iKkHVv1xXVAe+DprBeMIMI4TxUKOpB3zNvkSPFha
zcHrEdqKUyWG8u21/WaY065nrQZqxzz039/kD7J7+w==
=N4Ms
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
