Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00120
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 14:10:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA02155
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 18:10:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id SAA02151
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 18:10:08 GMT
Date: Wed, 6 Jun 2001 14:08:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: selinux@tycho.nsa.gov
Subject: Re: Configuring users
In-Reply-To: <3B1E8D1D.D06B5C59@cti.com.ar>
Message-ID: <Pine.SOL.3.95.1010606140625.3546a-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 6 Jun 2001, Hugo F. Martinez wrote:

>     When you edit the policy/users file do i have to put users such as
> apache, named, etc Or only those who have a login shell?

You only need separate user entries for users who login and/or
run cron jobs.  System processes run with the general system_u
user identity.  The SELinux user identity attribute is only set
by login and crond.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
