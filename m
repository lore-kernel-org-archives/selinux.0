Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3ACZCjW000541
 for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2018 08:35:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A919F8FD4
 for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2018 12:35:09 +0000 (UTC)
Received: from [10.43.12.93] (unknown [10.43.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 293AB2166BAD
 for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2018 12:35:08 +0000 (UTC)
To: selinux@tycho.nsa.gov
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
 <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
 <20180409125616.GA12076@gtierney.internal.digirati.com>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <38002f6d-9420-2498-6767-febcafc2faff@redhat.com>
Date: Tue, 10 Apr 2018 14:35:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180409125616.GA12076@gtierney.internal.digirati.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rihhdjU294WtdBmLkLMFSL0H5sRlbDPzU"
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rihhdjU294WtdBmLkLMFSL0H5sRlbDPzU
Content-Type: multipart/mixed; boundary="uaasuJKN6JmXlraJGojAvWhehC8PuXtct";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <38002f6d-9420-2498-6767-febcafc2faff@redhat.com>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
 <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
 <20180409125616.GA12076@gtierney.internal.digirati.com>
In-Reply-To: <20180409125616.GA12076@gtierney.internal.digirati.com>

--uaasuJKN6JmXlraJGojAvWhehC8PuXtct
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/09/2018 02:56 PM, Gary Tierney wrote:
> On Mon, Apr 09, 2018 at 01:41:12PM +0200, Lukas Vrabec wrote:
>=20
> ... snip ...
>=20
> Those wiki pages on SELinuxProject/cil are now pretty out of date
> (you'll notice that some other statements mentioned there like
> `template` are not implemented as well).=C2=A0 The updated documentatio=
n is
> at https://github.com/SELinuxProject/selinux/tree/master/secilc/docs.
>=20
>> Hi Dominick,
>>
>> Yes, This is one of the options to create hierarchy when the block on
>> top will have just minimum rules and every child block will append new=

>> rules.
>>
>> Unfortunately, this probably won't work in real world. Let's say that =
I
>> have this hierarchy and badlogger block contains several allow rules a=
nd
>> I want to inherit all of them except one, *BUT* I'm not SELinux policy=

>> expert and don't know how hierarchy looks like. That's the reason why
>> I'm looking for blockinheritfilter.
>>
>=20
> I think it's more reasonable for someone not intimate with the policy t=
o
> familiarize themselves with the hierarchy/composition of a well structu=
red
> policy, rather than what they may need to disallow in a given scope
> (which may
> come from other inherited blocks, calls to macros, or `in` statements
> scattered
> across several policy modules).=C2=A0 This means they can compose their=

> policy out
> of high level building blocks rather than low level allow rules (which
> arguably
> would require a policy expert to fully understand the implications of).=

>=20
> "blockinheritfilter" also seems to be at odds with the permission
> whitelisting/deny-by-default model of SELinux by having the policy auth=
or
> revoke permissions rather than permit them.
>=20

Understand.

Thank you for clarification.

Lukas.

> Thanks,
> Gary.
>=20
>> However, we should go via creating block namespaces hierarchy as you
>> described if there are no plans to implement this feature.
>>
>> Thanks,
>> Lukas.
>>
>>
>> --=C2=A0
>> Lukas Vrabec
>> Software Engineer, Security Technologies
>> Red Hat, Inc.
>>
>=20


--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--uaasuJKN6JmXlraJGojAvWhehC8PuXtct--

--rihhdjU294WtdBmLkLMFSL0H5sRlbDPzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAlrMr3wACgkQRyAaxC8p
zgbDIQgArLiUF+EKR9gtZkJnsteOJp189Hz2hX0QhyWzQ5z8vLuenuluPpqtAiug
nnVz+6SdotDDWp4jrOdi93j0hmZWb34HZOYmHx+WFoZjHWcbdR9j9WekdLWu1USb
CrF7qIL6NUm4bjVMa7mi17iRpMOxATsa9coBbKFmuTUIvvbW5mjzRyTYf6QZncod
ja0YPdi2BmyNqy1GUM273FXcCwTI61KWv5YQtX2un8l1FmuICBuWc9Fv39Y44Opq
l+QaY3tLaDwalKjgIfmmhxPaj1jd+4Tt5l9Z33egpPEnrarSV3p3qLOwQ6BzUx4f
SkE8bIXiKVBd+SLdJ/Wal8fhCWsYNA==
=I/0E
-----END PGP SIGNATURE-----

--rihhdjU294WtdBmLkLMFSL0H5sRlbDPzU--
