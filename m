Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VKoGMV009277
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 16:50:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6VKoGfo022326
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 20:50:16 GMT
Message-ID: <46AFA076.7090904@manicmethod.com>
Date: Tue, 31 Jul 2007 16:49:58 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: shahbaz khan <shazalive@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: PMS and SELinux
References: <7b740b700707301225q4aa45498yb61f12af17be0d95@mail.gmail.com>
In-Reply-To: <7b740b700707301225q4aa45498yb61f12af17be0d95@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

shahbaz khan wrote:
> I would like to ask a few questions from the experts regarding some 
> implementations. I am working on a survey on selinux rsbac and 
> grsecurity. Got some from mailing lists but need more. References will 
> be appreciated.. They are the following:
>  
>
>    1. What is a security aware application. What functionality it can
>       provide? Has this functionality been provide in the other
>       competitors.
>
a security aware application, in SELinux, is an application that 
utilizes the userspace interface to the security server. That is, it 
requests security decisions that are fulfilled by the kernelspace or 
userspace security server based on the policy loaded into the security 
server.

>    1. Where are sids implemented. I have heard that they are history
>       now. How are they opaque to object managers?
>
sids are only used in the kernel now, as a way to avoid dealing with 
memory lifespans on structs containing a security field (and also to 
save memory by only having one copy of each context, in the sidtab)

>    1. What difference has PMS brought to selinux. Do we have such in
>       other implementations?
>
it is still in a prototype phase so in terms of practical benefits it is 
pretty minimal, for now. It does allow one to control updates to the 
policy though, and hopefully will be ready for widespead deployment at 
some point in the near future. Other implementations (eg., rsbac, 
grsecurity) do not have fine grained access control on policy updates, 
implementations such as trusted extensions on solaris have a static BLP 
policy and therefore have no policy updates.

>    1. How is PMS implemented? Any technical documents? Is it a secure
>       application using the extended api?
>
There are a few fairly high level documents on selinux-symposium.org, 
and some others on oss.tresys.com/projects/policy-server. Since the 
object model changed fairly in the last implementation of the policy 
server the technical documents on the object model are currently out of 
date, we should be updating them at some point though.

>    1. How and where is AVC implemented?
>
the AVC is used by object managers (both kernel and userspace) to make 
access decision lookups faster, there is an implementation in the kernel 
(security/selinux/avc.c) and in libselinux (libselinux/src/avc.c)

>    1. Is there any good logging facility apart from regular denial? I
>       have heard rsbac and grsecurity has better logging facilities.
>
SELinux utilizes the in-kernel auditing framework, we don't want to 
confuse auditing and security policy enforcement (though we do have 
auditallow functionality), more fine grained auditing on specific 
syscalls, etc can be accomplished with the audit framework (see man 
auditctl)

>    1. SELinux uses syscall interception. Is it through LSM? How does
>       rsbac and grsecurity manage this?
>
There is no syscall interception, LSM is more abstract than the syscall 
layer. rsbac and grsecurity both implement their own hook systems that 
are similar (both different enough that they aren't satisfied with LSM).

>    1. Of the topic but how does grsecurity implement acls and rbac. Is
>       rbac used through the acls or a seperate module?
>
probably the best place to ask detailed questions about grsecurity's acl 
implementation is on their list.

>    1. How can we best judge the network controls of rsbac and
>       grsecurity w.r.t. implementation, usability and functionality?
>
grsec and rsbac both use network controls similar to the old selinux 
controls, where we limited access to specific ports, network interfaces, 
etc. SELinux now uses a netfilter based system where we apply labels to 
packets based on any netfilter criteria (port, interface, remote node, 
connection tracking, anything iptables can filter on) and we allow 
access based on the label of a particular packet. We also have 2 
implementations of labeled networking, which isn't available in rsbac or 
grsec.

> I will be glad to put the names of responders in my survey document's 
> acknowledgements.
>  
No need.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
