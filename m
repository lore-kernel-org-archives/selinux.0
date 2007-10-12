Message-ID: <470FB394.8000106@tresys.com>
Date: Fri, 12 Oct 2007 13:49:08 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Chad Sellers <csellers@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <C315C13B.2C502%csellers@tresys.com> <46F11C6C.4070306@redhat.com> <470F7BC0.4030003@redhat.com>
In-Reply-To: <470F7BC0.4030003@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I would like to get this moving again.
> 
> I believe we came to a conclusion that the permissive domain should be
> specified in userspace/policy.  So the next question is who can make the
> change and what is the syntax?
> 
> I see we can do this in two ways.
> 
> One we add a new access to the Process Class called Permissive;
> Which would cause the kernel to put this domain in the permissive
> domain.  I am sure Steven dislikes this suggestion.  :^)
> 

Thats a really bad idea, it means that any process that had ~ or * in 
the process class now becomes permissive. It also makes the hooks a 
complete mess as they now have to check for this permission in addition 
to the real requested perm.

> 
> The second solution is to add a new command to audit, dontaudit,
> auditallow, nerverallow
> 
> So if we add permissiveallow or just permissive.
> 
> What does the syntax look like?
> 
> permissive httpd_t;
> 
> permissive httpd_t self:process *;
> 
> In order to implement this, we need to modify libsepol,
> checkmodule/checkpolicy?
> 

I don't like this one either. I'd rather do what we were thinking about 
with selinuxfs where we have /selinux/types/foo_domain_t have a bitmap 
of properties, one of them being permissive.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
