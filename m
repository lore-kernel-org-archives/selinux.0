Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBHDqCIi001917
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 08:52:12 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBHDoSFj006578
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 13:50:29 GMT
Subject: Re: setting boolean values
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041217013648.GB11330@yggdrasil.localdomain>
References: <20041217013648.GB11330@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1103291222.3437.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Dec 2004 08:47:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-16 at 20:36, Greg Norris wrote:
> Stupid question... which component is responsible for setting the 
> initial value for booleans during system startup?  I'm guessing this 
> would be init's job, but am not absolutely certain.  I'm trying to 
> determine why they aren't being set properly on my Debian system... 
> hopefully it's not something embarrassingly stupid (nah, that NEVER 
> happens! ;-).

Yes, the current patch for /sbin/init calls sepol_genbools() to rewrite
the boolean initial values in the binary policy based on your booleans
config file prior to calling security_load_policy().  That was
introduced during FC3 development, so the Debian patch for init might
not be up-to-date.  BTW, Fedora Core now has a public CVS repository, so
people who want to track the SELinux-related patches there can do so
much more easily.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
