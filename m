Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07552
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 12:16:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04327
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 17:15:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA04323
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 17:15:54 GMT
Date: Thu, 8 Nov 2001 12:15:23 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: <selinux@tycho.nsa.gov>
Subject: Re: How can i configure this?
In-Reply-To: <3BEB0245.15AF2177@cti.com.ar>
Message-ID: <Pine.GSO.4.33.0111081211180.17720-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 8 Nov 2001, Hugo F. Martinez wrote:

> Sorry, I've got RedHat 7.1 and i did a full installation of SELinux
> following
> the Readme, and some tips from the Linux Magazine of september. Im using
> devfs

I'm curious about the tips, since I never saw that article and don't get
Linux Magazine.  In any event, this particular AVC denied message looks
like it is being caused by a problem in the SELinux support for assigning
security contexts to devfs entries, which is experimental and isn't being
actively used by us.  I'll have to look into it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
