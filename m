Date: Mon, 23 Apr 2018 18:48:19 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Joe Kirwin <jpk@cmd.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 selinux@tycho.nsa.gov, Travis Szucs <ts@cmd.com>
Message-ID: <20180423164818.GA17386@workstation>
References: <CAJ8tuXqjVAwfHo7usVTGKaKbhUFhUd0uZML4T3h=B=0fhmJKVg@mail.gmail.com>
 <bc31b468-299d-b0d6-af68-3f96d0655252@tycho.nsa.gov>
 <CAJ8tuXoUc0Eru04KMBzKOZ18qYb20CUvd1LPQZb9nBpqNge9xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <CAJ8tuXoUc0Eru04KMBzKOZ18qYb20CUvd1LPQZb9nBpqNge9xA@mail.gmail.com>
Subject: Re: Alias path subbing results in unexpected policy
 labelling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 04:21:22PM +0000, Joe Kirwin wrote:
> Petr, Daniel,
>=20
> Have you had time to verify this issue yet?
> Any comments to add?
>=20

I consider this as the expected behavior.

It's defined as "Substitute target path with sourcepath when generating def=
ault
 label." It means that /apple is substituted for /banana and the lookup is =
made
 for /banana/orange/foo.

On the other hand, `semanage-fcontext` man page and `semanage fcontext -h`
output could be misleading a bit as they use words "EQUAL" and "equivalent"
while it's not a symmetric relation, it's just a substitution.

I don't have an opinion about proposed change to have a real equivalence. It
could complicate some things a lot and the benefit is not clear to me right=
 now.

Petr

>
> On Tue, Mar 20, 2018 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>=20
> > On 03/19/2018 10:29 PM, Joe Kirwin wrote:
> > > *_Empirical Observations _*
> > > *
> > > *
> > > If I was to create an SELinux policy containing the following
> > file_contexts (fruits.fc)
> > > ```
> > > /apple/orange/.*                  --
> > gen_context(system_u:object_r:atype_t,s0)
> > > /banana/.*                           --
> > gen_context(system_u:object_r:btype_t,s0)
> > > ```
> > >
> > > If I then take the file
> > > /etc/selinux/default/contexts/files/file_contexts.subs_dist and append
> > to it the alias
> > > ```
> > > /apple /banana
> > > ```
> > >
> > > The resulting behavior is that when running:
> > > ```
> > > $ ./libselinux/utils/selabel_lookup_best_match -p /apple/orange/foo
> > > Best match context: system_u:object_r:btype_t:s0
> > >
> > > But the expected behavior is to match `atype_t` as that is a
> > "more-specific" match pattern
> >
> > I don't think this is a bug based on the documented behavior for
> > file_contexts.subs.  That said,
> > that support was added by Red Hat so I'll let them speak to it.
> >
> > >
> > > *_Looking into why_*
> > >
> > > From the method in `libselinux/src/label_file.c` :
> > >                       lookup_common(struct selabel_handle *rec, const
> > char *key, int type, bool partial)
> > >
> > > we encounter a call to :
> > >                      selabel_sub_key(struct saved_data *data, const c=
har
> > *key)
> > >
> > > In the example above the candidate path we're trying to match (referr=
ed
> > to as the key in the code) is "canonicalized" to the /banana alias but =
the
> > regex being evaluated is not
> > >
> > > *_A proposed fix_*
> > > *
> > > *
> > > /Also attached (label_file.patch), if the patch formatting is off on
> > this thread, apologies./
> > > *
> > > *
> > > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > > index 560d8c3..98a8d1b 100644
> > > --- a/libselinux/src/label_file.c
> > > +++ b/libselinux/src/label_file.c
> > > @@ -848,7 +848,7 @@ static struct spec *lookup_common(struct
> > selabel_handle *rec,
> > >  {
> > >     struct saved_data *data =3D (struct saved_data *)rec->data;
> > >     struct spec *spec_arr =3D data->spec_arr;
> > > -   int i, rc, file_stem;
> > > +   int i, rc, file_stem, orig_file_stem;
> > >     mode_t mode =3D (mode_t)type;
> > >     const char *buf;
> > >     struct spec *ret =3D NULL;
> > > @@ -879,8 +879,12 @@ static struct spec *lookup_common(struct
> > selabel_handle *rec,
> > >     }
> > >
> > >     sub =3D selabel_sub_key(data, key);
> > > -   if (sub)
> > > +   orig_file_stem =3D -1;
> > > +   if (sub) {
> > > +      orig_file_stem =3D find_stem_from_file(data, &key);
> > >         key =3D sub;
> > > +   }
> > >
> > >     buf =3D key;
> > >     file_stem =3D find_stem_from_file(data, &buf);
> > > @@ -896,7 +900,8 @@ static struct spec *lookup_common(struct
> > selabel_handle *rec,
> > >          * stem as the file AND if the spec in question has no mode
> > >          * specified or if the mode matches the file mode then we do
> > >          * a regex check        */
> > > -       if ((spec->stem_id =3D=3D -1 || spec->stem_id =3D=3D file_ste=
m) &&
> > > +       if ((spec->stem_id =3D=3D -1 || spec->stem_id =3D=3D file_ste=
m ||
> > > +            spec->stem_id =3D=3D orig_file_stem) &&
> > >             (!mode || !spec->mode || mode =3D=3D spec->mode)) {
> > >             if (compile_regex(data, spec, NULL) < 0)
> > >                 goto finish;
> > >
> > >
> > >
> > > I think there is still some simplification that could be done with
> > aliases, in that they really shouldn't have a direction (e.g. alias ->
> > original) instead they should go both ways and if there is a tie it sho=
uld
> > go by the ordering of the specs.
> > > Reason for this is that a developer of an SELinux policy, may not know
> > the contents or directionality of file_contexts.subs_dist ahead of time=
 or
> > when it might change.
> > >
> > > Thanks,
> > > Joe Kirwin and Travis Szucs
> > >
> >
> > --
> --=20
> *Joe Kirwin*  |  *Senior Security Developer_*
> *E:* jpk@cmd.com <bam@cmd.com>   *M:* 1.604.365.2823
>=20
> <https://app.salesforceiq.com/r?target=3D5a6243eae4b0af727465cb94&t=3DAFw=
hZf1CQsv7FDLhSeW59giQrg545clQ2ksOeCxqTY5CK4AoaKjZJqLqF4FBhplxxtKw68VNNcp3Th=
HgNAMyfYlitWTAFUx2WymfWC2lJKWbtcBVzXz7rzKynmKi0AIVRaiN70T6bDHU>

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlreDkwACgkQviIJHj72
InW/cQ/6A12nnEqC0dEeNxH0+Owe/4Dj3GDuxVLwu6K8l+oAdphfTk7Nf3BZ7Wdc
EmkmlZSfabYqlAggUysqHJBZmX7Ha7Uom7r9gA5Gk1NtX6lY78LODlNu51MjrZmd
mu4xhkJmSScUYqT2NDNRDQCbUHfxVE0sxUYegiuISZI2f6xA9ytFzAibM01G5h97
9F0Ia3J2JdXJ2fG77gmohV0noqRK4lGDgh9h13apX2atRpfk6fRcyUzPsi8wEO9Q
v5LqE8Ac+hFxuMxVPQu16CqJSZ+csbDgTy6rGHKOpZhdH+SEh4lF8dEvtNs6pa5m
fU3CgiU9LE7RfvHAdeWV0jkYQnjf4IOW1x3882Cfrf3u5AjtlfjnNJkIuJPZaHOS
7EDGu2V/AuuncGq+SNmYvf7tEdcFj7FdExcD0eUFAccULl6rujoYV312WFI630AU
hvr2VGAtiHn98pFRlUY92WNAWhAeLX3tp4tY6KQ4iUaOVTHmjOcsWRD7pjANaFpH
ZEjbvOSTlIlkMCjp25HwEglHD83BuGknNI/RrWvPWOS5y6va3+gWJG6ifvPRgeu7
ES83gTy7eEC47Q/buMuyShV9nFk7PI99O2VydnONLvVdMlyBtYPtpUUnroGIfpRA
ADBBtlRqR6XE2EE25ydVPIEYVoUnGxeSezmqUg/2bhWpLnWCfU4=
=rvND
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
