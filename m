Subject: Re: Base module, modules.conf
From: Stephen Smalley <sds@tycho.nsa.gov>
To: domg472@gmail.com
Cc: Cheyenne Solo <ayla.cheyenne@gmail.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1232133792.8594.4.camel@localhost.localdomain>
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
	 <1232132620.13917.109.camel@localhost.localdomain>
	 <1232133792.8594.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 14:52:24 -0500
Message-Id: <1232135544.13917.140.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-01-16 at 20:23 +0100, Dominick Grift wrote:
> On Fri, 2009-01-16 at 14:03 -0500, Stephen Smalley wrote:
> 
> > You need to first obtain a policy source tree as your starting point.
> > If you want to minimize your divergence from the distro-shipped policy,
> > then download the selinux-policy source RPM (.src.rpm) for your distro,
> > expand it, and then customize as desired and rebuild it (Dan - is there
> > a recipe documented somewhere for doing that?). 
> 
> I have created a screen cast that focuses on just that. However, the
> file is 200MB and i do not have the ability to host it.

I just meant writing down the sequence of commands to set up a buildable
policy source tree from the .src.rpm.  Screencast seems a bit overkill
for that - it really ought to just be part of the Fedora SELinux FAQ or
Guide IMHO.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
