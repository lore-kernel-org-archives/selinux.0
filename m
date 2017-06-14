Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EEZm1D014895
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 10:35:48 -0400
Received: by mail-lf0-f53.google.com with SMTP id p189so2529215lfe.2
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 07:35:45 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id p24sm123446eda.67.2017.06.14.07.35.43
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Jun 2017 07:35:43 -0700 (PDT)
Date: Wed, 14 Jun 2017 16:35:41 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Collecting ideas for audit2allow improvement
Message-ID: <20170614143541.GB5298@julius.enp8s0.d30>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <1497450625.9239.6.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
In-Reply-To: <1497450625.9239.6.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 10:30:25AM -0400, Stephen Smalley wrote:
> On Wed, 2017-06-14 at 09:01 -0400, Jan Zarsky wrote:
> > Hi,
> >=20
> > I would like to improve SELinux audit2allow tool as my bachelor
> > thesis.
> > I collected ideas from my colleagues from RedHat SELinux team and I
> > would also
> > like to hear your ideas - what would you improve to make audit2allow
> > smarter or
> > easier to use.
> >=20
> > Ideas collected so far:
> >=20
> > =A0 * offer dac_read_search when sufficient instead of dac_override
> > =A0=A0=A0=A0(see <https://github.com/SELinuxProject/selinux/issues/31>)
>=20
> The hard part here is knowing when it is sufficient.  Might require
> further kernel patches to get to the point where it is completely
> unambiguous from the audit messages alone.  You could perhaps default
> to only allowing dac_read_search and only allow dac_override if you see
> that dac_read_search is already allowed and you are still getting a
> dac_override denial.

This should not be an issue anymore. Becuase now (linux v4.12) dac_read_sea=
rch is first checked
so translating a rule for dac_read_search will always be the most secure op=
tion. It might not be enough but youll notice if it isnt. Just rerun it aga=
in and you'll end up with dac_override if needed.

>=20
> > =A0 * offer multiple solutions to a problem (example: 1) add allow rule
> > for
> > =A0=A0=A0=A0execute + execute_no_trans or 2) add allow rule for execute
> > =A0=A0=A0=A0+ type_transition rule)
>=20
> Is this type_transition to an existing type that already exists, or
> defining a new type and transitioning to it, or both?  Generating new
> domains and types dynamically is one of the major gaps in current
> audit2allow, and to date has only been supported in separate tools like
> sepolicy generate.

One should be extremely careful here. "execute" does not automatically impl=
y "execute_no_trans". That assumption can lead to disaster (https://www.cve=
details.com/cve/CVE-2015-1815/)
>=20
> > =A0 * interactive mode: ask questions and choose best solution
> > =A0 * warn when solution touches trusted computing base (rules you
> > should not be
> > =A0=A0=A0=A0adding)
> > =A0 * suggest alternate labels for content, example: httpd_t not
> > allowed to write
> > =A0=A0=A0=A0to user_home_t, might suggest that changing the label to
> > =A0=A0=A0=A0httpd_user_content_t
>=20
> This seems more along the lines of what setroubleshoot does, and tends
> to be policy-specific. We need to preserve the usability of audit2allow
> for other policies (e.g. Android, DSSP), so any policy-specific logic
> needs to be encapsulated, configuration-driven, and optional.

setroubleshoot is not smart enough to suggest httpd_user_content_t, instead=
 it suggest you allow full access to /home/* by toggling the boolean that g=
rants access to user home content.

I know this from experience. There was a bug in fedora's apache_user_conten=
t_template for more than a year and hardly anyone noticed it, probably beca=
use setroubleshoot would have just suggested you allow full access to user =
home content.

>=20
> > =A0 * output to CIL (add option for this)
>=20
> This would definitely be useful, as generating .te files just adds
> overhead at this point and makes audit2allow depend on having
> checkmodule and semodule_package installed.  In fact, I think we should
> move to generating CIL by default and just provide an option for
> generating .te files for backward compat.
>=20
> > =A0 * if the AVC talks about execute permission then offer also
> > type_transition
> > =A0=A0=A0=A0rule
> > =A0 * idea for a tool for automatic policy generation: On a test system
> > you
> > =A0=A0=A0=A0install application, turn the SELinux to permissive and run=
 a
> > full test
> > =A0=A0=A0=A0suit. You collect all the AVCs in say Elasticsearch (can use
> > common logging
> > =A0=A0=A0=A0ViaQ project for that) and then there is a tool that search=
es the
> > AVC,
> > =A0=A0=A0=A0groups them and creates a policy out of them.
>=20
> This seems similar to sepolicy generate.  We don't want to bring in
> many extra dependencies to audit2allow, but being able to dynamically
> generate new domains and types would IMHO be useful.
>=20
> > =A0 * add option to open bugzilla
>=20
> Need to be careful here since not all SELinux users are Red Hat users.
>=20
> > =A0 * output to Ansible playbook/role task (add option for this)
>=20
> Another improvement:
>=20
> * Add ability to generate ioctl whitelisting rules, see for example:
> http://jeffvanderstoep.blogspot.com/2016/02/collecting-ioctl-command-deni=
als-for.html
> but note that the syntax has changed to e.g.
> allowxperm <sourcedomain> <targetdomain>:<class> ioctl { <list of ioctl
> command values> };
>=20
> > I would also like to know which feature would you appreciate the
> > most.
>=20
> You should likely study the tooling and workflow used by other security
> projects, e.g. AppArmor, TOMOYO, grsecurity, for policy learning and
> generation.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllBSbkACgkQJXSOVTf5
R2nuIQwAhex2au1YWUqaXm3pdXwbVLIysw6HZcJHTQyjRHgRegKy4YzQxIFUJ4KL
+TwFv21jk/7kM5QED1E9WdI1zKH5FoqxU1x8cEcGVPLpmddN/7oVi9QsfdTs1NL5
Slhzj1+wgcZgi46Bc5GLko9wgcFXr7+FS+C1XvgwnOdmcvw/9hD8SRFXQ6rDgwqD
UbMIzqSIG92pSLeCsh+13tBTE8ZZFQEmHCeQBeVoOGbdDrW3bk2+dT+jhlCUq1Vq
PZkXh2VBzPtlAfVOMXv7yNtxVAo55ZvGG1ILrHQGnWsIrrcyy1tGDLgp6h6d3e13
WnVfMaCqe9c8WFjPi16YhVGH9idmW4rlm8vAN6UwFjYzuTwyt6sCmoB4xx8r+VQm
70xsxeQvfAnF74LkE0SvJB5KeMd6e2sGL691XHdl5X3GkyOjX/n0qWsOoMWfGI7F
y0mZBpJFcHHWbDrc/DTjCvbDAh0hWmp9abUaUEQr4+DPAZ2JBTfo12Vp//ArwUfT
FlE/0GL/
=eECr
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
