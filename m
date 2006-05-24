Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4O3cgW4030556
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 23:38:42 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4O3ce9T022008
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 03:38:41 GMT
Date: Tue, 23 May 2006 23:38:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Michael LeMay <lemaymd@lemaymd.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] keys: Kernel access key retention support for SELinux
In-Reply-To: <44738D14.3070207@lemaymd.com>
Message-ID: <Pine.LNX.4.64.0605232336530.6019@d.namei>
References: <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
 <Pine.LNX.4.64.0605231759580.4091@d.namei> <44738D14.3070207@lemaymd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 May 2006, Michael LeMay wrote:

> James Morris wrote:
> > > +    S_("retained_key")
> > >     
> > 
> > This naming is ugly, just call it 'key', which is what the key subsystem
> > does.
> > 
> >   
> That would have been the obvious approach, but I'm concerned that using
> unqualified "key" as a name is too ambiguous.  What if some other type of key
> is introduced into the kernel or SELinux?  I'm certainly willing to defer to
> your judgment on this if you're confident this won't cause issues in the
> future...

Yep, that was a problem with the upstream submission of the key subsystem, 
but for some reason, it was allowed, and we have to follow it.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
