Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FH03L9008981
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 12:00:03 -0500 (EST)
Subject: Re: Determining if SELinux is installed
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Scott Cain <cain@cshl.org>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1108486127.3297.55.camel@localhost.localdomain>
References: <1108484321.3297.45.camel@localhost.localdomain>
	 <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1108486127.3297.55.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1108486315.17854.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 11:51:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 11:48, Scott Cain wrote:
> Thanks.  I guess it will have to be the last option, since the installer
> is in perl, so I can't (directly) use is_selinux_enabled, and
> since /usr/sbin isn't typically in a user's path, I can't count on that
> either.  So `grep selinuxfs /proc/filesystems` it is!

Hmm...selinuxenabled (and the other trivial utilities from libselinux)
used to live in /usr/bin, but Red Hat moved them to /usr/sbin.  Perhaps
some of them should still be there for this type of usage.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
