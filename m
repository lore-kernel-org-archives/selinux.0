Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAENkiRb028285
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 18:46:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAENkHBb028535
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 23:46:17 GMT
Received: from sisko.scot.redhat.com (82-41-8-128.cable.ubr02.edin.blueyonder.co.uk [82.41.8.128])
	by jazzswing.ncsc.mil  with ESMTP id hAENkF4o028528
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 23:46:16 GMT
Subject: Re: unix_chkpwd
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311150859.04677.russell@coker.com.au>
References: <200311141901.14660.russell@coker.com.au>
	 <1068813495.9878.31.camel@sisko.scot.redhat.com>
	 <200311150859.04677.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1068853598.16851.11.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 14 Nov 2003 23:46:38 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, 2003-11-14 at 21:59, Russell Coker wrote:

> > 2 would require fcntl()ing it back again afterwards, of course.  Having
> > your shell inherit FD_CLOEXEC on stdin could be confusing, at best. :-)
> 
> That handle isn't used by the application and I need to have the policy deal 
> with unix_chkpwd inheriting file handles for the pty/tty device anyway for 
> the case of screen blankers etc.  So setting it back shouldn't be necessary.

Hmm, I think I just forgot that we were dealing with privilege
separation here.  Do we have a guarantee that the pam call is only done
by the unprivileged temporary fork?  If so, we needn't worry about the
final shell inheriting the CLOEXEC flag.

> It would be rather embarassing for an 
> upstream maintainer if the SE Linux version of a program was the only version 
> that did not have a security hole and people who don't use SE Linux were 
> forced to use the SE Linux version to close the hole!

Quite!

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
