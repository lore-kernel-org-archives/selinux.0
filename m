Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MMVaWt006502
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 18:31:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9MMVMIS000895
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 22:31:22 GMT
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by jazzswing.ncsc.mil  with ESMTP id h9MMVMDc000892
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 22:31:22 GMT
Subject: Re: init patch for loading policy
From: Joubert Berger <joubert@berger-family.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F957200.9040201@redhat.com>
References: <200310200148.15852.russell@coker.com.au>
	 <200310211052.28494.russell@coker.com.au>
	 <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
	 <200310220043.09925.russell@coker.com.au>
	 <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
	 <3F957200.9040201@redhat.com>
Content-Type: text/plain
Message-Id: <1066861893.7534.10.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Wed, 22 Oct 2003 18:31:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could you not hard code enough of a policy in the kernel to get init(8)
up and running?  Then let init run a script that loads the complete
policy and then runs /etc/rc.d/rc.sysinit or just have rc.sysinit load
it as it's first step.

--joubert

On Tue, 2003-10-21 at 13:50, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
> >   
> > > The results I have so far indicate that this approach has significant 
> > > problems.
> > > 
> > > Diverting /sbin/init with a shell script works better than this.
> > >     
> > Ok, thanks for looking into it.  So what exactly is the problem with
> > diverting /sbin/init again?  
> > 
> >   
> I still believe that the patch to /sbin/init is simple enough that all
> the rest of this stuff is complicating matters.  It allows too many
> ways for someone to make a modification that breaks security.  I have
> updated the files on people.redhat.com/dwalsh to use the modified
> init.  I have passed this by Bill Nottingham (Red Hat maintainer) and
> he is ok with it.
> 
> Of course if someone comes up with a simpler solution we would look at
> it.
> 
> Dan
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
