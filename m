Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA07432
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 09:05:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA26805
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 13:03:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA26801 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 13:03:38 GMT
Date: Mon, 19 Aug 2002 09:04:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: type_change rules
In-Reply-To: <20020819125700.7B617531@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190900150.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Russell Coker wrote:

> In my case it appears that login exec's the user's shell and is gone from
> memory.
>
> So it seems that to get this working correctly I need some changes to the
> login program to make it hang around (as login programs apparently do in
> other distributions), and I need to make sure that the SAK is blocked from
> killing the login process.

If compiled with PAM support, the util-linux login forks a child process
that waits for the user shell to exit and then cleans up the session
(including relabeling the tty back to its original SID, with the SELinux
patch).

> rc scripts aren't involved.  Doing it in init is ugly.  Changing getty means
> changing 4 getty programs that I use on machines I run (and more getty
> programs for a comprehensive solution).  I don't think that this is the real
> fix.

I think it is.  Keep in mind that the same issue arises for the Linux
ownership and modes on ttys, and that this must be addressed somewhere in
getty or init.  But I concede that it may be a lot of work to support all
getty programs.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
