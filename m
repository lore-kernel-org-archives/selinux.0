Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84AZCrT013455
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 06:35:13 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84AZBp9012701
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 10:35:11 GMT
Date: Sat, 4 Sep 2004 11:46:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen torri <storri@torri.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Guide to replace root as sysadm for machine
Message-ID: <20040904104621.GC4084@lkcl.net>
References: <1094265263.8562.24.camel@base.torri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094265263.8562.24.camel@base.torri.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dear stephen,

remember that the normal unix permissions are applied FIRST
and then the selinux ones second.

therefore you will first need to think of a way to achieve
what you want to do - on a non-selinux-enabled system.

one possible way which more experienced gentoo users will likely
tell you "noooooo don't do that!" would be to make emerge
setuid to root.

... maybe a better way would be to write a small program that
su's to root, asks for the root password (or _a_ password at
least), and then exec's emerge.

at least that way once you have it working you can write an
selinux policy to cover the use of that program.

l.

On Fri, Sep 03, 2004 at 10:34:23PM -0400, Stephen torri wrote:
> I am stumbling my way through using a non-root user as the sysadm for
> the computer. Is there any advice on this?
> 
> My goal is to have a non-root user able to do the following on my Gentoo
> box:
> 
> < User: storri - in sysadm_r (or whatever is appropriate) >
> - emerge rsync
> - emerge -av --deep world (or any package)
> 
> < User: storri - in user_r >
> - compile source code in home directory.
> 
> I figured I would start small. So far I am a bit stuck on getting the
> user sorted out. I figure that have a goal, two non-root users able to
> do normally 'root' actions I would be on my way to learning how to
> configure selinux.
> 
> So far I have added storri to the /etc/security/selinux/src/policy/user
> with the following:
> 
> user storri roles { user_r sysadm_r };
> 
> Beyond this would I need to change the normal 'user' and 'group'
> ownership for those directories touched by the emerge application?
> 
> Stephen
> 
> -- 
> Email: storri@torri.org
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
