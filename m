Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14DeORb011727
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 08:40:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i14DeN1I011452
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 13:40:23 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i14DeNbs011449 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 13:40:23 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dale Amon <amon@vnl.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Russell Coker <russell@coker.com.au>,
   Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040204133554.GC969@vnl.com>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <20040204115353.GA969@vnl.com> <1075897139.2267.77.camel@nb.suse.de>
	 <20040204133554.GC969@vnl.com>
Content-Type: text/plain
Message-Id: <1075901988.1998.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 13:39:49 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 13:35, Dale Amon wrote:

> Actually I was working with Jeff's patches for 2.6.0:
> 
>   ftp://ftp.suse.com/pub/people/jeffm/reiserfs/aclea/

Reiserfs's xattr stuff works with a very different on-disk encoding, and
the bug here is in the on-disk management routines, not the higher-level
xattr code.  So I'd expect those reiserfs patches are free from the bug.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
