Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDEJBIi003692
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 09:19:11 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDEJAX4028212
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 14:19:13 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41BD9FA9.9030402@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
	 <200412092040.iB9KelRx032136@turing-police.cc.vt.edu>
	 <1102647815.4509.123.camel@aeon>  <41B9AE1D.1020305@redhat.com>
	 <1102944341.32053.26.camel@aeon>  <41BD9FA9.9030402@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 01:19:00 +1100
Message-Id: <1102947540.32053.28.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-13 at 08:56 -0500, Daniel J Walsh wrote:
> >>I believe that the only people who will use roles as they are currently 
> >>constituted are security people. 
> >>
> >
> >Currently the only people who use strict policy are "security people".
> >  
> >
> By security people, I meant people who understand how to write policy.  

Same here.

> My opinion, is the
> end goal of strict policy should be used by security admins who don't 
> need to know how to write
> policy. selinux-policy-strict-sources should end up being like 
> kernel-sources.  Only to be used by
> developers and people interested in how the system works. 

I mostly agree with that.  However at the moment we are far from it in
so many ways that the issue of roles is minor.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
