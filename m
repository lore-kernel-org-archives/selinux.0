Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23088
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:42:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA29978
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:41:42 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA29974 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:41:41 GMT
Date: Wed, 20 Mar 2002 11:42:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: general_file_read_access
In-Reply-To: <20020320102215.A54A1232F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201141260.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> Could this macro be split into a number of smaller macros?
>
> I'd like to have a macro for reading the root directory, /usr, /usr/bin,
> /usr/sbin, /bin, and /sbin without allowing reading of any var_log_t files.

Yes, my intent is to gradually partition each of the macros into
increasingly finer-grained macros and then rewrite domains to use the new
macros.  Other suggestions for the finer-grained macros are welcome, of
course.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
