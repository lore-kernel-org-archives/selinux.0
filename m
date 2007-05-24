Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OG0ISc014081
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 12:00:18 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4OG0Hc3015599
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 16:00:17 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: James Antill <jantill@redhat.com>
To: Mark Goldman <mgoldman@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1180015458.3930.173.camel@tresys-winxppro>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mXHzqqmB+fpJyRjOUm6q"
Date: Thu, 24 May 2007 12:00:12 -0400
Message-Id: <1180022412.24418.58.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-mXHzqqmB+fpJyRjOUm6q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-24 at 10:04 -0400, Mark Goldman wrote:
> <snip>
> > > +static int write_home_dir_context(FILE * out, list_t * tpl, char *us=
er,
> > > +				  char *seuser, char *home, char *prefix)
> > > +{
> > > +	char *temp;
> > > +	char *line;
> > > +
> > > +	fprintf(out, "\n\n#\n# Home Context for user %s\n#\n\n", user);
> > > +	for (; tpl; tpl =3D tpl->next) {
> > > +		temp =3D semanage_sed(tpl->data, "HOME_DIR", home);
> >=20
> > Wow - I understand that this string handling in C is painful, but is
> > this really the best alternative? Perhaps parsing the input to make the
> > substitution easier would be better? Perhaps we should look for some
> > library code to do this?
> I am not really sure what the problem with this is.  We need to replace
> arbitrary substrings.  I searched in the C libraries for something that
> might do what I want.  I couldn't find anything, so I wrote a function
> to do it.

 I feel your pain, doing anything non-trivial with strings in C is
always a major PITA.
 As a personal project I've almost got ustr[1] in a 1.0 release, which I
hope could be used in the SELinux libraries (being able to easily
integrate it into libraries, is one of it's main points), and would
solve this problem and others in the SELinux libs. (like the strdup() +
a bit more data).

> As for parsing the input to make the substitution easier, I think it
> would be a lot more work to write or use a full fledged parser.  What
> we want in this situation is what I wrote in my opinion, although I am
> open to suggestions.

 Saying that, there were more than a few problems with semanage_sed()
even if you discount the genericness of the name:

1. You pre-allocate a bad amount of space:

+       srclen =3D strlen(src);
+       maxdest =3D 2 * srclen;
+       dest =3D malloc(maxdest);

...consider:

HOME_DIR        -d      system_u:object_r:user_home_dir_t:s0

strlen("HOME_DIR") =3D=3D 8, *2 =3D=3D 16
strlen("/home/kmacmillan") =3D=3D 16

...I think, you really want something like:

+       maxdest =3D srclen + (replen - vallen) * 2 + 1;


2. You pre-reallocate if there isn't enough room to insert a new val,
even if it's not possible to insert a new val:

+               min_increment =3D (dindex + replen + 1) - maxdest;
+               if (min_increment >=3D 0) {

...consider:

HOME_DIR/.+     system_u:object_r:user_home_t:s0

strlen("HOME_DIR/.+") =3D=3D 11, *2 =3D=3D 22
strlen("/home/james") =3D=3D 11

...now when you are at '.' in the above substitution, you'll have
dindex=3D11 and replen=3D11 which will trigger a realloc() even though you
only have 2 bytes left in src (so HOME_DIR will never match, obviously).


3. You should probably be calling strstr() instead of walking the
string.


4. All the sizes are signed int's, and no overflow/underflow checking is
done. This might be safe due to current usage, but it seems like a bad
idea to leave it this way in a core security lib.


[1] http://www.and.org/ustr/

--=20
James Antill <jantill@redhat.com>

--=-mXHzqqmB+fpJyRjOUm6q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVbaM11eXTEMrxtQRAkiiAKCrB7ELx/2MqEIKS+e0XigMymrUJwCfYbtY
A+zj9QM+BqO3tsNh4cEfJww=
=HBZx
-----END PGP SIGNATURE-----

--=-mXHzqqmB+fpJyRjOUm6q--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
