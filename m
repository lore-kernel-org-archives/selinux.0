Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06634
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 07:45:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA05586
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 12:45:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id MAA05582
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 12:44:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Thu, 29 Nov 2001 13:37:02 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0111280821160.1519-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0111280821160.1519-100000@raven>
MIME-Version: 1.0
Message-Id: <20011129124524.49DE63531E5@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Nov 2001 14:28, Stephen Smalley wrote:
> On Tue, 27 Nov 2001, Russell Coker wrote:
> > What is probably of more interest to you is the locations that I've put
> > header files in, here's what I'm currently installing:
> > /usr/include
>
> Well, this will naturally break the build of all of the userland
> components of SELinux.  Why do you need to change the installation
> directories from what we use?

Because no package is allowed to put files in /usr/local !

> > /usr/include/linux/flask
>
> This change is probably harmless for building the userland components,
> since the same #include directives will still work (#include
> <linux/flask/foo.h>).

That's the plan.

> But what about the <linux/asm-i386/unistd.h>
> and the <linux/asm-i386/flask/unistd.h> files?  These are also needed
> for building the userland components.

I'm not sure which is the best solution for that yet.

> > /usr/include/selinux
>
> This change will require changes to the userland components of SELinux,
> and I'm not planning on making these changes to our distribution unless
> there is a real justification.  What's wrong with
> /usr/local/selinux/include?

It conflicts with the FHS.  See section 4.5 and in particular 4.5.1:

   This directory should always be empty after first installing a
   FHS-compliant system. No exceptions to this rule should be made other
   than the listed directory stubs.

So I could create a /usr/local/selinux directory which is empty if necessary, 
but I can not put any files in it!

You will have the same issue with getting SE-Linux into any other major 
distribution.  Although Slackware would probably make an exception for it.  
Also Sun ships Solaris packages containing files in /usr/local so they would 
probably be happy to do so for their Qube and Raq machines too.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
