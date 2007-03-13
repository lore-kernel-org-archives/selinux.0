Subject: Re: Getting Security Identifier (SID) for newly created process
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <9d1b82480703131015y38a40d97k148b00e525f85cc2@mail.gmail.com>
References: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
	 <1173804916.2068.69.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480703131015y38a40d97k148b00e525f85cc2@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 13:35:52 -0400
Message-Id: <1173807352.2068.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 22:45 +0530, Pravin wrote:
> I dont know if u remember, But I was working on CKRM and SELinux integration.
> I also sent u a mail regarding my plans of adding hooks inside
> configfs, so that
> we can get better access control by using SELinux ACL's.
> 
> Please refer that mail with "SELinux and CKRM integration" for details
> of my plan about where in CKRM i am planning to add these hooks. If u
> want, I can resend it again.

I remember, but I wasn't clear on the connection here, as I wouldn't
expect you to have to compute the SID for a newly created process in
that code.  I can see you defining and implementing new LSM/SELinux
hooks called by CKRM to allocate, set up, and free security structures
for your resource group objects, just as already exist for tasks,
inodes, sockets, etc, and those hooks might call
security_transition_sid() to compute a SID for the resource group
objects.

> As part of those hooks, I also need to add security context to
> "res_group" data structure  (struct res_group) used by CKRM.
> This is required because SELinux need's to take decision like
> "Can process A create resource group B" and for that SELinux should be
> able to addrss "resource group B". This is why I need that security
> context in "struct res_group".

You wouldn't put it directly there, just like we didn't directly put a
security context on task_struct or inode.  LSM provides a layer of
indirection via the void* security fields, and you make hook calls from
your code to allocate, set up, and free the actual security structures.

> Here I am stuck about how to give initial SID's to these initial "res_group",
> and how to give SID's to any newly created res_group.
> 
> It will be great, If I can get some help here.

In the CKRM code, you would just make appropriate calls to LSM hooks and
then define SELinux hook function implementations that would handle the
actual setting of SIDs.  For initial objects, you can do it from
selinux_init(), just as we do for the initial task and keyrings, or you
can hook your initializer function to call a LSM hook for that purpose
(as is done e.g. for kernel sockets).

However, in terms of making sure that your approach is correct, I think
you also need to engage the CKRM developers to see if they think you are
controlling the right objects and operations based on their knowledge of
CKRM internals.  I can give general guidance, but I'm no expert on CKRM
internals.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
