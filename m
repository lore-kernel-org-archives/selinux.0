Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA04411
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 14:36:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA00416
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 19:36:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA00412
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 19:36:27 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26819
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 14:36:43 -0500 (EST)
Date: Thu, 22 Feb 2001 14:36:40 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200102221936.OAA10997@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: questions...
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> 
> > At some point, we may experiment with extending
> > the mandatory access control architecture to permit the mandatory
> > access control policy to override discretionary access denials
> > to provide a similar mechanism to the Linux capabilities.
> 
> I guess I'm a little slow today. How would having MAC access
> superceding DAC access be anything like the capabilities scheme?
> 

As the system is today the MAC and DAC controls are completely
separate. In order for access to be granted both checks must pass. The
MAC policy respects the DAC decision. The current capability mechanism
provides a capability to override the DAC mechanism. A root process
having this capability is not restricted by file permissions (it still
is constrained by the MAC policy though). With slight changes to the
implementation, it is possible to provide DAC override using only the
MAC policy. On a per-type basis, a process can be allowed to override
the DAC policy. In a sense, the current capability mechanism would be
encoded in the TE policy. This is actually more powerful than the
current capability mechanism because it is not all or nothing. It is
possible to override DAC for one type of file but not another. It also
becomes possible to use the MAC mechanism to provide equivalent
controls as do the other capabilities. Again the achitecture allows for
finer-grained control than that of the current capability mechanism.

--
Peter Loscocco, NSA
pal@epoch.ncsc.mil

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
