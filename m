Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j95Bu6Ns004313
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2005 07:56:06 -0400 (EDT)
Subject: Re: seusers.conf file
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <4342D741.7080006@redhat.com>
References: <4342D741.7080006@redhat.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 07:52:25 -0400
Message-Id: <1128513145.24059.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-04 at 15:25 -0400, Daniel J Walsh wrote:
> I have created an seusers.conf file with the following contents
> root:root:s0-s0:c0.c127
> default:user_u:s0
> 
> 
> Got a pam module that works with it, pretty well.  Problem is, which RPM 
> should I include this in?
> 
> I could just add it to libselinux or put it in a policy file.  Problem 
> with policy files is it would conflict.
> This would probably conf file you would want for mls.
> 
> Ideas?

Taking your question to the list for wider discussion.

So, to provide context for others, at present, seusers.conf (the file
introduced by Dan that maps Linux users to SELinux users and, if MLS is
enabled, MLS levels/ranges) lives directly in /etc/selinux rather
than /etc/selinux/$SELINUXTYPE.  Whether or not that is the right
location for the flat file backend was raised earlier on the list but
there was no clear answer, since on the one hand, it does contain
policy-specific information but on the other hand, other backends (e.g.
LDAP database) are likely to be completely external to policy entirely.
This file is only used by libselinux (getseuserbyname), so we can easily
relocate it if desired.

Dan's question now is what package should own the file.

In a way, this seems similar to the passwd file, which seems to be owned
by a generic package called "setup" that also owns many other /etc
config files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
