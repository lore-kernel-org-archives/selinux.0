Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G3vFvn026334
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 23:57:15 -0400
To: selinux@tycho.nsa.gov
From: Dan <dtdevore64@yahoo.com>
Subject: Trouble building secilc compiler
Message-ID: <55A72AE8.6010104@yahoo.com>
Date: Wed, 15 Jul 2015 23:54:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am having trouble building the secilc compiler. I cloned this repository:
"https://github.com/SELinuxProject/selinux" and when I change into the 
directory "secilc", and try to run the "make" command it gives me this 
output:



[steve@localhost secilc]$ sudo make
"cc -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute 
-Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused -I/usr/include 
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64   -c -o secilc.o secilc.c
secilc.c:30:20: fatal error: stdlib.h: No such file or directory
compilation terminated.
<builtin>: recipe for target 'secilc.o' failed
make: *** [secilc.o] Error 1"


I'm not sure what I'm doing wrong, I am just trying to get the compiler 
because I have upgraded everything else on my system to selinux 
userspace 2.4 from this website below.

"https://fedoraproject.org/wiki/Changes/SELinuxPolicyStoreMigration"


If anyone can help me I would really appreciate it. Thanks.
