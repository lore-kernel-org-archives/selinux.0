Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0T4YFRb009611
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 23:34:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0T4YE1I029855
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 04:34:14 GMT
Received: from smtp016.mail.yahoo.com (smtp016.mail.yahoo.com [216.136.174.113])
        by jazzband.ncsc.mil  with SMTP id i0T4YDbs029852 for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 04:34:14 GMT
Date: Wed, 28 Jan 2004 22:23:05 -0600
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Compiling a 2.6 UML kernel
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
Message-Id: <D578F80A-5212-11D8-9EEB-000393013D1A@unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi folks,

I'm trying to compile a 2.6 kernel with User Mode Linux support, using 
the latest 2.6 available on the website (linux-2.6-2003120509.tgz). 
After selecting the modules I need ("make menuconfig ARCH=um"), this is 
the error I get when I do a "make ARCH=um":

[root@myhost selinux-2.6]# make ARCH=um
   HOSTCC  scripts/genksyms/genksyms.o
   SHIPPED scripts/genksyms/lex.c
   SHIPPED scripts/genksyms/parse.h
   SHIPPED scripts/genksyms/keywords.c
   HOSTCC  scripts/genksyms/lex.o
   SHIPPED scripts/genksyms/parse.c
   HOSTCC  scripts/genksyms/parse.o
   HOSTLD  scripts/genksyms/genksyms
   HOSTCC  scripts/split-include
   HOSTCC  scripts/conmakehash
   HOSTCC  scripts/docproc
   HOSTCC  scripts/kallsyms
   CC      scripts/empty.o
   HOSTCC  scripts/mk_elfconfig
   MKELF   scripts/elfconfig.h
   HOSTCC  scripts/file2alias.o
   HOSTCC  scripts/modpost.o
   HOSTLD  scripts/modpost
   HOSTCC  scripts/pnmtologo
   HOSTCC  scripts/bin2c
   SPLIT   include/linux/autoconf.h -> include/config/*
   HOSTCC  arch/um/sys-i386/util/mk_sc.o
   HOSTLD  arch/um/sys-i386/util/mk_sc
arch/um/sys-i386/util/mk_sc > arch/um/include/sysdep-i386/sc.h
cd /usr/src/selinux-2.6/include/asm-um && ln -sf ../asm-i386 arch
cd arch/um/include && ln -sf sysdep-i386 sysdep
cd arch/um && ln -sf os-Linux os
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf archparam-i386.h archparam.h
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf system-i386.h system.h
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf sigcontext-i386.h sigcontext.h
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf processor-i386.h processor.h
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf ptrace-i386.h ptrace.h
cd /usr/src/selinux-2.6/include/asm-um/ ; \
ln -sf arch-signal-i386.h arch-signal.h
sed 's/ CONFIG/ UML_CONFIG/' 
/usr/src/selinux-2.6/include/linux/autoconf.h > 
arch/um/include/uml-config.h
gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
   CC      arch/um/util/mk_task_kern.o
In file included from include/asm/system-generic.h:4,
                  from include/asm/system.h:4,
                  from include/linux/list.h:8,
                  from include/linux/signal.h:4,
                  from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:22,
                  from include/asm/thread_info.h:11,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/util/mk_task_kern.c:1:
include/asm/arch/system.h:7:28: asm/cpufeature.h: No such file or 
directory
In file included from include/linux/time.h:28,
                  from include/asm/arch/signal.h:6,
                  from include/asm/signal.h:12,
                  from include/linux/signal.h:6,
                  from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:22,
                  from include/asm/thread_info.h:11,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/util/mk_task_kern.c:1:
include/linux/seqlock.h:35: parse error before "spinlock_t"
include/linux/seqlock.h:35: warning: no semicolon at end of struct or 
union
include/linux/seqlock.h:36: warning: type defaults to `int' in 
declaration of `seqlock_t'
include/linux/seqlock.h:36: warning: data definition has no type or 
storage class
include/linux/seqlock.h:50: parse error before '*' token
include/linux/seqlock.h:51: warning: function declaration isn't a 
prototype
include/linux/seqlock.h: In function `write_seqlock':
include/linux/seqlock.h:52: warning: implicit declaration of function 
`spin_lock'
include/linux/seqlock.h:52: `sl' undeclared (first use in this function)
include/linux/seqlock.h:52: (Each undeclared identifier is reported 
only once
include/linux/seqlock.h:52: for each function it appears in.)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:57: parse error before '*' token
include/linux/seqlock.h:58: warning: function declaration isn't a 
prototype
include/linux/seqlock.h: In function `write_sequnlock':
include/linux/seqlock.h:60: `sl' undeclared (first use in this function)
include/linux/seqlock.h:61: warning: implicit declaration of function 
`spin_unlock'
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:64: parse error before '*' token
include/linux/seqlock.h:65: warning: function declaration isn't a 
prototype
include/linux/seqlock.h: In function `write_tryseqlock':
include/linux/seqlock.h:66: warning: implicit declaration of function 
`spin_trylock'
include/linux/seqlock.h:66: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:76: warning: type defaults to `int' in 
declaration of `seqlock_t'
include/linux/seqlock.h:76: parse error before '*' token
include/linux/seqlock.h:77: warning: function declaration isn't a 
prototype
include/linux/seqlock.h: In function `read_seqbegin':
include/linux/seqlock.h:78: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:91: warning: type defaults to `int' in 
declaration of `seqlock_t'
include/linux/seqlock.h:91: parse error before '*' token
include/linux/seqlock.h:92: warning: function declaration isn't a 
prototype
include/linux/seqlock.h: In function `read_seqretry':
include/linux/seqlock.h:94: `iv' undeclared (first use in this function)
include/linux/seqlock.h:94: `sl' undeclared (first use in this function)
In file included from include/asm/arch/signal.h:6,
                  from include/asm/signal.h:12,
                  from include/linux/signal.h:6,
                  from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:22,
                  from include/asm/thread_info.h:11,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/util/mk_task_kern.c:1:
include/linux/time.h: At top level:
include/linux/time.h:297: parse error before "xtime_lock"
include/linux/time.h:297: warning: type defaults to `int' in 
declaration of `xtime_lock'
include/linux/time.h:297: warning: data definition has no type or 
storage class
In file included from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:22,
                  from include/asm/thread_info.h:11,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/util/mk_task_kern.c:1:
include/linux/signal.h:16: parse error before "spinlock_t"
include/linux/signal.h:16: warning: no semicolon at end of struct or 
union
include/linux/signal.h:19: parse error before '}' token
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2

Any clues? Has anybody tried to compile this with UML support? Do you 
recommend to use the 2.4 kernel with the UML patch, instead?
Thanks a lot!

Ignacio


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
