Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20872
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 10:10:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA06469
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 14:09:23 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA06465 for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 14:09:22 GMT
Date: Thu, 9 May 2002 10:09:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles -q option?
In-Reply-To: <20020509054935.0704B6E05@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205091008290.1046-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 9 May 2002, Russell Coker wrote:

> Could we have a "-q" option to setfiles to make it not write out messages
> such as the following?
>
> /usr/sbin/setfiles:  Running on a SELinux kernel, using new system calls
> /usr/sbin/setfiles:  read 450 specifications
> /usr/sbin/setfiles:  Done.
>
> Having it write out messages if it's not running on a SE Linux kernel would
> still be useful.  But when you install 100 new packages having the above
> three lines displayed 100 times is rather annoying...

We could certainly add such an option.  Or you could just redirect stdout
to /dev/null.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
