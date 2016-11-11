Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uABHxPn6032392
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 12:59:25 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so438595227wmd.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 09:59:21 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id s204sm13430715wmd.1.2016.11.11.09.59.20
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Nov 2016 09:59:20 -0800 (PST)
Subject: Re: checkpolicy dontaudit compiler bug?
To: selinux@tycho.nsa.gov
References: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <021477d4-6816-1915-e84a-f038b30dbbd1@gmail.com>
Date: Fri, 11 Nov 2016 18:59:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8RcC4BnmL7Wboc2WSdHjOmSH3QBLJrL5J"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RcC4BnmL7Wboc2WSdHjOmSH3QBLJrL5J
Content-Type: multipart/mixed; boundary="do3DxBStmfc5ibH6mNFND1D5xN8gcxGqj";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <021477d4-6816-1915-e84a-f038b30dbbd1@gmail.com>
Subject: Re: checkpolicy dontaudit compiler bug?
References: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
In-Reply-To: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>

--do3DxBStmfc5ibH6mNFND1D5xN8gcxGqj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/11/2016 06:51 PM, Nick Kralevich wrote:
> (apologies if you received this message twice. I believe the first
> message got stuck in a moderation queue somewhere)
>=20
> I'm trying to hunt down what appears to be a weird checkpolicy bug.
>=20
> On Android, we have a special SELinux domain called "su". This domain
> is intended to be used during debugging and is always in permissive
> mode. To avoid generating a huge number of denials, we use a number of
> "dontaudit" rules to suppress SELinux denials.
>=20
> See https://android.googlesource.com/platform/system/sepolicy/+/0e1cbf5=
68a9cc3dd0b26ead68a79d1f22dcb3add/private/su.te
>=20
> Specifically, the following dontaudit rule is in that file:
>=20
>   dontaudit su self:capability_class_set *;
>=20
> which expands out to:
>=20
>   dontaudit su self:{ capability capability2 } *;
>=20

That should not work. AFAIK you cannot use the "*" with two different
classes

you would need to

dontaudit su self:capability *;
dontaudit su self:capability2 *;

Maybe the other policy "bullhead" does not have the invalid
dontaudit su self:capability_class_set *; rule

> However, on one device in particular ("marlin"), we find that this
> dontaudit rule is ineffective. It appears that the checkpolicy
> compiler is ignoring the dontaudit statement.
>=20
> $ sesearch --dontaudit -s su -c capability,capability2 /tmp/marlin.sepo=
licy
> dontaudit su su:capability sys_module;
> dontaudit su su:capability2 { mac_admin mac_override wake_alarm
> block_suspend syslog audit_read };
>=20
> However, this isn't happening on the other device ("bullhead"), which
> is compiled with a very similar policy:
>=20
> $ sesearch --dontaudit -s su -c capability,capability2 /tmp/bullhead.se=
policy
> dontaudit su su:capability { setuid setfcap sys_chroot
> net_bind_service sys_nice mknod fsetid kill net_admin sys_rawio
> audit_control sys_pacct sys_resource sys_ptrace dac_read_search
> sys_boot sys_admin audit_write net_raw setgid sys_time lease
> dac_override net_broadcast linux_immutable fowner sys_tty_config
> setpcap sys_module ipc_lock chown ipc_owner };
> dontaudit su su:capability2 { mac_admin mac_override wake_alarm
> block_suspend syslog audit_read };
>=20
> Steps to reproduce:
>=20
> 1) Download the following files and place them in /tmp
>=20
>   http://kralevich.com/bullhead.policy.conf
>   http://kralevich.com/marlin.policy.conf
>=20
> 2) Run the following commands to compile the policy:
>=20
>   checkpolicy -M -c 30 -o /tmp/bullhead.sepolicy /tmp/bullhead.policy.c=
onf
>   checkpolicy -M -c 30 -o /tmp/marlin.sepolicy /tmp/marlin.policy.conf
>=20
> 3) Verify the dontaudit rules by running sesearch
>=20
>   sesearch --dontaudit -s su -c capability,capability2 /tmp/marlin.sepo=
licy
>   sesearch --dontaudit -s su -c capability,capability2 /tmp/bullhead.se=
policy
>=20
> Expected: the output from the sesearch command above is identical for
> each device.
>=20
> Actual: the output from the sesearch command differs.
>=20
> If anyone has any insight into this bug I'd appreciate it.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--do3DxBStmfc5ibH6mNFND1D5xN8gcxGqj--

--8RcC4BnmL7Wboc2WSdHjOmSH3QBLJrL5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYJgbzAAoJECV0jlU3+UdpLB4L/iW4CRXwVdpJqm+BCK8I/w3A
zRhEkUKK0TwDAuf/TazDYLhPLG3STxBuC3RlD0LYIyTxAKFdKMSg4coveIoguuKn
LR+FVhdWK/yW1ff62XZtGlphrehBKtRxfryYV4fxBguk5g4cAbYhtFQMs3mGgV9T
5OQ0vq3fOhhreX6DMoo8jHySZb8/CWJol9lM92/re+sXAsydNkt61jgS3dYZQL2k
Pz5nz3FECfwvdualsj24I3hvPpfo1CRgArbixkPEOVi8ye3+YBK/89MI3/5V1UTE
4WNMY8gdbNDFngqFMV+1K9/jAk5eWTWX3yKUr79qTVJduoEqXwFJoLwWpZV2Ubye
ZpdxarG/7FvyLF6cmEtcSO9dpNYu54zN1i/mj/4X+ARaQ6R2jrkBmyu1aweLVJWk
9RtSUq/p/cOyYF/v4f6qfJSMiFNhjQTfiwFxlW8PSSELkyOH52hs2ZFz/evJWtI+
VCnCDFIKmDM7b4PrFKb9zk0BlyUSqjvqzrLFa+S1ng==
=Y6mH
-----END PGP SIGNATURE-----

--8RcC4BnmL7Wboc2WSdHjOmSH3QBLJrL5J--
