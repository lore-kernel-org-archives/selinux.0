Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA14437
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 16:22:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA12679
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 21:21:15 GMT
Received: from penguincomputing.com ([209.24.233.229])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with SMTP id VAA12675
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 21:21:14 GMT
Date: Fri, 22 Dec 2000 13:22:02 -0800
From: Jeremiah Johnson <jjohnson@penguincomputing.com>
To: selinux@tycho.nsa.gov
Subject: Re: well.. stuff doesnt build.
Message-ID: <20001222132202.A20716@mailserver.penguincomputing.com>
References: <20001222113144.A18856@mailserver.penguincomputing.com> <Pine.SOL.3.95.1001222155131.24350A-100000@clipper.gw.tislabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.3.95.1001222155131.24350A-100000@clipper.gw.tislabs.com>; from sds@tislabs.com on Fri, Dec 22, 2000 at 03:54:19PM -0500
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I was hopeing I wouldnt need to rebuild the kernel and everything for basic stuff to compile, but ok.  I will definately try that out.

Jeremiah Johnson
Linux Security Analyst
Penguin Computing

On Fri, Dec 22, 2000 at 03:54:19PM -0500, Stephen Smalley wrote:
> 
> The include/linux/flask/flask.h file is automatically generated
> during the kernel build.  The flask subdirectory contains the
> Makefile and configuration files that are used to generate flask.h
> and some other header files.
> 
> --
> Stephen D. Smalley, NAI Labs
> sds@tislabs.com
> 
> On Fri, 22 Dec 2000, Jeremiah Johnson wrote:
> 
> > Ok, 
> > 
> > 	So I was attempting to build this stuff into rpm's.  But some of the include files reference files that don't seem to exist.  ie:
> > 
> > include/fs_secure.h
> > include/proc_secure.h
> > include/socket_secure.h
> > include/ss_types.h
> > 
> >   all reference
> > 
> > #include <linux/flask/flask.h>
> > 
> > "flask.h" doesnt exist in the distro.  I tried replacing "linux/flask/flask.h" with "flask_util.h" and compiling fileutils and it errors in building.  I can print the error if it would help.  But since I dont think flask.h and flask_util.h are the same its probably not related to that.
> > 
> > Jeremiah Johnson
> > Linux Security Analyst
> > Penguin Computing
> > 
> > You have received this message because you are subscribed to the selinux list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> > 
> 
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
