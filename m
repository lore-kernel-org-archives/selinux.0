Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15195
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2002 09:13:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA27970
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2002 13:11:25 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA27966
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2002 13:11:24 GMT
Date: Wed, 8 May 2002 09:13:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ppp
In-Reply-To: <20020508002846.8C7B56CF5@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205080836480.23293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 8 May 2002, Russell Coker wrote:

> In my policy I already have a user_t transition to pppd_t.  The issue is that
> pppd should not be running in user_r because the ip-up scripts will start
> other daemons which should be in domains that aren't permitted in user_r (EG
> the mail server).
>
> Basically preserving the current mode of operation of pppd for manual
> call-out and keeping it in user_r means removing system_r because most things
> that belong in system_r will end up in user_r!

Right.  But it isn't clear that creating a wrapper as you suggested offers
any real security benefit in this situation, and it may simply obscure the
fact that the user_r/system_r role separation would then be illusory.  You
might as well just add all of the system_r domains into user_r.  In either
case, the TE model provides the real control over transitions and
interactions among user and system processes based on their domains.

In general, the RBAC model provides no improvement in security over the TE
model, just a higher level of abstraction to ease user management.  It can
potentially bound the set of domains that are reachable based on the
role (as long as role transitions are not completely unconstrained, as it
appears that they are becoming), but the same effect can be achieved
simply by controlling domain transitions and defining derived domains as
necessary to maintain separation.  If role transitions will typically be
unconstrained, then one might argue that roles and the RBAC logic should
be removed entirely to avoid confusing the security model.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com












--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
