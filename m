Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37HoIue028421
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 13:50:19 -0400 (EDT)
Subject: Re: I am attempting to add a secadm_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050407174544.GY19784@lkcl.net>
References: <425553ED.1040703@redhat.com> <20050407164645.GX19784@lkcl.net>
	 <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil>
	 <20050407174544.GY19784@lkcl.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 13:39:36 -0400
Message-Id: <1112895576.27110.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 18:45 +0100, Luke Kenneth Casson Leighton wrote:
>  in the scenario i describe, which i mention in case dan could
>  incorporate it (it may happen to be the same thing), i would like
>  secadm to be able to do policy / labelling, and for sysadm to _not_
>  be able to.

Right, that is what Dan intends, IIUC.  But while you can (relatively)
easily prevent sysadm from directly modifying policy, loading it, and
relabeling files, you cannot easily prevent him from indirectly
achieving the same ends without greatly stripping away his privileges
even for ordinary administrative work, as I and others have mentioned in
the past (yes, I know Dan doesn't want to revive that discussion, but I
did want to make sure that Luke remembers it since he is asking about
this).   e.g. see the thread starting at 
http://marc.theaimsgroup.com/?l=selinux&m=105457887918050&w=2

>  if secadm could be drastically restricted to pretty much only be
>  able to run policy / labelling selinux command tools - even better.

Problematic at present, given that policy is modified in source form,
unless you want to require all policy modifications to be done off-line
and then only allow updated binary policy to be installed by the secadm.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
