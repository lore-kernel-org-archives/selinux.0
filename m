Subject: Re: Push mmap_min_addr changes to Linus
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <alpine.LRH.2.00.0908151944390.24683@tundra.namei.org>
References: <1250254869.2068.19.camel@dhcp231-106.rdu.redhat.com>
	 <alpine.LRH.2.00.0908151944390.24683@tundra.namei.org>
Content-Type: text/plain
Date: Sat, 15 Aug 2009 19:28:08 -0400
Message-Id: <1250378888.14501.97.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-08-15 at 19:46 +1000, James Morris wrote:
> On Fri, 14 Aug 2009, Eric Paris wrote:
> 
> > I'm tired of these recent exploits and SELinux being weaker against
> > local user priv escalation bugs using NULL pointers.  Can we push 
> > 
> > 7c73875e7dda627040b12c19b01db634fa7f0fd1
> > 84336d1a77ccd2c06a730ddd38e695c2324a7386
> > a2551df7ec568d87793d2eea4ca744e86318f205
> > 47d439e9fb8a81a90022cfa785bf1c36c4e2aff6
> > 
> > To linus?  It's fixing a clear security bug in that we are not checking
> > DAC before granting mmap_min_addr.  If need be I'll write another
> > smaller patch which just does the DAC check in the SELinux security
> > hook, but I'd rather see the true separation.
> 
> Probably best to make the smallest possible change now, so I suggest the 
> latter (which might be useful for distro backporting).

I thought about it overnight and decided that I am unwilling to go that
route.  Tieing both CAP_SYS_RAWIO and mmap_zero to the same /proc
tunable would reduce security when people have to set it to 0.  While we
fix the current SELinux weakness compared to non-SELinux systems we
would be giving up the current SELinux strengths.

Please push these as they stand.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
