Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18989
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:07:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA13087
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:07:10 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA13083
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:07:10 GMT
Date: Thu, 11 Jul 2002 16:07:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'Timothy Wood'" <timothy@hallcomp.com>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
In-Reply-To: <00dd01c22914$a9b23b30$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207111605400.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Ed Street wrote:

> That's what it seems to be.  It does look like an accident waiting to
> happen as well.

I'm not sure what you mean.  The relabeling of the terminal devices by
login is just like the setting of the uid on the device by login.  Nothing
unusual here.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
