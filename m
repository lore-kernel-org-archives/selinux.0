Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9LGthXZ010089
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 12:55:43 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9LGth8L024858
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 16:55:43 GMT
Subject: Re: ANN: imsep 0.6
From: Colin Walters <walters@gnome.org>
To: gtk-devel-list@gnome.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20041021161556.22246.qmail@web86901.mail.ukl.yahoo.com>
References: <20041021161556.22246.qmail@web86901.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 21 Oct 2004 12:55:52 -0400
Message-Id: <1098377752.16197.45.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ Re-CC'ing the SELinux list as this discussion is relevant there ]

On Thu, 2004-10-21 at 17:15 +0100, Sander Vesik wrote:

> Note that the specs and ideas come from the folks that consider a "mathematicly 
> proven to be correct and secure OS" developed by security cleared scientists 
> locked up to be more secure than a simple humble "mathematicly proven to be 
> correct and secure OS". 

I am not sure what you are talking about.  SELinux is not a project to
mathematically prove system security.  SELinux is simply an
implementation of mandatory access control (MAC) for Linux.  I am using
that mandatory control to lock down image loading.  Also, I have done a
fair amount of work on SELinux, and most of my patches have been
integrated.  I don't have any kind of formal security clearance.  The
same is true for a lot of other contributors.

> But more importantly - you can't simply run *one* imsep if you want to have any
> actual benefit that way, you must keep data from programs with different rights
> separate. 

Yes, I agree.  If you read the imsep source code, you will see that the
master process is written to do polyinstantiation based on the security
context of the requesting process.  However, this requires D-BUS
support, which is not written yet.  I plan to do that fairly soon.  Once
that support is available, it will be on the order of a one-line change
to the imsep master daemon to turn it on.

> Because otherwise a image loader with exploitable image bug opens up 
> it all to inspection and modification by code from some web site. 

Absolutely, and that's why I designed imsep to support
polyinstantiation.  But for Fedora's "targeted" policy, it is not useful
because all of userspace runs in the same security context.  But there
is still a high degree of security gain from imsep - a compromised image
loader is very very strictly confined.  See the sample security policy
in the imsep source code.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
