Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ID86xF005815
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 09:08:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ID6ILa003988
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 13:06:25 GMT
Date: Thu, 18 Sep 2003 14:07:48 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030918130748.GC22480@vnl.com>
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

I'm working on a merged policy and I'm curious why you ifdef on
klogd.te. syslog-ng subsumes klogd, so I've not installed it and 
thus not installed klogd.te.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
