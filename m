Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HF5YDa020286
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 11:05:34 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7HF5X3G023910
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 15:05:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: weird mprotect error
Date: Fri, 17 Aug 2007 11:05:29 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <joe@nall.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was working on a RHEL 5.1 beta machine with MLS policy, and I get a weird mprotect EACCES error in enforcing.  I have the folowing hello-world program:

#include <stdio.h>

main()
{
        printf("mlstest\n");
}

and the following policy:

policy_module(mlstest,1.0.1)
require { sensitivity s4; category c253; }

type mlstest_t;
type mlstest_exec_t;
domain_type(mlstest_t)
init_ranged_daemon_domain(mlstest_t,mlstest_exec_t,s4:c0.c253)
mls_rangetrans_target(mlstest_t)
 
libs_use_ld_so(mlstest_t)
libs_use_shared_libs(mlstest_t)
init_use_fds(mlstest_t)
init_use_script_ptys(mlstest_t)
domain_use_interactive_fds(mlstest_t)

#mls_fd_use_all_levels(mlstest_t)

Without the one mls rule, I get a denial, as expected, since mlstest_t's level is not equal to initrc_t's:

avc:  denied  { use } for  pid=3884 comm="mlstest" path="/lib/ld-2.5.so" dev=dm-0 ino=16842976 scontext=system_u:system_r:mlstest_t:s4:c0.c253 tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=fd

What is weird thing is that ld.so is in the path of denial which seems unexpected.  I would have expected to see a pty (since this was via run_init).  The behavior in the program is also not what was expected as shown by the strace:

execve("/home/jcdxdev/mlstest/mlstest", ["/home/jcdxdev/mlstest/mlstest"], [/* 19 vars */]) = 0
brk(0)                                  = 0x86fa000
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
access("/etc/suid-debug", F_OK)         = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f50000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=57159, ...}) = 0
mmap2(NULL, 57159, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f42000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\337"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1576952, ...}) = 0
mmap2(0x9b8000, 1295780, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x9b8000
mmap2(0xaef000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x137) = 0xaef000
mmap2(0xaf2000, 9636, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xaf2000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f41000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f416c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xaef000, 8192, PROT_READ)     = 0
mprotect(0x9b4000, 4096, PROT_READ)     = -1 EACCES (Permission denied)
writev(2, [{"/home/jcdxdev/mlstest/mlstest", 29}, {": ", 2}, {"error while loading shared libra"..., 36}, {": ", 2}, {"/lib/ld-linux.so.2", 18}, {": ", 2}, {"cannot apply additional memory p"..., 58}, {": ", 2}, {"Permission denied", 17}, {"\n", 1}], 10) = 167
exit_group(127)                         = ?

The mprotect fails with perm denied.  The only denial is the above one.  If you uncomment the mls rule in the above policy, the program functions as anticipated.  

Ideas?

--
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
