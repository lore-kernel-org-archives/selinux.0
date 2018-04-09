Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39BfJAJ015283
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 07:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D4A776FB9
 for <selinux@tycho.nsa.gov>; Mon,  9 Apr 2018 11:41:13 +0000 (UTC)
Received: from [10.43.12.93] (unknown [10.43.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FFB410F1C0B
 for <selinux@tycho.nsa.gov>; Mon,  9 Apr 2018 11:41:12 +0000 (UTC)
To: selinux@tycho.nsa.gov
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
Date: Mon, 9 Apr 2018 13:41:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180409084124.GB2087@julius.enp8s0.d30>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uxJO7qZfkNYDWmigrriNIieWmLuBGvHEU"
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uxJO7qZfkNYDWmigrriNIieWmLuBGvHEU
Content-Type: multipart/mixed; boundary="IaVLeuTrkTSvsdYL1CRdPaWqkOWz4KnLS";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
In-Reply-To: <20180409084124.GB2087@julius.enp8s0.d30>

--IaVLeuTrkTSvsdYL1CRdPaWqkOWz4KnLS
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/09/2018 10:41 AM, Dominick Grift wrote:
> On Mon, Apr 09, 2018 at 09:55:23AM +0200, Dominick Grift wrote:
>> On Sun, Apr 08, 2018 at 11:00:53PM +0200, Lukas Vrabec wrote:
>>> Hi All,
>>>
>>> I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESI=
GN"
>>> wiki page [1] and I'm interested in CIL namespaces. I tried several
>>> examples related to blockinheritence and all works just great!
>>>
>>> However, in following example I see keyword "blockinheritfilter":
>>>
>>> (block logger
>>> 	(blockabstract logger)
>>> 	(type process)
>>> 	(type log)
>>> 	(allow process log (file (getattr append write))))
>>>
>>> (block myapp
>>> 	(blockinherit logger)
>>> 	(blockinheritfilter myapp logger
>>> 		(allow process log (file (write)))))
>>>
>>
>> The example above actually demonstrates that you do not need blockinhe=
ritfilter (and should not use it for this example), instead you can just =
append rules to blocks.
>>
>> loggers should not open the log file for write and so the main templat=
e should not include that permission in the first place:
>>
>> (block logger                                                      =20
>>        (blockabstract logger)                                       =20
>>        (type process)                                               =20
>>        (type log)                                                   =20
>>        (allow process log (file (getattr append))))
>>
>> Then if you have a misbehaving logger you can just append the bad rule=
 to that block:
>>
>> (block badlogger
>>        (blockinherit logger)
>>        (allow process log (file (write)))))
>=20
> Or even:
>=20
> (block logger                                                      =20
>        (blockabstract logger)
>        (type process)
>        (type log)
>        (allow process log (file (getattr append))))=20
>=20
> (block badlogger                                                     =20
>        (blockabstract badlogger)
>        (blockinherit logger)
>        (allow process log (file (write))))=20
>=20
> (block yourlogger
>        (blockinherit badlogger))
>=20

Hi Dominick,

Yes, This is one of the options to create hierarchy when the block on
top will have just minimum rules and every child block will append new
rules.

Unfortunately, this probably won't work in real world. Let's say that I
have this hierarchy and badlogger block contains several allow rules and
I want to inherit all of them except one, *BUT* I'm not SELinux policy
expert and don't know how hierarchy looks like. That's the reason why
I'm looking for blockinheritfilter.

However, we should go via creating block namespaces hierarchy as you
described if there are no plans to implement this feature.

Thanks,
Lukas.

>>
>> Appending instead of filtering probably just the better approach also =
if you consider that blocks might have macros or nested blocks
>> You probably would not be able to filter any of those.
>>
>>
>>>
>>> If I understand it correctly, it should "remove" rule:
>>> allow myapp.process log:file write;
>>>
>>> So process type in myapp should have allowed:
>>> allow myapp.process log:file {getattr append};
>>>
>>> And process type in logger should have allowed:
>>> allow logger.process log:file {getattr append write};
>>>
>>> Which could be very cool feature, but I don't see any code in secilc
>>> related to "blockinheritfilter". Are there any plans to implement als=
o
>>> this in CIL namespaces or is there any other way how to handle this
>>> (DELETE statement is also not implemented) ?
>>>
>>> Thanks for any help.
>>> Lukas.
>>>
>>>
>>> [1] https://github.com/SELinuxProject/cil/wiki
>>>
>>> --=20
>>> Lukas Vrabec
>>> Software Engineer, Security Technologies
>>> Red Hat, Inc.
>>>
>>
>>
>>
>>
>> --=20
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02=

>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
>> Dominick Grift
>=20
>=20
>=20


--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--IaVLeuTrkTSvsdYL1CRdPaWqkOWz4KnLS--

--uxJO7qZfkNYDWmigrriNIieWmLuBGvHEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAlrLUVgACgkQRyAaxC8p
zgZdkAf8C+TKIp8LH0e0cGd1gD66Bmc4JQqTpxOjtWnum/kMvzdUEYXRqDNABaam
JF/MNe/5tE9c2zCxjSMy1nDyMgvtd/NLL6FGVfLkFMkrvhpC1fPBcEXG+Uuk1Vny
HLZ2nYPwDK3KWSYW6KuU2s+JGyJc2K+9r2aRQKWrCZ5H+PrwdRwlNdGoShF0xdpX
rmfvP3Q2YkXsEUW3yDvf/0leWaRw/DkuT5dcoTqErTYz0nqouYv0Y/bfVFq6IHsz
IqT3QnfrsHcGSve2cDzHVIIYsW3THVth22dgvsz1363zag+/vzj3+eyRsQRciETT
LhTif93keNU55um8TzFfEQaK0rXfIQ==
=q3Ub
-----END PGP SIGNATURE-----

--uxJO7qZfkNYDWmigrriNIieWmLuBGvHEU--
