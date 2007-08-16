Subject: Re: TE for networked resources
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov, muhammad.alam@uibk.ac.at
In-Reply-To: <7b740b700708161401x53a17dd7x628d291f38a6a355@mail.gmail.com>
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
	 <1187291188.909.96.camel@moss-spartans.epoch.ncsc.mil>
	 <7b740b700708161401x53a17dd7x628d291f38a6a355@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 17:08:21 -0400
Message-Id: <1187298501.909.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-17 at 02:01 +0500, shahbaz khan wrote:
> On 8/17/07, Stephen Smalley <sds@tycho.nsa.gov > wrote: 
>         On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:
>         > I was curious while reading Brindle et al paper on enhancing
>         selinux 
>         > policy for network domain that do we really need TE for
>         these remote
>         > resources. Can't we just do with IBAC and RBAC? We can let
>         the local
>         > subjects handle the TE with their own types with respect to
>         the IBAC 
>         > and RBAC of remote subject. This might be what they call
>         equivalence
>         > mechanism. The problems associated with TE are too tough for
>         selinux
>         > and current network controls to handle. The solutions will
>         cost too 
>         > much.
>         
>         User identity and role doesn't convey enough information - you
>         lose the
>         binding to the actual program/code.  Which matters.  You want
>         to be able
>         to allow a given component to interact with another component 
>         specifically, not any arbitrary process running with a given
>         user
>         identity or role.
>  
> I think this arbitration can be solved with iptables' rules. A local
> to remote port restriction. And further hardened with port labels.
> Will the label of ports not be enough? At the required points we still
> have TE.

No, ports aren't adequate for identifying the components.  Think client
side ports and also think dynamic port assignment (ala portmap).

> TE definitely gives a security granularity at the program/code level
> but it is being taken care of by the local system. If the local system
> ensures it till its boundaries then the remote subject, handling the
> requests, can contain the security problems with its own context and
> identity and role of the remote subject.
> 
> Sacrificing of the code binding at the cost of reasonable reduction in
> complexity, where code binding is mandatory in the boundaries of
> computer system but between two systems very little is lost. In the
> boundaries of the local system a malicious code cannot get executed
> with the right policy and if it does how can TE help to contain it
> from the remote system if TE attribute is considered on the remote
> side? I think identity and role are enough to contain it on the remote
> side. The tradeoff will only broaden risks for the data of that role
> and identity because it will not consider its types. Here identity
> serves as the level of granularity in a specific role.
> 
> Secondly, with SECMARK and IPSEC associations we do pass on the TE
> attribute in context. For extra sensitive applications and services,
> TE can be considered which means we still reduce the penalty of
> complexity in policy maintenance.
> 
> Shaz
> 
>  
>         > Is there any progress on this work. Let me know because I
>         have also
>         > working on this and might be able to assist. 
>         
>         --
>         Stephen Smalley
>         National Security Agency
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
