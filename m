From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: draper7@ziplip.com, SELinux@tycho.nsa.gov
Subject: Re: spasswd.c
Date: Sun, 16 Feb 2003 21:12:36 +0100
References: <MPCKDQD2D5PXECB1KMMIFRPTCEPZOPB0IJGLEHIP@ziplip.com>
In-Reply-To: <MPCKDQD2D5PXECB1KMMIFRPTCEPZOPB0IJGLEHIP@ziplip.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302162112.36169.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 16 Feb 2003 20:35, Dusty Hall wrote:
>   I'm having trouble compiling utils, specifically spasswd.  I've read
>
> [root@localhost:~/downloads/selinux/utils/spasswd] make
> cc -Wall -g -I/usr/local/selinux/include  -L/usr/local/selinux/lib 
> spasswd.c   -o spasswd spasswd.c: In function `sig_handler':
> spasswd.c:47: warning: implicit declaration of function `kill'
> spasswd.c: In function `main':
> spasswd.c:66: storage size of `sa' isn't known

Add the following near the top of spasswd.c:
#include <signal.h>

After the following line would be good:
#include <sys/types.h>

The problem was that when I added the kill() call for proxying signals I 
didn't add enough #include lines, it worked on my system and apparently on 
most people's systems too.  Steve, can this be added to the CVS?

Probably OWL is using an older glibc which relies on getting these things 
right.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
