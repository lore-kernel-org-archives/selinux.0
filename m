Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25333
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 13:25:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA07583
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 18:24:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA07572
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 18:24:15 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: straceing SE Linux
Date: Wed, 27 Feb 2002 17:04:34 +0100
Cc: <wakkerma@debian.org>, SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0202270836300.12300-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0202270836300.12300-100000@raven>
MIME-Version: 1.0
Message-Id: <20020227182506.47225134A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Feb 2002 14:53, Stephen Smalley wrote:
> On Wed, 27 Feb 2002, Russell Coker wrote:
> > Firstly what name should I use to refer to this syscall?  lsm() as the
> > library code uses or security() after the sys_security() definition in
> > the kernel?
>
> I'd use the 'security' name, since it is the name used in unistd.h
> (__NR_security).  We were using 'lsm' as the name of the system call
> before there was any unistd.h definition, and it is now just an alias
> for the security call.

OK.

> > The next issue is that there is one system call defined for LSM (number
> > 223 on Intel).  The first parameter of this call is the id of the
> > security service to manage.  I would like to display selinux() for a SE
> > system call lids() for a LIDS call, etc.  However it seems that this
> > would require a change to the strace structure.
> >
> > Should I do so, or am I on the wrong track by wanting to display these as
> > different function calls depending on the id parameter?
>
> I'd suggest looking at how strace handles the socketcall call, since the
> security call is similar to it in form, with an additional module
> identifier parameter to identify the security module.  strace does appear
> to interpret the call value and the argument array for socketcall,
> displaying socket operations with the corresponding call name and
> interpreted argument list.

>From inspecting the kernel code and the strace it appears that socketcall 
doesn't get processed the way you might expect.  It appears that for every 
function that works with socketcall() there is a separate system call for it. 
 So when I strace a socket program on my system it displays the socket(), 
connect() etc because those system calls are called directly.  It appears 
that my libc does not use socketcall()!  I could not find any special 
handling in the strace source for socketcall, it appears that socketcall() 
will be displayed as such!

Also I'm using strace version 4.4, I grabbed the source from the Debian 
unstable tree, as Wichert is both upstream author and Debian developer for 
strace I presume that there is no version of strace that has more 
capabilities in this regard.

Another thing, I just checked out the code for ioctl() and it doesn't help me 
as the output always matches "^ioctl(".

> I suppose a first step for making strace aware of security calls would be
> to translate the 'id' parameter to the security call and display the
> corresponding module name.  However, the longer term goal would be to
> actually display a name based on both the 'id' and the 'call' parameter
> and to interpret the argument array based on the (id, call) pair.

I agree.

What I think is necessary is firstly to write code to handle unknown id 
parameters from the security() system call as security(id = %d, ...
Then have code to handle known module IDs but unknown system calls as 
security(SELINUX, ... (or whatever the name is).  Then have code to handle 
known system calls by the full name.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
