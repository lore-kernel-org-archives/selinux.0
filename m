Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GHBhrT026555
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 13:11:43 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GHBgsh019591
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 17:11:42 GMT
Subject: Re: hald fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <4149C4DD.9040802@redhat.com>
References: <200409162151.44819.russell@coker.com.au>
	 <1095342276.30684.96.camel@moss-spartans.epoch.ncsc.mil>
	 <4149C4DD.9040802@redhat.com>
Content-Type: text/plain
Message-Id: <1095354548.30684.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 13:09:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-16 at 12:52, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> >Are all helpers executed by hald now labeled with hald_exec_t?
> >
> I don't think so.

Then that diff shouldn't be merged without corresponding updates to
hald.fc for all helpers.  What about the other programs under
/usr/libexec that are in the hal package (e.g. hal.dev, hal.hotplug)? 
Are there likely to be other helpers added in the future under
/usr/libexec or under /etc/hal?  

BTW, as a reminder, using the entrypoint type on helper programs means
that any of the helpers can be used to directly enter the domain without
going through the daemon itself (only from domains that are allowed to
transition to the domain, of course).  Not necessarily a vulnerability,
but something to consider.  Stronger model is to use a separate type on
helpers and only apply the entrypoint type to the actual entrypoint
program.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
