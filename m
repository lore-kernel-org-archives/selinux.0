Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14CxuRb011486
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 07:59:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14CwYVK026010
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:58:34 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i14CwXlx026004
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:58:33 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, Andreas Gruenbacher <agruen@suse.de>,
   Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20040204115353.GA969@vnl.com>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <20040204115353.GA969@vnl.com>
Content-Type: text/plain
Message-Id: <1075899574.1998.19.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 12:59:35 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 11:53, Dale Amon wrote:
> On Wed, Feb 04, 2004 at 03:41:04AM +0000, Stephen C. Tweedie wrote:
> > The fix is really simple: just test for (old_bh != new_bh) before
> > incrementing the refcounts.  The patch below is for ext3, but ext2 needs
> > the same fix.
> 
> When I added the handler for selinux rfs I saw the
> same sort of thing. Would I presume that the xattr 
> patches from Suse would require a similar mod?

Well, I was running 2.6 so xattr was built-in, not patched, so I haven't
tested the 2.4 patches; but I would imagine all 2.4 xattr patches will
have the same problem.

Cheers,
 Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
