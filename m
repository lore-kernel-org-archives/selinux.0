Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EC06Ha011666
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 08:00:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6EC05H5006429
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:00:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6EC05RX006426 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:00:05 GMT
Subject: Re: Updated Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: Howard Holm <hdholm@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <1057966291.1514.50.camel@chris.pebenito.net>
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
	 <1057966291.1514.50.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1058183994.13738.564.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Jul 2003 07:59:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-07-11 at 19:31, Christopher J. PeBenito wrote:
> I've been trying out the updated kernel patches, and I'm noticing a some
> different behavior with the nfs lockd and rpciod.  With this release,
> they're starting up in kernel_t:
> Is this intended?

Yes, these are kernel threads, and they call reparent_to_init, so their
SID is changed to the kernel SID.  This isn't new to this release.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
