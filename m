Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBALm2Ii023864
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:48:02 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBALm3R8013727
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 21:48:04 GMT
Date: Fri, 10 Dec 2004 21:58:35 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
Message-ID: <20041210215835.GA5239@lkcl.net>
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B8826D.30105@redhat.com> <1102613299.10785.21.camel@nexus.verbum.private> <1102615344.4509.39.camel@aeon> <1102632223.10785.36.camel@nexus.verbum.private> <1102645414.4509.105.camel@aeon> <1102693682.10785.44.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1102693682.10785.44.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 10, 2004 at 10:48:02AM -0500, Colin Walters wrote:

> If you want this, then why not just make your normal account user_r, and
> log in as root on the console?
> 
> > Also note that many daemons look for configuration or data files
> > under /root, this is due to bugs in daemons but many of them are not
> > expected to be fixed for quite a while.  
> 
> Point, but we should fix those bugs.
 
 e.g. if anyone's interested (and using it) - spamassassin, which
 attempts to dump log files (as root) pretty much evvveeerryyywhere.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
