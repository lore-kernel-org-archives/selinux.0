Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AJrogA022032
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 15:53:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AJk8fM009651
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 19:46:10 GMT
Message-Id: <200506101945.j5AJjo5F002174@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 15:45:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 2:31 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; 'Daniel J Walsh'; 'SELinux'; selinux-dev@tresys.com
> Subject: RE: Restorecon script
> 
> 
> > and the only changes required for orbit and
> > gconfd are to put their files in a different location. If /tmp is tmpfs
> there
> > needs to be a script that creates these directories with the correct labels
> at
> > boot.
> 
> ... and this leads us to... selinux.sh.
> Except you're saying that it should be executed once on boot, as root,
> and not per login shell, is that correct? We may actually need to
> do that, since at the current time I can't create .ICE-unix in this
> script - insufficient privileges.
> 

Sort of - the script might need its own domain.

> > Changes retroactively seem problematic (see my other email). I think this is
> a
> > hard problem - not relabeling possibly means confused users and relabeling
> > possibly means going against the user's wishes or confusing them.
> 
> I don't think the user's intended to be changing the types of those
> directories - they are to be used for internal settings. That's
> why most of them are hidden files.
> 

Maybe - doesn't mean that blindly relabeling them won't cause problems or
confusion. It is a large change to reset permissions on home directories on
login. Seems like this is better done at installation time or on specific admin
/ user request.

> >  I have to say
> > that not relabeling is probably more confusing, but it starts to feel like
> > fixing problems by rebooting . . . it just changes to logging in.
> 
> The relabeling was actually not what I was focusing on - the
> real issue was whether it's a good idea to pre-create folders
> ahead of time.

Which it seems like it is in general.

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
