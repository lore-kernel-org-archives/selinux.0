Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8O9BsrT015873
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 05:11:54 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8O9Brrq016566
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 09:11:53 GMT
Date: Fri, 24 Sep 2004 10:22:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Mark Huth <mc.huth@qut.edu.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: file context patches
Message-ID: <20040924092255.GA6246@lkcl.net>
References: <4ed82715.84b7e17d.81fae00@mail-msgstore01.qut.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ed82715.84b7e17d.81fae00@mail-msgstore01.qut.edu.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 24, 2004 at 04:44:26PM +1000, Mark Huth wrote:

> I was wondering what are the differences between policy 17 and
> policy 18?  

 what i know is that policy files are in a binary format
 suitable for upload to the kernel: new well-known SIDs
 (security ids) get added, the version has to change.

> Also, I've just done a yum update against the development
> tree, relabelled and tried booting into SELinux enforcing mode
> but it failed with heaps of denied messages regarding tmpfs_t.

 ah... tmpfs_t has only recently had support for extended attributes
 added.

 there are a couple of people from gentoo on this list who will know
 more about what's going on / the state of play wrt gentoo/hardened.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
