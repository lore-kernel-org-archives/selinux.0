Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6996ZHa022310
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 05:06:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6996YH5025023
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 09:06:34 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6996WRX025017 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 09:06:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: context trouble with 2.5 bits
Date: Wed, 9 Jul 2003 19:06:14 +1000
Cc: selinux@tycho.nsa.gov
References: <1057701768.25921.53.camel@columbia> <200307091017.42539.russell@coker.com.au> <1057716690.5878.25.camel@columbia>
In-Reply-To: <1057716690.5878.25.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307091906.14699.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jul 2003 12:11, Colin Walters wrote:
> > is expected.  Please tell me what "ls --context /dev/tty1" reports.
>
> meta:/var/log# ls --context /dev/tty1
> crw-------  root     tty      system_u:object_r:tty_device_t   /dev/tty1
> meta:/var/log#

That's what we want to see.

> Jul  8 21:41:52 meta sshd[642]: Accepted password for root from
> ::ffff:192.168.1.100 port 36286 ssh2 Jul  8 21:41:52 meta sshd[642]: fatal:
> Failed to get default security context for root.
>
> The same thing happens with a normal user.

What is the line in the "users" file for root?  Is there a line in the "users" 
file for the non-root user you tried?  If not is there a line for user_u?

> > Also while in permissive mode do some tests at the command line, do:
> > # echo user_u:user_r:user_t > /proc/whatever-it-is
> > # id
> >
> > Then id should report a context of user_u:user_r:user_t if the context
> > change is working correctly.
>
> Here's what I get:
>
> meta:/var/log# cat /proc/self/attr/current  && echo
> system_u:system_r:user_t
> meta:/var/log# echo root:system_r:sysadm_r > /proc/self/attr/current
> meta:/var/log# cat /proc/self/attr/current  && echo
> system_u:system_r:user_t
> meta:/var/log#

Sorry, you misunderstood my message.

I mean to echo a value to the file that specifies the context for the child 
process (you can't change the context of a running process, not even in 
permissive mode).

> > Does your /etc/security/default_contexts have the right stuff?
>
> It looks like this:
>
> system_r:local_login_t  user_r:user_t staff_r:staff_t
> system_r:sshd_t         user_r:user_t staff_r:staff_t
> system_r:crond_t        user_r:user_crond_t staff_r:staff_crond_t
> system_r:system_crond_t

Have you checked that sshd is running as system_u:system_r:sshd_t and that the 
"users" file permits the contexts user_r:user_t or staff_r:staff_t?  If you 
configured "root" to only be permitted the context sysadm_r:sysadm_t then it 
will be impossible to login as root via ssh (I have intentionally configured 
it this way on my laptop).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
