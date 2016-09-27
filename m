Date: Tue, 27 Sep 2016 09:44:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <pebenito@ieee.org>,
 Gary Tierney <gary.tierney@gmx.com>
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
Message-ID: <20160927074412.GA15284@x250.enp8s0.d30>
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
 <52a12ae5-ccbf-2545-1525-011d2c768c54@gmail.com>
 <ea1d8e6a-1bdf-8c54-aacc-41c068a7182f@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <ea1d8e6a-1bdf-8c54-aacc-41c068a7182f@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 10:20:12AM -0400, Stephen Smalley wrote:
> On 09/24/2016 04:26 AM, Dominick Grift wrote:
> > On 09/23/2016 09:36 PM, Stephen Smalley wrote:
> >> On 09/23/2016 10:28 AM, Gary Tierney wrote:
> >>> Introduces support for generating homedir/user contexts for
> >>> policies that implement RBACSEP.  The support works by taking
> >>> the prefix of a logins seuser and replacing the role field in
> >>> their context specifications with the prefix.  A new option
> >>> "genhomedircon-rbacsep" was added to /etc/selinux/semanage.conf
> >>> to allow toggling this behavior.
> >>=20
> >> The user prefix was previously used as a prefix for types, e.g.
> >> you could have: HOME_DIR/\.gnupg(/.+)?
> >> system_u:object_r:ROLE_gpg_secret_t and get it replaced with:=20
> >> /home/[^/]+/\.gnupg(/.+)?
> >> system_u:object_r:user_gpg_secret_t /root/\.gnupg(/.+)?
> >> system_u:object_r:sysadm_gpg_secret_t
> >>=20
> >> So I guess you could use it for the role field too, but for
> >> consistency you would want it to be: HOME_DIR/\.gnupg(/.+)?
> >> system_u:ROLE_r:ROLE_gpg_secret_t
> >>=20
> >> and the prefix would still just be "user".
> >=20
> > No one is actually using that privsep functionality anymore.
> > Reference policy removed support for it.
> >=20
> > Can we not instead just re-use that code for rbacsep?
> >=20
> > The alternative would be to add code similar to the privsep code
> > but then for rbacsep.
> >=20
> > Then we will have the issue that we can't reasonably rely on the=20
> > userprefix and prefix statements for rbacsep, because they might be
> > used for privsep (in theory at least)
> >=20
> > I other words if we were to implement rbacsep code similar to the=20
> > privsep code, then we would need a new policy statement similar to=20
> > userprefix and prefix.
> >=20
> > It seems much easier to me to just re-use the privsep code.
> >=20
> > rbacsep is the successor to privsep after all.
>=20
> First, I'm not sure what you mean by privsep; usually that term refers
> to privilege separation as in openssh.
>=20
> There are at least three ways of implementing "role" separation for
> objects in SELinux:
> (1) via TE and the use of derived types on objects e.g. ROLE_home_t,
> ROLE_devpts_t, etc,
> (2) via RBAC and the use of roles on objects (originally problematic
> because it required a set of changes to the kernel to support roles on
> objects, but that's all history now),
> (3) via UBAC and the use of SELinux user identities on objects to
> represent roles.
>=20
> refpolicy started with (1), experimented with (2) and seems to have
> settled on (3), likely because (2) wasn't fully supported in the
> kernel or userspace for a long time.  I guess libsemanage /
> genhomedircon already support (3) adequately.
>=20
> CIL apparently doesn't support (1), so that's broken regardless.
>=20
> So I guess reusing the prefix for RBACSEP won't break any existing
> users.  That said, it is clearly confusing to use something identified
> in the policy language and documentation as a "prefix" for the purpose
> of a "default role".  So maybe we should look to rename it in the
> language and code, with backward compatibility.  That can be done as a
> separate set of changes.  That might also help us with a different
> problem - obsoleting security_compute_user() aka /sys/fs/selinux/user
> and taking the get_default_context() logic to userspace.
>=20
> Has anyone compared UBAC vs RBAC now that the kernel and policy
> support roles on objects?  Is there a strong reason for refpolicy to
> stay with (3) other than compatibility with older distributions and
> this genhomedircon issue?
>=20

Another likely issue is also with sudo.

An unprivileged user (staff_u) runs sudo to change to root/sysadm_r in orde=
r to create a file that should be accessible system wide.

The file he created will end up with staff_u identity and IBACSEP constrain=
ed processes might not be able to access it.

This wouldnt be an issue with RBACSEP because the role is changed to sysadm=
_r, which is not RBACSEP constrained. (no "privileged" roles are constraine=
d)

This IBACSEP sudo issue can be avoided by using: `machinectl shell .host` i=
nstead. which will change the context fully to sysadm_u:sysadm_r:sysadm_t

However that is more difficult to configure and depends on systemd

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX6iNHAAoJECV0jlU3+UdpNvAMALmxN40QTdKRaJ9RTKz6Ufhd
eFXk2IvZ6nVz6AuLWiKxUjzjYpslbuEpPUsrNVBXc5jxiAOKDRyRDaJfnS7XIaqk
9Tdwy7Qh39hRchXrNskjXQmDloeQ3s+GYt04LcdrW++julJSU+HDQYx3OVfZVfYL
1air91Vk9ZvbA3v8q+vsws17vahZ3iuHJI/goE0Kkz0RydUysV3gBbc1kwvBFOnl
/x3Z6OVchq3KN6EZGJj9fqN59MQAtSqjfJIGD31TG9UTAqNkhIFweFVlaLfFiIAD
TIoUPRfPdGTI7j12AaCNg01BDNbxLbiAo4j1XxosLjS4bYuaqUah4FubTxIfszT7
LY3PFUfaSHHK0AKPeygeVX3c4cqlR5m5j2y/qn3z9TohKWLoFlg056MdCieEXtWZ
eij554czmbX/L9WFHnZnCAWVNc7VuhMt3lv7AiB5+RNMJmLZ67lxa1vlyTitOtjQ
Jik29LULrOTcP9o8gBmJyJ3if3vrLvLeK1r7AXuMAw==
=86sC
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
