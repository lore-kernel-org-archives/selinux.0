Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA19261
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2002 13:23:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04107
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2002 18:22:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA04096
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2002 18:22:29 GMT
Date: Tue, 8 Jan 2002 13:22:17 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Giovanni Mugnai <giovanni@unirel.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux on RH7.2
In-Reply-To: <200201081548.g08FmSL22221@unirel.unirel.it>
Message-ID: <Pine.GSO.4.33.0201081315160.21718-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Jan 2002, Giovanni Mugnai wrote:

> Finally I am starting to try SELinux, I have the need to try it on a RH 7.2,
> coul you tell me where I can find the SELinux patch for RH 7.2 and, if they
> exist, some configuration example or specific documentation.

Just download the current public release from the NSA web site
(http://www.nsa.gov/selinux).  It should work on either RH7.1 or RH7.2,
and it includes an example security policy configuration to get you
started.  Some documentation is available on the web site, and we are also
working on some newer documents with more up-to-date information.  Be sure
to apply the bug fix patches that have been posted to the mailing list
since the public release was made - see the mailing list archives.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
