Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JsbrT002675
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:54:37 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JsZv0029749
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:54:36 GMT
Date: Thu, 2 Sep 2004 21:05:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Colin Walters <walters@verbum.org>,
   linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   Bill Nottingham <notting@redhat.com>, Nigel Kukard <nkukard@lbsd.net>,
   harald@redhat.com
Subject: Re: Lomac questions [was Re: [OT] SELinux vs. other systems]
Message-ID: <20040902200540.GL5745@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com> <1094048975.11084.9.camel@nexus.verbum.private> <20040901172542.GH4964@austin.ibm.com> <1094141429.17265.281.camel@moss-spartans.epoch.ncsc.mil> <20040902172907.GB9645@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040902172907.GB9645@austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 12:29:07PM -0500, Linas Vepstas wrote:

> Is the 'broken-ness' the fact that grandma failed to run an anti-virus
> scanner and verify checksums, yada yada, before elevating the
> priveldge on the downloaded software?

 [this is all with the strict policy 1.14 mostly sortof btw]

 i've installed clamav, spamassassin, razor and pyzor.

 oh, and freshclam.

 i then found a little script called clamassassin [google], i then
 searched [google] for some advice on how to set up kmail filters.

 kmail, the clamassassin script and spamc all run under the user
 context.

 the user context is given the right to bind to servers.

 spamd and clamd both run as servers: they have their own
 policies that restrict their operation to what is known
 that they presently do, but they are allowed to listen to
 incoming requests [from spamc and the clamassassin script
 respectively.]

 selinux doesn't in the _slightest_ bit get in the way.


 the only thing that i did find is that razor is a complete pain.

 it endeavours to write log files into /root/razor.log, /tmp/razor.log,
 /razor.log, it's a pain, and selinux is _exactly_ the sort of thing
 that can detect - and stop! - this behaviour.

 pyzor appears to be a lot less haphazard.

 also nobody else appears to have tried to run freshclam [automatic
 update script] before now, so i had to hack the clamav.te policy
 a bit to get it to run.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
