Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FHL3L9009213
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 12:21:03 -0500 (EST)
Subject: Re: Determining if SELinux is installed
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Scott Cain <cain@cshl.org>, selinux@tycho.nsa.gov
In-Reply-To: <42122D9E.40806@redhat.com>
References: <1108484321.3297.45.camel@localhost.localdomain>
	 <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1108486127.3297.55.camel@localhost.localdomain>
	 <42122D9E.40806@redhat.com>
Content-Type: text/plain
Message-Id: <1108487575.17854.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 12:12:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 12:13, Daniel J Walsh wrote:
> Why can't you fully path it?  Just checking if the /proc/filesystem 
> exists is not sufficient, if the user has disabled
> SELinux via /etc/selinux/config instead of selinux=0, I think.  
> selinuxenabled also checks to see if a policy has been
> loaded.

That used to be true (in FC2 days), but is no longer the case - runtime
disable support completely disables SELinux, including unregistering
selinuxfs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
