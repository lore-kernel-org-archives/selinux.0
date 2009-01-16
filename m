Subject: Re: Base module, modules.conf
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cheyenne Solo <ayla.cheyenne@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 14:03:40 -0500
Message-Id: <1232132620.13917.109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-01-16 at 12:43 -0500, Cheyenne Solo wrote:
> Hello list,
> 
> This is my first time writing to the list, and I'm an SELinux newbie.
> 
> I'm trying to do some experiments on SELinux that require me to
> replace the base module.

Can you explain why?  Often it turns out that people can in fact do what
they want without replacing the base module these days (particularly
given the merge of strict and targeted policies), so it would be good to
first double check that you truly need to do this.

>  I have a policy I want to use in its place, but I'm having trouble on
> a couple different fronts. The easiest way I can think of to change
> the base module is to redefine what makes it up--that is, modify the
> modules.conf file. Neither of the makefiles have any conf target,
> however, and I have been unable to generate it. I would also like to
> know how to generate a base module from scratch.

What Makefiles are you referring to?  The refpolicy Makefile does have a
conf target.

> So my question is: how do I create a base module? How is it different
> from regular policy modules? How can I generate the modules.conf file
> and use it to modify the base? I have found very little on this in any
> book or on the Internet.
> 
> Relevant system stats: Fedora 8 running the targeted reference policy.

You need to first obtain a policy source tree as your starting point.
If you want to minimize your divergence from the distro-shipped policy,
then download the selinux-policy source RPM (.src.rpm) for your distro,
expand it, and then customize as desired and rebuild it (Dan - is there
a recipe documented somewhere for doing that?).  If you are less
concerned about divergence/compatibility with the distro-shipped policy,
then you can download an upstream refpolicy tarball from
oss.tresys.com/projects/refpolicy and build it, but you'll need to
adjust the upstream build.conf settings (or override them on the
command-line) if you want to match expected behaviors in Fedora.

BTW, Fedora 8 has been EOL'd.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
