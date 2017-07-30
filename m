Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6UIr3i2021566
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 14:53:03 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 2B0371A159
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 20:52:54 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tmBdnkcx44TP for <selinux@tycho.nsa.gov>;
 Sun, 30 Jul 2017 20:52:51 +0200 (CEST)
Received: from [IPv6:2a02:a03f:3c95:a400:d76d:2ac1:8d95:35cb] (unknown
 [IPv6:2a02:a03f:3c95:a400:d76d:2ac1:8d95:35cb])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id A5D4E1A074
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 20:52:51 +0200 (CEST)
To: selinux <selinux@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <d296cb72-90a1-4ebd-5d9d-879c0b4165b1@debian.org>
Date: Sun, 30 Jul 2017 20:52:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: setfiles crashing when SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

When using sefiles (setfiles -m -F -v 
/etc/selinux/refpolicy/contexts/files/file_contexts.bin  /) when SELinux 
is disabled, it crahes with the fillowing trace:

#0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
No locals.
#1  0x00007f13241957be in restorecon_sb (pathname=0xd36aa93160 "/usr/include/xf86drm.h", flags=flags@entry=0x7fffd3700ae3, sb=<optimized out>, sb=<optimized out>) at selinux_restorecon.c:666
         newcon = 0xd36abdc100 "system_u:object_r:usr_t:s0"
         curcon = 0x0
         newtypecon = 0x0
         rc = <optimized out>
         updated = false
         lookup_path = <optimized out>
#2  0x00007f1324196810 in selinux_restorecon (pathname_orig=pathname_orig@entry=0xd36aa943e0 "/", restorecon_flags=<optimized out>) at selinux_restorecon.c:984
         flags = {nochange = false, verbose = true, progress = false, set_specctx = true, add_assoc = true, ignore_digest = false, recurse = true, userealpath = false, set_xdev = true, abort_on_error = true,
           syslog_changes = false, log_matches = false, ignore_noent = false}
         issys = false
         setrestoreconlast = <optimized out>
         sb = {st_dev = 64769, st_ino = 2, st_nlink = 20, st_mode = 16877, st_uid = 0, st_gid = 0, __pad0 = 0, st_rdev = 0, st_size = 4096, st_blksize = 4096, st_blocks = 8, st_atim = {tv_sec = 1501439201,
             tv_nsec = 886964517}, st_mtim = {tv_sec = 1501435537, tv_nsec = 187391390}, st_ctim = {tv_sec = 1501439165, tv_nsec = 374865190}, __glibc_reserved = {0, 0, 0}}
         sfsb = {f_type = 61267, f_bsize = 4096, f_blocks = 3838052, f_bfree = 480404, f_bavail = 295268, f_files = 977280, f_ffree = 677268, f_fsid = {__val = {9930339, 726475040}}, f_namelen = 255,
           f_frsize = 4096, f_flags = 4128, f_spare = {0, 0, 0, 0}}
         fts = 0xd36aa93110
         ftsent = 0xd36ab77290
         pathname = 0xd36aa943a0 "/"
         pathdnamer = 0x0
         pathdname = <optimized out>
         pathbname = <optimized out>
         paths = {0xd36aa943a0 "/", 0x0}
         fts_flags = <optimized out>
         error = 0
         sverrno = <optimized out>
         xattr_value = 0x0
         size = <optimized out>
         dev_num = 64769
         __func__ = "selinux_restorecon"
#3  0x000000d368f23152 in process_glob (name=<optimized out>, opts=<optimized out>) at restore.c:89
         globbuf = {gl_pathc = 1, gl_pathv = 0xd36aa943c0, gl_offs = 0, gl_flags = 13456, gl_closedir = 0x0, gl_readdir = 0x0, gl_opendir = 0x0, gl_lstat = 0x0, gl_stat = 0x0}
         i = 0
         len = <optimized out>
         rc = <optimized out>
         errors = 0
#4  0x000000d368f229b0 in main (argc=6, argv=0x7fffd3700eb8) at setfiles.c:459
         sb = {st_dev = 64769, st_ino = 391936, st_nlink = 1, st_mode = 33188, st_uid = 0, st_gid = 0, __pad0 = 0, st_rdev = 0, st_size = 1383869, st_blksize = 4096, st_blocks = 2712, st_atim = {
             tv_sec = 1501439075, tv_nsec = 298617901}, st_mtim = {tv_sec = 1501438955, tv_nsec = 50281901}, st_ctim = {tv_sec = 1501438955, tv_nsec = 50281901}, __glibc_reserved = {0, 0, 0}}
         opt = <optimized out>
         i = <optimized out>
         input_filename = 0x0
         use_input_file = <optimized out>
         buf = 0x0
         buf_len = 71776119061217535
         base = <optimized out>
         mass_relabel = <optimized out>
         errors = 0
         ropts = 0xd368f2367c "e:f:hiIDlmno:pqrsvFRW0"
         sopts = 0xd368f23660 "c:de:f:hiIDlmno:pqr:svFR:W0"
         opts = <optimized out>
