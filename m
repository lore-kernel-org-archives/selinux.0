Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14BspRb011222
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 06:54:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14BrSVK022670
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 11:53:28 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id i14BrSlx022663
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 11:53:28 GMT
Date: Wed, 4 Feb 2004 11:53:53 +0000
From: Dale Amon <amon@vnl.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, Andreas Gruenbacher <agruen@suse.de>,
   Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: FS crash
Message-ID: <20040204115353.GA969@vnl.com>
References: <1074008995.7158.18.camel@kusturica> <200401142317.18958.russell@coker.com.au> <1075866064.19815.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075866064.19815.57.camel@sisko.scot.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 04, 2004 at 03:41:04AM +0000, Stephen C. Tweedie wrote:
> The fix is really simple: just test for (old_bh != new_bh) before
> incrementing the refcounts.  The patch below is for ext3, but ext2 needs
> the same fix.

When I added the handler for selinux rfs I saw the
same sort of thing. Would I presume that the xattr 
patches from Suse would require a similar mod?

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
