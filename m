Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAE9aIi020313
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 09:09:36 -0500 (EST)
Message-ID: <41B9AE1D.1020305@redhat.com>
Date: Fri, 10 Dec 2004 09:09:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Russell Coker <rcoker@redhat.com>
CC: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
References: <20041207000805.GH3678@jmh.mhn.de>	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>	 <41B8826D.30105@redhat.com>	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>	 <1102614445.4509.25.camel@aeon>	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>	 <1102615951.4509.50.camel@aeon>	 <200412092040.iB9KelRx032136@turing-police.cc.vt.edu> <1102647815.4509.123.camel@aeon>
In-Reply-To: <1102647815.4509.123.camel@aeon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok I succumb.    I will not fight the battle any longer, but I believe 
that average people will not user roles because it
is too difficult.  I will not build tools that will automatically 
relabel the file system since these will be prone
to errors.  People will run users in the default role of the system, 
whether we default it to user_r  with user_canbe_sysadm,
or default to staff. 

I believe that the only people who will use roles as they are currently 
constituted are security people. 

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
