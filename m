Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20136
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 11:09:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA26894
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 16:09:24 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA26881
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 16:09:20 GMT
Date: Wed, 14 Feb 2001 11:08:00 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Robertson Wayne <robertsonw@ll.mit.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: Porting to SELinux
In-Reply-To: <711DB7A5731DD111A2E1006097731A0B208686@ets>
Message-ID: <Pine.SOL.3.95.1010214104131.5716J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> Does anyone have any comments/thoughts on the applicability of SE Linux in
> an environment where RT Linux would be utilized?  Of course, there remains
> the hardware issue but as I understand it SE Linux currently is not ported
> to the 68K/PPC platforms and so using SE Linux would indicate a choice of
> Intel boards (of which there aren't too many vendors that have such products
> that are VME based).

Caveat:  I haven't used RTLinux, so I'm just drawing from their web
pages for information about it.  It appears that the primary issue would
be that  RTLinux has its own real-time kernel that runs a slightly
modified Linux kernel as its lowest priority thread and provides
communication interfaces between other threads (which can meet
strict real-time requirements) and Linux processes.  So if you
apply the Linux kernel patches provided by RTLinux and SELinux
(and resolve any conflicts) and then run the resulting kernel
on the RTLinux real-time kernel, you would have a system where
Linux processes are controlled by the mandatory security policy,
but the other RTLinux threads would operate outside of its controls.
SELinux could provide coarse-grained controls on interactions
between Linux processes and any of the RTLinux threads (since they
communicate via a device special file), but it couldn't distinguish
among the RTLinux threads or control any direct communications
between them.  If all of the real-time threads only need to be
associated with a single security label (security context),
then this might be adequate.  Otherwise, you need the
real-time kernel to provide labeling and controls for
its abstractions.

With regard to the hardware issue, it should not be difficult to port
SELinux to other architectures, especially after some recent changes
to the implementation of the new system calls.  An updated release 
should be forthcoming soon.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
