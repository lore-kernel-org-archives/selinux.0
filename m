Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA17735
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 15:01:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA25387
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:59:34 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA25383 for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:59:34 GMT
Date: Mon, 22 Jul 2002 15:00:20 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Stan Osborne <stan@tlaloc.sfsu.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: can't log in
In-Reply-To: <200207221848.LAA16193@tlaloc.sfsu.edu>
Message-ID: <Pine.GSO.4.33.0207221453110.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 22 Jul 2002, Stan Osborne wrote:

> Here are sample log entries in /var/log/auth.
>
>   Jul 19 01:58:28 raq104 PAM_pwdb[559]: (login) session opened for user admin by (uid=0)
>   Jul 19 01:58:49 raq104 login[559]: UNABLE TO GET VALID SID FOR admin

Is admin listed in /etc/security/default_context?  If so, check your
bootup messages for any errors during the kernel initialization.  Did you
see something like the following:
	security:  starting up (compiled Jul  3 2002)
	security:  loading policy configuration from /etc/security/selinux/policy.11
	security:  policydb is compressed, decompressing...
 	security:  decompressed 2839471 bytes
	security:  15 users, 5 roles, 717 types
	security:  29 classes, 116911 rules

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
