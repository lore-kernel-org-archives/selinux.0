Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23322
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 08:53:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA04239
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 13:52:44 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA04235 for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 13:52:43 GMT
Date: Wed, 27 Feb 2002 08:53:16 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <wakkerma@debian.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: straceing SE Linux
In-Reply-To: <20020227101339.9FAA5F8E3@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202270836300.12300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Feb 2002, Russell Coker wrote:

> Firstly what name should I use to refer to this syscall?  lsm() as the
> library code uses or security() after the sys_security() definition in the
> kernel?

I'd use the 'security' name, since it is the name used in unistd.h
(__NR_security).  We were using 'lsm' as the name of the system call
before there was any unistd.h definition, and it is now just an alias
for the security call.

> The next issue is that there is one system call defined for LSM (number 223
> on Intel).  The first parameter of this call is the id of the security
> service to manage.  I would like to display selinux() for a SE system call
> lids() for a LIDS call, etc.  However it seems that this would require a
> change to the strace structure.
>
> Should I do so, or am I on the wrong track by wanting to display these as
> different function calls depending on the id parameter?

I'd suggest looking at how strace handles the socketcall call, since the
security call is similar to it in form, with an additional module
identifier parameter to identify the security module.  strace does appear
to interpret the call value and the argument array for socketcall,
displaying socket operations with the corresponding call name and
interpreted argument list.

I suppose a first step for making strace aware of security calls would be
to translate the 'id' parameter to the security call and display the
corresponding module name.  However, the longer term goal would be to
actually display a name based on both the 'id' and the 'call' parameter
and to interpret the argument array based on the (id, call) pair.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
