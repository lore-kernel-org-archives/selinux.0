Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67GQfrT006940
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 12:26:41 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67GQeaX029302
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 16:26:40 GMT
Subject: Re: Compiling error - sysvinit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Jan Gehring <pr0gm4@linoratix.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1088791604.6478.6.camel@gorn.pebenito.net>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com>
	 <20040702071544.GA3277@lkcl.net> <20040702092526.GD3277@lkcl.net>
	 <20040702190146.78697fe7.pr0gm4@linoratix.com>
	 <1088791604.6478.6.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1089217593.1774.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 12:26:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-02 at 14:06, Chris PeBenito wrote:
> Most likely you are trying to compile an older sysvinit patch against
> libselinux-1.14.  I saw this myself a few days ago.  These two #defines
> are gone in 1.14.  Best bet is to update your sysvinit patch.  I added
> back these two #defines back into Gentoo's libselinux-1.14 selinux.h for
> compatibility, which is another option.
> 
> The #defines were:
> 
> #define SELINUXMNT "/selinux/"
> #define SELINUXPOLICY "/etc/security/selinux/policy"

Just be careful that no code other than /sbin/init uses such
definitions, as all other code should determine the selinuxfs mount
point at runtime via /proc/mounts (or just use the libselinux functions)
and should obtain policy file paths at runtime using the new libselinux
functions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
