Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5S0DB0S016791
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 20:13:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5S0CNss027953
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 00:12:23 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h5S0CLhY027950
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 00:12:21 GMT
Date: Sat, 28 Jun 2003 10:12:05 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux-team@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: biometric codecs / hardware signed blackbox-capable interconnecti ve system-resources
Message-ID: <20030628001205.GA21997@snoopy.apana.org.au>
References: <B4E788FBFCD6844F96A017F337797AE167B624@mozart.patioenclosuresinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B4E788FBFCD6844F96A017F337797AE167B624@mozart.patioenclosuresinc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 27, 2003 at 03:39:03PM -0400, Rottura, Steven wrote:
> > > 	Does SELinux ever consider biometric or other specialized hardware
> > > interfacing (i know it's just a patch for linux, but aren't there
> > > specialized devices it should intrinsically be built to deal with) /
> > > specialized hardware for partitioning and protecting each user /
> > > application's priveledge (realtime, on the fly)?  

SE-Linux is an authorization system, that makes decisions on what
processes can access what resources.

It is not an authentication system. An authentication system is
what that can decide who the user is that is using the terminal.

However, SE-Linux does need an authentication system. eg. when first
logging in to a computer. On most systems this is done with PAM, so if
you have a PAM module read a biometric fingerprint, you can use that for
logins.

This raises some other issues though. For instance, biometrics can not
be used as a general replacement for passwords, there are too many
weaknesses. The digital image of you biometric features could be stolen
for instance, like a password can be, but unlike the password, the
digital image cannot be change.

Then there is the other issue to. The computer knows user X logged on,
but how can it be sure that user X is still the user that is using (and
in control) of the computer? This is an issue for certain operations in
particular, eg. GPG signing outgoing E-Mail, running newrole to become
sysadm_r, etc.

I don't see any solutions here. For instance, lets say I went to a
untrusted computer console A. I insert a smart card to authenticate
myself, and automatically sysadm_r priviliges on remote computer B. This
could be done in a secure manner, and in such a way that that no data
on the smartcard can be stolen. This is easy, convenient, and means
you don't have to keep track of numerous passwords and retype them in
frequently (remember too that the more often you enter the password, the
more likely it is someone will observe it getting entered).

Unknown to me though, the copy of bash on A was altered, it forked
another process that also connected to B with sysadm_r priviliges, and
executed a command like "rm -rf /".

Anyway, I hope this gives you some things to consider...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
