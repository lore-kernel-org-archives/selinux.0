Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AFJDWt003998
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:19:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9AFJ70r028572
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 15:19:09 GMT
Date: Fri, 10 Oct 2003 11:19:21 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: Re: login messages
In-Reply-To: <200310101620.32424.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0310101115070.18207-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003, Russell Coker wrote:

> On Fri, 10 Oct 2003 05:39, Stephen Smalley wrote:
> > > Also I think I'll just make it loadkeys_t instead of having a number of
> > > user_loadkeys_t domains.
> >
> > So, what's the resolution on the capable() check being performed by the
> > SELinux module?  Should it be reduced from a full capable() check (i.e.
> > Linux capability and SELinux permission check) to just a SELinux
> > capability permission check, to avoid changing the Linux permissions
> > model and the need for a setuid program?
> 
> I think that makes sense at the moment.
> 
> However I think that the kernel people should consider making this capability 
> a requirement for non-SE kernels.  James, what do you think?
> 

I don't think that further restricting this for the standard kernel is
necessary, although feel free to propose the change on lkml if you feel
strongly about it.

I also agree that it is probably better to move from a capability check to
an SELinux permission.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
