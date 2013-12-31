Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBVIqpYu030387
 for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2013 13:52:51 -0500
Received: from [10.0.3.42] (unknown [10.0.3.42])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.mthode.org (Postfix) with ESMTPSA id 5853E14703
 for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2013 13:55:49 -0500 (EST)
Message-ID: <52C31282.6080809@mthode.org>
Date: Tue, 31 Dec 2013 12:52:50 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org> <52C27333.3060801@networkcrypt.com>
In-Reply-To: <52C27333.3060801@networkcrypt.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BJEiHG28qxlhvRMos8phAIVECu4Ff4rSH"
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJEiHG28qxlhvRMos8phAIVECu4Ff4rSH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/31/2013 01:33 AM, Francis Cunnane wrote:
> What do you propose....  This is free software.... Don't be a Jew.
>=20
>   On 12/30/2013 7:11 PM, Matthew Thode wrote:
>> On 12/30/2013 10:11 AM, Stephen Smalley wrote:
>>> Calling *setfilecon() with a NULL context is a bug in the caller, jus=
t
>>> like calling strlen() with a NULL string.
>>> Fix the callers, please.
>>>
>>> On Wed, Dec 25, 2013 at 9:36 AM, Nicolas Iooss
>>> <nicolas.iooss@m4x.org> wrote:
>>>> 2013/12/23 Daniel J Walsh wrote:
>>>>> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
>>>>>> My first message was not so clear. The check in
>>>>>> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
>>>>>> selinux_trans_to_raw_context(context, &rcontext) returns 0 and set=
s
>>>>>> rcontext to NULL. This is why I'm asking to change the return
>>>>>> value to
>>>>>> something else if you want "cp -a" working. This fix is not to
>>>>>> introduce a
>>>>>> new feature but to fix an existing one.
>>>>>>
>>>>>> Nicolas
>>>>>>
>>>>> How about if we add a check on lsetfilecon_raw?  Changing the
>>>>> behaviour on
>>>>> selinux_trans_to_raw_context might cause other problems.
>>>> I agree. I've found
>>>> http://selinuxproject.org/page/LibselinuxAPISummary which says
>>>> precisely for selinux_trans_to_raw_context: "If passed NULL, sets th=
e
>>>> returned context to NULL and returns 0." As this feature is
>>>> documented, callers may rely on it and changing this behavior is
>>>> likely to break things.
>>>>
>>>> Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-point=
er
>>>> dereference issue. Do these functions need a patch too?
>>>>
>>>> By the way, other callers of selinux_trans_to_raw_context may also
>>>> share this bug: avc_context_to_sid, security_canonicalize_context,
>>>> security_check_context, etc. Is doing a segmentation fault the
>>>> expected way to tell the caller it used a NULL pointer and should ha=
ve
>>>> manually checked every parameter before calling any libselinux
>>>> function?
>>>>
>>>> Thanks and merry Christmas!
>>>>
>>>> Nicolas
>>>>
>>>>>
>>>>> diff --git a/libselinux/src/lsetfilecon.c
>>>>> b/libselinux/src/lsetfilecon.c
>>>>> index 461e3f7..af3775e 100644
>>>>> - --- a/libselinux/src/lsetfilecon.c
>>>>> +++ b/libselinux/src/lsetfilecon.c
>>>>> @@ -9,6 +9,10 @@
>>>>>
>>>>>   int lsetfilecon_raw(const char *path, const security_context_t
>>>>> context)
>>>>>   {
>>>>> +       if (! context) {
>>>>> +               errno=3DEINVAL;
>>>>> +               return -1;
>>>>> +       }
>>>>>          return lsetxattr(path, XATTR_NAME_SELINUX, context,
>>>>> strlen(context) + 1
>>>>>                           0);
>>>>>   }
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>> I think I may have hit this bug as well.
>>
>> https://bugs.gentoo.org/show_bug.cgi?id=3D495274
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>=20
>=20
>=20
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
If I had any more info in the bug report then what was mentioned here,
it was meant to help.  Also, on vacation, so won't be of much help this
week :P

--=20
-- Matthew Thode


--BJEiHG28qxlhvRMos8phAIVECu4Ff4rSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwxKIAAoJECRx6z5ArFrDBY8QANB6slPWYOPPL8E0xCbJ/a2G
uWkbNjTBlWdHiaGUW2ikkq7Pnjtl0XoFxgnphj6+eZHd19N7mOxiqqK3q9f0JmZ5
NDCS/OvW2u5zlTPoZfN4LD5fa1i+SchjssbbFXfZDXL0fsB6OP8eT2dWgTUuPCxQ
JTAc2eDH4F/PAy/bjo4iF4uGPHH4S2VOtk4hZygA6RStPfrA8UuGg+EKckIAJyuE
031UW+/4WvTEIYDX3GU5Q29AcZNZoKzC90GH+xBRcZdsLFydGMgBT/ZmRdJKygDC
hamWuNA833t+WVJq2Hxb2b6EqAgeDffjAzuiT4t8sHdsn3ouD7Lzon1fCGOYrdyS
BM+zGOjg93bYLgDviByLHYvYXVRGVtpT8S1IJ0TtG9fmvIkMPdzTJD246hvND+pK
YEs9IkyuhK3ZFHqBxVd0at6XAnejHIRE07UBZE56qGLJnvb52g1tKYJSqIEvZ429
M8l5qoUbJTAbT/PKrKhyr72/MxyBbNNKWbrbwSHhOz4cklrUWVF3f63J3EXp/Q/1
huvLJ1G+/XG6J4FFFKm05xl2uHuaZFFjhBJ/pX6tYDHIRqrgeWpIrkM3vOKsfwbH
ErBUqo4jWIeo10ZF6/sO8m/bc2WTOJJJUTLb+nD5A1NEyTMwPVIwbLCPG3mMy5zX
oUAyGNSOuJRAyJHwz7Mb
=hUXc
-----END PGP SIGNATURE-----

--BJEiHG28qxlhvRMos8phAIVECu4Ff4rSH--
