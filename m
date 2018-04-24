To: Stephen Smalley <sds@tycho.nsa.gov>, Jaap <jjb@xs4all.nl>,
 SELinux <selinux@tycho.nsa.gov>
Cc: "selinux@lists.fedoraproject.org" <selinux@lists.fedoraproject.org>
References: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
 <99f11a38-42f0-0dac-8205-7f2cab015298@tycho.nsa.gov>
 <a01e6aec-2cf0-5d4c-b4b5-2149666fe192@tycho.nsa.gov>
 <8fce61a3-9973-24aa-048d-01c410afc333@xs4all.nl>
 <7a1b6984-9a42-38bf-e634-bdac7a4e07bc@tycho.nsa.gov>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <6b139318-25e9-d1f4-6aad-5d1413e38ca2@redhat.com>
Date: Tue, 24 Apr 2018 11:29:40 +0200
MIME-Version: 1.0
In-Reply-To: <7a1b6984-9a42-38bf-e634-bdac7a4e07bc@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Gpfdls8dZ6ZCRLTYj601wIy4mDGB9Mzty"
Subject: Re: selinux crashes always at startup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gpfdls8dZ6ZCRLTYj601wIy4mDGB9Mzty
Content-Type: multipart/mixed; boundary="wVnI1yeu8vEU0aka7hXqbmqo1BeAZYNW6";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Jaap <jjb@xs4all.nl>,
 SELinux <selinux@tycho.nsa.gov>
Cc: "selinux@lists.fedoraproject.org" <selinux@lists.fedoraproject.org>
Message-ID: <6b139318-25e9-d1f4-6aad-5d1413e38ca2@redhat.com>
Subject: Re: selinux crashes always at startup
References: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
 <99f11a38-42f0-0dac-8205-7f2cab015298@tycho.nsa.gov>
 <a01e6aec-2cf0-5d4c-b4b5-2149666fe192@tycho.nsa.gov>
 <8fce61a3-9973-24aa-048d-01c410afc333@xs4all.nl>
 <7a1b6984-9a42-38bf-e634-bdac7a4e07bc@tycho.nsa.gov>
In-Reply-To: <7a1b6984-9a42-38bf-e634-bdac7a4e07bc@tycho.nsa.gov>

--wVnI1yeu8vEU0aka7hXqbmqo1BeAZYNW6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi All,

As Stephen mentioned, "Not defined classes" from dmesg are just
warnings, that following class is not supported by policy, but hooks are
present in kernel already. However, I'm not sure what version of Fedora
you're using, but From Fedora 28+, we will support all socket classes
mentioned in your report.

Thanks,
Lukas.

On 04/19/2018 03:31 PM, Stephen Smalley wrote:
> On 04/18/2018 04:44 PM, Jaap wrote:
>> I am on Fedora 28, 4.16.2-300.fc28.x86_64 On a Dell laptop
>> policy:=C2=A0=C2=A0 selinux-policy.noarch 3.14.1-18.fc28
>=20
> (restored selinux list to cc line)
>=20
> Since this is Fedora-specific, I also added the Fedora selinux mailing =
list to the cc line above.
> You may wish to subscribe to that list if not already on it.
>=20
>> I do not know if / where Selinux messages are about the crash of selin=
ux. Does selinux have a log?
>=20
> ausearch -i -m AVC,SELINUX_ERR,USER_AVC -ts boot will show all SELinux =
kernel permission denials (AVC), kernel errors (SELINUX_ERR), and userspa=
ce permission denials (USER_AVC) since boot.  You can use other start tim=
e values (e.g. recent, today, ...) and other selectors to control exactly=
 what is reported.
>=20
>>
>>
>> On 04/18/2018 10:04 PM, Stephen Smalley wrote:
>>> On 04/18/2018 04:01 PM, Stephen Smalley wrote:
>>>> On 04/18/2018 03:40 PM, Jaap wrote:
>>>>> selinux crashes always at startup. problem is always reported (says=
 selinux) But it does not get better.
>>>> None of the SELinux messages you showed are errors.=C2=A0 They are j=
ust informational, and the message "the above unknown
>>>> classes and permissions will be allowed" indicates that they won't c=
ause any permission denials.
>>> Also, you didn't provide any information about your kernel, distro, p=
olicy, etc.
>>> Please provide a more complete log (particularly one that shows the a=
ctual error) and
>>> information about the system in question.
>> journalctl | grep selinux gives this:
>>
>> Apr 18 21:26:06 localhost.localdomain audit[1170]: USER_START pid=3D11=
70 uid=3D0 auid=3D42 ses=3D1 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'op=
=3DPAM:session_open grantors=3Dpam_selinux,pam_selinux,pam_loginuid,pam_k=
eyinit,pam_limits,pam_systemd,pam_unix acct=3D"gdm" exe=3D"/usr/lib/syste=
md/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> Apr 18 21:26:06 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { status } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gdm-wayland-session gnome-session --autostart /usr/share/gdm/greeter=
/autostart" scontext=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3D=
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem per=
missive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:08 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:08 localhost.localdomain systemd[1170]: selinux: avc: den=
ied=C2=A0 { reload } for auid=3Dn/a uid=3D42 gid=3D42 cmdline=3D"/usr/lib=
exec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" s=
context=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dsystem permissive=3D0
>> Apr 18 21:26:17 localhost.localdomain audit[1613]: USER_START pid=3D16=
13 uid=3D0 auid=3D1000 ses=3D3 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
op=3DPAM:session_open grantors=3Dpam_selinux,pam_selinux,pam_loginuid,pam=
_keyinit,pam_limits,pam_systemd,pam_unix acct=3D"jaap" exe=3D"/usr/lib/sy=
stemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> Apr 18 21:26:17 localhost.localdomain audit[1606]: USER_START pid=3D16=
06 uid=3D0 auid=3D1000 ses=3D2 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023 msg=3D'op=3DPAM:session_open grantors=3Dpam_selinux,pam_loginuid,pam_=
selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_=
unix,pam_gnome_keyring acct=3D"jaap" exe=3D"/usr/libexec/gdm-session-work=
er" hostname=3Dlocalhost.localdomain addr=3D? terminal=3D/dev/tty2 res=3D=
success'
>> Apr 18 21:26:50 localhost.localdomain audit[1606]: USER_END pid=3D1606=
 uid=3D0 auid=3D1000 ses=3D2 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c102=
3 msg=3D'op=3DPAM:session_close grantors=3Dpam_selinux,pam_loginuid,pam_s=
elinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_u=
nix,pam_gnome_keyring acct=3D"jaap" exe=3D"/usr/libexec/gdm-session-worke=
r" hostname=3Dlocalhost.localdomain addr=3D? terminal=3D/dev/tty2 res=3Ds=
uccess'
>> Apr 18 21:26:57 localhost.localdomain audit[2919]: USER_START pid=3D29=
19 uid=3D0 auid=3D1000 ses=3D5 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
op=3DPAM:session_open grantors=3Dpam_selinux,pam_selinux,pam_loginuid,pam=
_keyinit,pam_limits,pam_systemd,pam_unix acct=3D"jaap" exe=3D"/usr/lib/sy=
stemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> Apr 18 21:26:57 localhost.localdomain audit[2869]: USER_START pid=3D28=
69 uid=3D0 auid=3D1000 ses=3D4 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023 msg=3D'op=3DPAM:session_open grantors=3Dpam_selinux,pam_loginuid,pam_=
selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_=
unix,pam_gnome_keyring acct=3D"jaap" exe=3D"/usr/libexec/gdm-session-work=
er" hostname=3Dlocalhost.localdomain addr=3D? terminal=3D/dev/tty2 res=3D=
success'
>> Apr 18 21:27:33 localhost.localdomain audit[2869]: USER_END pid=3D2869=
 uid=3D0 auid=3D1000 ses=3D4 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c102=
3 msg=3D'op=3DPAM:session_close grantors=3Dpam_selinux,pam_loginuid,pam_s=
elinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_u=
nix,pam_gnome_keyring acct=3D"jaap" exe=3D"/usr/libexec/gdm-session-worke=
r" hostname=3Dlocalhost.localdomain addr=3D? terminal=3D/dev/tty2 res=3Ds=
uccess'
>> Apr 18 21:27:40 localhost.localdomain audit[3983]: USER_START pid=3D39=
83 uid=3D0 auid=3D1000 ses=3D7 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
op=3DPAM:session_open grantors=3Dpam_selinux,pam_selinux,pam_loginuid,pam=
_keyinit,pam_limits,pam_systemd,pam_unix acct=3D"jaap" exe=3D"/usr/lib/sy=
stemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
>> Apr 18 21:27:40 localhost.localdomain audit[3940]: USER_START pid=3D39=
40 uid=3D0 auid=3D1000 ses=3D6 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023 msg=3D'op=3DPAM:session_open grantors=3Dpam_selinux,pam_loginuid,pam_=
selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_=
unix,pam_gnome_keyring acct=3D"jaap" exe=3D"/usr/libexec/gdm-session-work=
er" hostname=3Dlocalhost.localdomain addr=3D? terminal=3D/dev/tty2 res=3D=
success'
>> [jaap@localhost ~]$
>>
>>>>> from journalctl:
>>>>>
>>>>>
>>>>> n systemd-journald[207]: Received SIGTERM from PID 1 (systemd).
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: systemd: 15 output li=
nes suppressed due to ratelimiting
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab =
hash slots, 107409 rules.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab =
hash slots, 107409 rules.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 8 user=
s, 14 roles, 5094 types, 312 bools, 1 sens, 1024 cats
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 94 cla=
sses, 107409 rules
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
sctp_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
icmp_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
ax25_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
ipx_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
netrom_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
atmpvc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
x25_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
rose_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
decnet_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
atmsvc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
rds_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
irda_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
pppox_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
llc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
can_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
tipc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
bluetooth_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
iucv_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
rxrpc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
isdn_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
phonet_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
ieee802154_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
caif_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
alg_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
nfc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
vsock_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
kcm_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
qipcrtr_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Class =
smc_socket not defined in policy.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: the above un=
known classes and permissions will be allowed
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Comple=
ting initialization.
>>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:=C2=A0 Settin=
g up existing superblocks.
>>>>
>>
>>
>=20


--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--wVnI1yeu8vEU0aka7hXqbmqo1BeAZYNW6--

--Gpfdls8dZ6ZCRLTYj601wIy4mDGB9Mzty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAlre+QQACgkQRyAaxC8p
zgZNcQgArXh3u4U6JYNoe6Fn9STN4cpHvAQh1Pd+Rw7ip8REHOfXgTJ7XhHf5X/O
d+XKFisQCM5Ov114UCm61+dAfbt3yi+U9GkJfz1fy/dcF+QSDh6cQ2Su6Wyj5Q/r
BawsKimXDhzhcjp7D+PTzVa4Q0J9SDParEuTN++LntA62Qy4YUDHFR36Y2UdUFkE
S6AuPFmtDkU5yap0ThRgEryvXOfI48lyW8buaey2iXHzXUoLeaJ0N+WymplkpLJa
Sy0v3XZQ3w3iGlXIexY4Gm+Lgtjwi2GsTB5gvy4aiRROcGeJ6HM4e+64iLojiFOD
DWq2EPx9mpPTHD+ipk/5QrSjelzlWg==
=g7jt
-----END PGP SIGNATURE-----

--Gpfdls8dZ6ZCRLTYj601wIy4mDGB9Mzty--
