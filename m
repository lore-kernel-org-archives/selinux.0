Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DIF5Vp000473
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 14:15:05 -0400
Received: by wiwl15 with SMTP id l15so8337041wiw.4
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 11:15:02 -0700 (PDT)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id hl8sm3823972wjb.38.2015.03.13.11.15.01
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2015 11:15:01 -0700 (PDT)
Date: Fri, 13 Mar 2015 19:15:00 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Strange behavior: type boundaries
Message-ID: <20150313181459.GB9437@linksys-wireless-usb.network2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I was playing with systemd-nspawn/machine, and machinectl allows one to pull in images. I am trying to confine it and i hit issues:

systemd runs systemd-importd, and systemd-importd runs systemd-pull

It seems as if though its some multithreading going on because i get:

type=SELINUX_ERR msg=audit(1426268982.258:2559): op=security_bounded_transition seresult=denied oldcontext=system_u:system_r:systemd_t newcontext=system_u:system_r:importd_t

Even though I am in permissive mode, and a transition rule "allow systemd_t importd_t:process transition;" is present, SELinux does not transition.

When i add a typebounds statement (typebounds systemd_t importd_t), then the scenario changes:

type=SELINUX_ERR msg=audit(1426268121.044:2414): op=security_compute_av reason=bounds scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process perms=transition
- ----
type=AVC msg=audit(1426268121.044:2415): avc:  denied  { transition } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process permissive=1
- ----
type=SELINUX_ERR msg=audit(1426268121.044:2416): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file perms=entrypoint
- ----
type=AVC msg=audit(1426268121.044:2417): avc:  denied  { entrypoint } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file permissive=1
- ----
type=SELINUX_ERR msg=audit(1426268121.046:2418): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd perms=use
- ----
type=AVC msg=audit(1426268121.046:2419): avc:  denied  { use } for  pid=9210 comm="systemd-importd" path="/dev/null" dev="devtmpfs" ino=1028 scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd permissive=1

These rules are present in the policy (the transition is obviously taking place in permissive mode) and so is the typebounds rule, but access looks still denied.

I do not understand what is going on here.

First of all importd_t is bounded to systemd. So why does it appear to be a problem that systemd operates on importd_t entities?

Also why does selinux refuse to type transition without a typebounds, and why does it give me a permission denied with a typebounds 

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVAykfAAoJENAR6kfG5xmch6kL/iR7H5pZCD8kDbpKgNGm6PIS
XemC/HnvH2sH+TluECQ6aYzf/nFR+aHAWkh4TOP7JwHE1nQQifTpaWIQsTWl7zuk
DEaOjxvnezgfH+kwLX4uyONgsq6cDyRf/Uo6fcooaDxmxOnC9eOcA7OPt7FdGdbI
Mi+0qpv5Z+RRtDfDxZ5jDTCi5iQiV3WwVj9sa+z5vvV6H807iyCAWa/cY3Cj+yAu
Q5yLChm5GZpANjAPxWSNzLrOxIl71cZDO+kAMvpKoSGvw63W7JgchzWJLn68EjjZ
MUaDJTIeOo2RbDoc1fRP/+KmBy9r9gz6VF6mkhokTlDPHwoL76jO5Ks8JEuN958/
Q/8uKedNJ71osR2ynZK+KEk2Sih/TLN8XoWgGapeTfBrfvPL05MCtCt0vdbO2DXH
N81BeoP7lasEO9N32wS3agOjwXlMdYP9hBeQmXWM6dgPN/7br9tchodM1sRddJhe
/LcfCkE1gaPMHlDkOrHvsn8P6oW35ItaLxyVlexAJg==
=YVmE
-----END PGP SIGNATURE-----
