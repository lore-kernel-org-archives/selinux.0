Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6OBUpBZ012357
 for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2016 07:30:51 -0400
Received: by mail-wm0-f54.google.com with SMTP id q128so104077643wma.1
 for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2016 04:30:31 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id h7sm10274071wjd.17.2016.07.24.04.30.29
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Jul 2016 04:30:29 -0700 (PDT)
Subject: Re: genhomedircon: some issues with a custom policy
To: selinux@tycho.nsa.gov
References: <20160723222704.GB29599@home>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <0c6a9a3a-d071-2d28-f2d5-47753522ee6f@gmail.com>
Date: Sun, 24 Jul 2016 13:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <20160723222704.GB29599@home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MM2XuVJJfsMuaDdJAgQcfkDCUfBet8rCT"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MM2XuVJJfsMuaDdJAgQcfkDCUfBet8rCT
Content-Type: multipart/mixed; boundary="HGxBKqgUjsJdLM04X96XlkNEt5eBWij87"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <0c6a9a3a-d071-2d28-f2d5-47753522ee6f@gmail.com>
Subject: Re: genhomedircon: some issues with a custom policy
References: <20160723222704.GB29599@home>
In-Reply-To: <20160723222704.GB29599@home>

--HGxBKqgUjsJdLM04X96XlkNEt5eBWij87
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/24/2016 12:27 AM, Gary Tierney wrote:
> Hi,
>=20
> There are a few issues I've run into with genhomedircon and a custom po=
licy
> (i.e., not based on refpolicy), 2 of which prevent me from using genhom=
edircon,
> and 1 small issue which I can work around.
>=20
> The first main issue is that my custom policy doesn't use "system_u" as=
 the
> system user identifier (instead it is "sys.id").  So when genhomedircon=
 writes
> out contexts for my login they are still associated with sys.id because=

> genhomedircon only does a simple search and replace for the default ref=
policy
> system user identifier "system_u".  I had look at existing contexts in
> homedir_templates for refpolicy, fedora-selinux and the custom policy I=
'm using
> and it seems like it'd be safe enough to replace the SELinux user in al=
l the
> HOMEDIR and USER context specifications regardless of if it matches "sy=
stem_u".
> Would this be a reasonable approach?
>=20
> The second issue is RBACSEP in my policy.  There's currently no way for=

> genhomedircon to know which role to associate with a logins file contex=
t specs
> if RBACSEP is used.  I noticed that genhomedircon will replace "ROLE" i=
n context
> specs with whatever the SELinux users prefix is so I've currently hacke=
d
> genhomedircon.c to replace the role in each context with whatever the u=
sers
> prefix is and have some policy like this:
>=20
> (in wheel
>     (tunableif enable_rbacsep
>         (true
>             (userprefix id wheel.role))))
>=20
> This makes sure all logins associated with wheel.id get a role of "whee=
l.role"
> in their generated context specs. This seems like a bit of a hack since=

> historically the users prefix has been used for a prefix in a type iden=
tifier.
> Any suggestions on how this should be handled?
>=20
> The third and smallest issue is that semanage-login supports login iden=
tifiers
> with the %groupname format but genhomedircon doesn't expand them to the=
 groups
> members.  I currently expand groups to their members in genhomedircon a=
nd treat
> a user belonging to 2 groups listed in seusers as an error.  Would a pa=
tch be
> accepted for this functionality?
>=20
> Thanks,
> Gary.
>=20

Gary thank you.

I have been wanting the above for quite some time. From a code
perspective i cannot give much feedback/comments, but i surface tested
this patch and all 3 features seem to work as advertised.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--HGxBKqgUjsJdLM04X96XlkNEt5eBWij87--

--MM2XuVJJfsMuaDdJAgQcfkDCUfBet8rCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXlKbPAAoJECV0jlU3+UdpVkYMAK4BEkpX964/Tu9I4/NjoKgN
k/Ts6GALlqYOcSgE22C4D6gUeb140JiVX+qBxT1t7gyvkXduAhrWkNTsFmV9kuox
04eN10ifCT0fOuR0Fw1ecSNuwPJRZlpb6/WOW31dyhrkdYydjQssdgR6ghzvco4W
RBJBlhDtiaUfTGRzyJUQ7ntSRfA/ri8rmcrpwZUI+fLiscDW35m4ZFpX+GabBuOT
MrRoiJhf+LG/WONfv/0bvpx9GCQEz87s6ImkY5MMECPJ9JQ6mG46obbWFJV6R4mu
Kp+IFn9uALmSe680Rt8hhwj7n8sg6IVXcVyozLcAP+2a04IkwNkooCXSZKkt9x7c
Eyi/iN/VF5lOt3vhZ02XRhlWbvouiNYscn5s2RZxwBUlNWc1Zo05w+OzAYHRCQBb
JHz7+6WRMdbSyQYuhK0MmHz3XSnP1I3nkxhPB3NzRnWBLP9UKkg7d6b3i+f2MPQZ
wnu84R2wBA1AB3VQ71CN5YlrnhQUVJ6jY/a4yxMjgQ==
=wohl
-----END PGP SIGNATURE-----

--MM2XuVJJfsMuaDdJAgQcfkDCUfBet8rCT--
