Subject: Re: [PATCH] refpolicy: Add GConf policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1159472462.3439.73.camel@moss-lions.epoch.ncsc.mil>
References: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
	 <1159455168.2850.19.camel@sgc.columbia.tresys.com>
	 <1159472462.3439.73.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 16:21:22 -0400
Message-Id: <1159474882.2850.74.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 15:41 -0400, James Carter wrote:
> On Thu, 2006-09-28 at 10:52 -0400, Christopher J. PeBenito wrote:
> > So to make a gconf object manager more useful, it seems like we would
> > want more confined desktop apps.  Do you think more core pieces of gnome
> > will be confined, such as gnome vfs and bonobo?  The group of gnome
> > modules in the example policy didn't seem to gain anything and also
> > seemed overengineered.  Do you anticipate a need to bring back some of
> > this?  If so, I think it would be better to have this as a start of a
> > gnome refpolicy module, which would have all the core pieces of gnome
> > policy.
> 
> You're right.  More desktop apps need to be confined for a gconf object
> manager to be useful.  I am not planning on writing a gnome-vfs-daemon
> or bonobo policy.

I was just curious if you feel that them having policies would be
useful.

>   After finishing up GConf, I'll be looking at window
> managers.
> 
> I think that you can make a case for putting GConf in a gnome policy
> since it is not being used by any other desktop. It really doesn't
> matter too much to me.  It does seem, however, like a gnome policy could
> become quite large.  I guess I imagined policy for a particular desktop
> eventually being kept in a separate policy directory like
> policy/modules/desktops/gnome to keep it organized together, but still
> consisting of many smaller modules.  
> 
> What do you think would be part of the gnome policy?

Core pieces that are common to all gnome systems, like gnome-vfs,
bonobo, orbit, etc.  Other things such as nautilus could go in their own
modules.  That is, assuming any of these need policies.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
