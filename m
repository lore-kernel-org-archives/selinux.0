Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28573
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 09:16:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA29377
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 13:15:37 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA29373
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 13:15:36 GMT
Date: Mon, 29 Jul 2002 09:15:22 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: fileutils
In-Reply-To: <20020727122038.6B5C7265@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207290911390.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 27 Jul 2002, Russell Coker wrote:

> One final thing, I think that copy_s() in copy.c should be changed to use
> open_secure() instead of just calling the regular function.  If we really
> want the context set on copy then the current setup allows for a race
> condition where a large file could potentially be read by an unauthorised
> process while it's being copied.  Also could there be situations in which the
> user has permission to create a file in a particular type via open_secure()
> but not have permissions to change it to that type later?

I agree, and yes, the latter is a possible situation.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
