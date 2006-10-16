Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GGewXD026863
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 12:40:58 -0400
Received: from ccerelbas02.cce.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9GGdZAt023725
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 16:39:36 GMT
Message-ID: <4533B60E.8010802@hp.com>
Date: Mon, 16 Oct 2006 12:40:46 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: New MLS constraint?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the removal of TCS's dev-allocator the solution for multi-level
printers that came out of the LSPP calls was to set a range on the
printer device, using chcon, and use SELinux to verify that the print
job was inside that range.

I've since added checking code to the server which does not allow jobs
to be enqueued into the spool or queued and printed unless an
avc_has_perm() check passes.  The current check uses SECCLASS_FILE, and
checks FILE__WRITE;

The subject is something like user_u:user_r:user_lpr_t:s2:A
The object is: system_u:object_r:printer_device_t:s2-s15:c0.c1023

When I do this check however, I get denied whenever the user's context
does not equal the lower level.  Is there a constraint that I can apply,
preferably to the object's type (printer_device_t as opposed to *_lpr_t,
) that would allow the above check to succeed?

-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
