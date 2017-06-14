Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EElbRI019319
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 10:47:40 -0400
Received: by mail-lf0-f49.google.com with SMTP id p189so2845762lfe.2
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 07:47:36 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id 2sm93672edt.66.2017.06.14.07.47.34
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Jun 2017 07:47:34 -0700 (PDT)
Date: Wed, 14 Jun 2017 16:47:32 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Collecting ideas for audit2allow improvement
Message-ID: <20170614144732.GC5298@julius.enp8s0.d30>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <1497450625.9239.6.camel@tycho.nsa.gov>
 <20170614143541.GB5298@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
In-Reply-To: <20170614143541.GB5298@julius.enp8s0.d30>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 04:35:41PM +0200, Dominick Grift wrote:
> On Wed, Jun 14, 2017 at 10:30:25AM -0400, Stephen Smalley wrote:
> > On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
> > > Hi,
> > >=20
> > > I would like to improve SELinux audit2allow tool as my bachelor
> > > thesis.
> > > I collected ideas from my colleagues from RedHat SELinux team and I
> > > would also
> > > like to hear your ideas - what would you improve to make audit2allow
> > > smarter or
> > > easier to use.
> > >=20
> > > Ideas collected so far:
> > >=20
> > > =A0 * offer dac_read_search when sufficient instead of dac_override
> > > =A0=A0=A0=A0(see <https://github.com/SELinuxProject/selinux/issues/31=
>)
> >=20
> > The hard part here is knowing when it is sufficient.  Might require
> > further kernel patches to get to the point where it is completely
> > unambiguous from the audit messages alone.  You could perhaps default
> > to only allowing dac_read_search and only allow dac_override if you see
> > that dac_read_search is already allowed and you are still getting a
> > dac_override denial.
>=20
> This should not be an issue anymore. Becuase now (linux v4.12) dac_read_s=
earch is first checked
> so translating a rule for dac_read_search will always be the most secure =
option. It might not be enough but youll notice if it isnt. Just rerun it a=
gain and you'll end up with dac_override if needed.
>=20
> >=20
> > > =A0 * offer multiple solutions to a problem (example: 1) add allow ru=
le
> > > for
> > > =A0=A0=A0=A0execute + execute_no_trans or 2) add allow rule for execu=
te
> > > =A0=A0=A0=A0+ type_transition rule)
> >=20
> > Is this type_transition to an existing type that already exists, or
> > defining a new type and transitioning to it, or both?  Generating new
> > domains and types dynamically is one of the major gaps in current
> > audit2allow, and to date has only been supported in separate tools like
> > sepolicy generate.
>=20
> One should be extremely careful here. "execute" does not automatically im=
ply "execute_no_trans". That assumption can lead to disaster (https://www.c=
vedetails.com/cve/CVE-2015-1815/)
> >=20
> > > =A0 * interactive mode: ask questions and choose best solution
> > > =A0 * warn when solution touches trusted computing base (rules you
> > > should not be
> > > =A0=A0=A0=A0adding)
> > > =A0 * suggest alternate labels for content, example: httpd_t not
> > > allowed to write
> > > =A0=A0=A0=A0to user_home_t, might suggest that changing the label to
> > > =A0=A0=A0=A0httpd_user_content_t
> >=20
> > This seems more along the lines of what setroubleshoot does, and tends
> > to be policy-specific. We need to preserve the usability of audit2allow
> > for other policies (e.g. Android, DSSP), so any policy-specific logic
> > needs to be encapsulated, configuration-driven, and optional.
>=20
> setroubleshoot is not smart enough to suggest httpd_user_content_t, inste=
ad it suggest you allow full access to /home/* by toggling the boolean that=
 grants access to user home content.
>=20
> I know this from experience. There was a bug in fedora's apache_user_cont=
ent_template for more than a year and hardly anyone noticed it, probably be=
cause setroubleshoot would have just suggested you allow full access to use=
r home content.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1457406

>=20
> >=20
> > > =A0 * output to CIL (add option for this)
> >=20
> > This would definitely be useful, as generating .te files just adds
> > overhead at this point and makes audit2allow depend on having
> > checkmodule and semodule_package installed.  In fact, I think we should
> > move to generating CIL by default and just provide an option for
> > generating .te files for backward compat.
> >=20
> > > =A0 * if the AVC talks about execute permission then offer also
> > > type_transition
> > > =A0=A0=A0=A0rule
> > > =A0 * idea for a tool for automatic policy generation: On a test syst=
em
> > > you
> > > =A0=A0=A0=A0install application, turn the SELinux to permissive and r=
un a
> > > full test
> > > =A0=A0=A0=A0suit. You collect all the AVCs in say Elasticsearch (can =
use
> > > common logging
> > > =A0=A0=A0=A0ViaQ project for that) and then there is a tool that sear=
ches the
> > > AVC,
> > > =A0=A0=A0=A0groups them and creates a policy out of them.
> >=20
> > This seems similar to sepolicy generate.  We don't want to bring in
> > many extra dependencies to audit2allow, but being able to dynamically
> > generate new domains and types would IMHO be useful.
> >=20
> > > =A0 * add option to open bugzilla
> >=20
> > Need to be careful here since not all SELinux users are Red Hat users.
> >=20
> > > =A0 * output to Ansible playbook/role task (add option for this)
> >=20
> > Another improvement:
> >=20
> > * Add ability to generate ioctl whitelisting rules, see for example:
> > http://jeffvanderstoep.blogspot.com/2016/02/collecting-ioctl-command-de=
nials-for.html
> > but note that the syntax has changed to e.g.
> > allowxperm <sourcedomain> <targetdomain>:<class> ioctl { <list of ioctl
> > command values> };
> >=20
> > > I would also like to know which feature would you appreciate the
> > > most.
> >=20
> > You should likely study the tooling and workflow used by other security
> > projects, e.g. AppArmor, TOMOYO, grsecurity, for policy learning and
> > generation.
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

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllBTIEACgkQJXSOVTf5
R2ljcgv+MelIk3RdFZuYP+tyrPQEHc2rrfnGB3xLF5HIKt0j/Wj8wMPBLYjlVHzR
9UhmAqO3Ls4xhTOy1GDYKFJCj95RwnFH76PazS0KKsISiZjXYUrMXgzASmHnT2q1
qZmzsZon37zcNFXTcRf6vD1h2yK4NRa51TzBHzSFbUFIf1j0JH7k1rVmqcbslbBL
MrHzj5/OVYRrCHes+BDFDymYc9C9J38kgB5tq5WlYLy6gSWgAYR0aNQhUifxDWz9
3VlKWICvvSO6zfdVZF0eWvNQmIQDIgc2ApCymOcX7244EApjSffWc9Pz1nHE3tYL
Af/ax0VL71TVmgi+BNc+alfps5WlBdJzHIjfn1V4KLzPXpsP+2XYg1u9lkHndIhU
ZcQB9pCal0dZcsP0DoMJbowFBhqPP3Ryn/4d06TcWPJ4tCHV7rloxg62jkAFIZfY
qky/yNQakJf0u3FSpX5ykkmQ79Ixc+Ae2HkOFs7aegFycD7YokxS1Icjy3rVhBJ6
39hKqpz4
=4znD
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
