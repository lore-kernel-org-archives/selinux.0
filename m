Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03486
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:43:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA18806
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 18:41:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA18802 for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 18:41:42 GMT
Date: Tue, 8 Oct 2002 14:43:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /proc woes
In-Reply-To: <20021008171123.A6113@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210081439380.25356-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Oct 2002, Tom wrote:

> Rebooting the machine fixed it, so this may have happened during either
> make relabel or make load (I installed a new policy today), though it's
> still a mystery to me how and I'm one of the people who believe that a
> reboot shouldn't be a valid solution. :)

I can't see any reason why a 'make relabel' or a 'make load' would yield
this behavior.  'make relabel' only runs setfiles on mounted ext[23] or
reiserfs filesystems to create or update the persistent label mappings.
'make load' doesn't relabel anything, although it might invalidate
security contexts if you removed types (like proc_t), leaving existing
objects in unlabeled_t (but not file_t).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
