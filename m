Subject: Re: Base module, modules.conf
From: Dominick Grift <domg472@gmail.com>
To: Cheyenne Solo <ayla.cheyenne@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <5ab9a20b0902041252l7041062fqc7202db633bb2141@mail.gmail.com>
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
	 <1232132620.13917.109.camel@localhost.localdomain>
	 <5ab9a20b0902041252l7041062fqc7202db633bb2141@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 22:53:31 +0100
Message-Id: <1233784411.6488.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Op woensdag 04-02-2009 om 15:52 uur [tijdzone -0500], schreef Cheyenne
Solo:

> I've started using Fedora 7 so I can use the strict policy and its
> user mapping capabilities for my (A)RBAC experimentation.

You can use RBAC just as well with Fedora 10. If required you can even
uninstall the unconfined module which will turn your targeted policy
into strict policy. Fedora 7 policy is no longer maintained.

> I have hit a different roadblock, however, dealing with custom user
> mappings: I cannot get users I've created to map to SELinux users I've
> defined. I've declared the users and their roles and types in a module
> that I have installed into the policy. 

Are you sure that this module is proper?

> When I added mappings to /etc/selinux/strict/seusers , either by hand
> or with semanage, the user ends up with the context
> system_u:system_r:xdm_t:SystemHigh-SystemLow. 

Are you sure that the mappings are create properly?

> I have files in the /etc/selinux/strict/contexts/users/ directory for
> each user and have put the types and roles appropriately in the
> default_type file. 

Did you also edit the contexts in the user contexts file? Not sure what
if anything is required in the default_type file.

> How does the login process really determine these mappings, and why
> would all of my custom mappings be redirected to
> system_u:system_r:xdm_t? I am quite puzzled.

Basicly it is the following steps i think.

You create an install a proper user domain.
you add a proper user mapping that has access to your new role.
You add a proper login mapping that maps the Login user to the SELinux
user.
You create a proper default context file. It has the name of the SElinux
user and it has proper default contexts defined in it.

This should, atleast in my view in Fedora 10, do it.

> Thanks,
> Ayla


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
