Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA11520
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 15:49:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA02260
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 20:48:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA02256
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 20:48:54 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28845
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 15:49:10 -0500 (EST)
Date: Fri, 23 Feb 2001 15:49:10 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200102232049.PAA11442@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: questions...
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Casey Schaufler wrote:
> If you are going to have a policy which
> is based on a label and on a user id you may have
> something good, but you ain't got a [DM]AC policy.
> 

If the modifications to SELinux to allow selective override of DAC (or
any other capability that Linux currently has) that were suggested were
made, what you get is a system that:

- still has the current DAC policy. SELinux doesn't change the existing
  DAC mechanism. That is not being proposed here.
- still enforces a mandatory access control (MAC) policy. By MAC, I mean a
  policy central to the system that every process on the system is
  subject to and that can only be changed as allowed by that policy.
  That is what SELinux does today.
- enforces a MAC policy which can allow certain processes, depending on
  security attributes of the process, to override the DAC mechanism to
  access files, depending on the security attributes of the file. This
  is just a refinement of the functionality that the current Linux
  capability mechanism along with the SELinux control over it gives
  today. It is more expressive allowing privileges to be limited to
  only those that are necessary. It allows processes other than root
  processes have this privilege. Also it removes the necessity to grant
  any process the ability to arbitrarily violate the MAC or DAC
  policies which is often what has been done in traditional MAC
  implementations.

I would say that this is good. If what SELinux has now supports a
[DM]AC policy, what is being proposed still does, only in an even more
useful way. If what SELinux does is not supporting a [DM]AC policy, the
goal of a [DM]AC policy perhaps should be questioned.

--
Peter Loscocco, NSA
pal@epoch.ncsc.mil

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
