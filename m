Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03789
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 17:50:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA22851
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 21:49:27 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id VAA22847
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 21:49:27 GMT
Date: Fri, 26 Oct 2001 17:49:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "White, Tom (AZ15)" <tom.white@honeywell.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: Problems with install
In-Reply-To: <4B2A46240C7CD311830C0090279C31E301D7807C@az15m09.iac.honeywell.com>
Message-ID: <Pine.GSO.4.33.0110261739480.13764-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 26 Oct 2001, White, Tom (AZ15) wrote:

> make: *** [policy] Illegal instruction (core dumped)

Check the Processor type in your kernel configuration.  If you left it set
for the default (Pentium III) and your machine is something older, then
you'll encounter this problem.  Also, while you're doing that, make sure
that you enabled the driver for your network card, since people often
forget to do that (most aren't enabled in the default configuration).
Then, prior to rebuilding in the lsm tree, cd to
selinux/module/selinux_plug/ss and remove *.cp.o and checkpolicy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
