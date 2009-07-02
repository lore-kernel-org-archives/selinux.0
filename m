Subject: Re: [Patch 2/2] libsemanage: remember and retrieve dontaudit
 settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4CBC6C.5090709@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 10:13:24 -0400
Message-Id: <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 09:55 -0400, Christopher Pardy wrote:
> It's not that a program would use this that couldn't link against
> libsemanage the functionality just seemed closer to that of the
> functions in libselinux, I've been doing alot of work on fedora stuff
> It seems to me  that 90% of the code in libsemanage is handle
> dependent functions. libselinux seems to be more of a global setting
> kind of deal. so it made sense to put it here. Let me know if this
> isn't the case

Unless you envision this interface being called by non-management
programs, I think it is reasonable to require them to link against
libsemanage and use an interface provided by it.

> > This doesn't make sense to me - we check whether we've already set
> > disable dontaudit and use that to decide whether to create the file?
> > But the existence of the file is what would have triggered setting
> > disable dontaudit in the first place.  Round and round we go...
> >   
> When we create the handle we set it's default property to the system
> default. When we commit a handle we set the system default property to
> the handles property. In between it is fully possible to that we have
> called a set_disable_dontaudit to change the value in the handle. If
> you would rather I checked if the two were different first I can.

Hmmm...but if the flag file is private to the store, then you can just
create or remove it directly from semanage_set_disable_dontaudit(), and
you won't need to do this at commit.  At which point you seemingly don't
need the libsepol or libsemanage get functions.

BTW, to create a new file in the store, you'll want to extend
semanage_sandbox_defs in semanage_store.h with a
SEMANAGE_DISABLE_DONTAUDIT value and use
semanage_fname(SEMANAGE_DISABLE_DONTAUDIT) to obtain the pathname to the
flag file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
