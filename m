Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBA33dIi018034
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 22:03:39 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBA31xPS009669
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 03:02:00 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <200412092040.iB9KelRx032136@turing-police.cc.vt.edu>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
	 <200412092040.iB9KelRx032136@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 14:03:35 +1100
Message-Id: <1102647815.4509.123.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 15:40 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Dec 2004 05:12:31 +1100, Russell Coker said:
> 
> > The solution then would be to have a separate domain for the
> > administrator to run ls which can read all sym-links while other
> > programs the administrator may run (rm, cp, mv, etc) will be denied
> > access to read many types of sym-link.  Is this a good idea?
> 
> Probably not - then you get into a situation where you try to mv/rm/cp
> something, it fails, and when you run ls, it looks like it should work....

That would only happen when you do "ls -l /tmp/foo/bar" and
"cp /tmp/foo/bar /whatever" and /tmp/foo is a sym-link.  It's not the
most common use, but you are correct it would bite people occasionally.

Creating a new permission for sym-links as in Steve's test patch is the
best solution.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
