Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA26812
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 20:39:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA01658
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 01:38:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA01654
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 01:38:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: stat_secure()
Date: Fri, 8 Feb 2002 11:05:39 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0202070744460.6028-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0202070744460.6028-100000@raven>
MIME-Version: 1.0
Message-Id: <20020208014037.9AC343A26AA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Feb 2002 22:53, Stephen Smalley wrote:
> On Thu, 7 Feb 2002, Russell Coker wrote:
> > The current behaviour is not what I expected.  I first expected that
> > stat_secure() would return -1 when run on a non-SE kernel.  Then when I
> > discovered that it works for the regular stat() functionality I expected
> > that the security_id_t *sid parameter would not be changed.
> >
> > I think that it would be preferrable for the call to return -1 or to set
> > *sid to -1 to indicate that a non-SE kernel is running.  There is a big
> > difference between a file being truely unlabled and the system just not
> > supporting SE!
>
> This is a compatibility hack for the modified utilities.  At present, they
> always call the *stat_secure interfaces when built with Flask/SELinux.
> The original implementation of stat_secure permitted that approach,
> because it simply used the existing stat call and a spare field in the
> stat structure, but that wasn't portable.  When stat_secure was
> reimplemented as a separate call, this compatibility hack was added to the
> library functions to permit the utilities to continue working on a
> non-SELinux kernel.  If/when someone has time to fix the modified
> utilities, we'll drop the hack from the library routines.

OK.  I'm happy to do the coding for that, but not without matching libraries.

So what if I start providing Debian packages with code that returns -1 from 
such system calls if there is no SE Linux running and then code programs such 
as /usr/bin/stat accordingly?  Is that recommended?

I'll send you patches when I'm done...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
