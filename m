Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P3sV3E027180
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 23:54:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5P3sU5e014051
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 03:54:30 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5P3sS92014048 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 03:54:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: local policy changes, /var/lib access, syslogd
Date: Wed, 25 Jun 2003 13:54:20 +1000
References: <1056505792.29159.43.camel@columbia>
In-Reply-To: <1056505792.29159.43.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306251354.20028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jun 2003 11:49, Colin Walters wrote:
> in /etc/selinux/domains/misc/local.te.  Is there a more "standard" place
> for this?

No.  I personally use domains/misc/custom.te, but it's a local issue.

We probably should document some suggested names to avoid the possibility of 
conflicts.

> Secondly, I'm getting a lot of programs wanting search access to
> /var/lib (var_lib_t).  At least sshd_t, user_ssh_t, syslogd_t,
> postfix_master_t, etc.  I added a bunch of dontaudit rules, but I'm
> wondering if anyone knew why these programs were trying to access
> /var/lib?

One way that programs can request search access to a directory is if you do 
the following:
cd /var/lib ; ssh foo

For ssh this is a very common issue.  I guess we could set things up such that 
a program in a user_whatever_t domain gets allow (or dontaudit) for search 
access to every type of directory that user_t has access to.  But that may 
permit undesired access.

Is sshd configured to have a privsep directory under /var/lib?

I suspect that postfix_master_t is trying to copy files around to setup a 
chroot environment.  For my machines I configure postfix to not use chroot.  
Chroot does not restrict postfix as much as SE Linux does and requires that 
Postfix be given access that I don't want to permit.

I would like to know more about what syslogd is doing.

> Finally, I also get a number of denials from syslogd attempting to
> access /dev/xconsole:
>
> avc:  denied  { read write } for  pid=162 exe=/sbin/syslogd
> path=/dev/xconsole dev=03:01 ino=2310191
> scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:device_t
> tclass=fifo_file
>
> I don't plan to use X on this machine, so I could just add a dontaudit I
> suppose, but I'm curious why this isn't the default.

/dev/xconsole is not inherantly related to X.  It is a named pipe that syslogd 
logs to, and it can be used by X or other programs to display the logs.

You can use /dev/xconsole without using X, or you can use X without 
/dev/xconsole (as I do).

If you run SE Linux on an X based workstation then you still probably don't 
want to permit the users to see the logs.

The best thing to do (IMHO) is to configure syslogd to not write anything to 
/dev/xconsole.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
