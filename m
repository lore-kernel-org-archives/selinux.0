Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAEaHIi020440
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 09:36:17 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAEaKR8029477
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 14:36:20 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   SE Linux list <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B9AE1D.1020305@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
	 <200412092040.iB9KelRx032136@turing-police.cc.vt.edu>
	 <1102647815.4509.123.camel@aeon>  <41B9AE1D.1020305@redhat.com>
Content-Type: text/plain
Message-Id: <1102689082.1628.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 09:31:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 09:09, Daniel J Walsh wrote:
> People will run users in the default role of the system, 
> whether we default it to user_r  with user_canbe_sysadm,
> or default to staff. 
> 
> I believe that the only people who will use roles as they are currently 
> constituted are security people. 

That will be true for most users until we have integrated user
management.  I've given you the basic building block for doing that
without requiring full policy sources (genpolusers), why can't you at
least integrate with system-config-users?  I know that won't help with
NIS/LDAP/..., but it is a starting point.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
