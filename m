Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGqPL9008890
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:52:25 -0500 (EST)
Subject: Re: Determining if SELinux is installed
From: Scott Cain <cain@cshl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>
References: <1108484321.3297.45.camel@localhost.localdomain>
	 <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 11:48:46 -0500
Message-Id: <1108486127.3297.55.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 11:33 -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 11:18, Scott Cain wrote:
> > Hello,
> > 
> > Is there a programmatic way to determine if SELinux is installed and
> > enabled?  I would like to know so that I can let the installer I've
> > written take appropriate action if it detects that it is there.
> 
> The libselinux function is is_selinux_enabled(3).
> There is also a libselinux utility called selinuxenabled(1) that can be
> used in a conditional, e.g. if selinuxenabled; then echo Yes; fi.
> Finally, you can also manually check for presence of selinuxfs in
> /proc/filesystems.

Thanks.  I guess it will have to be the last option, since the installer
is in perl, so I can't (directly) use is_selinux_enabled, and
since /usr/sbin isn't typically in a user's path, I can't count on that
either.  So `grep selinuxfs /proc/filesystems` it is!

Thanks,
Scott

-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
