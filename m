Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGg5L9008722
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:42:05 -0500 (EST)
Subject: Re: Determining if SELinux is installed
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Scott Cain <cain@cshl.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108484321.3297.45.camel@localhost.localdomain>
References: <1108484321.3297.45.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 11:33:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 11:18, Scott Cain wrote:
> Hello,
> 
> Is there a programmatic way to determine if SELinux is installed and
> enabled?  I would like to know so that I can let the installer I've
> written take appropriate action if it detects that it is there.

The libselinux function is is_selinux_enabled(3).
There is also a libselinux utility called selinuxenabled(1) that can be
used in a conditional, e.g. if selinuxenabled; then echo Yes; fi.
Finally, you can also manually check for presence of selinuxfs in
/proc/filesystems.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
