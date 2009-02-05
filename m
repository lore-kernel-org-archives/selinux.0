Subject: Re: Base module, modules.conf
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cheyenne Solo <ayla.cheyenne@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <5ab9a20b0902041252l7041062fqc7202db633bb2141@mail.gmail.com>
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
	 <1232132620.13917.109.camel@localhost.localdomain>
	 <5ab9a20b0902041252l7041062fqc7202db633bb2141@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 12:51:46 -0500
Message-Id: <1233856306.3181.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-04 at 15:52 -0500, Cheyenne Solo wrote:
>  
> 
> On Fri, Jan 16, 2009 at 2:03 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>          
>         On Fri, 2009-01-16 at 12:43 -0500, Cheyenne Solo wrote:
>         > Hello list,
>         >
>         > This is my first time writing to the list, and I'm an
>         SELinux newbie.
>         >
>         > I'm trying to do some experiments on SELinux that require me
>         to
>         > replace the base module.
>         
>         
>         Can you explain why?  Often it turns out that people can in
>         fact do what
>         they want without replacing the base module these days
>         (particularly
>         given the merge of strict and targeted policies), so it would
>         be good to
>         first double check that you truly need to do this.
> 
> You're quite right; after more fiddling and thinking I've found I can
> do what I want (and it's better to do so anyway) with the base policy
> intact. I've started using Fedora 7 so I can use the strict policy and
> its user mapping capabilities for my (A)RBAC experimentation. While I
> would still like to be able to modify the base policy, I can do
> without.

No need to regress to Fedora 7; as I said, the strict and targeted
policies have been merged into a single policy in Fedora 8 and later
such that you can map users to confined roles and even remove unconfined
altogether if you wish (although that requires care and likely isn't
required for your purposes).  You really should be using a Fedora
release that is still supported, like Fedora 10.

> I have hit a different roadblock, however, dealing with custom user
> mappings: I cannot get users I've created to map to SELinux users I've
> defined. I've declared the users and their roles and types in a module
> that I have installed into the policy. When I added mappings
> to /etc/selinux/strict/seusers , either by hand or with semanage, the
> user ends up with the context
> system_u:system_r:xdm_t:SystemHigh-SystemLow. I have files in
> the /etc/selinux/strict/contexts/users/ directory for each user and
> have put the types and roles appropriately in the default_type file. 
> 
> How does the login process really determine these mappings, and why
> would all of my custom mappings be redirected to
> system_u:system_r:xdm_t? I am quite puzzled.

system_u:system_r:xdm_t is the context of the graphical display manager,
so if you are ending up in that context upon a graphical login, that
means that your graphical display manager did not successfully set the
context to anything for the user session.  It may have logged some
errors to /var/log/messages or /var/log/secure.  It shouldn't have let
you login at all in enforcing mode.

Did you follow the instructions in:
http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation

The general sequence is:
1) Look up the Linux user in the seusers file, thereby obtaining a
SELinux user and a level.  This is handled by the getseuserbyname()
function in libselinux.
2) Get the list of security contexts for that (SELinux user, level) pair
reachable from the caller's context.  This is handled by the
get_ordered_context_list_with_level() function in libselinux.
Internally, this asks the kernel for a list of such contexts based on
policy and then orders and prunes the list based on the default_contexts
file.

There are some sample utilities (getseuser, getdefaultcon) in the
libselinux source tree that can be used to directly exercise those
functions for debugging purposes.

It would help for you to post your actual module and config files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
