Subject: Re: Conditional Policy using Reference Policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <321794.33448.qm@web86908.mail.ukl.yahoo.com>
References: <321794.33448.qm@web86908.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 08:46:33 -0400
Message-Id: <1175172393.13607.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 06:50 +0100, JanuGerman wrote: 
> I am trying to configure SELinux conditional policy
> using the Reference policy mechanism. Unfortunately,
> it does not take effect but, the module compiled
> successfuly. 

You haven't declared the boolean.  Also, the policy is in an interface,
so if nothing calls it, then you won't get a compile failure if the
Boolean does not exist.

> Which means that there was no boolean
> variable in the /selinux/booleans/. Plus, i wanted to
> ask, is this the correct way to enforce a conditional
> policy. The objective of this simple policy is that
> "any application can read/write but cannot delete this
> file, provided the boolean variable is set"

With the current policy it means that any domain that calls this
interface will be able to read and write the file if the Boolean is
true.

> Secondly, there are some commands given in the
> litrature for committing the values of the booleans to
> make them effective like change_bool variable 1, and
> echo 1 > /selinux/commit_pending_bools. The question
> is that whether these commands are not avialable any
> more?

change_bool and show_bool were renamed to setsebool and getsebool,
respectively.  You can still echo 0 and 1 to the entries
in /selinux/booleans/* and /selinux/commit_pending_bools.


> myapp.te:
> 
> policy_module(myapp,1.0)
> type myapp_t;
> domain_type(myapp_t)

Since you are trying to make a type for a file, you would want
file_type() instead of domain_type().

> 
> myapp.if:
> interface(`myapp_open_cond',`
> 	gen_requires(`

This should be gen_require (no s at the end).

> 		type myapp_t; bool test;
> 	')
> 
> 	
>         if (test) {
> 	allow $1 myapp_t:file rw_file_perms;
> 	}
> ')
> 
> myapp.fc:
> 
> /root/testfile   -- gen_context(system_u:object_r:myapp_t,s0)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
