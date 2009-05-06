Subject: Re: policy as configuration data
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E010D6962@exchange2.columbia.tresys.com>
References: 
	 <06A6610D4F464D4EBEAFBF2C5F86911E010D6962@exchange2.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 06 May 2009 10:32:17 -0400
Message-Id: <1241620337.27629.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-05 at 17:03 -0400, Caleb Case wrote:
> We've been looking into a couple of improvements to the SELinux
> infrastructure. One of the options we are looking at is treating policy
> as configuration data. We've found a couple of sticking points though.
> 
> First, removing a set of trusted tools (running in domains only able to
> access files of appropriate types) from the policy modification process
> makes it more difficult to control the flow of low integrity data into
> the policy.

Policy as configuration data does not imply that you have to let users
directly modify the config files without using a tool (which is useful
for general integrity and transactional behavior, not just security).
passwd data is config data, yet you are supposed to edit it via vipw and
tools like useradd.

> Also, how can we also support policy access control? For example, how do
> we determine who changed the policy if multiple people can edit the
> policy files? How do we handle simultaneous edits? What about
> transactions?

Again, policy as config data doesn't seem to preclude having a tool
mediate the changes.

> It's unclear if this is important since part of the goal here is to
> simplify and improve the SELinux experience.
> 
> Using a trusted set to tools has its advantages and doesn't necessarily
> preclude the use of a text based policy. A tool that could give the user
> a text module back for modification and accept a text module as input
> may be sufficient but doesn't exactly fit into how configuration data
> typically works.
> 
> We are looking for input on whether having an uncontrolled conf.d style
> policy directory that is admin-modifiable without the need for tools is
> a high priority for people or if the disadvantages outweigh the desire
> to edit files directly.
> 
> Questions/comments/rants/flames welcome.
> 
> Caleb
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
