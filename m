Subject: Re: object class discovery userland
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <465C67EB.1040801@tycho.nsa.gov>
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>
	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>
	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>
	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1179929852.10995.51.camel@sgc.columbia.tresys.com>
	 <46548D4E.50000@tycho.nsa.gov> <465623DD.6090304@tycho.nsa.gov>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFF31@exchange.columbia.tresys.com>
	 <465750DF.1050509@tycho.nsa.gov>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFFA2@exchange.columbia.tresys.com>
	 <465C67EB.1040801@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 29 May 2007 14:36:29 -0400
Message-Id: <1180463789.3340.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-29 at 13:50 -0400, Eamon Walsh wrote:
> Joshua Brindle wrote:
> > Eamon Walsh wrote:
> >> Here's a first go at an interface.  It's an init function
> >> that is a replacement for avc_init().  It takes flags, the
> >> class/permission mapping to use, and callback functions.
> >>
> >> This is trying to solve a few other problems at the same time, namely:
> >>
> >> - selinux prefix on the function name
> > 
> > So the client callsites will have to change then, oh well, we wanted to
> > do this anyway..
> 
> Well, the old avc_init() could be kept around for awhile.  Calling it 
> would still work, it just wouldn't have a mapping (would treat incoming 
> class/perm values literally).
> 
> > 
> >> - drops support for memory, threading, and locking callbacks
> >> (would just always use malloc and pthread)
> > 
> > Were these ever used or were they a remnant of the early
> > implementations?
> 
> I'm not aware of any users of them.  I put them in basically because the 
> X server wrapped malloc ("Xalloc"), glib has malloc wrappers and so 
> forth.  But the X people are moving away from this and back to straight 
> malloc.  I've come around to the belief that this is better done through 
> the linker with private functions.

Might want to look at dbusd; it uses the callbacks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
