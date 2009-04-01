Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n319o76c010563
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 05:50:07 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n319o6D0015021
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 09:50:06 GMT
Date: Wed, 1 Apr 2009 20:49:25 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Jarrett Lu <Jarrett.Lu@sun.com>
cc: Nicolas Williams <Nicolas.Williams@sun.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF website
In-Reply-To: <49D3212C.9070002@sun.com>
Message-ID: <alpine.LRH.2.00.0904012045410.23474@tundra.namei.org>
References: <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain>
 <49D10FC1.3000103@sun.com> <1238447664.2484.119.camel@localhost.localdomain> <49D1B133.3010907@sun.com> <20090331182851.GG9992@Sun.COM> <49D2E073.3060003@sun.com> <alpine.LRH.2.00.0904011751320.21948@tundra.namei.org> <49D3212C.9070002@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Apr 2009, Jarrett Lu wrote:

> > With SELinux systems, policies do not need to be identical to be
> > considered part of the same DOI.  Generally, labels need to remain
> > semantically equivalent (i.e. mean the same thing on each system), and the
> > policies need to be managed within the same administrative boundary.
> > Systems may restrict which labels they'll interpret from remote systems
> > (similar to root_squash).
> > 
> >    
> 
> Understood. My point is that a signature on a policy file may not always be
> the right tool to determine whether label translation should be done. When
> policies are different on two systems, how does one system know labels or
> types are semantically equivalent or not?

This should be determined via the DOI.

> Are you also saying that DOI is tied
> to administrative boundary, and the fact that systems using the same DOI
> implies the label and type definitions in each policy are always semantically
> equivalent?

For DOIs designed to function like this, yes.  i.e. it's not a property 
inherent to DOIs, but of how they're administered.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
