Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65]) by
	tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33GhYx6000209 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 11:43:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1]) by
	jazzswing.ncsc.mil  with ESMTP id h33GdfOv001736 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:39:41 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil
	[144.51.25.10]) by jazzswing.ncsc.mil  with ESMTP id h33GdeY1001733 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:39:40 GMT
Message-Id: <200304031650.LAA13186@moss-shockers.ncsc.mil>
Date: Thu, 3 Apr 2003 11:50:44 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux programming question
To: selinux@tycho.nsa.gov, carsten.grohmann@raumbildsysteme.de
Cc: hdholm@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> it is possible to change the sid of a program without to call an 
> exec*_secure?

The SID of a process may also change on a regular execve due to an
automatic domain transition in the policy configuration.  But the SID
of a process cannot change without going through an
execve/execve_secure; this is an intentional design choice, and has
been discussed in the documentation and on the list previously.  setSID-style
calls are considered harmful, as you cannot provide the same control over
the initialization of the process in the new SID and the inheritance of
state between the SIDs, so you end up with very little real separation
between the two SIDs.

As a side note, the entire SELinux API is undergoing massive changes as
part of preparing SELinux for submission to mainline 2.5, and is likely
to undergo even further changes after it is submitted in response to
kernel developer feedback before the API can truly be considered
stable.  There will still be a functional equivalent to execve_secure,
but it will look rather different.  Details to follow soon.

--
Stephen Smalley, NSA



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
