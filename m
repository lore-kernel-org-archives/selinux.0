Subject: Re: ANN: SELinux userspace release
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
 <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
 <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <b0247b13-fc06-e22a-4788-8831a283fb54@gmail.com>
Date: Fri, 14 Oct 2016 19:18:55 +0200
MIME-Version: 1.0
In-Reply-To: <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v8H6o0cKqKe9iIHC5fQXiP3I4AspvFHNl"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v8H6o0cKqKe9iIHC5fQXiP3I4AspvFHNl
Content-Type: multipart/mixed; boundary="hnhrfSFHnhNJ3D2surSQAXx4xuLviaj0M";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <b0247b13-fc06-e22a-4788-8831a283fb54@gmail.com>
Subject: Re: ANN: SELinux userspace release
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
 <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
 <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
In-Reply-To: <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>

--hnhrfSFHnhNJ3D2surSQAXx4xuLviaj0M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 07:17 PM, Stephen Smalley wrote:
> On 10/14/2016 12:20 PM, Dominick Grift wrote:
>> On 10/14/2016 06:15 PM, Stephen Smalley wrote:
>>> On 10/14/2016 12:02 PM, Dominick Grift wrote:
>>>> On 10/14/2016 05:55 PM, Stephen Smalley wrote:
>>>>> The 2016-10-14 / 2.6 release for the SELinux userspace is
>>>>> now available at:=20
>>>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>>>
>>>>> This has been tagged as 20161014 in the git repository.
>>>>>
>>>>> Below are some notes on this release for packagers of the=20
>>>>> SELinux userspace.  Please see the individual ChangeLog files
>>>>> for a detailed list of changes.
>>>>>
>>>>> 1) sepolicy converted to setools4: - sepolicy and its users
>>>>> now depend on setools4 instead of setools3.
>>>>>
>>>>> - Please convert any remaining users of setools3 to setools4=20
>>>>> since setools3 is no longer being developed.
>>>>>
>>>>> 2) genhomedircon enhancements and behavior changes: -=20
>>>>> genhomedircon supports the %{USERID} template for
>>>>> substituting the user's uid. %{USERNAME} has also been added
>>>>> as a new template for substituting the user's username.  The
>>>>> USER template is still supported for backward compatibility
>>>>> but is deprecated.
>>>>>
>>>>> - genhomedircon supports generating home directory contexts
>>>>> for login mappings using the %group syntax.  This may produce
>>>>> an error if the user belongs to multiple groups specified in
>>>>> the login mapping, which can be resolved by adding an
>>>>> explicit mapping for the user to override the group-based
>>>>> mapping.
>>>>>
>>>>> - genhomedircon will fully replace the SELinux user and
>>>>> range fields in each templated security context rather than
>>>>> only substituting for the hardcoded strings "system_u" and
>>>>> "s0".  As a side effect, genhomedircon no longer has special
>>>>> handling of "system_u" and will therefore trigger a warning
>>>>> if there is a "system_u" entry in seusers:
>>>>> libsemanage.add_user: user system_u not in password file This
>>>>> warning is not fatal, but it would be preferable to remove
>>>>> system_u from the seusers file. See=20
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1378204
>>>>>
>>>>> - genhomedircon will replace the role field in each
>>>>> templated security context with the user prefix for the user
>>>>> if the user prefix is the identifier of a role valid for the
>>>>> given user, or if it is "object_r". This enables configuring
>>>>> RBACSEP (i.e. role-based separation of user home directories)
>>>>> in policy.  If the user prefix is not a valid role, then
>>>>> genhomedircon will leave the role field unmodified as
>>>>> before.
>>>>>
>>>>
>>>> An issue was reported about genhomedircon with standard policy=20
>>>> model (non-mls), where no contexts were generated.
>>>>
>>>> I was able to reproduce this issue, and Gary produced a patch
>>>> to fix this. However the patch does not fully address the
>>>> issue, as it requires that one runs an additional semodule -B
>>>> to rerun genhomedircon. genhomedircon does not generate the
>>>> contexts the first time around.
>>>
>>> Hmm..reported to whom, and where did this discussion take place?
>>> I have seen nothing on the list.  Would have been helpful to
>>> have reported it on the -rc releases.
>>
>> Someone using gentoo-hardened encountered the issue, and gentoo=20
>> maintainer told Gary about it on IRC. Two day's ago, with a delay,
>> I set out to reproduce the issue to confirm the bug. I was planning
>> to report this on the list but: I was not expecting a release this
>> soon, and I was hoping for a revisited patch soon but it obviously
>> delayed.
>>
>> So only two day's ago the bug was confirmed. We should have
>> reported then but we didn't
>=20
> Since I haven't seen the patch, I can't comment on it.  I would think
> one could simply test sepol_policydb_mls_enabled(policydb) in
> semanage_genhomedircon() to determine whether MLS is enabled, and then
> pass that result down as appropriate so that the underlying code could
> handle the MLS-disabled case correctly.
>=20
>=20

This is the patch that does not fully address the issue

https://github.com/garyttierney/selinux/commit/600f20e5ea50eaac919ad8fee8=
987c6bdfa081e6.patch

I requires one additional "semodule -B" to make genhomedircon generate
the contexts. So it is only part of the fix. Also I haven't tested the
above patch in all scenarios (switching back and forth between the
various models)

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--hnhrfSFHnhNJ3D2surSQAXx4xuLviaj0M--

--v8H6o0cKqKe9iIHC5fQXiP3I4AspvFHNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYAROAAAoJECV0jlU3+UdpJQkMALJeuZjZi1uGrox6ATaWSWua
L4No41MGpixMNeTpG0UYom5+M49eMl9eg95mx2UwjrUxMIHmVs0o6AGZuxf81F7q
wyhFW4m8/u5oUpPJj7bqJVIjoQ6hIBI5/a6MQ+lNGHWSd51AmUFDW9nSFTMm37Uv
noOOuOiub8snyHvhGfrKoa8xYwmJu8VQKmorKMUq8dtMUPWDeKLdCPwg5aOiF7uP
7kfobJBgKgPxCM5yW+YYUXgoV9EsakZVzow7nK0unW3vNfuvKt7uiqZAuMRBCFq1
ExWHu/S353uliB90c0LNTTZs8viT5f7X68ue2in8KVo5QVo9hT1P/nHVAKX7WPoC
u/ZM67O+lSD5NcydaLQ+OhSFAOUbjo0BFjpYrcCqjlGmqg3n69nyHOzsPDbi4q1q
DaVZt/TWzeTPx5tVzTrXmGagxDFUyec1WsDjq7joYmzIoX+GwwSNmvrkG7UgxZxW
p3kddAI00DQ3oFV9czy9cz/PEIWIxUj81gOJgK43NA==
=R9L5
-----END PGP SIGNATURE-----

--v8H6o0cKqKe9iIHC5fQXiP3I4AspvFHNl--
