Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBV3BANw024848
 for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2013 22:11:11 -0500
Received: from [10.0.3.42] (unknown [10.0.3.42])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.mthode.org (Postfix) with ESMTPSA id 7BB5DB734
 for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2013 22:14:10 -0500 (EST)
Message-ID: <52C235CA.2010607@mthode.org>
Date: Mon, 30 Dec 2013 21:11:06 -0600
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
In-Reply-To: <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6ddrcBlM8odD6tJ19K1K3h16giF1pT7C6"
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ddrcBlM8odD6tJ19K1K3h16giF1pT7C6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/30/2013 10:11 AM, Stephen Smalley wrote:
> Calling *setfilecon() with a NULL context is a bug in the caller, just
> like calling strlen() with a NULL string.
> Fix the callers, please.
>=20
> On Wed, Dec 25, 2013 at 9:36 AM, Nicolas Iooss <nicolas.iooss@m4x.org> =
wrote:
>> 2013/12/23 Daniel J Walsh wrote:
>>>
>>> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
>>>> My first message was not so clear. The check in
>>>> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
>>>> selinux_trans_to_raw_context(context, &rcontext) returns 0 and sets
>>>> rcontext to NULL. This is why I'm asking to change the return value =
to
>>>> something else if you want "cp -a" working. This fix is not to intro=
duce a
>>>> new feature but to fix an existing one.
>>>>
>>>> Nicolas
>>>>
>>>
>>> How about if we add a check on lsetfilecon_raw?  Changing the behavio=
ur on
>>> selinux_trans_to_raw_context might cause other problems.
>>
>> I agree. I've found
>> http://selinuxproject.org/page/LibselinuxAPISummary which says
>> precisely for selinux_trans_to_raw_context: "If passed NULL, sets the
>> returned context to NULL and returns 0." As this feature is
>> documented, callers may rely on it and changing this behavior is
>> likely to break things.
>>
>> Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-pointer=

>> dereference issue. Do these functions need a patch too?
>>
>> By the way, other callers of selinux_trans_to_raw_context may also
>> share this bug: avc_context_to_sid, security_canonicalize_context,
>> security_check_context, etc. Is doing a segmentation fault the
>> expected way to tell the caller it used a NULL pointer and should have=

>> manually checked every parameter before calling any libselinux
>> function?
>>
>> Thanks and merry Christmas!
>>
>> Nicolas
>>
>>>
>>>
>>> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfileco=
n.c
>>> index 461e3f7..af3775e 100644
>>> - --- a/libselinux/src/lsetfilecon.c
>>> +++ b/libselinux/src/lsetfilecon.c
>>> @@ -9,6 +9,10 @@
>>>
>>>  int lsetfilecon_raw(const char *path, const security_context_t conte=
xt)
>>>  {
>>> +       if (! context) {
>>> +               errno=3DEINVAL;
>>> +               return -1;
>>> +       }
>>>         return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(co=
ntext) + 1
>>>                          0);
>>>  }
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
I think I may have hit this bug as well.

https://bugs.gentoo.org/show_bug.cgi?id=3D495274

--=20
-- Matthew Thode


--6ddrcBlM8odD6tJ19K1K3h16giF1pT7C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwjXVAAoJECRx6z5ArFrDkj0QAIJwOytwT8QZ6ro3G9mN9C+m
Dkin1sRxFdJrT1cwBZOSy/4y8zhesjWsE0zt+ucyQpQDw7x2/pZqs/9EKjMssYeS
9sqsP36gTfxzTxmLU2K3JheWm5IJrHcVhaecOD/GauM6/VZo3GfwELnxd8ky47gZ
jWkJgUC9utA/NJK5ML6H52SX8UQsCHZp6SwcM1p4X2bx+BgfV4ucb6ZCq7LZ9HwF
Br192YYVTdF47ZMIEOeY26RelNFbguleOI0tMCm56Ft+qWkqDQAIeFcfuZcvYO+5
DyDybvyQKGH1R2YV2oMLWZIES9oxH+8bu8vHfFPRbVQQjvn25CFCdobxQ3PvjVM4
zwHfCwE2fQtTG4a7gyI+EfH+cLhrVkaJ1qSJJG/v3FprNLcZ1a94v1v+HZybD/hd
UgnQsxjkFiGV3IdJIPY/WaV8CAg+RsSqYTTYcdyUkvZO7JGXfGVxRfpkZI9qBKsx
NeFKKJxBT3J1z0LaRs3QSUQJBoAbWZTmyTA1Y8f7uJ/w+Wl+KNJ94KoYZ4POY+50
sFbbEYiJRrhO3rw1NClDtTFrXfa4apULbIQc+ZE5egctepNbOAbHNwGWVW2Sm/W/
NCO5kN7thP8nBirE6XpZan8tStzGKDjYQdUibHEYBfpTsIYAVS9MVAidG/a5khYq
JXeqEqnBNsqsbO6qsNKx
=Mfac
-----END PGP SIGNATURE-----

--6ddrcBlM8odD6tJ19K1K3h16giF1pT7C6--
