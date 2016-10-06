Subject: [SUSPECTED SPAM] [SUSPICIOUS MESSAGE] Re: [PATCH v2 0/1] supporting
 RBACSEP in genhomedircon
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <cover.1475590141.git.gary.tierney@gmx.com>
 <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
 <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
 <afc6d84a-04be-6583-1ea7-00ba028cda1f@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <ac87a398-9262-4496-8cdd-c349845fce55@gmail.com>
Date: Thu, 6 Oct 2016 19:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <afc6d84a-04be-6583-1ea7-00ba028cda1f@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EFsdVi0Cu9wgSQRhFU2BphP3XejLFijAP"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EFsdVi0Cu9wgSQRhFU2BphP3XejLFijAP
Content-Type: multipart/mixed; boundary="NR1usmlMRtmcRD17Pjr0q7FH718Or0MT6";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <ac87a398-9262-4496-8cdd-c349845fce55@gmail.com>
Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
References: <cover.1475590141.git.gary.tierney@gmx.com>
 <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
 <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
 <afc6d84a-04be-6583-1ea7-00ba028cda1f@tycho.nsa.gov>
In-Reply-To: <afc6d84a-04be-6583-1ea7-00ba028cda1f@tycho.nsa.gov>

--NR1usmlMRtmcRD17Pjr0q7FH718Or0MT6
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"

On 10/06/2016 06:49 PM, James Carter wrote:
> On 10/06/2016 11:29 AM, Dominick Grift wrote:
>> On 10/06/2016 04:56 PM, James Carter wrote:
>>> On 10/06/2016 07:09 AM, Gary Tierney wrote:
>>>> New version of the previous genhomedircon-rbacsep patch with some
>>>> changes.  A
>>>> bit of a delay as I had to get in a libsepol/cil fix which was
>>>> blocking this.
>>>>
>>>> 1. Remove semanage.conf option
>>>> 2. Drop unrelated change
>>>> 3. Adds a new homedir_role member to the genhomedircon_user struct.
>>>> 4. Sets homedir_role if the SELinux users prefix is a valid role for
>>>> that user.
>>>> 5. Replaces all roles with homedir_role in context specifications if
>>>> homedir_role is set.
>>>>
>>>> One issue that came up when writing these patches is that genhomedircon
>>>> squashes logging [1] for some reason, which can result in no warning /
>>>> info
>>>> messages and an empty file_contexts.homedirs file if policy has been
>>>> incorrectly configured.  Can we get rid of this behavior or add a
>>>> flag to
>>>> conditionally enable logging?
>>>>
>>>> Dominick Grift helpfully created some test images that demo DSSP
>>>> policy working
>>>> with both RBACSEP and non-RBACEP:
>>>> https://secure-web.cisco.com/1em6l9je6cqcAfGQVqhiZiKLtU_K4PYkUi5VPpxqp=
iJ0xFDQJUnis-aED9BTadea2qheKi_0jaAflaiNJ6ocv9AJLowENdrpAIfdNAmv61QfkK7Qr23G=
GrqF2O80Zrc4fxNfK-JxffEi4s972g2yKtY3E2AE9JvP0FUv-DoidzmJjIO3AmbLgIXJjwVrcqL=
Gn0zgqLpR7qomQI0GXEJt4Rasx3UCy7RWTLj_lBAwSJyl2pLwGqs6DnQpmhT5ne2upcAdAZdU8d=
xQmnXEHIokDLdfHJXySjUj9CFBW1-Tk_ao/https%3A%2F%2Ftfirg.asu.su%2F2016%2F10%2=
F03%2Fgarys-patches%2F
>>>>
>>>> There are still some rough edges though, for example in policy you
>>>> can't write a
>>>> statement like: (userprefix id role) and put it in an abstract
>>>> namespace,
>>>> since it is interpreted as a literal:
>>>>
>>>> (block usersubj
>>>>     (blockabstract usersubj)
>>>>     (user id)
>>>>     (role role)
>>>>     (userrole id role)
>>>>     (userprefix id role))
>>>>
>>>> (block wheel
>>>>     (blockinherit usersubj))
>>>>
>>>> Which leaves us with a (userid, prefix) tuple of (wheel.id, role)
>>>> [wheel.id
>>>> might even just be id here, haven't checked if users are expanded or
>>>> also taken
>>>> as literals].
>>>>
>>>
>>> Users are fully qualified, so it is "wheel.id". It is true though that
>>> "role" in "(userprefix id role)" is taken as a string and is not
>>> expanded. The only identifiers that are fully qualified are those that
>>> will exist in the kernel policy and are stored in symbol tables.
>>>
>>> To get what you want you need to write:
>>>
>>> (block usersubj
>>>     (blockabstract usersubj)
>>>     (user id)
>>>     (userlevel id (SENS))
>>>     (userrange id ((SENS)(SENS (CAT))))
>>>     (role role)
>>>     (userrole id role))
>>>
>>> (block wheel
>>>     (blockinherit usersubj))
>>>
>>> (userprefix wheel.id wheel.role)
>>>
>>> which is inconvenient. It seems to me that if the userprefix statement
>>> is allowed in a block, then it makes sense to fully qualify it, but I
>>> tend to see the prefix as a string, so it would make more sense to me to
>>> just not allow it in blocks.
>>
>> It use to be a string, but that is no longer true with this patch. It is
>> a role now. In my view it should be treated as such
>=20
> This patch does not exactly make it a role. It treats it as a role if
> the prefix matches a valid role. The CIL compiler cannot assume that the
> prefix is a role. CIL could check to see if the prefix matches a role
> and fully qualify it if it does, but if it didn't match then it wouldn't
> be fully qualified and that doesn't seem like the desired behavior.
>=20

Thanks for clarifying. Maybe we should then just leave it a "string". It
is kind of a special "libsemanage" only thingy. So i don't really mind
giving it the special "libsemanage" treatment in DSSP. It's not pretty
in particular but it is not that ugly either.

> Jim
>=20
>>
>>>
>>> This makes more sense in the following example.
>>>
>>> (block userdecl
>>>     (blockabstract userdecl)
>>>     (user u)
>>>     (userlevel u (SENS))
>>>     (userrange u ((SENS) (SENS (CAT))))
>>>     (role r)
>>>     (userrole u r))
>>>
>>> (block user
>>>     (blockinherit userdecl))
>>>
>>> (userprefix user.u user)
>>>
>>> Where user is acting like a true prefix for user user.u and role user.r.
>>>
>>> Jim
>>>
>>>
>>>> Though this is something I can look at later if all is well here.
>>>>
>>>> [1]
>>>> https://secure-web.cisco.com/1iokgtqyM7Itorx97YhxU8Y8BPLgnjhdbqw6zxi_8=
hNknLJZx7ewWbWlxADD-Yf0luWHa_y6s01T-ngCV3fJ_U6nEqsvl6lXoXC2dm2zkY0pNleYg5DK=
jNMpcc60QnNRbO6XqutpZW0wqX0S6P_71J-E8rijBcVKVU0Jn35ArI4axuTiHzajjpc7GNh7r-8=
CZ-nPQDDMhNpo8JAm79rLCLLMe6hIKimqLzrvU8zvY4VDs1MqXVTLK0OXmfHGle_Y1/https%3A=
%2F%2Fgithub.com%2FSELinuxProject%2Fselinux%2Fblob%2Fmaster%2Flibsemanage%2=
Fsrc%2Fgenhomedircon.c#L568-L572
>>>>
>>>>
>>>>
>>>> Gary Tierney (1):
>>>>   genhomedircon: use userprefix as the role for homedir content
>>>>
>>>>  libsemanage/src/genhomedircon.c | 38
>>>> +++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>>
>>>
>>>
>>
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://secure-web.cisco.com/1RffBy8ro4_7atpp_kZh99MO_w3OPOwZuDujOr9hNlZQvn=
t7Xt3YyBc3l7bFjyerbhwj6-l0IjtuC8T9e3o5TxP6MRQA5ViyYPsfKbh1KJJ2CilbEKrQcOalr=
lZKMeoO2R7Et_r85N0tADBP3mgB2lz-qE3UgR_oHuVVbasNViEcyWs57hVJPeLrW8GFXZnLKG6Q=
vjr6O6ir3KMTg820_UJNcKorXtXEYIkJI1UJ-1TOS-QUkr5hd8kL3JlRQWU1R/https%3A%2F%2=
Fsks-keyservers.net%2Fpks%2Flookup%3Fop%3Dget%26search%3D0x3B6C5F1D2C7B6B02
Dominick Grift


--NR1usmlMRtmcRD17Pjr0q7FH718Or0MT6--

--EFsdVi0Cu9wgSQRhFU2BphP3XejLFijAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX9oiRAAoJECV0jlU3+UdpPRcMAKLGpO9cS6Tg8P2l0sJ5VXUe
c1grMHuZtO1SdN+7ru3YOWbK2FCj4f3EpFhjP3SZpdqi65WAWnJpiSI+/nE6/AfJ
ZmVsk8mgSJ2BkuAo8ytnXHZJIIerOYwIG9ZHdHAHzb98Dxi88Yz1WbtlymPi4MHs
lfd1e5yfpj6fWq5YnbkNodBR2h3GisccOpOfldIdbPEqVVEbeNDSL48co8wTqlWb
Oua3Nj8MXkN5WlJpM9c3HoLMk+xTpOUglsIQ6qe5q2s2OMNMHvLIdg+2F98+eefX
eKHYi/DkqTVs21zlM+ZYeks0Hx9nAtlMGX1uxijMuLb7vNad0SPS/yu/Ii7E4wHC
jg3ZwazOkJLCcmsXki6CP2TieLH9AIeU1+CD8rI+T9ptsX2j1gzszBY+eeOt+O9h
HUzZV4j45apCujFi2Ga4HIlsYlMSksmNMe6N4yLbv8SzSAjE+JZrrjP2KS3aLLcK
R4dVdm4xeEJe2a4jCcgHNx1ziADe0/sxCDGkDrj77Q==
=5o9h
-----END PGP SIGNATURE-----

--EFsdVi0Cu9wgSQRhFU2BphP3XejLFijAP--
