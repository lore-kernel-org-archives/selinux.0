Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LF0WgA026512
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 11:00:32 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LEturg012095
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:55:56 GMT
Subject: Re: ainit
From: Colin Walters <walters@redhat.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com
In-Reply-To: <200507212142.28830.russell@coker.com.au>
References: <200507212142.28830.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 10:55:46 -0400
Message-Id: <1121957746.15247.5.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 21:42 +1000, Russell Coker wrote:
>  Does ALSA require that a shared 
> memory segment be available to all programs that are accessing the sound 
> device? 

This is a consequence of switching to the ALSA "dmix" device by default,
which does transparent sound mixing in userspace via the shared memory.
This fixes the extremely user-visible bug of multiple applications not
being able to use the sound card at the same time.

Fundamentally though the IPC key doesn't have to be allocated by the
system; I wrote some code a while back that would have allocated it as
part of the X login, all in the normal user session so there was no
"system" part involved.  I'm still not sure why our ALSA maintainer
chose the ainit/PAM route given that you don't care about sound mixing
for any other means of logging in like ssh or virtual terminal.  Or at
least, I don't think we should care.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
