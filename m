Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23289
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 09:01:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA17653
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 14:00:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA17649
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 14:00:43 GMT
Date: Wed, 9 Jan 2002 09:00:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Odd problem with lsm-full-2001_12_10 on RH 7.2
In-Reply-To: <1010581828.1483.10.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0201090840380.20082-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 9 Jan 2002, Justin Smith wrote:

> This is an intermittent problem corrected (temporarily) by rebooting.
> I don't know whether it is related to SELinux or just to the 2.4.16
> kernel (or something else entirely).
>
> When I try to perform certain tasks (like edit the crontab), I get the
> message
>
> bash: /usr/bin/crontab: Cannot allocate memory

This sounds similar to a problem with 2.4.16 reported in the following
message on the linux-kernel mailing list:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100782613611428&w=2

This problem was tracked down as being due to a problem in the ntfs code,
and when ntfs was disabled, the error no longer occurred.  Are you using
ntfs?  If so, try disabling it.

If not, the only known bug in the last public release of SELinux that
might produce this behavior was fixed by the patch in the following
message:
http://marc.theaimsgroup.com/?l=selinux&m=100861319315772&w=2

If that doesn't help, you might try the 2.4.17 LSM kernel from
lsm.immunix.org to see if that helps.  But be warned, some people have
reported filesystem corruption problems with 2.4.17, although I haven't
seen it myself on our test machines.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
