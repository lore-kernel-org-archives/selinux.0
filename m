Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82Em2rT029645
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 10:48:02 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82ElC3w007537
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 14:47:13 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200409022338.20644.russell@coker.com.au>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 10:46:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 09:38, Russell Coker wrote:
> Also something to note is that we really don't want to use this when producing 
> a file_contexts file for distributing to other machines.  It would be likely 
> to grant inappropriate access to block devices.

But with the current Makefile patch, this is precisely what will happen
for anyone who does not have policy sources installed, right?  And last
I checked, policy sources are only installed by explicit request, not by
default.  Seems to require separate Makefile targets for local build vs.
rpm build.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
