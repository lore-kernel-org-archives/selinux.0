Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14M8jRb015021
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 17:08:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14M72VK015037
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 22:07:02 GMT
Received: from Woody.fw.matav.hu ([145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id i14M71lx014872
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 22:07:01 GMT
Date: Wed, 4 Feb 2004 21:58:00 +0000
From: =?iso-8859-2?B?TWFnb3PhbnlpIMFycOFk?= <mag@bunuel.tii.matav.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>, Ben Collins <bcollins@debian.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Russell Coker <russell@coker.com.au>,
   Andreas Gruenbacher <agruen@suse.de>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [selinux] Re: FS crash
Message-ID: <20040204215800.GD11886@bunuel.tii.matav.hu>
References: <1074008995.7158.18.camel@kusturica> <200401142317.18958.russell@coker.com.au> <1075866064.19815.57.camel@sisko.scot.redhat.com> <20040204191142.GA11886@bunuel.tii.matav.hu> <1075922729.1998.429.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1075922729.1998.429.camel@sisko.scot.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezõm azt hiszi, hogy Stephen C. Tweedie a következõeket írta:
> Any code that is aware of fast vs. slow symlinks will not work if the
> i_blocks gets out of sync, so it's possible that that's a problem.  But
> fsck (with Ted's endian fixes) should correct the i_blocks counter.  If
> you still have silo problems reading after that, then there must be
> something else going on.

Well. How to look into the problem? I wanted to insert some debugging
code into the secondary loader, but it is too complicated to my simple
mind. I also could not figure out how to run a debugger on it.

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
