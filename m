Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69CERrT018783
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 08:14:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69CEQNR003645
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 12:14:26 GMT
Subject: Re: An SELinux policy for Red Hat 9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bradley Chapman <kakadu@gmail.com>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0407090443663d55c4@mail.gmail.com>
References: <e294b46e040708131736c57b6@mail.gmail.com>
	 <200407092111.55045.russell@coker.com.au>
	 <e294b46e0407090443663d55c4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1089375253.11726.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jul 2004 08:14:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-09 at 07:43, Bradley Chapman wrote:
> On Fri, 9 Jul 2004 21:11:55 +1000, Russell Coker <russell@coker.com.au> wrote:
> > But if you REALLY want to use RHL 9, the current policy should work OK, you
> > just have to make the appropriate changes to pam, logrotate, cron, coreutils,
> > etc.
> 
> What sort of changes? Path changes? 

I think Russell is referring to the userland patches for those
packages.  The current patches and SRPMS in our userland tree are drawn
from the Fedora Core development tree, so you are likely to run into
dependency problems building them on RH9.  And Fedora Core actually
includes _many_ other patched userland packages for SELinux; we only
maintain a core subset in our tree for reference purposes for people who
want to port to other distributions.  A few examples of patched userland
packages in Fedora Core that are not in our tree include gdm, usermode,
atd, and libuser, and there are many others.  There is also the issue of
glibc security awareness; the RH9 glibc won't enable secure mode upon
domain transitions, unlike the Fedora Core glibc.

If you truly are limited to using RH9, then you should likely grab an
older release of SELinux that was based on RH9.  But life will be
simpler if you can move to FC2.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
