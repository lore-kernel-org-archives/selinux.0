Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6QKQWrT027805
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 16:26:33 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6QKQ37L009837
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 20:26:03 GMT
Subject: Re: file_contexts patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040717195326.GA16762@bern.cip.ifi.lmu.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
	 <200407170802.08072.russell@coker.com.au>
	 <20040716224252.GD4940@obadja.jmh.mhn.de>
	 <200407171159.00489.russell@coker.com.au>
	 <20040717195326.GA16762@bern.cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 26 Jul 2004 16:25:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-17 at 15:53, Thomas Bleher wrote:
> * Russell Coker <russell@coker.com.au> [2004-07-17 05:16]:
> > Maybe we should have a suse.te and suse.fc for such things?  One thing we want 
> > to avoid if possible is having entries in types.fc for distribution specific 
> > names which bloat types.fc and make setfiles run more slowly.
> 
> I think this is a good idea. I have a few other policy snippets which
> are needed on SuSE but won't be suitable for general policy.
> As a start, I have attached a small suse.te and suse.fc.
> Can this be included in CVS?

Would it be better to make the distro a tunable (e.g.
policy/tunables/distro.te) and use ifdef's in the individual .te files
and .fc files for the distro-specific changes to a given domain?  I'd
particularly like to see all of the RedHat-specific changes moved from
rpm.{te,fc} into something that is clearly specific to RedHat.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
