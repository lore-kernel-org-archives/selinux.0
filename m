Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23128
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:44:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA08480
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:43:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA08476
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:43:23 GMT
Date: Wed, 20 Mar 2002 11:44:17 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kernel Make
In-Reply-To: <20020320121931.GC32621@vnl.com>
Message-ID: <Pine.GSO.4.33.0203201143030.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Dale Amon wrote:

> Any particular reason your README suggests using
> "make" instead of "make bzImage"? I can't remember
> the last time I built an uncompressed kernel. 3-4 years
> at the least...

No, no particular reason.  But it doesn't really matter.  The README then
says to do a 'make install', which uses bzImage as the default.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
