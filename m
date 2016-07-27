Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6RHMDJd003354
 for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2016 13:22:17 -0400
Received: by mail-wm0-f50.google.com with SMTP id q128so221241675wma.1
 for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2016 10:21:56 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id e10sm7374780wjc.21.2016.07.27.10.21.52
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Jul 2016 10:21:52 -0700 (PDT)
Subject: Re: I still think typebounds checking is too tight.
To: selinux@tycho.nsa.gov
References: <d96a16a9-62e9-f65f-f045-eb7678acd620@redhat.com>
 <4de677bc-b755-5e3f-57fe-20487cef6ee3@tycho.nsa.gov>
 <a609530f-a663-286d-3190-0155805e7d7c@redhat.com>
 <38aa7acf-e142-f539-61b2-1eaa8eb86415@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <0cb7e192-1df4-a2cc-fecb-cdd8796405e3@gmail.com>
Date: Wed, 27 Jul 2016 19:21:42 +0200
MIME-Version: 1.0
In-Reply-To: <38aa7acf-e142-f539-61b2-1eaa8eb86415@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2PV0v50NCx1CRIcse6feADqJucnO5HCoJ"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2PV0v50NCx1CRIcse6feADqJucnO5HCoJ
Content-Type: multipart/mixed; boundary="2PPxx4xlKMXNKPnUuFRm11NRXI3x9Cdpt"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <0cb7e192-1df4-a2cc-fecb-cdd8796405e3@gmail.com>
Subject: Re: I still think typebounds checking is too tight.
References: <d96a16a9-62e9-f65f-f045-eb7678acd620@redhat.com>
 <4de677bc-b755-5e3f-57fe-20487cef6ee3@tycho.nsa.gov>
 <a609530f-a663-286d-3190-0155805e7d7c@redhat.com>
 <38aa7acf-e142-f539-61b2-1eaa8eb86415@tycho.nsa.gov>
In-Reply-To: <38aa7acf-e142-f539-61b2-1eaa8eb86415@tycho.nsa.gov>

--2PPxx4xlKMXNKPnUuFRm11NRXI3x9Cdpt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/27/2016 07:02 PM, Stephen Smalley wrote:
> On 07/27/2016 12:52 PM, Daniel J Walsh wrote:
>>
>>
>> On 07/27/2016 11:08 AM, Stephen Smalley wrote:
>>> On 07/27/2016 10:14 AM, Daniel J Walsh wrote:
>>>> We are now seeing breakage on entrypoint.
>>>>
>>>>
>>>> If I have a less confined domain and I want to allow unconfined_t to=

>>>> transition to it, the compiler and the kernel eliminate entrypoints =
calls.
>>>>
>>>> unconfined_typebounds(svirt_lxc_net_t)
>>>>
>>>> Causes thousands of these errors.
>>>>
>>>>   (allow svirt_lxc_net_t ccs_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t canna_initrc_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t canna_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t callweaver_initrc_exec_t (file (entrypoint)=
))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t callweaver_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t calamaris_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t cachefilesd_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t bumblebee_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>
>>>> Since svirt_lxc_net_t can be entered via an exec_type.  But unconfin=
ed_t
>>>> can not.  I think this access should be treated like a target also.
>>>>
>>>> IE Ignored, I don't want to have to allow unconfined_t or docker_t t=
o be
>>>> able to be entered by all of the domains that svirt_lxc_net_t could =
be
>>>>
>>>> entered from.
>>> First question: Why does svirt_lxc_net_t need so many entrypoints?
>>> Optimally each domain would only have a single entrypoint type, for t=
he
>>> executable used to initially enter that domain.
>>>
>>> Regardless, the correct way to handle this situation is to define a
>>> typebounds on the _exec_t types too, e.g.
>>> typebounds unconfined_exec_t ccs_exec_t;
>>> will cause the first rule above to pass as long as you have:
>>> allow unconfined_t unconfined_exec_t:file entrypoint;
>>> in your policy.
>>>
>>> However, you'll need to do this for all of the _exec_t types that are=

>>> entrypoints for your domain.
>>>
>>> This was case #2 in the typebounds logic in my kernel patch descripti=
on:
>>>     2. If we have:
>>>         typebounds A B;
>>>         typebounds A_exec B_exec;
>>>     then:
>>>         allow B B_exec:file <permissions>;
>>>     will satisfy the bounds constraint iff:
>>>         allow A A_exec:file <permissions>;
>>>     is also allowed in policy.
>>>
>>>     This is essentially the same as #1; it is merely included as
>>>     an example of dealing with object types related to a bounded doma=
in
>>>     in a manner that satisfies the bounds relationship.  Note that
>>>     this approach is preferable to leaving B_exec unbounded and havin=
g:
>>>         allow A B_exec:file <permissions>;
>>>     in policy because that would allow B's entrypoints to be used to
>>>     enter A.  Similarly for _tmp or other related types.
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho=
=2Ensa.gov.
>>>
>>>
>> Reason for container domains to be use exec_type entrypoints was polic=
y
>> was originally written to allow you to start a container on any
>> executable in /usr.
>>
>> Basically we are doing
>>
>> runcon -t svirt_lxc_net_t /usr/bin/httpd
>=20
> Do you still need that or is there a common entrypoint now (even if it
> is just a script)?
>=20
>>
>> Can't do
>> typebounds unconfined_exec_t exec_type;
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> policy_module(mypol,1.0)
>>
>> gen_require(`
>>     type svirt_lxc_net_t;
>>     attribute entry_type;
>>     type unconfined_exec_t;
>> ')
>> unconfined_typebounds(svirt_lxc_net_t)
>> typebounds unconfined_exec_t entry_type;
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>
>> # make -f /usr/share/selinux/devel/Makefile
>> Compiling targeted mypol module
>> /usr/bin/checkmodule:  loading policy configuration from tmp/mypol.tmp=

>> mypol.te:9:ERROR 'type entry_type is not declared' at token ';' on lin=
e
>> 3257:
>>    =20
>> typebounds unconfined_exec_t entry_type;
>> /usr/bin/checkmodule:  error(s) encountered while parsing configuratio=
n
>> /usr/share/selinux/devel/include/Makefile:154: recipe for target
>> 'tmp/mypol.mod' failed
>> make: *** [tmp/mypol.mod] Error 1
>=20
> Yes, checkpolicy presently only supports specifying an individual child=

> type for the type bounds.  That said, I don't think it would be hard to=

> extend checkpolicy to support specifying an attribute for the child typ=
e
> (but not the parent - that has to be a singleton), and then just set th=
e
> parent for all the types in that attribute.  I guess you'd have to
> update CIL too.
>=20
>=20

If we want to support this for systemd, then we might as well not beat
around the bush and make systemd unconfined, and make all daemon
processes systemd process bounded subjects, and all daemon executable
files systemd executable file bounded executable files.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--2PPxx4xlKMXNKPnUuFRm11NRXI3x9Cdpt--

--2PV0v50NCx1CRIcse6feADqJucnO5HCoJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXmO2rAAoJECV0jlU3+Udpbo8MAKKJhRD9zdVq+/bUNXBgiK/L
XIT+tAkq42hZDpce9V+ZBYVL8fQ4DomtuJXSCDGCQqP3fKWtyrnAb2J9deNYeS+k
94HGpu5qucBaRluDILZ3CZzUKmUHh3SGxXsa90iZmnY5MCfTZIkE66wXcS9LVuFD
vcntAeeFijOcHfRfeLoxVbrN4zNW4rtHnTH2ISwcxYrmiEf1OE39YBAwVC5RYGpz
o+SUtabWTAf3FDKFZVsjeyE2Tac4bFff9n1lq1WRE0A0qNm13wQGytpTQ9W6BTGf
VPsUaDW8tWJUwJHxn0MVHb7mnbCI5t6W/edwMk29QLf2wKa7ak9Va5AYkBtb7AmX
SXqN14t0IBK4TvFfNoW4yj+zZgRNXA19ZOmayWjV/YTrZtNVowsrYD23ZEqcCWn+
90WWediEscpbibx3taPj7PK39xFNSE6+F9CF/rj8Hnyqn3dGEkjucnQofDGOubdF
k/EQyjG9oZNihRz5ZORed8pMMofN4y+6v57V7LtKaA==
=iBa5
-----END PGP SIGNATURE-----

--2PV0v50NCx1CRIcse6feADqJucnO5HCoJ--
