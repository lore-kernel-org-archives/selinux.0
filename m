Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBA2uFIi017960
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 21:56:15 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBA2sZPS009467
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 02:54:36 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <20041209213846.GH8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon> <41B8AB69.1060805@redhat.com>
	 <1102623195.4509.86.camel@aeon> <41B8B409.4070807@redhat.com>
	 <20041209213846.GH8179@jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 13:56:08 +1100
Message-Id: <1102647369.4509.117.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 22:38 +0100, Thomas Bleher wrote:
> > Roles can be used to govern which applications can be run.  So I could 
> > have a student role where only
> > student applications could be run. 
> 
> That's right, but unless you lock down the account _very_ much, you
> can't prevent them from running arbitrary code. That's something to keep
> in mind.

Also we have to look into the can_exec_any() situation.  An increasing
number of domains use this macro to execute most binaries on the system.
I am not convinced that it is suitable for any domain, not even user_t.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
