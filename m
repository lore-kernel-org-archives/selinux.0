Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AMoELa012559
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 18:50:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AMmbLY012555
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 22:48:37 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8AMmbsG012552
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 22:48:37 GMT
Date: Wed, 10 Sep 2003 23:50:10 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910225010.GT5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063233012.27358.11.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063233012.27358.11.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2003 at 06:30:12PM -0400, Colin Walters wrote:
> That shouldn't be necessary if you're using the Debian mkinitrd scripts
> I wrote.  It has hooks for dropping things in like this.

Sounds good...
 
> You shouldn't have to change anything at all, just install
> selinux-policy-default.  I noticed there have been a few revisions to
> mkinitrd in unstable since then, but last I checked it worked.

Okay, So are you saying mkinitrd is good as is? Your 
selinux-policy-default is installed. I guess I'll have to 
go read /usr/sbin/mkinitrd to see what you've done.
 
> I really need to find some time to do that.  Real life and other
> projects have kind of been in the way, but I do hope to do it within a
> week or so.

Not a big rush. With the devfs problem now staring at me it
may well *be* a week or two before this even comes on my
radar again. The policy I've patched up from an install of
yours should be just fine for testing.

Isn't arrow head collecting fun?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
