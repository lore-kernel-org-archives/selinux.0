Subject: Re: Policy infrastructure problems and improvement
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <49E00466.4090702@schaufler-ca.com>
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
	 <49DEC8D0.2060105@schaufler-ca.com>
	 <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil>
	 <49E00466.4090702@schaufler-ca.com>
Content-Type: text/plain
Date: Tue, 14 Apr 2009 09:31:01 -0400
Message-Id: <1239715861.19405.39.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-10 at 19:45 -0700, Casey Schaufler wrote:
> James Carter wrote:
> > On Thu, 2009-04-09 at 21:19 -0700, Casey Schaufler wrote:
> >   
> >> James Carter wrote:
> >>     
> >>> I am looking at improving the policy infrastructure.  The ultimate goal
> >>> is to make SELinux policy writing, policy customization, policy
> >>> management, and administration easier and less confusing. My focus will
> >>> be on the userspace parts of SELinux. 
> >>>
> >>> My plan to do this is as follows:
> >>> (1) Determine and enumerate the existing problems of the current
> >>> infrastructure.
> >>> (2) Determine the desired capabilities and architecture of the ideal
> >>> infrastructure.
> >>> (3) Determine the changes needed to the current architecture to fix the
> >>> current problems and to provide the desired capabilities.
> >>> (4) Make the policy infrastructure as close to the ideal as possible
> >>> while providing some kind of backwards compatibility and taking other
> >>> practicalities into consideration.
> >>>
> >>> I have had some informal discussions with others internally and at
> >>> Tresys, and the five emails to follow have my summary of the problems
> >>> that have been identified in those discussions.
> >>>
> >>> My hope is that there will be a good discussion and that others on the
> >>> list will identify other problems and provide more details or examples
> >>> to the problems already identified.
> >>>   
> >>>       
> >> I will throw my traditional comment on the pile as I didn't see that
> >> you had it on your list anywhere. The policy required to describe a
> >> system is too large.
> >>
> >>     
> >
> > That's easy to fix.  Make the system smaller. ;)
> >   
> 
> Or kick off all those stoopid users, if that's easier (smiley here).
> 
> > I think that this would fit under complexity of SElinux policies.
> >   
> 
> Perhaps.
> 
> > Again, better layering is needed.  
> 
> Here I disagree. Obscuring the size behind layers or modularity
> does not actually make it smaller.
> 
> > It would be nice if I could just
> > write policy for the particular domains and resources that I cared about
> > without having to worry about the policy for the rest of the system.
> >   
> 
> The fact that you are willing to accept the behavior of "policy you
> don't care about" also does not make the policy smaller.
> 
The size of the policy is not the main issue.  Yes, the policy can be
large, and in some systems that can be an issue.  But the concern here
is the complexity of the policy and how to reduce that complexity.
> 
> > Unfortunately, policy writing differs from program writing in that while
> > different programs that run on a system *share* resources and so it
> > doesn't matter what the other programs do (for the most part) as long as
> > my program gets to use those resources at some point, all of the
> > policies work together to *control* resources.  In the end, you must
> > have one policy.  
> 
> Yes. Interdependencies. That is why, in this context, size matters.
> 
> > The question is how to write the policies in a more
> > layered way and have the policy infrastructure merge the layers
> > together.  
> >   
> 
> Ignoring the bulk of the policy and attending to a part of the policy
> also does not make the rest of the policy go away. Because the SELinux
> implementation is so granular you can't layer without losing value.
> 
True, it doesn't make it go away, just like writing a program in a
higher level language does not make all of the low level instructions go
away.  But it does allow the programmer to just focus on the task at
hand, without worrying about all of the low level details.

Likewise, if there were a layer of policy that secured the base system,
so that the policy writer could just focus on the policy for the desired
workflow of the system, that would greatly reduce the complexity of the
policy that he would have to deal with.

It may be that this is not possible, you may be right that to layer like
this would require a low level policy that was too permissive to be of
any value, but I am not that pessimistic yet.

> But that could just be me. It may be time for a grain of salt.
> 
> Thank you.
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
