Subject: Re: CKRM and SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
References: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
	 <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 08:01:06 -0500
Message-Id: <1172581266.19041.312.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-27 at 12:06 +0530, Pravin wrote:
> Hi,
> I was working on possibility resource management using SELinux, but I
> feel that using SELinux hooks only, it won't be possible to do
> resource management effectively. 
> 
> After studying CKRM from resource management point of view,
> possibility of integrating SELinux framework with CKRM came over. 
> We can use SELinux contexts and domains to be used as classes in CKRM.
> Enforcing the division of resources will be done by CKRM only.
> In this way, we can reuse the context's of SELinux in CKRM.
> 
> There was a mail dating back to 2005 regarding this possibility 
> http://www.nsa.gov/selinux/list-archive/0506/12047.cfm
> But it seems the idea was not followed afterwards.
> 
> May I know if such integration of SELinux and CKRM is feasible or not,
> and how useful will it be?
> Please let me know your views and comments on this possibility. 

Resource management based on security context would be useful, whether
using CKRM or something else for the resource management.  The
simplistic approach of allowing one to specify resources per security
context wouldn't be adequate; instead, one would want to be able to
assign resources for a set of security contexts matching some criteria,
e.g. all contexts with role R or all contexts with level L.  Look at the
audit filter by context support that exists in current kernels, and note
how the implementation divides responsibility among the audit subsystem
and SELinux such that audit doesn't need to directly interpret contexts.

You would also need to consider the control requirements on the resource
management subsystem, and how to enable SELinux to control the interface
to it with sufficient granularity.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
