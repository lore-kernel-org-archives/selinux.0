Subject: Re: ANN: SELinux userspace release
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
Date: Fri, 14 Oct 2016 18:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rWm9NDkjCFH1t6rN0dsQoVVL4j7mI7XCn"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWm9NDkjCFH1t6rN0dsQoVVL4j7mI7XCn
Content-Type: multipart/mixed; boundary="4sGVBhp3B9IFu5So0EW3AEwMDDKik2JiF";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <629e4cb0-52ae-fdf0-6415-1cfdbd253b12@gmail.com>
Subject: Re: ANN: SELinux userspace release
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
 <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
 <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>
In-Reply-To: <3c05e0f9-eef9-0290-97f0-fb2a1730d02c@tycho.nsa.gov>

--4sGVBhp3B9IFu5So0EW3AEwMDDKik2JiF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 06:15 PM, Stephen Smalley wrote:
> On 10/14/2016 12:02 PM, Dominick Grift wrote:
>> On 10/14/2016 05:55 PM, Stephen Smalley wrote:
>>> The 2016-10-14 / 2.6 release for the SELinux userspace is now
>>> available at:=20
>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>
>>> This has been tagged as 20161014 in the git repository.
>>>
>>> Below are some notes on this release for packagers of the
>>> SELinux userspace.  Please see the individual ChangeLog files for
>>> a detailed list of changes.
>>>
>>> 1) sepolicy converted to setools4: - sepolicy and its users now
>>> depend on setools4 instead of setools3.
>>>
>>> - Please convert any remaining users of setools3 to setools4
>>> since setools3 is no longer being developed.
>>>
>>> 2) genhomedircon enhancements and behavior changes: -
>>> genhomedircon supports the %{USERID} template for substituting
>>> the user's uid. %{USERNAME} has also been added as a new template
>>> for substituting the user's username.  The USER template is still
>>> supported for backward compatibility but is deprecated.
>>>
>>> - genhomedircon supports generating home directory contexts for
>>> login mappings using the %group syntax.  This may produce an
>>> error if the user belongs to multiple groups specified in the
>>> login mapping, which can be resolved by adding an explicit
>>> mapping for the user to override the group-based mapping.
>>>
>>> - genhomedircon will fully replace the SELinux user and range
>>> fields in each templated security context rather than only
>>> substituting for the hardcoded strings "system_u" and "s0".  As a
>>> side effect, genhomedircon no longer has special handling of
>>> "system_u" and will therefore trigger a warning if there is a
>>> "system_u" entry in seusers: libsemanage.add_user: user system_u
>>> not in password file This warning is not fatal, but it would be
>>> preferable to remove system_u from the seusers file. See
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1378204
>>>
>>> - genhomedircon will replace the role field in each templated
>>> security context with the user prefix for the user if the user
>>> prefix is the identifier of a role valid for the given user, or
>>> if it is "object_r". This enables configuring RBACSEP (i.e.
>>> role-based separation of user home directories) in policy.  If
>>> the user prefix is not a valid role, then genhomedircon will
>>> leave the role field unmodified as before.
>>>
>>
>> An issue was reported about genhomedircon with standard policy
>> model (non-mls), where no contexts were generated.
>>
>> I was able to reproduce this issue, and Gary produced a patch to
>> fix this. However the patch does not fully address the issue, as it
>> requires that one runs an additional semodule -B to rerun
>> genhomedircon. genhomedircon does not generate the contexts the
>> first time around.
>=20
> Hmm..reported to whom, and where did this discussion take place?  I
> have seen nothing on the list.  Would have been helpful to have
> reported it on the -rc releases.

Someone using gentoo-hardened encountered the issue, and gentoo
maintainer told Gary about it on IRC. Two day's ago, with a delay, I set
out to reproduce the issue to confirm the bug. I was planning to report
this on the list but: I was not expecting a release this soon, and I was
hoping for a revisited patch soon but it obviously delayed.

So only two day's ago the bug was confirmed. We should have reported
then but we didn't

>=20
> Maybe we ought to just make MLS mandatory / always enabled; it is
> relied upon by various userspace components these days for MCS (e.g.
> sandbox, libvirt/svirt, openshift, etc) and most of us are only
> testing the MLS-enabled code paths since it is always enabled in
> Fedora, RHEL, and Android at least.
>=20
>>
>>> - genhomedircon will generate entries for logins mapped to the
>>> default user.  Previously no entries were generated for such
>>> logins, which could lead to no matching file_contexts.homedirs
>>> entries for users with home directories outside of
>>> LU_HOMEDIRECTORY in the absence of usepasswd=3DTrue.
>>>
>>> 3) libselinux pcre2 support: - libselinux supports either pcre1
>>> or pcre2 but not both at the same time. The default remains
>>> pcre1.
>>>
>>> - To use pcre2, build libselinux and sefcontext_compile with
>>> 'make USE_PCRE2=3Dy". You must also rebuild your file_contexts.bin
>>> files with the rebuilt sefcontext_compile.
>>>
>>> - With pcre2, file_contexts.bin is no longer
>>> architecture-neutral. The relevant architecture properties are
>>> endianness, pointer width, and PCRE2_SIZE type.  libselinux will
>>> automatically detect an architecture mismatch and ignore the
>>> stored precompiled regexes in that case, recompiling them instead
>>> at runtime.  sefcontext_compile -i will report the pcre version
>>> and architecture strings that it will include in the=20
>>> file_contexts.bin file.
>>>
>>> - With pcre2, file_contexts.bin is substantially larger than for
>>> pcre1. With the Fedora policy, we see the following sizes: 383165
>>> file_contexts (text) 1507941 file_contexts.bin (binary with pcre1
>>> regexes) 8304105 file_contexts.bin (binary with pcre2 regexes)
>>>
>>> - If you know that you will be generating file_contexts.bin for a
>>> target with a different architecture string or if you do not wish
>>> to pay the additional storage cost, you can use the -r option to
>>> sefcontext_compile to omit the compiled regexes. With the Fedora
>>> policy, this yields a much smaller file: 540540 file_contexts.bin
>>> (binary omitting pcre2 regexes) You can make this the default
>>> when libsemanage invokes sefcontext_compile by adding the
>>> following stanza to semanage.conf: [sefcontext_compile] path =3D
>>> /usr/sbin/sefcontext_compile args =3D -r $@ [end]=20
>>> _______________________________________________ Selinux mailing
>>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>>> containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>>
>>
>> _______________________________________________ Selinux mailing
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>> "help" to Selinux-request@tycho.nsa.gov.
>>
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--4sGVBhp3B9IFu5So0EW3AEwMDDKik2JiF--

--rWm9NDkjCFH1t6rN0dsQoVVL4j7mI7XCn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYAQXJAAoJECV0jlU3+UdpsxkL/RiecvZBemk1AMsEntux1LXJ
Hc9ue1F0pVnJJKkhztMIaA5Ad4ptmRzVioxx4W07i4FAWz3xgb03ykuxkowRNz/S
TYauPwJid51iNFYJDbG75dlkYPjc3IPbTkIhawuVypHEe2k+1WqyNw6hhO8f9IeY
Bb5XkjT9ODUGoiz1m2vKA1JlQN+CTm1DlAd76m2rBmSu35GTCPXr3lL6kZSTA+A4
WAKCPj+fzqtr2R2WoO+6VOQJYOnnN04kF7yXcPgf3JIFYkulCqQKeFpIpTr5B2ey
ZEqIIXTGSUdXZ955p5jFcSomhTlSNiF5OP1wwha/SsTH5RtCfVDUPs5hflmQ3rX0
/mO4nVJ2g6UnnncYUIOhio5/L58qYzD4KQTPPYksfw60CAEf0i4Y5sFpVaHYL8J8
W7bWuo7bSx6txN41Tmd9wJAA5tItZqp8PSX80SAMUKg5y7If+Fi5bQe9d/kcOM66
/pZGXoRLS87U0IRUgny28IQ+66vRqSeMhHKN4jTYWg==
=tEPK
-----END PGP SIGNATURE-----

--rWm9NDkjCFH1t6rN0dsQoVVL4j7mI7XCn--
