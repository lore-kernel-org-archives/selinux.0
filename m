Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA14260
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 15:56:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA19110
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 20:55:39 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA19100
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 20:55:38 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id PAA24673
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 15:54:19 -0500 (EST)
Date: Fri, 22 Dec 2000 15:54:19 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: well.. stuff doesnt build.
In-Reply-To: <20001222113144.A18856@mailserver.penguincomputing.com>
Message-ID: <Pine.SOL.3.95.1001222155131.24350A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


The include/linux/flask/flask.h file is automatically generated
during the kernel build.  The flask subdirectory contains the
Makefile and configuration files that are used to generate flask.h
and some other header files.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com

On Fri, 22 Dec 2000, Jeremiah Johnson wrote:

> Ok, 
> 
> 	So I was attempting to build this stuff into rpm's.  But some of the include files reference files that don't seem to exist.  ie:
> 
> include/fs_secure.h
> include/proc_secure.h
> include/socket_secure.h
> include/ss_types.h
> 
>   all reference
> 
> #include <linux/flask/flask.h>
> 
> "flask.h" doesnt exist in the distro.  I tried replacing "linux/flask/flask.h" with "flask_util.h" and compiling fileutils and it errors in building.  I can print the error if it would help.  But since I dont think flask.h and flask_util.h are the same its probably not related to that.
> 
> Jeremiah Johnson
> Linux Security Analyst
> Penguin Computing
> 
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
