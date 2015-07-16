Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GCr5Qs027817
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 08:53:06 -0400
Date: Thu, 16 Jul 2015 14:53:46 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Dan <dtdevore64@yahoo.com>
Subject: Re: Trouble building secilc compiler
Message-ID: <20150716125316.GA31003@sec-eng-01.lab.eng.brq.redhat.com>
References: <55A72AE8.6010104@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A72AE8.6010104@yahoo.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 11:54:16PM -0400, Dan wrote:
> I am having trouble building the secilc compiler. I cloned this repository:
> "https://github.com/SELinuxProject/selinux" and when I change into
> the directory "secilc", and try to run the "make" command it gives
> me this output:
> 
> 
> 
> [steve@localhost secilc]$ sudo make
> "cc -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute
> -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
> -I/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64   -c -o secilc.o
> secilc.c
> secilc.c:30:20: fatal error: stdlib.h: No such file or directory
> compilation terminated.
> <builtin>: recipe for target 'secilc.o' failed
> make: *** [secilc.o] Error 1"
> 
> 
> I'm not sure what I'm doing wrong, I am just trying to get the
> compiler because I have upgraded everything else on my system to
> selinux userspace 2.4 from this website below.

I can only guess that you are missing glibc-headers package installed.
> 
> "https://fedoraproject.org/wiki/Changes/SELinuxPolicyStoreMigration"
> 
> 
> If anyone can help me I would really appreciate it. Thanks.

I'm just building secilc package in my plautrba/selinux COPR repository:

https://copr.fedoraproject.org/coprs/plautrba/selinux/builds/

and I'm going to send it to package review process soon.

Petr
