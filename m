Date: Thu, 29 Sep 2016 02:06:10 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
Message-ID: <20160929010610.GA3548@home-pc>
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
 <52a12ae5-ccbf-2545-1525-011d2c768c54@gmail.com>
 <ea1d8e6a-1bdf-8c54-aacc-41c068a7182f@tycho.nsa.gov>
 <20160927074412.GA15284@x250.enp8s0.d30>
 <c6f41bcd-a5ca-0760-4e97-c9e99d0bee88@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <c6f41bcd-a5ca-0760-4e97-c9e99d0bee88@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2016 at 09:39:49AM -0400, Stephen Smalley wrote:
> On 09/27/2016 03:44 AM, Dominick Grift wrote:
> > On Mon, Sep 26, 2016 at 10:20:12AM -0400, Stephen Smalley wrote:
> >> On 09/24/2016 04:26 AM, Dominick Grift wrote:
> >>> On 09/23/2016 09:36 PM, Stephen Smalley wrote:
> >>>> On 09/23/2016 10:28 AM, Gary Tierney wrote:
> >>>>> Introduces support for generating homedir/user contexts
> >>>>> for policies that implement RBACSEP.  The support works by
> >>>>> taking the prefix of a logins seuser and replacing the role
> >>>>> field in their context specifications with the prefix.  A
> >>>>> new option "genhomedircon-rbacsep" was added to
> >>>>> /etc/selinux/semanage.conf to allow toggling this
> >>>>> behavior.
> >>>>=20
> >>>> The user prefix was previously used as a prefix for types,
> >>>> e.g. you could have: HOME_DIR/\.gnupg(/.+)?=20
> >>>> system_u:object_r:ROLE_gpg_secret_t and get it replaced with:
> >>>>  /home/[^/]+/\.gnupg(/.+)?=20
> >>>> system_u:object_r:user_gpg_secret_t /root/\.gnupg(/.+)?=20
> >>>> system_u:object_r:sysadm_gpg_secret_t
> >>>>=20
> >>>> So I guess you could use it for the role field too, but for=20
> >>>> consistency you would want it to be: HOME_DIR/\.gnupg(/.+)?=20
> >>>> system_u:ROLE_r:ROLE_gpg_secret_t
> >>>>=20
> >>>> and the prefix would still just be "user".
> >>>=20
> >>> No one is actually using that privsep functionality anymore.=20
> >>> Reference policy removed support for it.
> >>>=20
> >>> Can we not instead just re-use that code for rbacsep?
> >>>=20
> >>> The alternative would be to add code similar to the privsep
> >>> code but then for rbacsep.
> >>>=20
> >>> Then we will have the issue that we can't reasonably rely on
> >>> the userprefix and prefix statements for rbacsep, because they
> >>> might be used for privsep (in theory at least)
> >>>=20
> >>> I other words if we were to implement rbacsep code similar to
> >>> the privsep code, then we would need a new policy statement
> >>> similar to userprefix and prefix.
> >>>=20
> >>> It seems much easier to me to just re-use the privsep code.
> >>>=20
> >>> rbacsep is the successor to privsep after all.
> >>=20
> >> First, I'm not sure what you mean by privsep; usually that term
> >> refers to privilege separation as in openssh.
> >>=20
> >> There are at least three ways of implementing "role" separation
> >> for objects in SELinux: (1) via TE and the use of derived types
> >> on objects e.g. ROLE_home_t, ROLE_devpts_t, etc, (2) via RBAC and
> >> the use of roles on objects (originally problematic because it
> >> required a set of changes to the kernel to support roles on=20
> >> objects, but that's all history now), (3) via UBAC and the use of
> >> SELinux user identities on objects to represent roles.
> >>=20
> >> refpolicy started with (1), experimented with (2) and seems to
> >> have settled on (3), likely because (2) wasn't fully supported in
> >> the kernel or userspace for a long time.  I guess libsemanage /=20
> >> genhomedircon already support (3) adequately.
> >>=20
> >> CIL apparently doesn't support (1), so that's broken regardless.
> >>=20
> >> So I guess reusing the prefix for RBACSEP won't break any
> >> existing users.  That said, it is clearly confusing to use
> >> something identified in the policy language and documentation as
> >> a "prefix" for the purpose of a "default role".  So maybe we
> >> should look to rename it in the language and code, with backward
> >> compatibility.  That can be done as a separate set of changes.
> >> That might also help us with a different problem - obsoleting
> >> security_compute_user() aka /sys/fs/selinux/user and taking the
> >> get_default_context() logic to userspace.
> >>=20
> >> Has anyone compared UBAC vs RBAC now that the kernel and policy=20
> >> support roles on objects?  Is there a strong reason for refpolicy
> >> to stay with (3) other than compatibility with older
> >> distributions and this genhomedircon issue?
> >>=20
> >=20
> > Another likely issue is also with sudo.
> >=20
> > An unprivileged user (staff_u) runs sudo to change to root/sysadm_r
> > in order to create a file that should be accessible system wide.
> >=20
> > The file he created will end up with staff_u identity and IBACSEP
> > constrained processes might not be able to access it.
> >=20
> > This wouldnt be an issue with RBACSEP because the role is changed
> > to sysadm_r, which is not RBACSEP constrained. (no "privileged"
> > roles are constrained)
> >=20
> > This IBACSEP sudo issue can be avoided by using: `machinectl shell
> > .host` instead. which will change the context fully to
> > sysadm_u:sysadm_r:sysadm_t
> >=20
> > However that is more difficult to configure and depends on systemd
>=20
> Ok, so let's drop the unrelated change from the patch, resolve whether
> we want this to be enabled through semanage.conf or some other means,
> and get a final patch for it.  And then look in the future toward
> renaming things in a backward-compatible manner.

An issue with the semanage.conf option is that switching from an RBACSEP=20
policy to a non-RBACSEP policy (or vice versa) could result in no=20
homedir contexts being generated if semanage.conf isn't updated to=20
reflect that.  This was raised by one of the Gentoo guys r.e. users=20
installing policy packages.

So, thinking about the semanage.conf option with refactoring prefix to=20
something more suitable in the future in mind I came up with the=20
following:

We can drop the option and treat the "prefix" as a homedir role,=20
regardless of whether the policy implements RBACSEP or not.  In the=20
future this could either be object_r, or a RBACSEP constrained role (or=20
even an object role defined in policy with an identifier other than=20
object_r).  This way we can do the following checks before trying to=20
write out contexts to preserve backwards compatability:

1. Check if the given prefix is a valid role in the policy.
2. Check that the users list of roles contains the prefix, or that the=20
role is object_r.
3. Start writing contexts out as normal but with fixed roles.  If an=20
error is encountered with a generated context we can issue a warning=20
about it and skip that entry, preserving genhomedircons current behavior=20
(it's unlikely that we did not intend to use RBACSEP if we got this far,=20
since a users prefix typically wouldn't be the identifier of a valid=20
role).

If any of the checks leading up to 3 fail, we just write out the=20
contexts as we usually would without fixing the role.  This would=20
preserve backwards compatability and allow the old privsep model to work=20
just based on string substitution.

This approach also makes toggling RBACSEP support for homedirs from the=20
policy very easy with just a tunable:

(block user
     (user id)
     (role role)
     (userrole id role)

     (tunableif enable_rbacsep
         (true
             (userprefix id role)) # (userhomerole id role) ?
         (false
             (userprefix id object_r))))

I'm respinning my patch to see how that goes and will get it up later=20
today.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX7Gj7AAoJEHBu12WFqnnYPRwH/2Ibe1YzO5CBDqB4Zr1BZcL7
fewBIlpybbaywbbZMLvkmH09+X4hvg+yh0NN0jxGJqDSSMx2M52/k4ugMnlsy+2q
9DkyhZlDlDeunUtXLvwjOrV+E49eGcs00BDx/v28PqLjGMlig2D+8IFMbrcnLhxC
ksrqdvSxzPMvfytDB9zywkAGXFh3ByoCrWCW+tFowXXkceAiWzY9QzDXqCzlOk5J
qvRykpfXlpCmZrKJW8k743AfiW/N18+OAyeXKvEgeAYOzM4IHndrFdCUxqf8NXtq
2MKEAh/tBrOL+EuR5GxqAJbKd+SpkH8heTo1wG9jWziu19PRUJdDfTr+0uDIWqg=
=71Qg
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
