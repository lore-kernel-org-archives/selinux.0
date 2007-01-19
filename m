Message-ID: <45B0FB16.1040509@mentalrootkit.com>
Date: Fri, 19 Jan 2007 12:08:38 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] add selpolgen
References: <45ACEE9E.7000709@mentalrootkit.com>	 <1169135113.22731.285.camel@moss-spartans.epoch.ncsc.mil>	 <45AFD027.9070007@mentalrootkit.com>	 <1169214598.22731.508.camel@moss-spartans.epoch.ncsc.mil>	 <1169222979.22731.567.camel@moss-spartans.epoch.ncsc.mil>	 <45B0F088.2030104@mentalrootkit.com> <1169225990.22731.596.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169225990.22731.596.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-01-19 at 11:23 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2007-01-19 at 08:49 -0500, Stephen Smalley wrote:
>>>> On Thu, 2007-01-18 at 14:53 -0500, Karl MacMillan wrote:
>>>>> Stephen Smalley wrote:
>>>> We can follow whatever practice is normal for python modules.  However,
>>>> how are those usually packaged?  Separate from the application that uses
>>>> them?  Or together?  As it stands, this module would become a dependency
>>>> of audit2allow and thus of policycoreutils; is there any benefit to
>>>> packaging it separately?
>>> Or conversely, we could remove audit2allow from policycoreutils and put
>>> it and this new python module into a single package.  It isn't as though
>>> audit2allow is fundamental to system operation anyway.
>>>
>> I think that the separation is desirable and matches current python 
>> practice. The sepolgen module is meant to be generic and available to 
>> many python programs (which is why it gets installed in python 
>> site-packages).
> 
> Ok.
> 
>> I would rather break policycoreutils into multiple packages to remove 
>> the dependency on this for minimal installations. There is a natural 
>> division between system / policy management tools (e.g., restorecon, 
>> semanage, newrole) and policy debugging / development (audit2allow, 
>> audit2why, semodule_link, semodule_expand, and semodule_package).
>>
>> Maybe selcoreutils (which can eventually be bundled under a single 'sel' 
>> command like git / svn) and policydevtools. Distros may want to further 
>> divide those packages into graphical and non-graphical.
> 
> Are you proposing a new upstream structure, or just how the existing
> policycoreutils might be split into multiple packages by distributions?
> Fedora already splits newrole and system-config-selinux into their own
> distinct sub-packages (policycoreutils-newrole, policycoreutils-gui),
> the former to avoid a need for newrole under targeted policy due to
> concerns about its suidness.
> 

New upstream structure - though just letting distros split them how they 
will is also fine with me.

> I'd tend to put semodule_package into the same class as
> checkmodule/checkpolicy (policy build toolchain, required even to build
> local modules, and thus needed by ordinary users), whereas
> semodule_link, semodule_expand, and semodule_deps are more
> development/debug tools oriented toward selinux developers.  audit2allow
> and audit2why are likewise user-oriented tools rather than only being
> used by selinux developers.
> 

Agreed.

> libsemanage invokes setfiles, genhomedircon, and load_policy, so it
> requires them.  There is presently a circular dependency between
> libsemanage and genhomedircon.
> 

genhomedircon should probably be folded into libsemanage eventually.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
