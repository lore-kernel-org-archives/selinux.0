Subject: Re: [RFC][PATCH] libselinux: Namespacing
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178887672.3504.159.camel@moss-spartans.epoch.ncsc.mil>
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1178835154.12294.151.camel@code.and.org>
	 <1178887321.3504.152.camel@moss-spartans.epoch.ncsc.mil>
	 <1178887672.3504.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4zBoC7ZjUjWtjzuipRVk"
Date: Fri, 11 May 2007 10:39:34 -0400
Message-Id: <1178894374.12294.164.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4zBoC7ZjUjWtjzuipRVk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-11 at 08:47 -0400, Stephen Smalley wrote:
> On Fri, 2007-05-11 at 08:42 -0400, Stephen Smalley wrote:

> >  /* Free the memory allocated for a context by any of the below get* ca=
lls. */
> > -	extern void freecon(security_context_t con);
> > +	extern void selinux_freecon(security_context_t con);
> > +#if SELINUX_COMPAT_API
> > +#define freecon(c) selinux_freecon(c)
> > +#else
> > +#error "freecon replaced by selinux_freecon; please update callers."
> > +#endif
>=20
> Oops, that won't work.  Any way to embed an #error within a #define, so
> that we can trigger the #error only upon encountering a freecon(x)?

 Right, I was confused what you wanted for a minute there :). As for a
message when freecon() is used, there's:

#define freecon(x) char freecon_is_replaced_by_selinux_freecon[-1]

..or:

#define freecon(x) selinux_namespace()

 /* in some C file somewhere */

void selinux_namespace(void)
{
  abort();
}
link_warning (selinux_namespace, "if SELINUX_COMPAT_API isn't defined
the function you are looking for should be prefixed with \"selinux_\".
Please update the callers.")

...where link_warning() is from glibc as:

# define link_warning(symbol, msg) \
  __make_section_unallocated (".gnu.warning." #symbol) \
  static const char __evoke_link_warning_##symbol[]     \
    __attribute__ ((used, section (".gnu.warning." #symbol __sec_comment)))=
 \
    =3D msg;

--=20
James Antill <jantill@redhat.com>

--=-4zBoC7ZjUjWtjzuipRVk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGRIAl11eXTEMrxtQRAromAJ9d5Zrq3Kjo91okJLwYhfaA0DbVjgCcC9ni
VooamKSrOXyf12BBdKtIYAY=
=t/1J
-----END PGP SIGNATURE-----

--=-4zBoC7ZjUjWtjzuipRVk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
