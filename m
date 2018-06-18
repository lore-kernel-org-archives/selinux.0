Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IJOuts012863
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 15:24:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID01.oob.disa.mil (Postfix) with SMTP id 418gyt6TvLz3tZXj
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 19:24:54 +0000 (UTC)
Received: from USFB19PA05.eemsg.mil (unknown [192.168.16.2])
 by USFBF3ID01.oob.disa.mil (Postfix) with ESMTP id 418gys0j4pz3tZXd
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 19:24:53 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0C0A401EF00
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 19:24:46 +0000 (UTC)
Received: from workstation (unknown [10.40.205.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A6E2026D5B
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 19:24:46 +0000 (UTC)
Date: Mon, 18 Jun 2018 21:24:44 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180618192443.GA8162@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Subject: is_selinux_enabled() after chroot()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

libselinux sets selinut_mnt and has_selinux_config only in its constructor =
and
is_selinux_enabled() and others just use selinux_mnt to check if SELinux is
enabled. But it doesn't work correctly when you use chroot() to a directory=
 without /proc
and /sys/fs/selinux mounted as it was discovered in
https://bugzilla.redhat.com/show_bug.cgi?id=3D1321375=20

In this case, is_selinux_enabled() after chroot() returns true while in a n=
ew
program run from chrooted process it returns false. It can be demonstrated =
by
the steps below.

The solution could be to check if selinux_mnt still exists whenever a funct=
ion
depending on this is called. Would this be acceptable?




$ sudo dnf --nogpg --installroot=3D/var/lib/machines/example  install syste=
md

$ cat > test_libselinux.c <<EOF
#include <selinux/selinux.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  pid_t pid;
  int wstatus;

  if (argc > 1) {
    printf("SELinux in chrooted process: %d\n", is_selinux_enabled());
    return 0;
  }
  if (chroot("/var/lib/machines/example") !=3D 0)
    return -1;

  printf("SELinux in process after chroot(): %d\n", is_selinux_enabled());
  printf("/sys/fs/selinux exists: %d\n", access("/sys/fs/selinux", F_OK));
  printf("/etc/selinux/config exists: %d\n\n", access("/etc/selinux/config"=
, F_OK));

  if ((pid =3D fork()) =3D=3D 0 ) {
    execv("./test_is_selinux_enabled", (char *[]){ "./test_is_selinux_enabl=
ed", "chrooted", NULL});
  }

  wait(&wstatus);
  return 0;
}
EOF

$ gcc -o test_is_selinux_enabled test_libselinux.c -lselinux

$ sudo ./test_is_selinux_enabled                           =20
SELinux in process after chroot(): 1
/sys/fs/selinux exists: -1
/etc/selinux/config exists: -1

SELinux in chrooted process: 0


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlsoBvQACgkQviIJHj72
InWDcA//YmeN2iEg+aq7oNtyYknzE+MjJlHCU/Yxo1C8WlbAZnBjP0t3xlyV2Eet
Mcr+dKe//AQLJzAwFF/7Z4yH5RQfxlcw64ByNpnMxGBXRtWhcSJChASAQyWBMDJ6
pSf4ghxBbbhOgs12D2uIrslAJPe+v2FdTzQZ50cNhs6+L/kGHlSRKwoUMIPfUNly
2itRePbkCJhbE8NiIEpHGGdbQNP9ajdLQT5SyGxAcgyUHr3QTp1p0dxUVS+4wr0P
G41VMlHWDJktZgOOdIkvZQ7qbTnKv/D0oYZjr2FG1EL07WsOSS6kIJeIBKCs8lTT
+mXdFnt+erG5SXOCWols1nwXNJR/583oYKVAf9XFAKpNNxYqojXAGjbEwtQFmh6A
EMG4RV9pg1ud9JNI2RCLGZZs7ESd6z3dgjtGTl1jmIYVIey7rUrRRIItRILEuhQS
NmfXrUhynnU11C67+nxd2qVvwkD4dlunMmFhdeQxugeUmiPxLUyrcjLj5HwnNZAl
qcgRaJmG4F9SdBsE2AM3HO1fReQwDS3X0QucqTq3dVcjSZPB9Fpaq17d97vBYZPA
/ThuqAugRKA63lCXt4yh0OHZzMaTowrHDu2x/8PotclAwZtGCY85DDqfm9xAEEAA
m6tl5P9tNJTtyEuOV0/CL2xoTBUIezz5mlY66jL7bvAzESm4zsU=
=k/8b
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
