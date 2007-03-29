Subject: Re: Conditional Policy using Reference Policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <321794.33448.qm@web86908.mail.ukl.yahoo.com>
References: <321794.33448.qm@web86908.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 08:21:06 -0400
Message-Id: <1175170866.3864.536.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 06:50 +0100, JanuGerman wrote:
> Hi every one,
> 
> I am trying to configure SELinux conditional policy
> using the Reference policy mechanism. Unfortunately,
> it does not take effect but, the module compiled
> successfuly. Which means that there was no boolean
> variable in the /selinux/booleans/. Plus, i wanted to
> ask, is this the correct way to enforce a conditional
> policy. The objective of this simple policy is that
> "any application can read/write but cannot delete this
> file, provided the boolean variable is set"
> 
> Secondly, there are some commands given in the
> litrature for committing the values of the booleans to
> make them effective like change_bool variable 1, and
> echo 1 > /selinux/commit_pending_bools. The question
> is that whether these commands are not avialable any
> more?
> 
> The module files are as follows:
> Thanks,
> JG
> 
> myapp.te:
> 
> policy_module(myapp,1.0)
> type myapp_t;
> domain_type(myapp_t)

Your .te file only defines a type and declares it to be a domain type.
It doesn't define the boolean, nor does it define any allow rules for
the type you have defined.

> myapp.if:
> interface(`myapp_open_cond',`
> 	gen_requires(`
> 		type myapp_t; bool test;
> 	')
> 
> 	
>         if (test) {
> 	allow $1 myapp_t:file rw_file_perms;
> 	}
> ')

The optional .if (interface) file is to define interfaces provided by
your module for other modules to call.  But as no other module calls
this interface, it is never used.  I think you instead wanted to declare
the boolean (not in a requires block, but as a definition with a default
value) and put the conditional allow rule into your .te file.  You don't
need an .if file unless your module needs to be called by other modules.

> myapp.fc:
> 
> /root/testfile   -- gen_context(system_u:object_r:myapp_t,s0)

This doesn't make sense because myapp_t was defined as a domain type,
i.e. a type for a process, not a file.  I'd suggest doing some more
reading of the online documentation for refpolicy and looking at
existing .te files as examples, and possibly using SLIDE
(http://oss.tresys.com/projects/slide) to help you create your module.
There is also a book, SELinux by Example, that you may find helpful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
