Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14DanRb011677
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 08:36:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14DZAVK028262
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 13:35:10 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id i14DZ9lx028259
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 13:35:09 GMT
Date: Wed, 4 Feb 2004 13:35:54 +0000
From: Dale Amon <amon@vnl.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Dale Amon <amon@vnl.com>, "Stephen C. Tweedie" <sct@redhat.com>,
   Russell Coker <russell@coker.com.au>,
   Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: FS crash
Message-ID: <20040204133554.GC969@vnl.com>
References: <1074008995.7158.18.camel@kusturica> <200401142317.18958.russell@coker.com.au> <1075866064.19815.57.camel@sisko.scot.redhat.com> <20040204115353.GA969@vnl.com> <1075897139.2267.77.camel@nb.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075897139.2267.77.camel@nb.suse.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 04, 2004 at 01:18:59PM +0100, Andreas Gruenbacher wrote:
> On Wed, 2004-02-04 at 12:53, Dale Amon wrote:
> > On Wed, Feb 04, 2004 at 03:41:04AM +0000, Stephen C. Tweedie wrote:
> > > The fix is really simple: just test for (old_bh != new_bh) before
> > > incrementing the refcounts.  The patch below is for ext3, but ext2 needs
> > > the same fix.
> > 
> > When I added the handler for selinux rfs I saw the
> > same sort of thing. Would I presume that the xattr 
> > patches from Suse would require a similar mod?
> 
> Yes. A diff for 2.4 is attached. This is not exploitable by ordinary
> users unless selinux is used, but as Stephen said, with selinux it will
> result in EIO or worse.

Actually I was working with Jeff's patches for 2.6.0:

  ftp://ftp.suse.com/pub/people/jeffm/reiserfs/aclea/

I haven't tried anything since test4 because when I saw the
errors after adding my handler patch I thought I'd tweaked
a bug inside the fs that put the project well beyond the
time (for learning curve) that I had available.

Does Jeff have any updates in the works? I see his latest is
2.6.0-test11. 

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
