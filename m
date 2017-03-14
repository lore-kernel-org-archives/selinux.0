Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2EAdv4g017044
 for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2017 06:39:57 -0400
Received: from workstation1.local.opinurate.com ([185.34.9.224]) by
 mail.gmx.com (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MEnjW-1d2dIB0rxS-00Fxg2 for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2017
 11:39:53 +0100
Date: Tue, 14 Mar 2017 10:39:51 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: tomcat_t domain behavior
Message-ID: <20170314103951.GA2914@workstation1.local.opinurate.com>
References: <CAEKGoSGVccL=jEOOfGcKAdgHE+cUk5XC2Z01nt_jtke6MdjVXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <CAEKGoSGVccL=jEOOfGcKAdgHE+cUk5XC2Z01nt_jtke6MdjVXw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 12:24:32PM +0900, =E9=9D=A2=E5=92=8C=E6=AF=85 wrote:
> Hi list,
>=20
> I just found strange behavior on tomcat_t.
> (I checked Fedora25, CentOS7).
>=20
> During PoC for CVE-2017-5638(I know RedHat products are
> not affected, just wanted to confirm SELinux behavior),
> I found that tomcat_t can read shadow_t file, access to
> admin_home_t directory, and so on.
>=20
> I guess there is a suitable reason to allow those permission
> to tomcat_t, but I just want to confirm the reason.
>=20
> ----- Quick test for tomcat_t -----;
> I did just temporary test for checking tomcat_t behavior
> on Fedora25.
>=20
> 1. I copied /bin/bash to /root/tomcat_shell.sh, and assigned
>    context as "tomcat_exec_t".
>=20
> [root@fedora25 ~]# ls -lZ /root/tomcat_shell.sh
> -rwxr-xr-x. 1 root root system_u:object_r:tomcat_exec_t:s0
> 1072008 Mar 14 11:53 /root/tomcat_shell.sh
>=20
> 2. I added some cil policy just for this test.
> [root@fedora25 ~]# cat tomcat_sh.cil
> (typeattributeset entry_type tomcat_exec_t)
> (roletype unconfined_r tomcat_t)
> (typetransition unconfined_t tomcat_exec_t process tomcat_t)
>=20
> 3. load above module, and run tomcat_shell.sh
> [root@fedora25 ~]# semodule -i tomcat_sh.cil
> [root@fedora25 ~]# ./tomcat_shell.sh
> [root@fedora25 ~]# id -Z
> unconfined_u:unconfined_r:tomcat_t:s0-s0:c0.c1023
>=20
> 4. access to shadow file, /root/ file, etc.
> [root@fedora25 ~]# cat /etc/shadow
> root:$6$h0wd.::0:99999:7:::
> bin:*:17004:0:99999:7:::
> daemon:*:17004:0:99999:7:::
> --snip--
> [root@fedora25 ~]# cat /root/tomcat_sh.cil
> (typeattributeset entry_type tomcat_exec_t)
> (roletype unconfined_r tomcat_t)
> (typetransition unconfined_t tomcat_exec_t process tomcat_t)
> [root@fedora25 ~]# ls -lZ /root/tomcat_sh.cil
> -rw-r--r--. 1 root root unconfined_u:object_r:admin_home_t:s0
> 138 Mar 14 12:01 /root/tomcat_sh.cil
> ----- End -----
>=20
> So, can I ask the reason why we add these permission to tomcat_t?

These permissions aren't directly added to tomcat, they come from tomcat be=
ing an unconfined domain:
https://github.com/fedora-selinux/selinux-policy-contrib/blob/f25/tomcat.te=
#L21

$ sesearch -ACS -s tomcat_t -t shadow_t -c file -p read
Found 1 semantic av rules:
   allow files_unconfined_type file_type : file { ioctl read write create g=
etattr setattr lock relabelfrom relabelto append unlink link rename execute=
 swapon quotaon mounton execute_no_trans open audit_access } ;=20

$ seinfo -ttomcat_t -x
   tomcat_t
      can_read_shadow_passwords
      can_write_shadow_passwords
      can_relabelto_shadow_passwords
      can_change_object_identity
      can_load_kernmodule
      can_load_policy
      can_setbool
      can_setenforce
      corenet_unconfined_type
      corenet_unlabeled_type
      devices_unconfined_type
      domain
      files_unconfined_type
      filesystem_unconfined_type
      kern_unconfined
      kernel_system_state_reader
      process_uncond_exempt
      selinux_unconfined_type
      storage_unconfined_type
      unconfined_domain_type
      dbusd_unconfined
      daemon
      syslog_client_type
      sepgsql_unconfined_type
      tomcat_domain
      userdom_filetrans_type
      x_domain
      xserver_unconfined_type

I don't see why Tomcat would need to be an unconfined domain, though.

>=20
> Kind Regards,
>=20
> OMO
>=20
>=20
> --=20
> Kazuki Omo: ka-omo@sios.com
> OSS &Security Evangelist
> OSS Business Planning Dept.
> CISSP #366942
> http://www.secureoss.jp/
> Tel: +819026581386
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYx8huAAoJEHBu12WFqnnYdq0H/j9Aj3omtB5ACH3jBJqZtgeJ
yFObK++B7M9NbI6sIYkG9Tv9bDeywifQ/GJaTR6AIL2l8OvcZ7TnNMbH0BcPvr3j
inBx8dxfeDYj96wkoFxxnl5tHcv28zrLa7MPsChpPDRPWwIUzIseU9uKAMOJjk9c
6vy6gQX0jkAkDVL+R6Ld8plVtmRt9HP71RBqvnCfWqS/4RyvZuPQJvWtsACADfXP
gpfcLFqDpWTRANy8NxK5voycEwbH2YKDlytwX7Q8LTM77VxQIeI2Y5wcjifM+gkn
+vNNzXno0bTUlHxRNWcru21Smw4VdXxDOY2sSOHqKS6v0j61l2T8GbKBLM9EIUo=
=sZr0
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
