Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HjoIi014243
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:45:50 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HjrEj002182
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:45:53 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1102614049.32175.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 12:40:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:20, Stephen Smalley wrote:
> You can actually do that today without policy modules.  Recall that I
> created a genpolusers utility a while back that takes an existing binary
> policy and a new users text configuration and generates a new binary
> policy that is identical except it has the new user declarations.  So
> you only need a copy of the users source file on the machine, and you
> can then modify it, use genpolusers to rebuild the binary policy against
> it, and then load the new binary policy.

BTW, note that the copy of the users source on the machine would need to
be a post-processed copy, after m4 has processed it.  For example,
during policy build, you could do:
	m4 tunables/*.tun tmp/program_used_flags.te users serviceusers > users.final

And then install that users.final file as part of the policy package, for use by
genpolusers, e.g.
	genpolusers policy.18 users.final policy-new.18
	mv policy-new.18 policy.18

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
