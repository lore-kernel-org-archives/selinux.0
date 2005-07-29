Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6THjNgA002188
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 13:45:25 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6THdOC2026239
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 17:39:24 GMT
Subject: Libsepol ongoing
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1122658154.28860.19.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 13:36:37 -0400
Message-Id: <1122658597.28860.27.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following ongoing things need IMHO need completion for libsepol.
I just thought I'd list them here, since I'll be gone
for the next three weeks, and maybe someone wants to work
on something.

1) Replace all use of printf/fprintf with new debug system

2) Replace all use of __sepol_debug_printf with new debug system

3) Replace boolean and interface data structures with opaque records
for libsemanage (see how the other ones are done)

4) Move all non-exported functions without static callers out
of the headers, and into internal headers.

5) Move checkpolicy scope support into libsepol, and
add scope checking on symbol lookups (?)

6) Replace duplicate checkpolicy user/port/context support
with calls to libsepol


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
