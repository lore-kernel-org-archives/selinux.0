Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA04024
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 15:26:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA00211
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 19:25:45 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id TAA00206
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 19:25:45 GMT
Date: Thu, 23 Aug 2001 15:25:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: RE: New Development Site
In-Reply-To: <200108221233.FAA12977@mail22.bigmailbox.com>
Message-ID: <Pine.SOL.3.95.1010823151603.23963e-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 22 Aug 2001, Jonathan Day wrote:

>IMHO, there's a right time for everything, and right now, that seems to
>be to examine the new infrastructure that's going to be used. Will it
>mean that the next version of SELinux will be more restricted? More
>flexible? How secure is the infrastructure itself? The new version of
>SELinux will be using external code - has it been audited? What else can
>it do?

On this topic (the new infrastructure, using external code), let me note
that the SELinux project has been contributing to the development of the
LSM kernel patch as well as developing our own SELinux module that uses
the hooks provided by that patch.  So we aren't simply using an
external patch developed by others - we have been involved in the
development and review of the patch from a very early stage.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
