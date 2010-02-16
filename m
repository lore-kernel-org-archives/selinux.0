Message-ID: <4B7B21A2.3080006@gmail.com>
Date: Tue, 16 Feb 2010 23:52:18 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se> <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil> <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE55F6DF250E8CA008D9CEBCD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE55F6DF250E8CA008D9CEBCD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/16/2010 10:30 PM, Alan Rouse wrote:
> I had been trying various things in this image.  So, just to be sure I =
have a repeatable state, I've rebuilt my system from scratch as follows:
>=20
> 1. standard OpenSuse 11.2 install (using Gnome);  boot; start terminal;=
 su -
> 2.  install packages:=20
>=20
> selinux-tools=20
> selinux-policy=20
> libselinux*=20
> libsemanage*=20
> policycoreutils=20
> checkpolicy  =20
> make=20
> m4=20
> gcc=20
> findutils-locate=20
> git
>=20
> 3.  add "3 security=3Dselinux selinux=3D1 enforcing=3D0" to the grub bo=
ot line (boot to runlevel 3 with selinux in permissive mode) and reboot.
> 4.  git clone http://oss.tresys.com/git/refpolicy.git
> 5.  change build.conf:  "DIST =3D suse"  and "MONOLITHIC =3D n"
> 6.  make clean; make conf; make; make install-src;=20
> 7.  change /etc/refpolicy to point to the just-built policy version, an=
d reboot
> 8.  restorecon -R /; reboot
>=20
> sestatus -v gives:
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
>=20
> Process contexts:
> Current context:                system_u:system_r:sysadm_t
> Init context:                   system_u:system_r:init_t
> /sbin/mingetty                  system_u:system_r:sysadm_t
>=20
> File contexts:
> Controlling term:               system_u:object_r:tty_device_t
> /etc/passwd                     system_u:object_r:etc_t
> /etc/shadow                     system_u:object_r:shadow_t
> /bin/bash                       system_u:object_r:shell_exec_t
> /bin/login                      system_u:object_r:login_exec_t
> /bin/sh                         system_u:object_r:bin_t -> system_u:obj=
ect_r:shell_exec_t
> /sbin/agetty                    system_u:object_r:getty_exec_t
> /sbin/init                      system_u:object_r:init_exec_t
> /sbin/mingetty                  system_u:object_r:getty_exec_t
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t
> /lib/libc.so.6                  system_u:object_r:lib_t -> system_u:obj=
ect_r:lib_t
> /lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:obj=
ect_r:ld_so_t
>=20
> pstree- Z gives:
> init(`system_u:system_r:init_t')
>  |-acpid(`system_u:system_r:sysadm_t')
>  |-auditd(`system_u:system_r:sysadm_t')
>  |  |-audispd(`system_u:system_r:sysadm_t')
>  |  |  `-{audispd}(`system_u:system_r:sysadm_t')
>  |  `-{auditd}(`system_u:system_r:sysadm_t')
>  |-cron(`system_u:system_r:sysadm_t')
>  |-cupsd(`system_u:system_r:sysadm_t')
>  |-dbus-daemon(`system_u:system_r:sysadm_dbusd_t')
>  |  `-{dbus-daemon}(`system_u:system_r:sysadm_dbusd_t')
>  |-dhcpcd(`system_u:system_r:dhcpc_t')
>  |-login(`system_u:system_r:sysadm_t')
>  |  `-bash(`system_u:system_r:sysadm_t')
>  |     `-pstree(`system_u:system_r:sysadm_t')
>  |-master(`system_u:system_r:sysadm_t')
>  |  |-pickup(`system_u:system_r:sysadm_t')
>  |  `-qmgr(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-nscd(`system_u:system_r:sysadm_t')
>  |-rpcbind(`system_u:system_r:sysadm_t')
>  |-rsyslogd(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  `-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |-startpar(`system_u:system_r:sysadm_t')
>  |-udevd(`system_u:system_r:sysadm_t')
>  |  |-udevd(`system_u:system_r:sysadm_t')
>  |  `-udevd(`system_u:system_r:sysadm_t')
>  `-vmtoolsd(`system_u:system_r:sysadm_t')
>=20
> Now, I tried setsebool -P init_upstart=3D1.  It gives an error message:=

> ----------------
> Libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent=
 directory conflicts with a file context already specified in the policy.=
  This usually indicates an incorrectly defined system account.  If it is=
 a system account please make sure its uid is less than 1000 or its log i=
n shell is /sbin/nologin.
> ----------------
>=20
> So I did "usermod -s /sbin/nologin nobody" and repeated the setsebool (=
no error message returned, and "getsebool init_upstart" reports that it w=
as on.  But after reboot it is off again...

If you used the -P option with setsebool than the settings should be
persistent across reboots.

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
> Sent: Tuesday, February 16, 2010 2:39 PM
> To: Alan Rouse
> Cc: 'selinux@tycho.nsa.gov'
> Subject: RE: SELinux Policy in OpenSUSE 11.2
>=20
> On Tue, 2010-02-16 at 14:19 -0500, Alan Rouse wrote:
>> "sestatus -v" reports the following:
>>
>> SELinux status:                 enabled
>> SELinuxfs mount:                /selinux
>> Current mode:                   permissive
>> Mode from config file:          permissive
>> Policy version:                 24
>> Policy from config file:        refpolicy
>>
>> Process contexts:
>> Current context:                system_u:system_r:sysadm_t
>> Init context:                   system_u:system_r:init_t
>> /sbin/mingetty                  system_u:system_r:sysadm_t
>=20
> Ok, so init is in the right security context, but getty is not.
> refpolicy has a rule that says if init runs a shell, transition to sysa=
dm_t - that is for single-user mode.  But that gets disabled if using ups=
tart since upstart runs everything via a shell.
>=20
> Try:
> setsebool -P init_upstart=3D1
> reboot
>=20
> pstree -Z output might also be interesting.
>=20
> --
> Stephen Smalley
> National Security Agency
>=20



--------------enigE55F6DF250E8CA008D9CEBCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt7IakACgkQMlxVo39jgT8k/QCfad0QGYCiKAY1M1gY1gkvjlMI
D4sAoNXXpR5tjGaEiVrN5ha5CdaBiOpK
=YnGt
-----END PGP SIGNATURE-----

--------------enigE55F6DF250E8CA008D9CEBCD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
