Date: Thu, 12 Apr 2018 22:03:30 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov, lvrabec@redhat.com
Message-ID: <20180412200329.GA14296@workstation>
References: <20180412102601.32191-1-vmojzis@redhat.com>
 <22b8ccd4-1a6c-0a5a-ecfc-b17853027545@tycho.nsa.gov>
 <ed0c62cb-61ed-2f0f-3984-1ff2bd1325ce@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <ed0c62cb-61ed-2f0f-3984-1ff2bd1325ce@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: do not change file mode of seusers
 and users_extra
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 01:22:40PM -0400, Stephen Smalley wrote:
> On 04/12/2018 11:07 AM, Stephen Smalley wrote:
> > On 04/12/2018 06:26 AM, Vit Mojzis wrote:
> >> Commit 8702a865e08b5660561e194a83e4a363061edc03 causes file mode of
> >> seusers and users_extra to change based on the value defined in config
> >> file whenever direct_commit is called and policy is not rebuilt.
> >> (e.g. when setting a boolean).
> >>
> >> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1512639
> >=20
> > I think this patch is correct and expect to apply it, but am left wonde=
ring about the permissions
> > on /var/lib/selinux/targeted in general.  It appears that we are incons=
istent in our file modes
> > on files under /var/lib/selinux/targeted/active, e.g. file_contexts.hom=
edirs, *.local, and modules/*/* are 0644,
> > whereas other files are 0600.  Of course, given that the directories ar=
e 0600, only root can even lookup files under
> > these directories regardless of their individual file modes so it isn't=
 as though those files are truly accessible.
> > Looks like there are other uses of sh->conf->file_mode that are suspect=
 in semanage_direct_commit() for files
> > in the store, whereas I think it should only be used for installed file=
s (i.e. /etc/selinux/targeted/*).
>=20
> Actually, we seem to be inconsistent even among different modules; some s=
eem to be 0600 and others 0644, likely due
> to some being prebuilt/prepackaged that way and others installed via semo=
dule -i.  Also, policy.kern and policy.linked are presently 0644.
>=20
> On a separate but related note, rpm -V selinux-policy-targeted output see=
ms somewhat surprising, e.g. wouldn't expect file_contexts.local, commit_nu=
m, etc to be managed by rpm itself.  Not sure it should be managing /var/li=
b/selinux at all.

Note that /etc/selinux/targeted/modules/active was part of selinux-policy-t=
argeted since 2011.

file_contexts.local is in /etc/selinux and is shipped with %config(noreplac=
e). It means it's preserved during updates and
`rpm -qf /etc/selinux/targeted/contexts/files/file_contexts.local` shows th=
e relevant package.

The other files showed by `rpm -V` are probably not necessary to be include=
d in the package.

As far as I know we need to ship the SELinux store in /var/lib/selinux as w=
hole for systems using OSTree where packages
are not installed, i.e. post installation scripts are not run, but they are=
 just extracted to a filesystem.





> >=20
> >>
> >> $ ll /var/lib/selinux/targeted/active/users_extra
> >> -rw-------. 1 root root 101 11.=C2=A0dub 17.31 /var/lib/selinux/target=
ed/active/users_extra
> >> $ ll /var/lib/selinux/targeted/active/seusers
> >> -rw-------. 1 root root 73 11.=C2=A0dub 17.31 /var/lib/selinux/targete=
d/active/seusers
> >> $ semanage boolean -m --on httpd_can_network_connect
> >> $ ll /var/lib/selinux/targeted/active/seusers
> >> -rw-r--r--. 1 root root 73 23.=C2=A0b=C5=99e 16.59 /var/lib/selinux/ta=
rgeted/active/seusers
> >> $ ll /var/lib/selinux/targeted/active/users_extra
> >> -rw-r--r--. 1 root root 101 23.=C2=A0b=C5=99e 16.59 /var/lib/selinux/t=
argeted/active/users_extra
> >> $ rpm -Vq selinux-policy-targeted
> >> .M.....T.    /var/lib/selinux/targeted/active/seusers
> >> .M.....T.    /var/lib/selinux/targeted/active/users_extra
> >>
> >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >> ---
> >>  libsemanage/src/direct_api.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api=
=2Ec
> >> index e7ec952f..c58961be 100644
> >> --- a/libsemanage/src/direct_api.c
> >> +++ b/libsemanage/src/direct_api.c
> >> @@ -1481,7 +1481,7 @@ rebuild:
> >>  			retval =3D semanage_copy_file(path,
> >>  						    semanage_path(SEMANAGE_TMP,
> >>  								  SEMANAGE_STORE_SEUSERS),
> >> -						    sh->conf->file_mode);
> >> +						    0);
> >>  			if (retval < 0)
> >>  				goto cleanup;
> >>  			pseusers->dtable->drop_cache(pseusers->dbase);
> >> @@ -1499,7 +1499,7 @@ rebuild:
> >>  			retval =3D semanage_copy_file(path,
> >>  						    semanage_path(SEMANAGE_TMP,
> >>  								  SEMANAGE_USERS_EXTRA),
> >> -						    sh->conf->file_mode);
> >> +						    0);
> >>  			if (retval < 0)
> >>  				goto cleanup;
> >>  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
> >>
> >=20
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlrPu4kACgkQviIJHj72
InWVug//QzlVXZV2l51/fN/K2whL4u4yRjFOmawRTSOrmfmjriiFfgbXQr6p7hrc
hCCQm1iIhly669GcTXlL/7XrrFAY7CR/5hGjYyIaVBZ3eRyCLke8ttoemqyUivg6
Ei2hRsCewhVkktBZTUZ7ZZ0ML4GzGc8PVZZrVNMMJvmLOIEQGsbRSI9us0mKt3is
usoPwYBT5o1rhYXawl3wKE9EVsIBXoCjMWVR1bFigl94Wijg18gkbFvqKEiBYvh1
h5Loo7oiltdk5w4quAJDuff7kCs+Cs2YoOgZvZ1RGvwkw9Lj8bsqkYO4a72eOwjm
4LgZELE3sE2g2U4MIiN5SOVi8kC2dUILmPsahJuvur3oAaLex9WyqhSb/Huc1FZL
UnQ74ZuxAO/AtRuj2+2WkKk9Ch7SSnDIdG67RYd8ufvj5yloLaPNLvMAqLLDdL/y
vJeRmJkI4cbvu0Mp5eeIOzga/uRXUZ0Ql4jKl89JT00SfiH2FPqbRqyeslumk8U5
S/44NAoBkkEEkVMm/NoDGO3sG8117AaooSyrPKySocA0gBNvfwdXkAp1XbvJLNbG
FjbsohBuWm5DCAs/tCJNSeaUHWc6/OdSWlPcp2O5btofVb6V0qu8z1G0WrU400hw
VCTg4PYTCmPReBqES/wq8+BZiZStD8LoRognfvdxlpChoRGkHPQ=
=4qjm
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
