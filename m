Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5ALHOgA023001
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 17:17:24 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AL9efM013195
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 21:09:45 GMT
Message-Id: <200506102109.j5AL9W5F003192@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 17:09:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118437074.4812.24.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 4:58 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; 'Daniel J Walsh'; 'SELinux'; selinux-dev@tresys.com
> Subject: RE: Restorecon script
> 
> 
> > Maybe - doesn't mean that blindly relabeling them won't cause problems or
> > confusion. It is a large change to reset permissions on home directories on
> > login. Seems like this is better done at installation time or on specific
> admin
> > / user request.
> 
> Why should blindly relabeling internal files cause problems or
> confusion? I am assuming that policy has the correct context, and
> anything else is wrong

Labeling by path is unsafe when the system is not in a known good state.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> - after all those are _internal_ files,
> not to be directly manipulated by the user, but handled
> automatically.
> 
> The script does not reset permissions on home directories, it
> resets permissions on specific subfolders. More importantly,
> it does not reset the top level directory.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
