Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23536
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 09:40:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19581
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 14:39:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA19577
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 14:39:52 GMT
Date: Wed, 9 Jan 2002 09:39:57 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Odd problem with lsm-full-2001_12_10 on RH 7.2
In-Reply-To: <Pine.GSO.4.33.0201090840380.20082-100000@raven>
Message-ID: <Pine.GSO.4.33.0201090938410.20082-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 9 Jan 2002, Stephen Smalley wrote:

> This problem was tracked down as being due to a problem in the ntfs code,
> and when ntfs was disabled, the error no longer occurred.  Are you using
> ntfs?  If so, try disabling it.

Actually, I see that this problem can also be caused by modify_ldt.  So
in addition to not using ntfs, try the patch posted at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100827770130527&w=2

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
