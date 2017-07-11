Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6BK5kF4013325
 for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2017 16:05:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so326657lff.2
 for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2017 13:05:40 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w41sm95619edd.43.2017.07.11.13.05.37
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Jul 2017 13:05:37 -0700 (PDT)
Date: Tue, 11 Jul 2017 22:05:36 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
Message-ID: <20170711200536.GA31651@julius.enp8s0.d30>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <1499802772.22660.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <1499802772.22660.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 03:52:52PM -0400, Stephen Smalley wrote:
> On Mon, 2017-07-10 at 16:25 -0400, Stephen Smalley wrote:
> > As systemd ramps up enabling NoNewPrivileges (either explicitly in
> > service unit files or as a side effect of other security-related
> > settings in service unit files), we're increasingly running afoul of
> > its interactions with SELinux.
> >=20
> > The end result is bad for the security of both SELinux-disabled and
> > SELinux-enabled systems.=A0=A0Packagers have to turn off these
> > options in the unit files to preserve SELinux domain
> > transitions.=A0=A0For
> > users who choose to disable SELinux, this means that they miss out on
> > at least having the systemd-supported protections.=A0=A0For users who
> > keep
> > SELinux enabled, they may still be missing out on some protections
> > because it isn't necessarily guaranteed that the SELinux policy for
> > that service provides the same protections in all cases.
> >=20
> > Our options seem to be:
> >=20
> > 1) Just keep on the way we are now, i.e. packagers have to remove
> > default protection settings from upstream package unit files in order
> > to have them work with SELinux (and not just NoNewPrivileges=3D
> > itself; increasingly systemd is enabling NNP as a side effect of
> > other
> > unit file options, even seemingly unrelated ones like
> > PrivateDevices).
> > SELinux-disabled users lose entirely, SELinux-enabled users may lose
> > (depending on whether SELinux policy provides equivalent or
> > better guarantees).
> >=20
> > 2) Change systemd to automatically disable NNP on SELinux-enabled
> > systems.=A0=A0Unit files can be left unmodified from upstream.=A0=A0SEL=
inux-
> > disabled users win.=A0=A0SELinux-enabled users may lose.
> >=20
> > 3) Try to use typebounds, since we allow bounded transitions under
> > NNP.
> > Unit files can be left unmodified from upstream. SELinux-disabled
> > users
> > win.=A0=A0SELinux-enabled users get to benefit from systemd-provided
> > protections.=A0=A0However, this option is impractical to implement in
> > policy
> > currently, since typebounds requires us to ensure that each domain is
> > allowed everything all of its descendant domains are allowed, and
> > this
> > has to be repeated for the entire chain of domain transitions.=A0=A0The=
re
> > is
> > no way to clone all allow rules from children to the parent in policy
> > currently, and it is doubtful that doing so would be desirable even
> > if
> > it were practical, as it requires leaking permissions to objects and
> > operations into parent domains that could weaken their own security
> > in
> > order to allow them to the children (e.g. if a child requires execmem
> > permission, then so does the parent; if a child requires read to a
> > symbolic
> > link or temporary file that it can write, then so does the parent,
> > ...).
> >=20
> > 4) Decouple NNP from SELinux transitions, so that we don't have to
> > make a choice between them. Introduce a new policy capability that
> > causes the ability to transition under NNP to be based on a new
> > permission
> > check between the old and new contexts rather than
> > typebounds.=A0=A0Domain
> > transitions can then be allowed in policy without requiring the
> > parent
> > to be a strict superset of all of its children.=A0=A0The rationale for
> > this
> > divergence from NNP behavior for capabilities is that SELinux
> > permissions
> > are substantially broader than just capabilities (they express a full
> > access matrix, not just privileges) and can only be used to further
> > restrict capabilities, not grant them beyond what is already
> > permitted.
> > Unit files can be left unmodified from upstream.=A0=A0SELinux-disabled
> > users
> > win.=A0=A0SELinux-enabled users can benefit from systemd-provided
> > protections
> > and policy won't need to radically change.
> >=20
> > This change takes the last approach above, as it seems to be the
> > best option.
> >=20
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> > =A0security/selinux/hooks.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 41 +++=
+++++++++++++++++++++---
> > ----------
> > =A0security/selinux/include/classmap.h |=A0=A02 +-
> > =A0security/selinux/include/security.h |=A0=A02 ++
> > =A0security/selinux/ss/services.c=A0=A0=A0=A0=A0=A0|=A0=A07 ++++++-
> > =A04 files changed, 36 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3a06afb..f0c11c2 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2326,24 +2326,37 @@ static int check_nnp_nosuid(const struct
> > linux_binprm *bprm,
> > =A0		return 0; /* No change in credentials */
> > =A0
> > =A0	/*
> > -	=A0* The only transitions we permit under NNP or nosuid
> > -	=A0* are transitions to bounded SIDs, i.e. SIDs that are
> > -	=A0* guaranteed to only be allowed a subset of the permissions
> > -	=A0* of the current SID.
> > +	=A0* If the policy enables the nnp_transition policy
> > capability,
> > +	=A0* then we permit transitions under NNP or nosuid if the
> > +	=A0* policy explicitly allows nnp_transition permission
> > between
> > +	=A0* the old and new contexts.
> > =A0	=A0*/
> > -	rc =3D security_bounded_transition(old_tsec->sid, new_tsec-
> > >sid);
> > -	if (rc) {
> > +	if (selinux_policycap_nnptransition) {
> > +		rc =3D avc_has_perm(old_tsec->sid, new_tsec->sid,
> > +				=A0=A0SECCLASS_PROCESS,
> > +				=A0=A0PROCESS__NNP_TRANSITION, NULL);
> > +		if (!rc)
> > +			return 0;
> > +	} else {
> > =A0		/*
> > -		=A0* On failure, preserve the errno values for NNP vs
> > nosuid.
> > -		=A0* NNP:=A0=A0Operation not permitted for caller.
> > -		=A0* nosuid:=A0=A0Permission denied to file.
> > +		=A0* Otherwise, the only transitions we permit under
> > NNP or nosuid
> > +		=A0* are transitions to bounded SIDs, i.e. SIDs that
> > are
> > +		=A0* guaranteed to only be allowed a subset of the
> > permissions
> > +		=A0* of the current SID.
> > =A0		=A0*/
> > -		if (nnp)
> > -			return -EPERM;
> > -		else
> > -			return -EACCES;
> > +		rc =3D security_bounded_transition(old_tsec->sid,
> > new_tsec->sid);
> > +		if (!rc)
> > +			return 0;
>=20
> NB: As currently written, this logic means that if you enable the new
> policy capability, the only way to allow a transition under NNP is by
> allowing nnp_transition permission between the old and new domains. The
> alternative would be to fall back to checking for a bounded SID if
> nnp_transition permission is not allowed. The former approach has the
> advantage of being simpler (only a single check with a single audit
> message), but means that you can't mix usage of bounded SIDs and
> nnp_transition permission as a means of allowing a transitions under
> NNP within the same policy.  The latter approach provides more
> flexibility / compatibility but will end up producing two audit
> messages in the case where the transition is denied by both checks: an
> AVC message for the permission denial and a SELINUX_ERR message for the
> security_bounded_transition failure, which might be confusing to users
> (but probably not; they'll likely just feed the AVC through audit2allow
> and be done with it).  Thoughts?

I think the current implementation is fine if i understand correctly:

1. With the policy capability disabled the behavior doesnt change, so if yo=
u dont want the current behavior (type_bounds) then just to enable the polc=
ap
2. If you enable the policy capability then you decided to leverage nnp_tra=
nsition instead of the current behavior

Theres plenty flexibility with this approach i would argue

>=20
> > =A0	}
> > -	return 0;
> > +
> > +	/*
> > +	=A0* On failure, preserve the errno values for NNP vs nosuid.
> > +	=A0* NNP:=A0=A0Operation not permitted for caller.
> > +	=A0* nosuid:=A0=A0Permission denied to file.
> > +	=A0*/
> > +	if (nnp)
> > +		return -EPERM;
> > +	return -EACCES;
> > =A0}
> > =A0
> > =A0static int selinux_bprm_set_creds(struct linux_binprm *bprm)
> > diff --git a/security/selinux/include/classmap.h
> > b/security/selinux/include/classmap.h
> > index b9fe343..7fde56d 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -47,7 +47,7 @@ struct security_class_mapping secclass_map[] =3D {
> > =A0	=A0=A0=A0=A0"getattr", "setexec", "setfscreate", "noatsecure",
> > "siginh",
> > =A0	=A0=A0=A0=A0"setrlimit", "rlimitinh", "dyntransition", "setcurrent",
> > =A0	=A0=A0=A0=A0"execmem", "execstack", "execheap", "setkeycreate",
> > -	=A0=A0=A0=A0"setsockcreate", "getrlimit", NULL } },
> > +	=A0=A0=A0=A0"setsockcreate", "getrlimit", "nnp_transition", NULL }
> > },
> > =A0	{ "system",
> > =A0	=A0=A0{ "ipc_info", "syslog_read", "syslog_mod",
> > =A0	=A0=A0=A0=A0"syslog_console", "module_request", "module_load", NULL
> > } },
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > index e91f08c..88efb1b 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -73,6 +73,7 @@ enum {
> > =A0	POLICYDB_CAPABILITY_EXTSOCKCLASS,
> > =A0	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> > =A0	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> > +	POLICYDB_CAPABILITY_NNPTRANSITION,
> > =A0	__POLICYDB_CAPABILITY_MAX
> > =A0};
> > =A0#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > @@ -84,6 +85,7 @@ extern int selinux_policycap_openperm;
> > =A0extern int selinux_policycap_extsockclass;
> > =A0extern int selinux_policycap_alwaysnetwork;
> > =A0extern int selinux_policycap_cgroupseclabel;
> > +extern int selinux_policycap_nnptransition;
> > =A0
> > =A0/*
> > =A0 * type_datum properties
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c
> > index 2f02fa6..2faf47a 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -76,7 +76,8 @@ char
> > *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] =3D {
> > =A0	"open_perms",
> > =A0	"extended_socket_class",
> > =A0	"always_check_network",
> > -	"cgroup_seclabel"
> > +	"cgroup_seclabel",
> > +	"nnp_transition"
> > =A0};
> > =A0
> > =A0int selinux_policycap_netpeer;
> > @@ -84,6 +85,7 @@ int selinux_policycap_openperm;
> > =A0int selinux_policycap_extsockclass;
> > =A0int selinux_policycap_alwaysnetwork;
> > =A0int selinux_policycap_cgroupseclabel;
> > +int selinux_policycap_nnptransition;
> > =A0
> > =A0static DEFINE_RWLOCK(policy_rwlock);
> > =A0
> > @@ -2009,6 +2011,9 @@ static void security_load_policycaps(void)
> > =A0	selinux_policycap_cgroupseclabel =3D
> > =A0		ebitmap_get_bit(&policydb.policycaps,
> > =A0				POLICYDB_CAPABILITY_CGROUPSECLABEL);
> > +	selinux_policycap_nnptransition =3D
> > +		ebitmap_get_bit(&policydb.policycaps,
> > +				POLICYDB_CAPABILITY_NNPTRANSITION);
> > =A0
> > =A0	for (i =3D 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
> > =A0		pr_info("SELinux:=A0=A0policy capability %s=3D%d\n",

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlllL4wACgkQJXSOVTf5
R2mHSAv/e7pFvfkw+jdvNKIviCmDnxAUCqW6kHoB79+Ogs3257ZJBYuLxYlPMfti
bgsslUgMm+G9OOo+8ZD+c729JxHjyiAVtdynJJ5LPlh6o3m7afX1o3ISp6GFlOjy
mqKe+iMbBia5EWWplDd1bYMghw8l+ns7dJSGNYl2X26lPfTACNKFEYd93tO+xaSF
bE0x5amige580iNMgyTwtav9dpeHKJvazje+LqvwXgyYj0XbiGmTui+3IPH2ai3B
RtwuisR0jwpbsPRg09RSpTCprwYkAZdndt9SORVbx1kT3Rla4fZDrVpqApzD+qCJ
tTEbzxiUIAnvKRvsEvJ7A4nNnj9zLty8CwcQKROionULb6A8UnIyY8aKhGDDQzff
DGs+SvjZxdLFMbkafg6udljNi2eyY5Cv5AW4tqf6gHiPCsDy8Rvpwqh7g+K9NU+M
LL90vjob7F/D1ocDebofESrbbXkRH9dmk/u2PrTsBDncETGKVvTnX8B9BjE9vI7O
FqUY8cTa
=o8A2
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
