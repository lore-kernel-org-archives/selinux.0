Subject: Re: policy as configuration data
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Caleb Case <ccase@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <4A01A7A7.2010602@manicmethod.com>
References: 
	 <06A6610D4F464D4EBEAFBF2C5F86911E010D6962@exchange2.columbia.tresys.com>
	 <1241620337.27629.10.camel@localhost.localdomain>
	 <4A01A7A7.2010602@manicmethod.com>
Content-Type: text/plain
Date: Wed, 06 May 2009 12:41:52 -0400
Message-Id: <1241628112.27629.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-06 at 11:07 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2009-05-05 at 17:03 -0400, Caleb Case wrote:
> >> We've been looking into a couple of improvements to the SELinux
> >> infrastructure. One of the options we are looking at is treating policy
> >> as configuration data. We've found a couple of sticking points though.
> >>
> >> First, removing a set of trusted tools (running in domains only able to
> >> access files of appropriate types) from the policy modification process
> >> makes it more difficult to control the flow of low integrity data into
> >> the policy.
> > 
> > Policy as configuration data does not imply that you have to let users
> > directly modify the config files without using a tool (which is useful
> > for general integrity and transactional behavior, not just security).
> > passwd data is config data, yet you are supposed to edit it via vipw and
> > tools like useradd.
> > 
> 
> How do you define config data? Is the current module store considered config 
> data? I can't think of a definition that doesn't either include every file on 
> the system or exclude things like passwd, shadow, etc.

Yes, the current module store is config data.  Prior discussions of
treating policy as config data vs. as a software package had nothing to
do with whether or not one would use tools to manage it or whether it
would be source or binary.  

> I think from a users perspective config data means they can drop a file 
> somewhere, restart a service and the additional config is active (apply the same 
> to modifying a file).

I don't really see that as a major problem with SELinux at present; I
think the users would be fine with running semodule -i <module> rather
than dropping in a file as long as we can make that a low overhead
operation.

> 
> >> Also, how can we also support policy access control? For example, how do
> >> we determine who changed the policy if multiple people can edit the
> >> policy files? How do we handle simultaneous edits? What about
> >> transactions?
> > 
> > Again, policy as config data doesn't seem to preclude having a tool
> > mediate the changes.
> > 
> 
> If a tool is required then how is it better than what we have now?

I don't believe the requirement to use tools is one of the real
obstacles to using SELinux at present; if anything, admins seemed to
very much like the ability to control SELinux via semodule and semanage
rather than using vi and make.

I do however see binary modules as creating a lot of fragility, and
without truly bringing the benefits they were originally intended to
confer.  That's a separate issue from whether or not one uses a tool to
install a module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
