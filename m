Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77HljL2020727
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 13:47:45 -0400
Received: from smtp106.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77HlWQx013250
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 17:47:37 GMT
Message-ID: <489B3536.1060103@schaufler-ca.com>
Date: Thu, 07 Aug 2008 10:47:34 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Request for multiple mailing lists
References: <489B25B6.4080309@windriver.com>
In-Reply-To: <489B25B6.4080309@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Ambrose wrote:
> The SE Linux <selinux@tycho.nsa.gov> mailing list is being cluttered 
> with non selinux related material.
>
> Especially concerning refpolicy. And there is no set fast term used 
> for filtering such content, and needless to say a waste of bandwidth.
>

SELinux without policy is like a book without pages. Think of
the reference policy as the pages of the Old Testament.

> The SELinux list is not a place for non-SELinux maintainers, like 
> Tresys to discuss their policies within themselves. Would it be 
> alright for me and the other developers in my company to use the 
> SELinux list to discuss our policies?

Well I think so. It's kind of pointless to have a loadable policy if
everyone always uses the same one now, isn't it?

> Or the next company that decides to adopt SELinux?

You bet. Any issues that arise from any policy should be discussed here.
The basic underlying mechanisms of SELinux have changed more in the past
couple years more in support of policy desires and/or issues than for
any other reason (best I can tell anyhow).

> RedHat goes as far as to using the SELinux list as a communication 
> channel with Tresys. Unless there has been some agreement made between 
> the SELinux gatekeepers (NSA?) , Tresys and Redhat, I find this a 
> misuse of the mailing list.
>
> In the last 4 months, there have only been a handful of unique threads 
> concerning SELinux. A few by Stepehen, Eric, and myself. Everything 
> else is policy related.  With a total of 800 odd messages in this time 
> frame, its quite clear the policy discussion is cluttering the list. 
> As more and more people begin to adopt SELinux and face the battles of 
> SELinux integration, the userspace topic will become increasingly 
> popular.
>

Policy postings are prevalent because policy is where the flexibility of
SELinux lies.

> As I see it, the current list should be split into 3.
>
> 1. selinux-kernel
>    This would be a very low volume list. .Perhaps even with special 
> clearance to address security holes and concerns.

Please, no restricted lists. This is Open Source, after all.

> 2. selinux-userspace
>    This list would deal with userspace tools, wrappers and other non 
> kernel related material. Whether it be NSA's userspace tools or 
> support for 3rd party applications being compiled to be selinux-aware 
> using libselinux. This list is very important, if not the most 
> important of the three.

I could agree if the tool chain, applications, and runtime were not
so tightly integrated with and dependent on the policy.

> 3. selinux-policy
>    This list will deal with policies. A good place for Administrators 
> and policy developers to discuss the creation, debugging and use of 
> various policies. This as it stands would have the highest volume. 
> Nevertheless as suggested by Grift Dominick on #selinux, a forum would 
> be an even better place to discuss policies. Repository of ideas, 
> designs and development dedicated to policies. A forum for the 
> Administrator and Policy Developer.

The policy feeds into the tools which feed back into the policies.
The bulk of the tools are there to deal with policy, so I don't see
them being reasonably separable.

> Without this breakdown, the selinux list would be analogous to people 
> talking about GNU and C programming on lkml.
Which is something that happens from time to time. For good or ill
SELinux is a system, not a just kernel component. Anyone who is serious
about using or even monitoring what goes on with SELinux would need
to watch all three of the proposed lists to make sense of what's
going on.


That is of course the view from over here.

Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
