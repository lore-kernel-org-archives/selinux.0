Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDDPnIi003284
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 08:25:49 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDDPoX4026510
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 13:25:51 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
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
Date: Tue, 14 Dec 2004 00:25:41 +1100
Message-Id: <1102944341.32053.26.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 09:09 -0500, Daniel J Walsh wrote:
> Ok I succumb.    I will not fight the battle any longer, but I believe 
> that average people will not user roles because it
> is too difficult.  I will not build tools that will automatically 
> relabel the file system since these will be prone
> to errors.  People will run users in the default role of the system, 
> whether we default it to user_r  with user_canbe_sysadm,
> or default to staff. 

I think that the way to go is to have staff_t be the default login
domain, have two roles for it staff_r and staff_restricted_r where the
latter can't change to sysadm_r and has other limitations.  I'll write
the policy for staff_restricted_r.

> I believe that the only people who will use roles as they are currently 
> constituted are security people. 

Currently the only people who use strict policy are "security people".

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
