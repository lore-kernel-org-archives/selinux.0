Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13614
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 11:35:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA29621
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:34:35 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA29617
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:34:35 GMT
Date: Thu, 11 Jan 2001 10:34:50 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101111634.KAA82194@tomcat.admin.navo.hpc.mil>
To: bet@rahul.net, Stephen Smalley <sds@tislabs.com>
Subject: Re: IPSEC integration (was Re: SELinux and covert channels)
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Bennett Todd <bet@rahul.net>:
> 2001-01-11-09:01:41 Stephen Smalley:
> > Additionally, although mandatory access controls have been
> > implemented for sockets, the controls are currently limited
> > because support for communicating packet labels across the network
> > has not yet been implemented.  As discussed in the documentation,
> > the intent is to use IPSEC security associations to implicitly
> > label packets once IPSEC is integrated.
> 
> This I thought was the most exciting single bit of the whole
> announcement.
> 
> While any MAC implementation is certainly interesting, and the more
> expressive ones are especially appealing for their potential for
> sandboxing, the real hard problems we're fighting with now, and
> expecting to be battling in the near future, center on defining
> really tight security perimeters around distributed apps. The
> ability to have a coherent enforcement of a centrally-specified
> policy over all the data throughout a distribute app is very, very
> exciting indeed.
> 
> Especially to me, since I've been telling people that it's the next
> big step for some time now:-).

YES --

I would also like to see the abiltity of a fully integrated
IPSec with some "additional" abilities:

1. identify the remote user (including the ability to do user id mapping
   remote user -> local user)
2. identify remote security labels (including label translation
   remote lable ->local lable)
3. Use the above information to authenticate/authorize socket connections.
4. prevent local users from accessing sockets without authorization ("user"
   daemon prevention, unauthorized communication with remote hosts...)
5. Selectively enforce the use of encryption with remote hosts
6. Have the security authorization data base (?? not sure this is the right
   place) to handle/recognize various authentication methods - Kerberos,
   PKI, SSL, ... perhaps via  a "PAM" definition. (I do mean PKI as separate
   from SSL as a communications protocol.)

It would seem to me that a complete handling of authentication would
include IPSec and local logins as well. Merging this together should
simplify a lot of application programming... It would be able to use
simple socket code that would transparently provide authentication
without the use of user level (and ignorable) libraries. If the remote
(or local) user cannot be authenticated, then the communication will not
be allowed.

It will no longer be up to the user to protect data in transit. If the
SA has the remote host marked as requiring encryption, then it will be.
If the SA (at either end of the communication) doesn't allow something,
then the link will be disallowed.

At the cost of some redundancy - Users would not be able to open sockets
that allow any form of unauthentication/unauthorized communication.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
