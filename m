Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HCbxLa024696
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 08:37:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8HCbvn0006999
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:37:58 GMT
Date: Wed, 17 Sep 2003 13:37:47 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030917123747.GF8988@vnl.com>
References: <20030915214153.GE8988@vnl.com> <20030916145353.GM8988@vnl.com> <200309172014.59503.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309172014.59503.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 17, 2003 at 08:14:59PM +1000, Russell Coker wrote:
> On Wed, 17 Sep 2003 00:53, Dale Amon wrote:
> 
> Here's a new syslogd.te that should solve most of the problems you had.

Will this work with Colin's or should I try to interpolate the two?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
