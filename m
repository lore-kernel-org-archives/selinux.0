Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA29442
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 11:47:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA27476
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 16:46:05 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA27472 for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 16:46:01 GMT
Date: Fri, 8 Feb 2002 11:46:36 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: stat_secure()
In-Reply-To: <20020208014037.9AC343A26AA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202081141330.22738-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 8 Feb 2002, Russell Coker wrote:

> OK.  I'm happy to do the coding for that, but not without matching libraries.

As far as the libraries are concerned, you would simply eliminate the
is_flask_enabled() test and the else clause from the
libsecure/src/*stat_secure.c files.  Then, if SELinux isn't present, the
call will return -1 as expected.

> So what if I start providing Debian packages with code that returns -1 from
> such system calls if there is no SE Linux running and then code programs such
> as /usr/bin/stat accordingly?  Is that recommended?

That's fine.  They should just use is_flask_enabled() to test for the
presence of SELinux and only call the new system calls if it returns 1.
That is already the case for the new system calls other than stat_secure.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
