Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA21920
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 07:53:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA23197
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 12:52:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA23193
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 12:52:42 GMT
Date: Thu, 7 Feb 2002 07:53:18 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: stat_secure()
In-Reply-To: <20020207003936.D5D1C364E8A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202070744460.6028-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 7 Feb 2002, Russell Coker wrote:

> The current behaviour is not what I expected.  I first expected that
> stat_secure() would return -1 when run on a non-SE kernel.  Then when I
> discovered that it works for the regular stat() functionality I expected that
> the security_id_t *sid parameter would not be changed.
>
> I think that it would be preferrable for the call to return -1 or to set *sid
> to -1 to indicate that a non-SE kernel is running.  There is a big difference
> between a file being truely unlabled and the system just not supporting SE!

This is a compatibility hack for the modified utilities.  At present, they
always call the *stat_secure interfaces when built with Flask/SELinux.
The original implementation of stat_secure permitted that approach,
because it simply used the existing stat call and a spare field in the
stat structure, but that wasn't portable.  When stat_secure was
reimplemented as a separate call, this compatibility hack was added to the
library functions to permit the utilities to continue working on a
non-SELinux kernel.  If/when someone has time to fix the modified
utilities, we'll drop the hack from the library routines.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
