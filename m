Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44HWJOG000452
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:32:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so4826773wmu.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:32:16 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id c3sm792164edb.23.2017.05.04.10.32.14
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 10:32:15 -0700 (PDT)
Date: Thu, 4 May 2017 19:32:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/6] Revert "policycoreutils: let output of `fixfiles` be
 redirected (as normal)"
Message-ID: <20170504173213.GC29905@julius>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
 <20170504172819.GB29905@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
In-Reply-To: <20170504172819.GB29905@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 07:28:19PM +0200, Dominick Grift wrote:
> On Thu, May 04, 2017 at 06:01:17PM +0100, Alan Jenkins wrote:
> > This reverts commit ac7899fc3ad6221e195dd13cdf14b346897314ae,
> > which is not yet part of an officially tagged release
> > (or release candidate).
> >=20
> > `LOGFILE=3D/proc/self/fd/1` was wrong.
> >=20
> > `LOGFILE=3D$(tty)` was being relied on in one case (exclude_dirs),
> > to log messages from a function run specifically with stdout redirected
> > (captured into a variable).
> >=20
> > Having `logit "message"` break inside redirected functions
> > is a nasty leaky abstraction.
> >=20
> > This caused e.g. `fixfiles restore` to terminate early with the error
> >=20
> >     skipping: No such file or directory
> >=20
> > if the user had configured any excluded paths in
> > /etc/selinux/fixfiles_exclude_dirs
> > ---
> >  policycoreutils/scripts/fixfiles | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index bc74d69..75d7762 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -119,7 +119,11 @@ VERBOSE=3D"-p"
> >  FORCEFLAG=3D""
> >  DIRS=3D""
> >  RPMILES=3D""
> > -LOGFILE=3D/proc/self/fd/1
> > +LOGFILE=3D`tty`
> > +if [ $? !=3D 0 ]; then
> > +    LOGFILE=3D"/dev/null"
> > +fi
> > +LOGGER=3D/usr/sbin/logger
>=20
> $ ls /usr/bin/logger
> /usr/bin/logger
> $ ls /usr/sbin/logger
> ls: cannot access '/usr/sbin/logger': No such file or directory

Whoops, please ignore. This was removed anyway

>=20
> >  SETFILES=3D/sbin/setfiles
> >  RESTORECON=3D/sbin/restorecon
> >  FILESYSTEMSRW=3D`get_rw_labeled_mounts`
> > @@ -134,11 +138,11 @@ else
> >  fi
> > =20
> >  #
> > -# Write to LOGFILE
> > +# Log to either syslog or a LOGFILE
> >  #
> >  logit () {
> >  if [ -n $LOGFILE ]; then
> > -    echo $1 >> "$LOGFILE"
> > +    echo $1 >> $LOGFILE
> >  fi
> >  }
> >  #
> > --=20
> > 2.9.3
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLZZkACgkQJXSOVTf5
R2mbNQv+MQDbyAGf9m8uMXb1X6KVKQhorQ06Y6NPdysCEjTuKMBSoQfypSTy0jrN
1dEfflt8w/94Ru3yUSTLtnS8nY4rPKnwkam7mfFxQ8Uy1kUWKLtLNanhJ4se+jJa
gXEVSjvvXQKMpj3ng9AjXbahuyC2WZNn16DR6AEQw/tg8Ge4X+N1PFxlWr8SAlol
TeME2Bngw64H4YufbVcSqpLe3R+9tj1FLRZYKXfU1RzLkq1EqI1KM1hnYHc2kX7a
yxZLuky2/Q+TbpL0M0n8QgtU5XXScuitMAxlidQXJBZ/i59R2cEy9L2fNJhXnBSH
sQOyoug6+qQ3MNY0FIplmJn/g0HZSjL5lKa/TKEHrPvu8sofXkD6ZgfMi5B+DqB9
VVBYbK/JxbOxl7CAW45T0xar+EB/KglR8FCHUE0Egz97j9vxWdPAuTHknvhOoumT
QeLCLAUA+cX7KZnXKaQi2fnMAjaQLYv7bN3oFV6xjJGUaSNPwA8ZaW9oGOTNMmpf
pQ3Tl2Za
=8EiX
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
