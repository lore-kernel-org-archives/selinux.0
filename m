Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?=22Bj=F6rn?= "Vogel\"" <selinux770@tortenboxer.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070810130703.128070@gmx.net>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
Content-Type: text/plain; charset=utf-8
Date: Fri, 10 Aug 2007 09:19:31 -0400
Message-Id: <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-10 at 15:07 +0200, "Björn Vogel" wrote:
> > > It could be solved by removing -z,defs from the src/Makefile. I don't
> > know the consequences but it works.
> > 
> > No, it depends on thread local storage support in your glibc.  Manoj was
> > using a workaround patch for it at one time for Debian,
> > http://marc.info/?l=selinux&m=115807948020898&w=2
> 
> > restorecond depends on inotify.  But you don't need restorecond to have
> > a working system, so you can always remove it from the Makefile SUBDIRS
> > definition.
> 
> I'll try that. Thanks.
> 
> > > That's why I'm using the old sources. They work.
> > 
> > Well, except that they evidently don't.
> 
> Ok, you're right. Actually I meant: They compile with less problems ;o)
> 
> > > > Those versions are consistent with one another.
> > > > Kernel version?  Policy version?
> > > kernel version is 2.6.16-omap1
> > > How do I find out the policy version?
> > 
> > Same way you found out what package version you were using of
> > checkpolicy and friends, I assume.
> 
> Then i think it's 
> selinux-policy-default_1.26-7 or
> selinux-policy-default_1.26
> 
> I'm not really sure about that, because the policy was not written by me. It's only for testing. If the version of the policy is relevant, this might by the most probable error. Which version has the policyto be (at least)  to work with the (old) packages I mentioned?

That should be fine; you'd only run into problems if using newer
reference policy versions with that older checkpolicy.

I'd suggest sending me a copy of your policy.conf and policy.20
off-list, and ideally giving me the precise URLs where I can find
the .tar.gz files that you used as your baseline.  Then I can try to
re-create the bug.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
