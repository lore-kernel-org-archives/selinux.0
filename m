Date: Thu, 11 Apr 2002 20:41:56 -0700 (PDT)
From: Sung Kim <hunkim@cse.ucsc.edu>
To: SELinux@tycho.nsa.gov
Subject: Compile error with Download 2.4 LSM-based Prototype (stable,
 recommended)
Message-ID: <Pine.GSO.4.44.0204112038440.17711-100000@sundance.cse.ucsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I tried to install 2.4 LSM-based Prototype (stable, recommended).
But I've got these error messages.

make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -I../include -I.. -DKBUILD_\BASENAME=queue  -c -o queue.o queue.c
queue.c: In function `__selopt_queue_dequeue':
queue.c:98: warning: implicit declaration of function `nf_reinject'
queue.c: In function `match_dev':
queue.c:169: dereferencing pointer to incomplete type
queue.c:170: dereferencing pointer to incomplete type
queue.c:173: dereferencing pointer to incomplete type
queue.c:174: dereferencing pointer to incomplete type
queue.c: In function `selopt_queue_init':
queue.c:416: warning: implicit declaration of function `nf_register_queue_handler'
queue.c: In function `selopt_queue_exit':
queue.c:429: warning: implicit declaration of function `nf_unregister_queue_handler'
make[3]: *** [queue.o] Error 1
make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/selopt'
make[2]: *** [_subdir_selopt] Error 2
make[2]: Leaving directory `/usr/src/lsm-2.4/security/selinux'
make[1]: *** [_subdir_selinux] Error 2
make[1]: Leaving directory `/usr/src/lsm-2.4/security'
make: *** [_dir_security] Error 2

My gcc version is 3.0.2 and tried in Linux hunkim.cse.ucsc.edu 2.4.17 #1 SMP Fri Jan 4 14:46:58 EST 2002 i686 unknown.
I set all possible security options.

Any idea?

--
Sung Kim <hunkim@cse.ucsc.edu>
http://www.cse.ucsc.edu/~hunkim

 "Dreams become reality!"


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
