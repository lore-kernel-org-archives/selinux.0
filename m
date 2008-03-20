Subject: Re: [PATCH-v4] SELinux: introduce permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, selinux <selinux@tycho.nsa.gov>,
        jmorris@namei.org, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1206028012.32000.45.camel@moss-spartans.epoch.ncsc.mil>
References: <1205260003.5297.109.camel@localhost.localdomain>
	 <1205260785.23866.180.camel@moss-spartans.epoch.ncsc.mil>
	 <7e0fb38c0803200821l7b61f861p1ae33e22f62aa647@mail.gmail.com>
	 <1206028012.32000.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 20 Mar 2008 11:53:39 -0400
Message-Id: <1206028419.6333.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-03-20 at 11:46 -0400, Stephen Smalley wrote:
> On Thu, 2008-03-20 at 11:21 -0400, Eric Paris wrote:
> > I think we all agree that this patch is good as is and we should go
> > ahead and apply for the next round.
> > 
> > Correct?
> 
> Yes - for the kernel patch. As I recall, there were a few minor issues
> with the libsepol patch.
> > 
> > -Eric

Yup, starting to go through the other patches, I think we just needed
comments on the bitfield usage, but I'm looking over it now.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
