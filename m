To: =?UTF-8?Q?Benjamin_Sch=c3=bcle?= <bschuele@gmail.com>,
 selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
References: <CAC=PkGvDqY8JuBcO_N0zAo7Zwhf+k_s--iowEDh3AxjQJShHNQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c07d0205-eda3-3f68-3691-2c95617e6c78@tycho.nsa.gov>
Date: Fri, 21 Sep 2018 13:10:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAC=PkGvDqY8JuBcO_N0zAo7Zwhf+k_s--iowEDh3AxjQJShHNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: Bug in selinux on ubuntu 16.04 with kernel 4.15.0-34
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2018 04:50 AM, Benjamin Schüle wrote:
> Hello,
> 
>   just found a bug in selinux. It appears on ubuntu 16.04 with kernel
> 4.15, but not with kernel 4.4.
> 
> What's going wrong:
> Copy a link with "-a" option while selinux is on.
> 
> 
> steps to reproduce:
>    ~$ mkdir -p a/b
>    ~$ ln -s b a/c
>    ~$ cp -a a b
>    cp: failed to restore the default file creation context: Invalid argument
> 
> 
> Results of my investigation:
> 
> The "cp" of coreutils is calling "setfscreatecon (NULL)" to restore
> the default file creation context (coreutils-8.30/src/copy.c:1771) as
> it is stated in the selinux api
> (/libselinux/include/selinux/selinux.h:71).
> 
> As we see in the result of strace below, the kernel returns an -1 on
> try to restore the default file creation context. So, in my opinion,
> is the bug has to be in the selinux_setprocattr method in the
> security/selinux/hooks.c file.
> 
> 
> Part of "strace  cp -a a b"
> 
> lgetxattr("a/c", "security.selinux",
> "system_u:object_r:user_home_dir_t:s0", 255) = 37
> readlink("a/c", "b", 2)                 = 1
> symlink("b", "b/a/c")                   = 0
> open("/proc/self/task/2136/attr/fscreate", O_RDWR|O_CLOEXEC) = 3
> write(3, NULL, 0)                       = -1 EINVAL (Invalid argument)
> close(3)                                = 0
> open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=2995, ...}) = 0
> read(3, "# Locale name alias data base.\n#"..., 4096) = 2995
> read(3, "", 4096)                       = 0
> close(3)

This appears to be Ubuntu-specific; I can't reproduce upstream.  If you 
are able to reproduce with an upstream kernel, let us know; otherwise, 
file a bug with Ubuntu.  A quick look at the Ubuntu kernel git tree 
shows the following commit which would explain this regression.

commit 36788bfe15f16b2eba39d0e563ae8027c5072b98
Author: Colin Ian King <colin.king@canonical.com>
Date:   Tue Oct 3 13:12:54 2017 +0100

     UBUNTU: SAUCE: LSM stacking: check for invalid zero sized writes

     BugLink: http://bugs.launchpad.net/bugs/1720779
     BugLink: http://bugs.launchpad.net/bugs/1763062


     Writing zero bytes to /proc/$pid/task/$pid/attr/context via
     security_setprocattr cause an oops in memcpy_erms. Fix this by
     checking for zero size and returning -EINVAL for this invalid
     write size.

     Detected by running stress-ng --procfs 0

     Signed-off-by: Colin Ian King <colin.king@canonical.com>
     Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
