Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA19871
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 13:59:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA23476
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 18:59:01 GMT
Received: from ultraviolet.org ([192.215.175.10])
	by jazzband.ncsc.mil  with SMTP id SAA23472
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 18:58:54 GMT
Date: Mon, 26 Nov 2001 11:59:36 -0800
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: kernel oops
Message-ID: <20011126115936.A14920@ultraviolet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7iMSBzlTiPOCCT2k
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've had 3 oopses in the last week that I've been playing with selinux.
ksymoops decoded results are attached. The first occurred when I was
trying to reload the policy:

Nov 21 19:33:24 bench3 kernel: ss:  loading policy configuration from /ss_p=
olicy
Nov 21 19:33:24 bench3 kernel: security:  4 users, 5 roles, 349 types
Nov 21 19:33:24 bench3 kernel: security:  29 classes, 60594 rules
Nov 21 19:33:24 bench3 kernel: Unable to handle kernel paging request at vi=
rtual address 465ec21c

The system was still useable but attempts to reload the policy were
hanging so I rebooted.

The other two happened when nobody was doing anything with the system
except cron running the normal stuff.

Nov 22 14:40:00 tracy kernel: task_precondition:  assigning context system_=
u:system_r:crond_t to pid 1620 exe=3D/usr/sbin/crond
Nov 22 14:40:00 tracy kernel: Unable to handle kernel paging request at vir=
tual address 00732528

Nov 22 14:41:00 tracy kernel:  <1>Unable to handle kernel paging request at=
 virtual address a8d4b5ec                                                  =
          =20

After this the system was hung solid, no ping or anything.

--=20
Tracy Reed      http://www.ultraviolet.org

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops1.txt"

ksymoops 2.4.0 on i686 2.4.12-lsm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-lsm/ (default)
     -m /boot/System.map-2.4.12-lsm (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c022f660, System.map says c0151f80.  Ignoring ksyms_base entry
 Unable to handle kernel paging request at virtual address 465ec21c
 c01ad045
 *pde = 00000000
 Oops: 0000
 CPU:    1
 EIP:    0010:[convert_context+117/320]    Not tainted
 EIP:    0010:[<c01ad045>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010282
 eax: ddee9000   ebx: d6df3864   ecx: d71df620   edx: da1c0c88
 esi: d6cdbdd8   edi: ffffffea   ebp: d6cdbde0   esp: d6cdbd7c
 ds: 0018   es: 0018   ss: 0018
 Process load_policy (pid: 10363, stackpage=d6cdb000)
 Stack: 000000ff d6cdbde0 00000002 00000005 da1c0c88 da1c03e0 d6df3860 d6df3880
        00000079 c01a949c 000000f9 d6df3864 d6cdbdd8 d6cdbde0 c036a220 de6d0b20
        d6cdbe20 c01ad1d1 d6cdbde0 c01acfd0 d6cdbdd8 00000000 00000000 c036a220
 Call Trace: [sidtab_map_remove_on_error+44/144] [security_load_policy+193/432] [convert_context+0/320] [inode_has_perm+284/672] [task_precondition+40/816]
 Call Trace: [<c01a949c>] [<c01ad1d1>] [<c01acfd0>] [<c019b69c>] [<c019a9b8>]
    [<c019b445>] [<c019fa07>] [<c013394a>] [<c0132546>] [<c01ae4bd>] [<c01a7f4f>]
    [<c01328bd>] [<c01967d7>] [<c0106f1b>]
 Code: 8b 54 90 fc 52 8b 46 04 8b 40 18 50 e8 7a be ff ff 5a 85 c0

>>EIP; c01ad045 <convert_context+75/140>   <=====
Trace; c01a949c <sidtab_map_remove_on_error+2c/90>
Trace; c01ad1d1 <security_load_policy+c1/1b0>
Trace; c01acfd0 <convert_context+0/140>
Trace; c019b69c <inode_has_perm+11c/2a0>
Trace; c019a9b8 <task_precondition+28/330>
Trace; c019b445 <task_has_security+a5/1e0>
Trace; c019fa07 <selinux_file_alloc_security+27/30>
Trace; c013394a <get_empty_filp+4a/160>
Trace; c0132546 <dentry_open+e6/190>
Trace; c01ae4bd <sys_security_load_policy+17d/1a0>
Trace; c01a7f4f <sys_selinux+ff/350>
Trace; c01328bd <filp_close+8d/a0>
Trace; c01967d7 <sys_security+17/20>
Trace; c0106f1b <system_call+33/38>
Code;  c01ad045 <convert_context+75/140>
00000000 <_EIP>:
Code;  c01ad045 <convert_context+75/140>   <=====
   0:   8b 54 90 fc               mov    0xfffffffc(%eax,%edx,4),%edx   <=====
Code;  c01ad049 <convert_context+79/140>
   4:   52                        push   %edx
Code;  c01ad04a <convert_context+7a/140>
   5:   8b 46 04                  mov    0x4(%esi),%eax
Code;  c01ad04d <convert_context+7d/140>
   8:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c01ad050 <convert_context+80/140>
   b:   50                        push   %eax
Code;  c01ad051 <convert_context+81/140>
   c:   e8 7a be ff ff            call   ffffbe8b <_EIP+0xffffbe8b> c01a8ed0 <hashtab_search+0/60>
Code;  c01ad056 <convert_context+86/140>
  11:   5a                        pop    %edx
Code;  c01ad057 <convert_context+87/140>
  12:   85 c0                     test   %eax,%eax


2 warnings issued.  Results may not be reliable.

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.txt"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.0 on i686 2.4.12-lsm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-lsm/ (default)
     -m /boot/System.map-2.4.12-lsm (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c022f660, System.map says c0151f80.  Ignoring ksyms_base entry
 Unable to handle kernel paging request at virtual address 00732528
 c0112800
 *pde =3D 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[__wake_up+48/192]    Not tainted
 EIP:    0010:[<c0112800>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010007
 eax: d681c4a4   ebx: 0073252c   ecx: 00000001   edx: 00000001
 esi: d954c5a0   edi: d681c4a0   ebp: d4d79f40   esp: d4d79f28
 ds: 0018   es: 0018   ss: 0018
 Process crond (pid: 1619, stackpage=3Dd4d79000)
 Stack: 00000001 00000286 00000001 d681c4a0 d954c5a0 d954c5a0 d4deb9a0 c013=
b891
        d9a33340 c1958fa0 c013b8de d954c5a0 00000000 00000001 c0133b1e d954=
c5a0
        d9a33340 bffff760 d4bca000 c011498a 00000654 d9a33340 d9a33340 0000=
0000
 Call Trace: [pipe_release+113/144] [pipe_write_release+14/32] [fput+78/256=
] [do_fork+1658/1808] [filp_close+141/160]
 Call Trace: [<c013b891>] [<c013b8de>] [<c0133b1e>] [<c011498a>] [<c01328bd=
>]
    [<c013292b>] [<c0106f1b>]
 Code: 8b 4b fc 8b 01 85 45 f0 74 64 31 c0 9c 5e fa f0 fe 0d 00 f8

>>EIP; c0112800 <__wake_up+30/c0>   <=3D=3D=3D=3D=3D
Trace; c013b891 <pipe_release+71/90>
Trace; c013b8de <pipe_write_release+e/20>
Trace; c0133b1e <fput+4e/100>
Trace; c011498a <do_fork+67a/710>
Trace; c01328bd <filp_close+8d/a0>
Trace; c013292b <sys_close+5b/70>
Trace; c0106f1b <system_call+33/38>
Code;  c0112800 <__wake_up+30/c0>
00000000 <_EIP>:
Code;  c0112800 <__wake_up+30/c0>   <=3D=3D=3D=3D=3D
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=3D=3D=3D=
=3D=3D
Code;  c0112803 <__wake_up+33/c0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c0112805 <__wake_up+35/c0>
   5:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0112808 <__wake_up+38/c0>
   8:   74 64                     je     6e <_EIP+0x6e> c011286e <__wake_up=
+9e/c0>
Code;  c011280a <__wake_up+3a/c0>
   a:   31 c0                     xor    %eax,%eax
Code;  c011280c <__wake_up+3c/c0>
   c:   9c                        pushf =20
Code;  c011280d <__wake_up+3d/c0>
   d:   5e                        pop    %esi
Code;  c011280e <__wake_up+3e/c0>
   e:   fa                        cli   =20
Code;  c011280f <__wake_up+3f/c0>
   f:   f0 fe 0d 00 f8 00 00      lock decb 0xf800


2 warnings issued.  Results may not be reliable.

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops3.txt"

ksymoops 2.4.0 on i686 2.4.12-lsm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-lsm/ (default)
     -m /boot/System.map-2.4.12-lsm (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c022f660, System.map says c0151f80.  Ignoring ksyms_base entry
  <1>Unable to handle kernel paging request at virtual address a8d4b5ec
 c012ae6e
 *pde = 00000000
 Oops: 0002
 CPU:    1
 EIP:    0010:[kfree+110/144]    Not tainted
 EIP:    0010:[<c012ae6e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010092
 eax: d681c620   ebx: d4a14000   ecx: c15284c0   edx: b50cdd79
 esi: d681c620   edi: 00000282   ebp: d4f67440   esp: d4d77f08
 ds: 0018   es: 0018   ss: 0018
 Process sadc (pid: 1609, stackpage=d4d77000)
 Stack: d681c620 c02eabe0 00000000 d93cf5a0 40018000 d954c9a0 c014ce70 d954c9a0
        c01456be d681c620 d954c9a0 c0146d74 d954c9a0 d4f67440 d954c9a0 c01445a6
        d954c9a0 00000001 00000000 d93cf5a0 d93cf5a0 d93cf5a0 c1958f20 c0133ba3
 Call Trace: [proc_delete_inode+0/80] [destroy_inode+30/48] [iput+404/416] [dput+230/336] [fput+211/256]
 Call Trace: [<c014ce70>] [<c01456be>] [<c0146d74>] [<c01445a6>] [<c0133ba3>]
    [<c01328bd>] [<c013292b>] [<c0106f1b>]
 Code: 89 44 93 08 ff 03 eb 10 6a 01 8d 44 24 04 50 51 e8 cd fb ff

>>EIP; c012ae6e <kfree+6e/90>   <=====
Trace; c014ce70 <proc_delete_inode+0/50>
Trace; c01456be <destroy_inode+1e/30>
Trace; c0146d74 <iput+194/1a0>
Trace; c01445a6 <dput+e6/150>
Trace; c0133ba3 <fput+d3/100>
Trace; c01328bd <filp_close+8d/a0>
Trace; c013292b <sys_close+5b/70>
Trace; c0106f1b <system_call+33/38>
Code;  c012ae6e <kfree+6e/90>
00000000 <_EIP>:
Code;  c012ae6e <kfree+6e/90>   <=====
   0:   89 44 93 08               mov    %eax,0x8(%ebx,%edx,4)   <=====
Code;  c012ae72 <kfree+72/90>
   4:   ff 03                     incl   (%ebx)
Code;  c012ae74 <kfree+74/90>
   6:   eb 10                     jmp    18 <_EIP+0x18> c012ae86 <kfree+86/90>
Code;  c012ae76 <kfree+76/90>
   8:   6a 01                     push   $0x1
Code;  c012ae78 <kfree+78/90>
   a:   8d 44 24 04               lea    0x4(%esp,1),%eax
Code;  c012ae7c <kfree+7c/90>
   e:   50                        push   %eax
Code;  c012ae7d <kfree+7d/90>
   f:   51                        push   %ecx
Code;  c012ae7e <kfree+7e/90>
  10:   e8 cd fb ff 00            call   fffbe2 <_EIP+0xfffbe2> c112aa50 <_end+d93cd4/204c52e4>


2 warnings issued.  Results may not be reliable.

--FCuugMFkClbJLl1L--

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwCnygACgkQ9PIYKZYVAq3OTgCdHQaVXUYDmLdHbsxTa+y3m0RJ
cnAAn12NMJM7SFvlZARN/cuVH4pe2wX0
=6/TQ
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
