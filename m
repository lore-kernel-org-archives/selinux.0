Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HCFSLa024552
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 08:15:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HCDjLY014206
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:13:46 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8HCDjsG014201
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:13:45 GMT
Date: Wed, 17 Sep 2003 13:15:12 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030917121512.GD8988@vnl.com>
References: <20030916155439.GN8988@vnl.com> <200309172036.48566.russell@coker.com.au> <20030917111027.GA8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030917111027.GA8988@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 17, 2003 at 12:10:27PM +0100, Dale Amon wrote:
> But how would you know whether you needed to re-pivot 
> or not? What if you have booted your maintenance kernel
> or some other that doesn't pivot? The boot script would
> have to recognize that. I haven't got the test machine
> booted at the moment so I can't check it the initrd mount
> has a unique feature that you can find in /proc/mounts.

I suppose you could check for the exitence of an /initrd
mount and then check that /initrd/selinux exists.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
