Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14268
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 08:16:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08688
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 12:16:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA08684
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 12:16:04 GMT
Date: Mon, 22 Jul 2002 08:16:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Natr Brazell <brazell@bmh.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: =?iso-8859-1?Q?Installation_question?=
In-Reply-To: <63114.137.246.8.231.1027290964.squirrel@austin.bmh.com>
Message-ID: <Pine.GSO.4.33.0207220814530.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 21 Jul 2002, Natr Brazell wrote:

> Please see the below /var/log/messages entries and tell me what I have to
> do to correct them.  2.4.18 LSM kernel in passive mode.

Since I know nothing about /usr/stow or jsaf, I can't help you, other than
to note that you need to define appropriate types for these files and
likely a separate domain for jsaf.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
