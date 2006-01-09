Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k09HuYXf001018
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 12:56:34 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k09HuXNp022169
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 17:56:33 GMT
Subject: Re: Latest policy diffs, very large
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <43BAD603.5060209@redhat.com>
References: <43BAD603.5060209@redhat.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 12:56:56 -0500
Message-Id: <1136829416.29815.97.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 14:52 -0500, Daniel J Walsh wrote:
> ftp://people.redhat.com/dwalsh/SELinux/policy-20060103.patch

I've merged most of this in so far, but I have several questions.

> Added selinux policy man pages.

I merged this, but in the long run I think it would be better if we
eventually move the information into the XML documentation, and write a
tool that will generate the man pages from the XML, so that there aren't
any possible synchronization problems between the XML and the man pages.

> Many minor changes...

* why does automount need net_bind_service? it doesn't have any rules
for binding sockets.
* there are comments about readahead in initrc distro_redhat; however,
readahead has a policy now, so why are these rules still needed?
* several daemons added cron_system_entry(), cron, cups, apm, why is
this needed?
* why is dev_read_raw_memory(hald_t) needed?
* why is noatsecure needed for the kernel to run init on an MLS system?
* why does mount_t need to rw all terminals?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
