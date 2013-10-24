Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OIa7rw015546
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 14:36:07 -0400
Received: by mail-qe0-f48.google.com with SMTP id d4so1675287qej.7
        for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:36:06 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux: Update policy version to support constraints info
Date: Thu, 24 Oct 2013 11:36:05 -0700 (PDT)
Message-ID: <11155540.a6QObQOMze@sifl>
In-Reply-To: <1382610164.40150.YahooMailNeo@web87904.mail.ir2.yahoo.com>
References: <1382398322.27942.61.camel@localhost> <5266730C.2010205@tycho.nsa.gov> <1382610164.40150.YahooMailNeo@web87904.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, October 24, 2013 11:22:44 AM Richard Haines wrote:
> ----- Original Message -----
> 
> > From: Stephen Smalley <sds@tycho.nsa.gov>
> > To: Eric Paris <eparis@redhat.com>
> > Cc: selinux@tycho.nsa.gov
> > Sent: Tuesday, 22 October 2013, 13:43
> > Subject: Re: SELinux: Update policy version to support constraints info
> > 
> > On 10/21/2013 07:32 PM, Eric Paris wrote:
> >>  From: Richard Haines <richard_c_haines@btinternet.com>
> >>  Date: Tue, 18 Dec 2012 19:37:46 +0000
> >>  
> >>  Update the policy version (POLICYDB_VERSION_CONSTRAINT_NAMES) to allow
> >>  holding of policy source info for constraints.
> > 
> > Before we get into code review, let me ask the following:
> > Why do we need a new kernel binary policy version for information that
> > is only used by userspace?  Why can't this information be extracted from
> > the policy module format or stored in an auxiliary file used only by
> > userspace?
> 
> True it could be done the ways you suggest, however the module format would
> only work for modular policies and the auxiliary file (I felt) would be
> difficult to track (could be another config type file maybe?).

My current two cents on the issue ...

Working under the assumption that the userspace tools would much prefer to 
read the policy directly from the kernel (for obvious reasons), it makes sense 
to me that we provide this additional constraint information along with the 
rest of the policy.  Having to pull policy information from both the kernel 
and a regular file seems like it could lead to all sorts of problems.

Further, I believe that for the majority of systems the extra ~5k of kernel 
memory is not a major deal breaker, although I will concede that for smaller 
systems (Android perhaps?) this might be more of a concern.  What if, along 
with this extra constraint information, we add a toggle (perhaps via a new 
policy capability) which would trigger the kernel to either preserve the 
constraint info or discard it when the policy is loaded? 

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
