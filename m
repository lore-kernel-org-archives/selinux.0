Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28664
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 14:43:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA20816
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 18:43:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id SAA20812
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 18:43:20 GMT
Date: Wed, 9 May 2001 14:42:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: selinux@tycho.nsa.gov
Subject: Re: Installing selinux on RedHat 7.0
In-Reply-To: <3AF9C18F.1890725@cti.com.ar>
Message-ID: <Pine.SOL.3.95.1010509144033.627I-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 9 May 2001, Hugo F. Martinez wrote:

> ERROR IN THE STATEMENT ENDING ON LINE 1054 (TOKEN ';'):
>     UNKNOWN CLASS FILESYSTEM USED IN RULE

You need to apply the patch that I sent to the mailing list
on Monday to fix a bug in the checkpolicy program.  After
applying the patch, rebuild your checkpolicy program and try again.

> security: unable to open /ss_policy

This is because you were unable to compile and install the security
policy configuration using the checkpolicy program, due to the bug.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
