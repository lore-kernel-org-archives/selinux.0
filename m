Return-Path: <SRS0=tF6o=Q7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A1C43381
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981B20661
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 17:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfBXRjw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 12:39:52 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:51160 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfBXRjw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Feb 2019 12:39:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id BD2EE2E0FA1
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 18:39:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8QruuQYolhs0 for <selinux@vger.kernel.org>;
        Sun, 24 Feb 2019 18:39:46 +0100 (CET)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id E98CF2E0FA0
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 18:39:45 +0100 (CET)
Date:   Sun, 24 Feb 2019 18:39:44 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: Bash 5 change in behavior and SELinux
Message-ID: <20190224173944.GA18551@brutus.lan>
References: <20190224165919.GA4310@brutus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224165919.GA4310@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 24, 2019 at 05:59:19PM +0100, Dominick Grift wrote:
> Recently Bash-5 appeared in the Fedora repositories and i instantly noticed an inpleasant change (for the record: this did not happen before):

I suppose this is just a "feature" or a "bug" in Bash-5 and that i will just have to deal with it. Just seems a bit unnecessary access to me.

> 
> [kcinimod@brutus ~]$ touch mytest1.test
> [kcinimod@brutus ~]$ rm ~/*.test
> rm: cannot remove '/home/kcinimod/*.test': No such file or directory
> [kcinimod@brutus ~]$ rm ~/mytest1.test
> [kcinimod@brutus ~]$ echo $?
> 0
> 
> After running `semodule -DB` the following AVC denials surfaced:
> 
> avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-3" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:files.home.file:s0 tclass=dir permissive=1
> avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-1" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:fs.rootfs.fs:s0 tclass=dir permissive=1
> 
> So I took to #bash and they told me:
> 
> 17:43 <_abc_> grift: that is exactly what you see on android and is
>               a direct result of the missing x bit equivalent in
>               the selinux policy
> 
> 17:44 <_abc_> grift: rephrased: globbing the * requires the x bit
>               set
> 17:44 <_abc_> (it's equivalent in selinux policy)
> 
> So why does this show up as a "read"? Its allowed to "search" "/" and "/home", but since Bash 5 this no longer is enough.
> 
> Scripts break everywhere because of this
> 
> Here is an strace:
> 
> execve("/usr/bin/rm", ["rm", "/home/kcinimod/*.test"], 0x7ffd4a604e68 /* 33 vars */) = 0
> brk(NULL)                               = 0x55fd172f2000
> arch_prctl(0x3001 /* ARCH_??? */, 0x7ffd55284d40) = -1 EINVAL (Invalid argument)
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=73196, ...}) = 0
> mmap(NULL, 73196, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f2000
> close(3)                                = 0
> openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@@\2\0\0\0\0\0"..., 832) = 832
> lseek(3, 792, SEEK_SET)                 = 792
> read(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0's\373BN\237-\352\fHBW\214\275t\225"..., 68) = 68
> fstat(3, {st_mode=S_IFREG|0755, st_size=5591560, ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fce3e2f0000
> lseek(3, 792, SEEK_SET)                 = 792
> read(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0's\373BN\237-\352\fHBW\214\275t\225"..., 68) = 68
> lseek(3, 864, SEEK_SET)                 = 864
> read(3, "\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32) = 32
> mmap(NULL, 1857568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fce3e12a000
> mprotect(0x7fce3e14c000, 1679360, PROT_NONE) = 0
> mmap(0x7fce3e14c000, 1363968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7fce3e14c000
> mmap(0x7fce3e299000, 311296, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16f000) = 0x7fce3e299000
> mmap(0x7fce3e2e6000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1bb000) = 0x7fce3e2e6000
> mmap(0x7fce3e2ec000, 14368, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fce3e2ec000
> close(3)                                = 0
> arch_prctl(ARCH_SET_FS, 0x7fce3e2f1580) = 0
> mprotect(0x7fce3e2e6000, 16384, PROT_READ) = 0
> mprotect(0x55fd17129000, 4096, PROT_READ) = 0
> mprotect(0x7fce3e32e000, 4096, PROT_READ) = 0
> munmap(0x7fce3e2f2000, 73196)           = 0
> brk(NULL)                               = 0x55fd172f2000
> brk(0x55fd17313000)                     = 0x55fd17313000
> brk(NULL)                               = 0x55fd17313000
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=2997, ...}) = 0
> read(3, "# Locale name alias data base.\n#"..., 4096) = 2997
> read(3, "", 4096)                       = 0
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_IDENTIFICATION", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_IDENTIFICATION", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=368, ...}) = 0
> mmap(NULL, 368, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e32d000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib64/gconv/gconv-modules.cache", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=26398, ...}) = 0
> mmap(NULL, 26398, PROT_READ, MAP_SHARED, 3, 0) = 0x7fce3e2fd000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_MEASUREMENT", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_MEASUREMENT", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=23, ...}) = 0
> mmap(NULL, 23, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2fc000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_TELEPHONE", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_TELEPHONE", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=59, ...}) = 0
> mmap(NULL, 59, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2fb000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_ADDRESS", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_ADDRESS", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=167, ...}) = 0
> mmap(NULL, 167, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2fa000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_NAME", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_NAME", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=77, ...}) = 0
> mmap(NULL, 77, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f9000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_PAPER", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_PAPER", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=34, ...}) = 0
> mmap(NULL, 34, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f8000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_MESSAGES", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_MESSAGES", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=57, ...}) = 0
> mmap(NULL, 57, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f7000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_MONETARY", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_MONETARY", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=286, ...}) = 0
> mmap(NULL, 286, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f6000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_COLLATE", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_COLLATE", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=2586242, ...}) = 0
> mmap(NULL, 2586242, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3deb2000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_TIME", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_TIME", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=3284, ...}) = 0
> mmap(NULL, 3284, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f5000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_NUMERIC", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_NUMERIC", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=54, ...}) = 0
> mmap(NULL, 54, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3e2f4000
> close(3)                                = 0
> openat(AT_FDCWD, "/usr/lib/locale/en_US.UTF-8/LC_CTYPE", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/locale/en_US.utf8/LC_CTYPE", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=337024, ...}) = 0
> mmap(NULL, 337024, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fce3de5f000
> close(3)                                = 0
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> newfstatat(AT_FDCWD, "/home/kcinimod/*.test", 0x55fd172f88e8, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
> geteuid()                               = 1000
> newfstatat(AT_FDCWD, "/home/kcinimod/*.test", 0x7ffd55284a60, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> write(2, "rm: ", 4rm: )                     = 4
> write(2, "cannot remove '/home/kcinimod/*."..., 37cannot remove '/home/kcinimod/*.test') = 37
> openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> write(2, ": No such file or directory", 27: No such file or directory) = 27
> write(2, "\n", 1
> )                       = 1
> lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
> close(0)                                = 0
> close(1)                                = 0
> close(2)                                = 0
> exit_group(1)                           = ?
> +++ exited with 1 +++
> 
> -- 
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
