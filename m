Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83GUTrT008904
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 12:30:30 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83GUTUQ025027
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:30:29 GMT
Subject: Re: Proposed Hardware File Context file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040903143808.GA26568@lkcl.net>
References: <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377DD5.8010500@redhat.com>
	 <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil>
	 <41377F4B.3010608@redhat.com>
	 <1094167821.24091.25.camel@nexus.verbum.private>
	 <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil>
	 <20040903131751.GC30562@lkcl.net>
	 <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil>
	 <20040903143808.GA26568@lkcl.net>
Content-Type: text/plain
Message-Id: <1094228921.19206.228.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Sep 2004 12:28:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-03 at 10:38, Luke Kenneth Casson Leighton wrote:
>   what do you think of the idea of
>   "run-time enabling of alternative file contexts"?
> 
>   because i still think that extending the existing
>   file_contexts syntax to have an optional keyword at the
>   end, and then providing extended versions of the existing
>   libselinux file context related functions, would provide
>   the simplest from-here-to-there approach.

I don't like it.  Rationale:
- programs that don't have device information (or whatever the keyword
is based on) available to them can't provide useful input to the
libselinux function, so they will end up matching the wrong entry. 
Better to completely move device info out of the main file_contexts (and
mark /dev(/.*)? with <<none>>) and maintain it elsewhere for udev and
other potential users that have device information available.
- pathnames are a poor man's way of identifying devices anyway.  Far
better to map actual device ids if we can.

Essentially, udev is an object manager for /dev, and I'd be glad to push
management of the device node contexts into it.  And the closer it
parallels the existing support for ownership/permissions, the better, as
that increases the likelihood of the SELinux support being understood
and maintained properly.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
