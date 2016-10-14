Subject: Re: ANN: SELinux userspace release
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
 <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
 <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
 <b0247b13-fc06-e22a-4788-8831a283fb54@gmail.com>
 <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <eb17bf61-e00e-7b7c-9073-527138aa6538@gmail.com>
Date: Fri, 14 Oct 2016 19:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j7IrNglM8VkHtqxu8eodgEo1gr1OLBsAP"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j7IrNglM8VkHtqxu8eodgEo1gr1OLBsAP
Content-Type: multipart/mixed; boundary="XpS5vN8RJ92OCTMawjs25vo2NIdaJTEpS";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <eb17bf61-e00e-7b7c-9073-527138aa6538@gmail.com>
Subject: Re: ANN: SELinux userspace release
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
 <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
 <213db96b-7274-bdbf-78dc-9418c1ed2566@tycho.nsa.gov>
 <b0247b13-fc06-e22a-4788-8831a283fb54@gmail.com>
 <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>
In-Reply-To: <bd7f3d99-cb86-183e-afb2-aef188d85adb@tycho.nsa.gov>

--XpS5vN8RJ92OCTMawjs25vo2NIdaJTEpS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 07:28 PM, Stephen Smalley wrote:
> On 10/14/2016 01:18 PM, Dominick Grift wrote:
>> On 10/14/2016 07:17 PM, Stephen Smalley wrote:
>>> On 10/14/2016 12:20 PM, Dominick Grift wrote:
>>>> On 10/14/2016 06:15 PM, Stephen Smalley wrote:
>>>>> On 10/14/2016 12:02 PM, Dominick Grift wrote:
>>>>>> On 10/14/2016 05:55 PM, Stephen Smalley wrote:
>>>>>>> The 2016-10-14 / 2.6 release for the SELinux userspace is
>>>>>>> now available at:=20
>>>>>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>>>>>
>>>>>>> This has been tagged as 20161014 in the git repository.
>>>>>>>
>>>>>>> Below are some notes on this release for packagers of
>>>>>>> the SELinux userspace.  Please see the individual
>>>>>>> ChangeLog files for a detailed list of changes.
>>>>>>>
>>>>>>> 1) sepolicy converted to setools4: - sepolicy and its=20
>>>>>>> users now depend on setools4 instead of setools3.
>>>>>>>
>>>>>>> - Please convert any remaining users of setools3 to=20
>>>>>>> setools4 since setools3 is no longer being developed.
>>>>>>>
>>>>>>> 2) genhomedircon enhancements and behavior changes: -=20
>>>>>>> genhomedircon supports the %{USERID} template for=20
>>>>>>> substituting the user's uid. %{USERNAME} has also been=20
>>>>>>> added as a new template for substituting the user's=20
>>>>>>> username.  The USER template is still supported for=20
>>>>>>> backward compatibility but is deprecated.
>>>>>>>
>>>>>>> - genhomedircon supports generating home directory=20
>>>>>>> contexts for login mappings using the %group syntax. This
>>>>>>> may produce an error if the user belongs to multiple=20
>>>>>>> groups specified in the login mapping, which can be=20
>>>>>>> resolved by adding an explicit mapping for the user to=20
>>>>>>> override the group-based mapping.
>>>>>>>
>>>>>>> - genhomedircon will fully replace the SELinux user and=20
>>>>>>> range fields in each templated security context rather=20
>>>>>>> than only substituting for the hardcoded strings=20
>>>>>>> "system_u" and "s0".  As a side effect, genhomedircon no=20
>>>>>>> longer has special handling of "system_u" and will=20
>>>>>>> therefore trigger a warning if there is a "system_u"=20
>>>>>>> entry in seusers: libsemanage.add_user: user system_u
>>>>>>> not in password file This warning is not fatal, but it
>>>>>>> would be preferable to remove system_u from the seusers
>>>>>>> file. See
>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1378204
>>>>>>>
>>>>>>> - genhomedircon will replace the role field in each=20
>>>>>>> templated security context with the user prefix for the=20
>>>>>>> user if the user prefix is the identifier of a role
>>>>>>> valid for the given user, or if it is "object_r". This
>>>>>>> enables configuring RBACSEP (i.e. role-based separation
>>>>>>> of user home directories) in policy.  If the user prefix
>>>>>>> is not a valid role, then genhomedircon will leave the
>>>>>>> role field unmodified as before.
>>>>>>>
>>>>>>
>>>>>> An issue was reported about genhomedircon with standard=20
>>>>>> policy model (non-mls), where no contexts were generated.
>>>>>>
>>>>>> I was able to reproduce this issue, and Gary produced a=20
>>>>>> patch to fix this. However the patch does not fully
>>>>>> address the issue, as it requires that one runs an
>>>>>> additional semodule -B to rerun genhomedircon.
>>>>>> genhomedircon does not generate the contexts the first time
>>>>>> around.
>>>>>
>>>>> Hmm..reported to whom, and where did this discussion take=20
>>>>> place? I have seen nothing on the list.  Would have been=20
>>>>> helpful to have reported it on the -rc releases.
>>>>
>>>> Someone using gentoo-hardened encountered the issue, and
>>>> gentoo maintainer told Gary about it on IRC. Two day's ago,
>>>> with a delay, I set out to reproduce the issue to confirm the
>>>> bug. I was planning to report this on the list but: I was not=20
>>>> expecting a release this soon, and I was hoping for a
>>>> revisited patch soon but it obviously delayed.
>>>>
>>>> So only two day's ago the bug was confirmed. We should have=20
>>>> reported then but we didn't
>>>
>>> Since I haven't seen the patch, I can't comment on it.  I would=20
>>> think one could simply test sepol_policydb_mls_enabled(policydb)=20
>>> in semanage_genhomedircon() to determine whether MLS is enabled,=20
>>> and then pass that result down as appropriate so that the=20
>>> underlying code could handle the MLS-disabled case correctly.
>>>
>>>
>>
>> This is the patch that does not fully address the issue
>>
>> https://github.com/garyttierney/selinux/commit/600f20e5ea50eaac919ad8f=
ee8987c6bdfa081e6.patch
>>
>>
>>
> I requires one additional "semodule -B" to make genhomedircon
>> generate the contexts. So it is only part of the fix. Also I=20
>> haven't tested the above patch in all scenarios (switching back
>> and forth between the various models)
>=20
> That's because it is testing the wrong policy.  As I said above, it
> needs to test sepol_policydb_mls_enabled(policydb) using the policydb
> passed to semanage_genhomedircon(), which is not yet the active
> policy.  Doing so is also more efficient since it avoids re-loading
> the policy from a file into memory.
>=20
>=20

Okay if you can provide me with a patch then I can test it to confirm
that it works on my end if needed. I don't think Gary is available right
now so it might take a bit for him to rewrite it.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--XpS5vN8RJ92OCTMawjs25vo2NIdaJTEpS--

--j7IrNglM8VkHtqxu8eodgEo1gr1OLBsAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYARXkAAoJECV0jlU3+Udp8BUL/i8u2IBj3IdVRw2VYFXL6u16
edqGrEPjg8h+bsK4k2sTe/qEUiSXiflOsp+RL50ZCYIiyBxGgjH3NGLJ+nw8Ww6O
it2xZiXH3OS6fSQ5XV2gDIb3v3Avl5saCsQ3WHBSrPzg32ghLvOWMLvDWSHhN4O4
j/znYGCCGEWKNH7pIMbp5/6R32YIP0AHeR5yWVUy9EeXCxs3oCv/U9CClWxgowwt
4aRQHnEO8ikXGpNH2M5wb187DVIgnKWhWz5mOWbSHY3MyVnOaQ80u36fQOIAZZfi
RDjxl1H4hDf+gH/Ftm3LWodQklNPYdxJzfM6LRV66EaTAN2+eXAGuHjjHGWqa/Dp
iHOkwhDxwwCMs2CdmvpHpZzDRJqTedo3NinlKEfGbGcfPZyBsQaQtmSLDu9v169s
vt/Nk48MZxe632klbqXS2/lGfR6L1QU1BSZKZLf+9f2yK05IR7vdFvjamQa1p6Qj
XaI8vdX/wPhxvqoSwgiAQNG/Fc5zsurCA2GVafvl6A==
=nqfn
-----END PGP SIGNATURE-----

--j7IrNglM8VkHtqxu8eodgEo1gr1OLBsAP--
