Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA29542
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 09:17:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA23608
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 14:16:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA23603
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 14:16:38 GMT
Date: Wed, 7 Nov 2001 09:16:56 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Chandrashekar B ." <chandra@liqwidkrystal.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problem with su program
In-Reply-To: <20011107174152.C6659@chandra.liqwidkrystal.com>
Message-ID: <Pine.GSO.4.33.0111070909300.13356-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 7 Nov 2001, Chandrashekar B . wrote:

> Hi, The su program that comes with the selinux does not inherit resource
> limitations
> set in /etc/security/limits.conf file, while the default su program that
> comes with
> linux (found in /bin directory) understands and enforces them.
> Was this feature deliberately removed or is it a bug ?
>
> I'm running the selinux patch for kernel 2.4.10 on RedHat Linux 6.1

SELinux doesn't modify the su program.  The distribution does include a
sh-utils package with a modified id program (to display the security
context) and a new runas program (to run a program with a specified
security context when permitted by the policy), and sh-utils does include
a su program, but we don't use it.  The install target of
the utils/Makefile specifically removes this su program from
/usr/local/selinux/bin (along with the other programs that aren't
modified by SELinux but happen to be installed during the 'make
install').  So you shouldn't be using that su program at all.

It sounds like you are running the 9/26 release of SELinux.  I'm not sure
why you are using RedHat 6.1 rather than RedHat 7.1, although that is
certainly your option.  You also might want to upgrade at some point,
although you might want to wait now for a new release based on 2.4.14.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
