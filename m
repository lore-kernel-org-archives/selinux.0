Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20688
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 09:49:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA04245
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 13:47:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA04241
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 13:47:29 GMT
Date: Thu, 9 May 2002 09:48:43 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ppp
In-Reply-To: <20020509054932.AD7AA6E11@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205090931210.1046-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 9 May 2002, Russell Coker wrote:

> No it would not be illusory!  It would be that there would be two ways of
> entering system_r, one of which is run_init (by the system administrator) and
> the other is the ppp wrapper which can be called by a user.

Except that the wrapper does nothing other than to run pppd in
system_u:system_r:pppd_t.  Hence, every user_r process can transition to
system_r.  The corresponding program (pppd) and domain (pppd_t) would be
hardcoded by the wrapper (and could be strictly enforced by the TE model -
i.e. the wrapper domain can be limited to running pppd in pppd_t), but the
role separation itself would be gone.

> I don't like the idea of moving all the system_r domains into user_r.

Understood, but keep in mind that the end result is the same.  Even if you
place all of the system_r domains into user_r, that doesn't mean that a
user_r:user_t process can transition (directly) to those domains.  The TE
policy controls the domain transitions and entrypoint programs, so you can
simply authorize user_t to run pppd in pppd_t and authorize pppd_t to run
the daemon programs in their domains.

> I take your point, however I am definately not proposing totally
> uncontstrained role transitions.  I am merely suggesting a wrapper program to
> solve one particular instance of role transitions.
>
> How else should we approach this problem?  I guess I could have a pppd which
> is always running, and have a SUID-root helper program which tells it when to
> connect or disconnect.  Then the helper program would only need permissions
> to send signals or write to a Unix domain socket.  I can get this done (I
> have commit access to the PPP CVS) if it's considered the right thing to do,
> although it will take time.

In the short term, the ppp wrapper is probably fine.  The latter approach
does sound better as a longer term solution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
