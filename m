Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA18609
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 09:04:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA05849
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 13:03:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA05845
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 13:03:18 GMT
Date: Mon, 15 Apr 2002 09:04:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles verbosity
In-Reply-To: <20020414185305.6F3FD22A7A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204150903030.24406-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 14 Apr 2002, Russell Coker wrote:

> When running setfiles with the -v option I get messages such as the following:
>
> setfiles:  relabeling /etc/ld.so.cache from rjc:object_r:ld_so_cache_t to
> system_u:object_r:ld_so_cache_t
>
> I suggest that we change setfiles to have two levels of verbosity, one of
> which doesn't give messages such as the above.
>
> What do you think?

Do you mean omitting messages about changes that only setting the user
identity attribute to system_u?  This would require intepretation of
security contexts by setfiles.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
