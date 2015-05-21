Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LGs0M9025468
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 12:54:00 -0400
Received: by wghq2 with SMTP id q2so91802880wgh.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 09:53:26 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id ck16sm24998873wjb.37.2015.05.21.09.53.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2015 09:53:25 -0700 (PDT)
Date: Thu, 21 May 2015 18:53:23 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add selinux_openssh_contexts_path()
Message-ID: <20150521165322.GD683@x131e>
References: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
 <20150521162441.GB683@x131e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
In-Reply-To: <20150521162441.GB683@x131e>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 06:24:41PM +0200, Dominick Grift wrote:
> On Thu, May 21, 2015 at 06:14:22PM +0200, Petr Lautrbach wrote:
> > openssh in Fedora uses "sshd_net_t" type for privilege separated
> > processes in the preauthentication phase. Similarly, openssh portable u=
ses
> > "sftp_t" for internal-sftp processes. Both type are hardcoded what is n=
ot ideal.
> > Therefore selinux_openssh_contexts_path() was created to get a path whe=
re sshd
> > can get a correct types prepared by a distribution or an administrator.
>=20
> I requested this feature and i am using this feature in my personal polic=
y. So hereby my ACK for what it is worth.
>=20
> However:
>=20
> That SYSTEMD_CONTEXTS though, that must have been a mistake?

As far as i am concerned this commit should be reverted:

https://github.com/SELinuxProject/selinux/commit/ce2a8848ad45e375cfdb58cebe=
28bc12431bb3db

I just did a grep -ri systemd_contexts in the systemd repository and nothin=
g returned. I also cannot place that commit message.

>=20
> I do not believe that this is used or that it is needed/wanted.
>=20
> >=20
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  libselinux/include/selinux/selinux.h |  1 +
> >  libselinux/src/file_path_suffixes.h  |  1 +
> >  libselinux/src/selinux_config.c      | 12 ++++++++++--
> >  libselinux/src/selinux_internal.h    |  1 +
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index d0eb5c6..4beb170 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -543,6 +543,7 @@ extern const char *selinux_virtual_image_context_pa=
th(void);
> >  extern const char *selinux_lxc_contexts_path(void);
> >  extern const char *selinux_x_context_path(void);
> >  extern const char *selinux_sepgsql_context_path(void);
> > +extern const char *selinux_openssh_contexts_path(void);
> >  extern const char *selinux_systemd_contexts_path(void);
> >  extern const char *selinux_contexts_path(void);
> >  extern const char *selinux_securetty_types_path(void);
> > diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_=
path_suffixes.h
> > index 3c92424..d1f9b48 100644
> > --- a/libselinux/src/file_path_suffixes.h
> > +++ b/libselinux/src/file_path_suffixes.h
> > @@ -23,6 +23,7 @@ S_(BINPOLICY, "/policy/policy")
> >      S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
> >      S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
> >      S_(LXC_CONTEXTS, "/contexts/lxc_contexts")
> > +    S_(OPENSSH_CONTEXTS, "/contexts/openssh_contexts")
> >      S_(SYSTEMD_CONTEXTS, "/contexts/systemd_contexts")
> >      S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
> >      S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dis=
t")
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index 0a80141..bec5f3b 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -48,8 +48,9 @@
> >  #define FILE_CONTEXT_SUBS_DIST 25
> >  #define LXC_CONTEXTS      26
> >  #define BOOLEAN_SUBS      27
> > -#define SYSTEMD_CONTEXTS  28
> > -#define NEL               29
> > +#define OPENSSH_CONTEXTS  28
> > +#define SYSTEMD_CONTEXTS  29
> > +#define NEL               30
> > =20
> >  /* Part of one-time lazy init */
> >  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
> > @@ -491,6 +492,13 @@ const char *selinux_lxc_contexts_path(void)
> > =20
> >  hidden_def(selinux_lxc_contexts_path)
> > =20
> > +const char *selinux_openssh_contexts_path(void)
> > +{
> > +    return get_path(OPENSSH_CONTEXTS);
> > +}
> > +
> > +hidden_def(selinux_openssh_contexts_path)
> > +
> >  const char *selinux_systemd_contexts_path(void)
> >  {
> >  	return get_path(SYSTEMD_CONTEXTS);
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 0abf1b4..844e408 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -83,6 +83,7 @@ hidden_proto(selinux_mkload_policy)
> >      hidden_proto(selinux_media_context_path)
> >      hidden_proto(selinux_x_context_path)
> >      hidden_proto(selinux_sepgsql_context_path)
> > +    hidden_proto(selinux_openssh_contexts_path)
> >      hidden_proto(selinux_systemd_contexts_path)
> >      hidden_proto(selinux_path)
> >      hidden_proto(selinux_check_passwd_access)
> > --=20
> > 2.4.1
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
> --=20
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
> Dominick Grift



--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXg1+AAoJENAR6kfG5xmc1FgL/3Vwal/j1Q0xzQmeKw3MTcV/
m0KjSZJTl+03Ki+cyjHJmfboK3X4hrDvp4xX43RRDSQuorh2qxkX7Pj6XR9SjXpi
oqFTAJq1JmmJiRr5eXWxLX32ihmWk83zMNeepS0477oF0OIC3nZ/w/jx9faHpInS
qf5njNNKlN0C+7laB9rlRrklQsKHRBFtGbRZmb5+hpq2c0dhZsJllEbHmsoZPRNM
Ss3p819xjNxqVYwcOcunqa3tfMpSfT43AG+C2RHZX+7vf4ixPntOtQTEMD8uU/CJ
5WlasAEKbHf/8LvszwGW5qrQ3CjRduVwV5Jq89vo9yzKc77OSQifln4M8ktxprbQ
jZaDfyHZ5BQnCPqUiq5zH9HiJR3/IlRoEAGOM6+9eTPvEIZatRV8WscLayFhfn3n
ar5oc0/fvtdn2UhWHMWfm+dFc0H6tnNFcoVghXZaLzW2bDZuMy66ZQuepMbCsE4n
dpwLf6WO/8WrBF2WQUu25vnDehmAwg1UNastXzmXug==
=4ZU5
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
