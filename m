Subject: Re: Compiling libsepol with -fPIC instead of -fpic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
In-Reply-To: <45636F88.3020608@mentalrootkit.com>
References: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>
	 <4561E044.6050006@mentalrootkit.com>
	 <1164143156.13758.125.camel@moss-spartans.epoch.ncsc.mil>
	 <45636F88.3020608@mentalrootkit.com>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 10:58:25 -0500
Message-Id: <1164211105.13758.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-21 at 16:28 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > On Mon, 2006-11-20 at 12:05 -0500, Karl MacMillan wrote:
> >> Manoj Srivastava wrote:
> 
> >> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > 
> > Is the problem truly limited to libsepol, or is it also an issue with
> > libsemanage and/or libselinux?
> > 
> > Possibly we could define it as a variable in the Makefile (e.g. PIC ?=
> > -fpic) with a default of -fpic and allow you to build them with make
> > PIC=-fPIC on SPARC to avoid any effect on x86.
> > 
> 
> The docs claim an effect only on m68k, PowerPC, and SPARC. So it should 
> be safe to replace this globally for all of our code.

Ok.  Particularly given that both libsemanage and libselinux now depend
on libsepol.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
