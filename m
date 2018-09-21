Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8L8qndS009251
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 04:52:49 -0400
Received: by mail-lj1-f179.google.com with SMTP id p10-v6so10923448ljg.2
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 01:52:46 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Benjamin_Sch=C3=BCle?= <bschuele@gmail.com>
Date: Fri, 21 Sep 2018 10:50:33 +0200
Message-ID: <CAC=PkGvDqY8JuBcO_N0zAo7Zwhf+k_s--iowEDh3AxjQJShHNQ@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Bug in selinux on ubuntu 16.04 with kernel 4.15.0-34
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

 just found a bug in selinux. It appears on ubuntu 16.04 with kernel
4.15, but not with kernel 4.4.

What's going wrong:
Copy a link with "-a" option while selinux is on.


steps to reproduce:
  ~$ mkdir -p a/b
  ~$ ln -s b a/c
  ~$ cp -a a b
  cp: failed to restore the default file creation context: Invalid argument


Results of my investigation:

The "cp" of coreutils is calling "setfscreatecon (NULL)" to restore
the default file creation context (coreutils-8.30/src/copy.c:1771) as
it is stated in the selinux api
(/libselinux/include/selinux/selinux.h:71).

As we see in the result of strace below, the kernel returns an -1 on
try to restore the default file creation context. So, in my opinion,
is the bug has to be in the selinux_setprocattr method in the
security/selinux/hooks.c file.


Part of "strace  cp -a a b"

lgetxattr("a/c", "security.selinux",
"system_u:object_r:user_home_dir_t:s0", 255) = 37
readlink("a/c", "b", 2)                 = 1
symlink("b", "b/a/c")                   = 0
open("/proc/self/task/2136/attr/fscreate", O_RDWR|O_CLOEXEC) = 3
write(3, NULL, 0)                       = -1 EINVAL (Invalid argument)
close(3)                                = 0
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2995, ...}) = 0
read(3, "# Locale name alias data base.\n#"..., 4096) = 2995
read(3, "", 4096)                       = 0
close(3)
