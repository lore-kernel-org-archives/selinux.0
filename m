Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17422
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 14:32:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA24307
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 19:31:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA24300
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 19:31:09 GMT
Date: Mon, 25 Mar 2002 14:31:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: does bin_t vs sbin_t really make sense?
In-Reply-To: <20020321203108.2AA20226CF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203251422240.1015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 21 Mar 2002, Russell Coker wrote:

> I have been thinking about the division of bin_t vs sbin_t.
>
> Does preventing a regular user from running a (non-SUID and non-SGID) program
> in /sbin actually gain us anything?  The only possible advantage I can see is
> if the user is denied execute access to all directories where they have write
> access, if the user is denied ptrace() access, and if we suspect that there
> is a kernel bug allowing one of these programs to do nasty things in spite of
> SE policy and unix permissions prohibiting it.
>
> Having the two types just requires an additional entry on allow lines for no
> great benefit as far as I can tell.

The distinction may have some benefit for the daemon domains, as opposed
to the user domains.  It doesn't impose much burden to retain the
distinction, since can_exec_any covers all of the executable types, and
you can also define your own macros and/or type attributes to cover
particular sets of executable types.

> What I think would be more useful is to give /usr/bin a different type, then
> you can either ban sysadm_t from executing it or trigger an automatic type
> conversion to something safe!

This would be interesting, but I'm not sure what the impact would be on
normal operations.  I'd be more inclined to transitioning to an
unprivileged user domain rather than denying execute access completely.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
