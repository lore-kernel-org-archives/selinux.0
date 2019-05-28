Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A81EC04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 16:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4CA2166E
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku3Z+I1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE1QcM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 12:32:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36735 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1QcM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 12:32:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so32671276edx.3
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2yIXNKDcGQYu/OCuvYRwtPbU+lXpvpOrAectwwYFMM=;
        b=ku3Z+I1DgwAy9gPAT/1ZdkxAFjjBLrfFpKeuuW/ozylkOsvsjgMSPjJNLvpS5IaiV/
         OHtheDlgoI6YOg24KHIhuMdhVFmMPM0CtfXUhT/p8b+a6mNzLl1Inv+GbOYOFCqUO0aF
         mBLkQooZgEWUMEFWixhjVJ9u5a5/Q6G1Z10QSK/k6OA5xUquN0u8QKGzSgrlCgeZYLTf
         /TE7tCiURLQR3YnyN/RfOFRzlfptUowNqysQsezivYZhYbHY8KO62f56efuIdk5TmDcC
         AzDn75y/5J8selKD+gX9Emg93xoWbXD/b3Uee4fPfTkA92GcReYkfg2BTZrR5EtlKZPv
         Ve1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=A2yIXNKDcGQYu/OCuvYRwtPbU+lXpvpOrAectwwYFMM=;
        b=McczPAPkdRm2Cwo3mH1vylenl09HzE0NyyFsCaqvjpxyk+IvRQgYJGB9SOAVS+VaK1
         +XVzUQE0RTXZYnnvcAvapA22Z0tA6JYQ4OWORK24ix5PlzA90RjUhXNl3cnxM76AcOs1
         yDuZuSrTYIhmHBHomdE/IdYsI9fPthA782hjcKcAUe6sGe5Ip1HjtudsxkXa9xi3/MJ3
         YnNhKbddO3SFoq3KG3rk125+WzCI2EYS/EJWyc7/vYZz42sdq3qnUbdR9dS3RVn+H1Bx
         eC3QfZC6HikkInYOHCqmHXBqTsigmf9HMz35cMHOE3mhZUbJZoSzGbmPQrmd1MO6HAkN
         6BWQ==
X-Gm-Message-State: APjAAAXHYhkAxP9OeLuTG3iUWkVVtv5uEbig3/RnIgSQRmujiEXjKH2f
        h01xLPXkfDe4PX+0qUIrZ0hiwhHb
X-Google-Smtp-Source: APXvYqzZ+SAl8fWGFocA+9HUrTHQBI9ii/o2yhrZzg0Ui1pprmLBhT7+I+Oi7syGp77hH3/Em8Rb4Q==
X-Received: by 2002:a17:906:59c5:: with SMTP id m5mr67238024ejs.27.1559061130276;
        Tue, 28 May 2019 09:32:10 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id p9sm532400edx.15.2019.05.28.09.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 09:32:08 -0700 (PDT)
Date:   Tue, 28 May 2019 18:32:07 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH userspace v2 4/7] secilc: add flag to enable policy
 optimization
Message-ID: <20190528163207.GA12099@brutus.lan>
Mail-Followup-To: Ondrej Mosnacek <omosnace@redhat.com>,
        selinux@vger.kernel.org
References: <20190528145912.13827-1-omosnace@redhat.com>
 <20190528145912.13827-5-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20190528145912.13827-5-omosnace@redhat.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 04:59:09PM +0200, Ondrej Mosnacek wrote:
> Add a command-line option -O/--optimize to optimize the final policydb
> using sepol_policydb_optimize() before writing it out.
>=20
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  secilc/secilc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index ad6862ba..26996ef9 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -68,6 +68,7 @@ static __attribute__((__noreturn__)) void usage(const c=
har *prog)
>  	printf("  -G, --expand-generated         Expand and remove auto-generat=
ed attributes\n");
>  	printf("  -X, --expand-size <SIZE>       Expand type attributes with fe=
wer than <SIZE>\n");
>  	printf("                                 members.\n");
> +	printf("  -n, --no-optimize              do not optimize final policy\n=
");

I think something may have gone wrong here.

>  	printf("  -v, --verbose                  increment verbosity level\n");
>  	printf("  -h, --help                     display usage information\n");
>  	exit(1);
> @@ -97,6 +98,7 @@ int main(int argc, char *argv[])
>  	int policyvers =3D POLICYDB_VERSION_MAX;
>  	int attrs_expand_generated =3D 0;
>  	int attrs_expand_size =3D -1;
> +	int optimize_policy =3D 1;
>  	int opt_char;
>  	int opt_index =3D 0;
>  	char *fc_buf =3D NULL;
> @@ -117,12 +119,13 @@ int main(int argc, char *argv[])
>  		{"filecontexts", required_argument, 0, 'f'},
>  		{"expand-generated", no_argument, 0, 'G'},
>  		{"expand-size", required_argument, 0, 'X'},
> +		{"no-optimize", no_argument, 0, 'n'},
>  		{0, 0, 0, 0}
>  	};
>  	int i;
> =20
>  	while (1) {
> -		opt_char =3D getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:", long_opt=
s, &opt_index);
> +		opt_char =3D getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:n", long_op=
ts, &opt_index);
>  		if (opt_char =3D=3D -1) {
>  			break;
>  		}
> @@ -211,6 +214,9 @@ int main(int argc, char *argv[])
>  				}
>  				break;
>  			}
> +			case 'n':
> +				optimize_policy =3D 0;
> +				break;
>  			case 'h':
>  				usage(argv[0]);
>  			case '?':
> @@ -294,6 +300,14 @@ int main(int argc, char *argv[])
>  		goto exit;
>  	}
> =20
> +	if (optimize_policy) {
> +		rc =3D sepol_policydb_optimize(pdb);
> +		if (rc !=3D SEPOL_OK) {
> +			fprintf(stderr, "Failed to optimize policydb\n");
> +			goto exit;
> +		}
> +	}
> +
>  	if (output =3D=3D NULL) {
>  		int size =3D snprintf(NULL, 0, "policy.%d", policyvers);
>  		output =3D malloc((size + 1) * sizeof(char));
> --=20
> 2.20.1
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlztYoIACgkQJXSOVTf5
R2mprgv/RpNKkZiPjJlv9bWmr95kLzikDTbYz3MVRCoHASBYuJVndtOeb5Qf7pvI
PD0MwIq5ZJMrXT/zWJh7aoKZgfmh5c+E4TJMKnGtjEbEpCCo3XHAGrIZxPlKUK28
8sWVq3TY/DVl2fNcTOK0Ve7WuPmwg2wmM7lAmgampXB0lKOFZ3r+hvm0thF/DPHV
jhWiMcG0oExNnOjjc/br4piJtPe+e+n+teNfQ/R0GahCRsuSafdAHPoHEycQcGBI
yubUDTjQ9o/L2xTDDH9xYectbdcRWsU6Kqjxkss9KTGIFAA9O7qYGQUrMP1gA4sK
a90AStsVrG4pUU1/gePC7EB8+s21V6m/+UhF3rZfVQQcaRMGRUGQwSdRhH+HFvYR
KJfZJrknUoK2tqL+JJySXwbo50SSQV/D9w1NarWIN+LlsLLeYGUvfuvzJaUe8Mwv
TrXBpCwzrnnOsbMGUniFeOh9jT/4kwtiGgQYoqtNvDswB0/NfjO41dp9YvVMl207
TF271Jd5
=of6Z
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
