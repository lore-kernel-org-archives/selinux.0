Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7GZeZF030722
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 11:35:40 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA7GZewW025786
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 16:35:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id lA7GBmh6000645
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 11:11:48 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id lA7GBmsx000644
	for selinux@tycho.nsa.gov; Wed, 7 Nov 2007 11:11:48 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7BVMEY002641
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 06:31:22 -0500
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA7BVLGh023438
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 11:31:21 GMT
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: bug-coreutils@gnu.org
Subject: should GNU install call matchpathcon by default?
Date: Wed, 07 Nov 2007 12:31:19 +0100
Message-ID: <87k5ou9trs.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This morning I noticed a flagrant difference in the speed of
"make install" for the just-released gettext-0.17.  It took 12(!)
times longer on a rawhide system than on a usually-slower debian
unstable system. (3min vs. 15s)

I tracked it down to the fact that on that rawhide system, I'm using
the latest _upstream_ install binary from (SELinux-enabled) coreutils.
The rawhide /usr/bin/install only ever calls matchpathcon (via
setdefaultfilecon) when its final chown or chmod fails.  Looks like
a fortuitous bug in the rawhide patch.  The version of install from
upstream coreutils calls it every time, since that's the only thing that
made sense to me when I redid coreutils' SELinux support.  Considering no
one can be relying on install's matchpathcon semantics, even in rawhide,
I think it should not be the default, upstream -- especially considering
the enormous performance hit.

Any objections or suggestions from the SELinux folks?

Do you think coreutils' install should use matchpathcon at all?  If so,
either it'll have to be associated with a new option, or it'll have
to be a lot more efficient.  Yes, we've discussed this before, and
you guys convinced me to provide the functionality for ease of use.
But for those not familiar with the issues, note that you can get the
same effect without the embedded matchpathcon call, simply by invoking
install with a context provided by the matchpathcon _program_:

  install -Z $(matchpathcon $dest_file) SRC_FILE $dest_file

Can someone can look at making matchpathcon more efficient?  I understand
that making it the default would be nice, and if it's feasible to minimize
the performance impact of that matchpathcon call, it'd be much better *not*
to add a new option.

Unless I find a magic bullet, I'll disable install's use of
matchpathcon for the upcoming test release.

Jim

In case you're interested in trying a recent snapshot,

  http://meyering.net/cu/coreutils-6.9-ss.tar.gz
  http://meyering.net/cu/coreutils-6.9-ss.tar.gz.sig

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
