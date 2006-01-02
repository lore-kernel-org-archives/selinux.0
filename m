Message-ID: <43B98298.4020106@tresys.com>
Date: Mon, 02 Jan 2006 14:44:24 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: Documentation, anyone?
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
In-Reply-To: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> Hi,
> Recent changes broke lots of stuff on my system.
> For example, genhomedircon no longer reads my local.users file...
> It seems that this is somehow related to semanage changes...
> Which doesn't work for me, and I can't find *any* documentation on it.
> So the current SELinux shape is IMHO really bad... no current
> documentation, and even those who have working installations (like me)
> have no idea how to get the latest stuff working... :-(
> 
> I have a user role "netuser" who is allowed to use the network to a
> larger extend (e.g. bind to port_t). I'd like to make that the default
> role for certain unix accounts...
> 
> $ semanage user --add -s netuser_u -R netuser_r erich
> ['netuser_r']
> libsemanage.assert_init: A direct or server connection is needed to use
> this function - please call the corresponding connect() method
> libsemanage.enter_ro: could not enter read-only section
> /usr/sbin/semanage: Seuser lerich already defined
> 
> I couldn't find an example for /etc/selinux/seusers, I guessed it looks
> like
> "lerich:netuser_u" but that didn't work either...
> 
> I've also investigated "genhomedircon", and what strikes me as really
> bad code is that it keeps on calling an external "grep" on just about
> everything.
> Loading a file and applying a regexp is really easy in Python, you
> know...
> 
> To all users of my Debian repository or Debian unstable:
> Avoid upgrading for now if you are using extra user roles...
> 
> best regards,
> Erich Schubert

We've been putting a ton of effort into making the upgrade path to a 
managed system pretty painless but it isn't exactly transparent. Have 
you been watching all the traffic here? I know we addressed some of the 
issues you are having. The srpm that upgrades to a modular policy has 
all the migration logic, debian should probably consider converting to 
modular and releasing a migration package since almost all the 
functionality we are now adding depends on having a managed system.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
