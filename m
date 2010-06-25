Message-ID: <4C24852C.5050406@gmail.com>
Date: Fri, 25 Jun 2010 12:30:04 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alice Mynona <alice_mynona@bian-fu.net>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Developing a SELinux policy for antivirus - Activating a boolean
 variable when another has been actived
References: <4C237345.2010200@bian-fu.net>	 <1277399578.25186.50.camel@moss-pluto.epoch.ncsc.mil> <1277400829.25186.54.camel@moss-pluto.epoch.ncsc.mil> <4C2480B5.7040602@bian-fu.net>
In-Reply-To: <4C2480B5.7040602@bian-fu.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0537EFEDEB969A21EDCE3FFF"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0537EFEDEB969A21EDCE3FFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/25/2010 12:11 PM, Alice Mynona wrote:
> Stephen Smalley schrieb am 24.06.2010 19:33 Uhr:
>> On Thu, 2010-06-24 at 13:12 -0400, Stephen Smalley wrote:
>>> On Thu, 2010-06-24 at 17:01 +0200, Alice Mynona wrote:
>>>> Hello,
>>>>
>>>> during the developing of a SELinux module I got the following error =
messages when executing "audit2allow -a -l"
>>>>
>>>> ...
>>>> libsepol.context_from_record: type antivirus_t is not defined
>>>> libsepol.context_from_record: could not create context structure
>>>> libsepol.context_from_string: could not create context structure
>>>> libsepol.sepol_context_to_sid: could not convert unconfined_u:unconf=
ined_r:antivirus_t:s0 to sid
>>>>
>>>> "antivirus_t" is a domain I have defined in my module:
>>>>
>>>> type antivirus_t;
>>>> domain_type(antivirus_t)
>>>>
>>>> I have already removed the module (semodule -r antivirus.pp && semod=
ule -R) and did a file context repair afterwards (fixfiles restore). The =
error still exists.=20
>>>>
>>>> I have reinstalled the policy (yum reinstall selinux-policy-*), but =
the problem remains. I have also taken a look at "file_contexts" (cd /etc=
/selinux/targeted/modules/active && grep antivirus_t file_contexts*), but=
 there's no "antivirus_t" anymore.
>>>>
>>>> Can you help me to find the cause of the problem? I don't know how t=
o debug libsepol-messages.
>>>>
>>>> I'm using "selinux-policy-targeted-3.6.32-118.fc12.noarch".
>>>
>>> Sounds like the -l option to audit2allow isn't working correctly, so
>>> that instead of only processing audit messages since the last policy
>>> reload, you are still processing the audit messages from when that
>>> policy module was installed, and unsurprisingly it cannot map those
>>> contexts since you removed the module.  That would be a bug in
>>> audit2allow/sepolgen.
>>>
>>> Workaround would be to use ausearch to select the desired range of
>>> messsages specifically, e.g.
>>> /sbin/ausearch -m AVC -ts today | audit2allow
>>
>=20
> I did a reload today at 08:36:00 a.m. (semodule -R). Round about two an=
d half hours later I checked the auditlog:
>=20
> ausearch -m AVC --start 25.06.2010 08:36:00 --end 25.06.2010 11:00:00
>=20
> Only messages from ssh_t (success=3Dyes). Fine. But "audit2allow -a -l"=
 still throws error messages:
>=20
> ...
> libsepol.context_from_record: type antivirus_t is not defined
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert unconfined_u:unconfine=
d_r:antivirus_t:s0 to sid
> ...
>=20
>> Dan - looks like you pushed the audit2why analyze calls down into
>> sepolgen while it is parsing the messages.  But this means that all
>> messages will be analyzed even if the user specified -l.
>>
>=20
> I will wait for Dan's answer :-).
>=20
> Problem solved. @All: Thanks for your help.
>=20
> Best regards,
>=20
> Alice
>=20
> p.s.:
> I still don't know how to debug sepol-messages. Can you give me a hint?=


I think it is not just with the -l option as i had similar output today
by using plain ausearch -m avc -ts recent | audit2allow:

libsepol.context_from_record: invalid security context:
"staff_u:staff_r:mozilla_t:s0-s0:c0.c1023"
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
staff_u:staff_r:mozilla_t:s0-s0:c0.c1023 to sid
libsepol.context_from_record: invalid security context:
"staff_u:staff_r:mozilla_t:s0-s0:c0.c1023"


>=20
> --
> This message was distributed to subscribers of the selinux mailing list=
=2E
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.go=
v with
> the words "unsubscribe selinux" without quotes as the message.



--------------enig0537EFEDEB969A21EDCE3FFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwkhTMACgkQMlxVo39jgT/WKQCcDgEwCkXGFZb7lvCH4sdz0DSe
DTQAn2aYpeLdnB80DCrwoaZVjcJKjL2y
=IIg4
-----END PGP SIGNATURE-----

--------------enig0537EFEDEB969A21EDCE3FFF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
