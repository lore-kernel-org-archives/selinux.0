Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SJQdrT013698
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 15:26:39 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SJQ8tS014675
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 19:26:08 GMT
Subject: Re: file_contexts patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040726220609.GB2175@jmh.mhn.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
	 <200407170802.08072.russell@coker.com.au>
	 <20040716224252.GD4940@obadja.jmh.mhn.de>
	 <200407171159.00489.russell@coker.com.au>
	 <20040717195326.GA16762@bern.cip.ifi.lmu.de>
	 <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
	 <20040726220609.GB2175@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1091042753.6886.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jul 2004 15:25:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-07-26 at 18:06, Thomas Bleher wrote:
> That would be okay with me.
> 
> To support distro-specific file contexts we would have to modify the
> build to include the tunables when creating the file_contexts file (it
> is already run through m4). Something like the following quick patch:

Merged.  Also added a tunables/distro.te file.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
