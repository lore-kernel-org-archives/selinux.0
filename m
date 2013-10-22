Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MEmWZY028165
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 10:48:32 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so4266341eae.38
        for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 07:48:29 -0700 (PDT)
Received: from deserted.net ([128.224.252.2])
        by mx.google.com with ESMTPSA id k7sm57626917eeg.13.2013.10.22.07.48.27
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 07:48:28 -0700 (PDT)
Date: Tue, 22 Oct 2013 10:48:24 -0400
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: support building on older PCRE libs
Message-ID: <20131022144823.GC3728@deserted.net>
References: <1382453199-19064-1-git-send-email-joe@deserted.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
In-Reply-To: <1382453199-19064-1-git-send-email-joe@deserted.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[[PATCH] libselinux: support building on older PCRE libs] On 13.10.22 (Tue =
10:46) Joe MacDonald wrote:

> Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
> absence, use pcre_free() instead.
>=20
> Signed-off-by: Joe MacDonald <joe@deserted.net>
> ---
>=20
> This will hit all uses of pcre_free_study() provided label_file.h gets
> included somewhere along the way.  Also makes it cleaner to back out when
> ancient versions of libpcre fall off the support map and it keeps the code
> from being filled with all-caps.
>=20
>  libselinux/src/label_file.h |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index bf0c9e2..7d48832 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -8,6 +8,11 @@
>  #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
>  #define SELINUX_COMPILED_FCONTEXT_MAX_VERS	1
> =20
> +/* Prior to verison 8.20, libpcre did not have pcre_free_study() */
> +#if (PCRE_MAJOR < 8 || PCRE_MINOR < 20)
> +#define pcre_free_study  pcre_free
> +#endif
> +
>  /* A file security context specification. */
>  struct spec {
>  	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */

Hmm, actually, no.  That's the same logic I had in the previous #if ...
#endif block but it's wrong for cases where PCRE_MAJOR > 8.  Sorry about
that.

--=20
-Joe MacDonald.
:wq

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJmkDcACgkQwFvcllog0Xz3yQCgqwUFe4tmeLkk/1JWvHZ0ERQi
KdUAoKQQLsqKbXE556KsLNvy4fhRxZsU
=6bam
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
