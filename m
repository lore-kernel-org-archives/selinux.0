Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14FHURb012365
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 10:17:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14FG7VK005727
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:16:08 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i14FG6lx005724
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:16:06 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Russell Coker <russell@coker.com.au>,
   =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SE Linux <selinux@tycho.nsa.gov>, ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1075893298.2267.50.camel@nb.suse.de>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <1075893298.2267.50.camel@nb.suse.de>
Content-Type: text/plain
Message-Id: <1075907802.1998.168.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 15:16:42 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 11:14, Andreas Gruenbacher wrote:

> thanks for hunting this bug and for the precise analysis. The identical
> bug is in ext2 as well. I will send the attached patch to LKML & Andrew
> after verifying. Is it correct?

Looks OK to me, and at least the ext3 bit survives my initial stress
testing using the load that was previously reproducing the bugs.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
