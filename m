Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0AHX89A027958
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 12:33:09 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0AHXwK7026787
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 17:33:58 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Antill <jantill@redhat.com>
Subject: Re: Tar storage of SELinux context, translated or not
Date: Wed, 10 Jan 2007 12:33:40 -0500
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1168448023.13080.33.camel@code.and.org>
In-Reply-To: <1168448023.13080.33.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701101233.40143.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, January 10 2007 11:53 am, James Antill wrote:
>  As some of you know, I have done patches to make GNUtar able to
> save/restore ACLs, SELinux context and generic user xattrs. I've
> recently had to fixup the ACL support for compatibility with star etc.,
> and for a couple of reasons that got me thinking about the SELinux
> support as well.
>
>  I had originally decided that the SELinux security context should be
> stored in translated form, Ie. getfilecon => tar => setfilecon, my
> thinking was that if you want to store something over a long period this
> is the better format ... but as I think more about it now I'm not 100%
> convinced (for instance, AIUI ipsec etc. uses raw format to distribute
> context between machines).
>  With the current changes, this is a great time to change it (but I
> really, really, don't want to have an option either way) ... if we want
> to. So should I change it to non-translated?

Regardless of what the tar command does, you could always have the tarfile 
format allow either (store both the context string as well as a flag 
indicating if the context was translated).  This way if things change down 
the road all the existing tar files are still valid.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
