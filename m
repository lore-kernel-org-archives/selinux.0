Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k16Mo5Xf014589
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 17:50:05 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k16Mo2hQ001263
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 22:50:02 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43E0B8AA.6060407@redhat.com>
References: <43E0B8AA.6060407@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 17:50:46 -0500
Message-Id: <1139266246.13925.16.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-01 at 08:33 -0500, Daniel J Walsh wrote:
> I added a noaudit flag to unconfined_domain_template to stop mono/wine 
> from spewing execmem messages to the auditlog.

I changed the implementation a little to use different interfaces rather
than using .

> Add file_context for initng

Dropped this pending resolution of the bug [1] in redhat bugzilla.

I merged the lvm range transition, but I still feel that the sysadm/rpm
one is wrong.  Sysadm should be running and system low, and the specific
MLS permissions should be given instead.

The remainder is merged.

[1] https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=179761

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
