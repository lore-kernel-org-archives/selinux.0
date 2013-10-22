Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MEH8FU025873
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 10:17:08 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so4516855eek.27
        for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 07:16:40 -0700 (PDT)
Date: Tue, 22 Oct 2013 10:16:32 -0400
From: Joe MacDonald <joe@deserted.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] libselinux: support building on older PCRE libs
Message-ID: <20131022141631.GB3728@deserted.net>
References: <1382383000-16439-1-git-send-email-joe@deserted.net>
 <1382383000-16439-2-git-send-email-joe@deserted.net>
 <52658E3D.3010701@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
In-Reply-To: <52658E3D.3010701@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re: [PATCH 1/2] libselinux: support building on older PCRE libs] On 13.10.=
21 (Mon 16:27) Stephen Smalley wrote:

> On 10/21/2013 03:16 PM, Joe MacDonald wrote:
> > Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
> > absence, use pcre_free() instead.
> >=20
> > Signed-off-by: Joe MacDonald <joe@deserted.net>
> > ---
> >  libselinux/src/label_file.c           |    4 ++++
> >  libselinux/utils/sefcontext_compile.c |    4 ++++
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 9b0d6b0..51520cf 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -561,7 +561,11 @@ static void closef(struct selabel_handle *rec)
> >  		free(spec->type_str);
> >  		if (spec->regcomp) {
> >  			pcre_free(spec->regex);
> > +#if (PCRE_MAJOR >=3D 8 && PCRE_MINOR >=3D 20)
> >  			pcre_free_study(spec->sd);
> > +#else
> > +			pcre_free(spec->sd);
>=20
> We try to avoid #if / #ifdef scattered throughout the code.
> The preferred approach is to conditionally define pcre_free_study() to
> pcre_free() if building with the older libpcre.

Sure thing.  I'll resubmit.  Given that this is present in only two
files with the only obvious common #include (within the selinux repo
itself) being label_file.h, I'll put the #define there.  Does that seem
reasonable?

-J.

>=20
>=20
> > +#endif
> >  		}
> >  	}
> > =20
> > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/s=
efcontext_compile.c
> > index 6f79dd6..b34966b 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -301,7 +301,11 @@ static int free_specs(struct saved_data *data)
> >  		free(specs[i].lr.ctx_trans);
> >  		free(specs[i].regex_str);
> >  		pcre_free(specs[i].regex);
> > +#if (PCRE_MAJOR >=3D 8 && PCRE_MINOR >=3D 20)
> >  		pcre_free_study(specs[i].sd);
> > +#else
> > +		pcre_free(specs[i].sd);
> > +#endif
> >  	}
> >  	free(specs);
> > =20
> >=20
>=20

--=20
-Joe MacDonald.
:wq

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJmiL8ACgkQwFvcllog0Xy4tACguDNYTQcfm9WdoRXqgmha19vR
pMkAnRY3KSB1Of0Qy/oPhE5GuJ1A1D6H
=dq5s
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
