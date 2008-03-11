Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BKlVbh019238
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 16:47:31 -0400
Received: from mk-filter-3-a-4.mail.uk.tiscali.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2BKlNHB007956
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 20:47:28 GMT
From: "Martin J. Green" <mail@martinjgreen.me.uk>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 11 Mar 2008 20:35:33 +0000
Subject: RE: Getting started with SELinux and Slackware
Message-ID: <54EE10FFA0116B408D3A5172CB52729F01311A12DAC2@exchange.home.martinjgreen.me.uk>
References: <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F012DC48610D7@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DABD@exchange.home.martinjgreen.me.uk>
	 <1205249079.23866.145.camel@moss-spartans.epoch.ncsc.mil>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DABF@exchange.home.martinjgreen.me.uk>
 <1205260397.23866.175.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1205260397.23866.175.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Solved the compile issues, I symlinked the libs in /lib to /usr/lib - but should I actually have them in /usr/lib instead? (I followed Tim Wood's scripts which used /lib).

The buildscripts for slackware at http://www.firstinternetservices.com/selinux are complete & working for the base selinux packages for the new version (I'm working on userland now - will post to the same when I'm done)

I take it since this is linking against sepol its probably safe to assume that the patch upstreamed into ssh is relatively up-to-date? (util-linux had a similar compile problem so the same should be true)

Martin

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
Sent: 11 March 2008 18:33
To: Martin J. Green
Subject: RE: Getting started with SELinux and Slackware


On Tue, 2008-03-11 at 18:14 +0000, Martin J. Green wrote:
> That particular example was just openssh with --with-selinux added to normal options (none of which include disabling shared or enabling static). I've see the same error when compiling checkpolicy and util-linux though

Possibly your environment doesn't support shared libs or you don't have
the shared libraries installed first?

You need to build and install libsepol.

Older versions of libselinux didn't have the libsepol dependency, so
older versions of the openssh selinux patch wouldn't have linked against
it either.

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
