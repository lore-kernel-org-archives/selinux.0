Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5K8ge3E006590
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2003 04:42:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5K8gd5e010847
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2003 08:42:40 GMT
Received: from petrus.schuldei.org (petrus.schuldei.org [81.27.1.16])
        by jazzband.ncsc.mil  with ESMTP id h5K8gd92010844 for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2003 08:42:39 GMT
Date: Fri, 20 Jun 2003 10:40:27 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: how usable is selinux in lsm-2.5?
Message-ID: <20030620084027.GA1852@schuldei.org>
References: <20030618212607.GB5278@schuldei.org> <1056025963.1071.27.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1056025963.1071.27.camel@moss-huskers.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) [030619 14:33]:
> On Wed, 2003-06-18 at 17:27, Andreas Schuldei wrote:
> > I notice with satisfaction that lsm-2.5 with selinux configured
> > in compiles fine here.
> 
> Are you referring to the lsm-2.5 BitKeeper tree from either
> lsm.bkbits.net or lsm.immunix.org?  I did replace the SELinux module in
> that tree with the new 2.5 SELinux, although the LSM patch in that tree
> still includes various hooks that are not in mainline.  You might want
> to wait until we make an updated public release of the mainline
> 2.5-based SELinux and use it.

when do you expect to release that?

> http://www.nsa.gov/selinux/lk, but it might be easier for you to wait
> for an updated public release on the main download page.

would that be the same date then above?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
