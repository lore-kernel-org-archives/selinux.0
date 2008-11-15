Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAF0crA5024731
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 19:38:53 -0500
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAF0b3xE020320
	for <selinux@tycho.nsa.gov>; Sat, 15 Nov 2008 00:37:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: 2.6.26 Debian kernel panic
Date: Sat, 15 Nov 2008 11:38:42 +1100
Cc: Paul Menzel <paul.menzel@web.de>
References: <200810281410.45041.russell@coker.com.au>
In-Reply-To: <200810281410.45041.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811151138.43153.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have reproduced the below problem with the DomU in question having SE Linux 
disabled.  The symptom of a process taking maximum CPU time and then killing 
the system if it was stopped was occurring with Apache and ejabberd 
processes.  I rebooted the DomU about 6 times and had the problem occur each 
time.

The evidence seems quite clear that it was not a SE Linux problem.

It was suggested that the problem could be related to dodgey RAM, a memtest86+ 
run for 6 hours did not find any errors.  While this is not conclusive 
evidence of a lack of a problem, it's a strong indication that when a problem 
is reproducable quickly and easily when running a kernel but not over the 
course of 6 hours of memtest86+ then it's not faulty RAM.

The DomU in question is now running a CentOS (2.6.18) kernel with no problems.

http://etbe.coker.com.au/2008/10/22/upgrading-a-server-to-64bit-xen/

The machine in question is not entirely a standard configuration.  I am 
running a CentOS 5 kernel with Debian user-space as described in the above 
blog post.

On Tuesday 28 October 2008 14:10, Russell Coker <russell@coker.com.au> wrote:
> Below are the syslog messages from a kernel panic when running 2.6.26.  To
> trigger it I ran "semodule -i sendmail.pp" on a machine with the exim
> policy loaded (not something that you expect people to do - but not
> something you expect to cause a problem either) and load_policy went into
> an infinite loop (100% CPU use - strace reported no syscalls being made).
>  At that
> stage "kill -9" seemed like the right solution, killing load_policy gave
> the following result.

-- 
Russell Coker <russell@coker.com.au>
http://etbe.coker.com.au/          My Blog
http://etbe.coker.com.au/category/security/  My Security blog posts
http://www.coker.com.au/selinux/play.html  My Play Machine, root PW "SELINUX"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
