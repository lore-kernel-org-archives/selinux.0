Subject: Re: [refpolicy] apt and rpm
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Stefan Schulze Frielinghaus <stefan@sf-net.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1187099652.26008.171.camel@moss-spartans.epoch.ncsc.mil>
References: <D7B1D472-6E9E-407F-B9DE-E7D6B100F0CC@sf-net.com>
	 <1187099652.26008.171.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 18:04:33 +0000
Message-Id: <1187719473.13874.28.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-14 at 09:54 -0400, Stephen Smalley wrote:
> On Tue, 2007-08-14 at 08:14 +0200, Stefan Schulze Frielinghaus wrote:
> > Hello,
> > 
> > I'm trying to fix the rules for apt and I have some questions  
> > regarding how "rpm allow-rules" work.
> > 
> > For example the last update was about the loadkeys package. In  
> > permissive mode I get the following failures while updating:
> > 
> > allow loadkeys_t apt_t:fd use;
> > allow loadkeys_t apt_t:fifo_file write;
> > allow loadkeys_t devpts_t:dir search;
> > allow loadkeys_t dpkg_t:fd use;
> > allow loadkeys_t dpkg_t:fifo_file { read write };
> > allow loadkeys_t newrole_t:fd use;
> > allow loadkeys_t sysadm_devpts_t:chr_file { read write };
> > 
> > With other updates I get nearly the same errors. I beliefe that these  
> > problems had rpm too. Because every package apt/rpm tries to exchange/ 
> > restart a file descriptor etc. will be needed. I could add for every  
> > domain a apt_read_pipes(*) but I think this is _not_ the SELinux way ;-)
> > 
> > How could I solve these ones? Is there an interface which regards  
> > other programs more power while speaking with apt/rpm?

I believe it has to do with long chains of exec() and fd inheritance of
pipes and terminals, etc.  For example:

staff_t->newrole_t->sysadm_t->rpm_t->rpm_script_t->loadkeys_t

Its easy to handle the transition itself, but the problem is with
propagating rules for the inherited things, like the terminal and role.
Normally it manages to work out since sysadm can already transition to
these domains, so the terminal and role works out.  If we wanted to add
a completely new role, say pkgadm, which could only run rpm, we'd still
have to get any domain that rpm transitions to added to pkgadm_r and
probably allowed to use pkgadm's terminals.

I have ideas for making this work (it can work now, but the
implementation is not so nice), but it requires role domination (or role
attributes), and a way to add types in one attribute to another
attribute.

> Looks like rpm cheats ;)  I see rpm_use_fds() and rpm_read_pipes() in an
> optional_policy block within the domain_type() definition in domain.if
> (underneath a comment about them being questionable).

Yes, it does cheat.

> Also, I have to wonder how much benefit we derive from using separate
> domains for rpm vs. dpkg - abstractly they have the same purpose and
> require the same permissions, even if they exercise a slightly different
> set and may be architected differently.  May be a tradeoff in least
> privilege vs. maintainable policy.   Domains are supposed to be
> equivalence classes.

It might work, I have noticed that the similarities seem to have
increased.

> On the other side, I have to wonder about putting both yum and rpm into
> a single domain, as I could see them possibly being usefully
> differentiated.

I think it would mainly depend on if we want to limit network to only
yum.  IIRC rpm itself can pull from through http or ftp if you specify
it on the command line.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
