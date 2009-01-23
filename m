Message-ID: <497A13D9.1070204@redhat.com>
Date: Fri, 23 Jan 2009 14:00:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: More MLS fun
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I figured out why dbus/nm-applet is not working in mls mode.  DBUS
thinks I am not logged in at the console. DBUS looks for the file
/var/run/console/dwalsh which is supposed to be created  by pam_console
when I log in.  pam_console does not create this file because it looks
for /tmp/.X11-unix/X0.  Which was not created because of the AVC below.
I believe this is denied because sock_files are not allowed to have a
range associated with it.  Are sock_files supposed to have ranges in
MLS?  If not why is X trying to create a ranged sock_file?

- ----
time->Fri Jan 23 11:53:28 2009
type=SYSCALL msg=audit(1232729608.294:4209): arch=c000003e syscall=49
success=no
 exit=-13 a0=3 a1=7fff28d972a0 a2=13 a3=8101010101010100 items=0
ppid=6354 pid=6
355 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
fsgid=0 tty=
(none) ses=4294967295 comm="Xorg" exe="/usr/bin/Xorg"
subj=system_u:system_r:xse
rver_t:s0-s15:c0.c1023 key=(null)
type=AVC msg=audit(1232729608.294:4209): avc:  denied  { create } for
pid=6355
comm="Xorg" name="X0"
scontext=system_u:system_r:xserver_t:s0-s15:c0.c1023 tcont
ext=system_u:object_r:xserver_tmp_t:s0-s15:c0.c1023 tclass=sock_file
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkl6E9kACgkQrlYvE4MpobNJfACgzgO04tT8LIAQFvc1eoYMc0li
TDsAoJJqMLtjRFHGIp3LCTXJIdMXB24u
=0n6d
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
