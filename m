Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AN5MLa012629
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:05:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AN5Lmw009370
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:05:21 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8AN5K9d009367 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:05:21 GMT
Date: Thu, 11 Sep 2003 00:05:19 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910230519.GU5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063233012.27358.11.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063233012.27358.11.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2003 at 06:30:12PM -0400, Colin Walters wrote:
> You shouldn't have to change anything at all, just install
> selinux-policy-default.  I noticed there have been a few revisions to
> mkinitrd in unstable since then, but last I checked it worked.

Okay, I see what you've done. mkinitrd loads /etc/mkinitrd/mkinitrd.conf
which calls /etc/mkinitrd/scripts/selinux.

Good show. Since that issue is all sorted, I just have
to read the man page again to make sure I'm doing it
right.

That should be one more dead gator in the 2.6.0 swamp 
then. :-)

--
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
