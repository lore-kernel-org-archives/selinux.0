Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38DbbRb017530
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 09:37:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38DZbUZ014047
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:35:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i38DZamT014039
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:35:36 GMT
Subject: Re: strange labeling problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
References: <1081376404.9215.13.camel@nexus.verbum.private>
	 <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1081431443.6379.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 09:37:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-08 at 09:32, Stephen Smalley wrote:
> chcon likely never called setfilecon at all, since getfilecon would have
> told it that the file already had the right context.  Try setfilecon
> instead.  If it had called setfilecon -> setxattr, then SELinux would
> have updated the inode SID accordingly.

This suggests that perhaps chcon should have a force option to force it
to relabel even if it thinks that the file already has the correct
context.  Looks like '-f' is already taken.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
