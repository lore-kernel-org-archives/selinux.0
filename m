Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AJAWLa011282
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 15:10:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AJ8tLY026514
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:08:55 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8AJ8tsG026498
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:08:55 GMT
Date: Wed, 10 Sep 2003 20:10:15 +0100
From: Dale Amon <amon@vnl.com>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910191015.GQ5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063220599.29764.6.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063220599.29764.6.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2003 at 02:03:19PM -0500, Chris PeBenito wrote:
> Is there going to be any work getting the handler for the 2.4?  I tried
> to add it on to Jeff's 2.4 patches on ftp.suse.com, but was
> unsuccessful.

Hmmm... I shouldn't think it should be too hard to do that,
assuming the format of handlers is similar. The 2.6 one was
pretty straight forward.

I'll take a look. Supper first though :-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
