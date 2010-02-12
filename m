Subject: Re: {SPAM?}  Re: Random fork showing up in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B75711F.5070908@redhat.com>
References: <4B740814.8080802@redhat.com>
	 <1265980035.911.88.camel@gorn.columbia.tresys.com>
	 <4B75711F.5070908@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 12 Feb 2010 11:01:13 -0500
Message-ID: <1265990473.4386.35.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-12 at 10:17 -0500, Daniel J Walsh wrote:
> On 02/12/2010 08:07 AM, Christopher J. PeBenito wrote:
> > On Thu, 2010-02-11 at 08:37 -0500, Daniel J Walsh wrote:
> >> There has got to be something I am doing wrong.  But on my blog someone asked about writing a program that does a fork and having SELinux block it.  
> >>
> >> Where is the fork access coming from?
> > 
> > Are you sure its not this:
> > 
> > allow domain self:process { fork sigchld };
> > 
> > in domain.te?
[...]
> Yes that is it.
> 
> Seems like a strange rule to have on domain.  Might be better to move
> it to daemon rather then have it on domain.

I don't agree.  When we started refpolicy, we added it to domain since
its so pervasive.  Its also minimally security-relevant since the new
process is in the same domain.

I went back to the old example policy, since that had the explicit fork
permissions, and found that 228 of the 275 domains had the fork
permission.  I saw plenty of non-daemon domains that can fork.

Basically, refpolicy took the convenience trade-off, and its taken
almost 5 years for someone to take issue with this.  I'm still
comfortable with this decision.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
