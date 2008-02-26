Date: Wed, 27 Feb 2008 00:39:05 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH][RFC] Unify printk messgaes
In-Reply-To: <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0802270036270.22022@us.intercode.com.au>
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
 <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Feb 2008, Stephen Smalley wrote:

> 
> On Tue, 2008-02-26 at 20:53 +1100, James Morris wrote:
> > I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
> > kernel boot messages, so I've unified these to "SELinux:" with the patch 
> > below to reduce user confusion.  (It doesn't try and fix every printk, 
> > just the ones with "security:").
> > 
> > Also simplified the avtab hash message, from:
> > 
> >   SELinux:8192 avtab hash slots allocated. Num of rules:163922
> > 
> > to
> > 
> >   SELinux: 8192 avtab hash slots, 163922 rules.
> > 
> > 
> > Comments?
> 
> Makes sense from a user perspective - reflects further nativization of
> the Flask code for the Linux implementation, but will yield a difference
> in output between SELinux and e.g. SEBSD.  Only question I have is
> whether any userspace tools are looking for the security: prefix today.

Not that I'm aware of.  These are informational kernel messages, and if 
userland needs access to the information, it should really be done via an 
official user interface such as selinuxfs.

> I don't think we can change the avc: prefix for avc messages given the
> impact on userspace tools that search for them.

Agreed.

> It would also likely help to change error messages in hooks.c to have
> SELinux in the message in place of the __FUNCTION__ name, and/or to
> ensure that all such functions have a selinux prefix.
> inode_doinit_with_dentry is an obvious candidate for renaming - my bad.

I'll add this to the todo list -- the main thing was to not use 
"security:", as it implies something at the LSM layer.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
