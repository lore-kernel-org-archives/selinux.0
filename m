Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA19467
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 01:49:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA18484
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:48:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id FAA18472 for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:48:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: ppp
Date: Thu, 9 May 2002 14:41:38 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205080836480.23293-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205080836480.23293-100000@raven>
MIME-Version: 1.0
Message-Id: <20020509054932.AD7AA6E11@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 May 2002 23:13, Stephen Smalley wrote:
> > In my policy I already have a user_t transition to pppd_t.  The issue is
> > that pppd should not be running in user_r because the ip-up scripts will
> > start other daemons which should be in domains that aren't permitted in
> > user_r (EG the mail server).
> >
> > Basically preserving the current mode of operation of pppd for manual
> > call-out and keeping it in user_r means removing system_r because most
> > things that belong in system_r will end up in user_r!
>
> Right.  But it isn't clear that creating a wrapper as you suggested offers
> any real security benefit in this situation, and it may simply obscure the
> fact that the user_r/system_r role separation would then be illusory.  You

No it would not be illusory!  It would be that there would be two ways of 
entering system_r, one of which is run_init (by the system administrator) and 
the other is the ppp wrapper which can be called by a user.

> might as well just add all of the system_r domains into user_r.  In either
> case, the TE model provides the real control over transitions and
> interactions among user and system processes based on their domains.

I don't like the idea of moving all the system_r domains into user_r.

> In general, the RBAC model provides no improvement in security over the TE
> model, just a higher level of abstraction to ease user management.  It can
> potentially bound the set of domains that are reachable based on the
> role (as long as role transitions are not completely unconstrained, as it
> appears that they are becoming), but the same effect can be achieved
> simply by controlling domain transitions and defining derived domains as
> necessary to maintain separation.  If role transitions will typically be
> unconstrained, then one might argue that roles and the RBAC logic should
> be removed entirely to avoid confusing the security model.

I take your point, however I am definately not proposing totally 
uncontstrained role transitions.  I am merely suggesting a wrapper program to 
solve one particular instance of role transitions.

How else should we approach this problem?  I guess I could have a pppd which 
is always running, and have a SUID-root helper program which tells it when to 
connect or disconnect.  Then the helper program would only need permissions 
to send signals or write to a Unix domain socket.  I can get this done (I 
have commit access to the PPP CVS) if it's considered the right thing to do, 
although it will take time.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
