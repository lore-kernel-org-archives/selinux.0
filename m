Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05423
	for <selinux@tycho.nsa.gov>; Fri, 29 Dec 2000 10:15:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA22578
	for <selinux@tycho.nsa.gov>; Fri, 29 Dec 2000 15:14:35 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA22574
	for <selinux@tycho.nsa.gov>; Fri, 29 Dec 2000 15:14:35 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id KAA13980
	for <selinux@tycho.nsa.gov>; Fri, 29 Dec 2000 10:15:07 -0500 (EST)
Date: Fri, 29 Dec 2000 10:15:07 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: porting to 2.4?
In-Reply-To: <00122711304402.03583@rigel>
Message-ID: <Pine.SOL.3.95.1001229100358.9554B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Wed, 27 Dec 2000, Steven King wrote:

> Is anyone already working on this?  I've been looking at it and it seems like 
> it should be fairly straight forward...

We haven't started a port to the 2.4 kernel yet, other than
some preliminary analysis of the differences between 2.2 and
2.4 by a relatively new member of the NSA SELinux team.  His 
assessment was that a port could be quite involved due to the extent
of changes between 2.2 and 2.4, but I'm not sure how significant
those changes are for our modifications.  In addition to porting
our existing changes, we would want to address new features in the
2.4 kernel.  Since we have a small development team, we have to
carefully balance between porting what we have to newer kernel versions
and doing further security development.  If you are interested in
assisting in a port to the 2.4 kernel, let us know.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
