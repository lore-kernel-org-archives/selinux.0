Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15744
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 11:51:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA02507
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 15:51:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA02502
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 15:51:30 GMT
Date: Thu, 20 Jun 2002 11:51:28 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new macro in users.te
In-Reply-To: <20020620152801.81DDB5B8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206201142380.16259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Jun 2002, Russell Coker wrote:

> Also the following was sent to me in a private message in response to this
> discussion on the list, I feel that I am not able to comment on it, Stephen,
> could you respond?
>
> > You've probably already considered this.  Would this situation be a
> > candidate for role dominance?  Tie the primary domain to the dominate
> > role and the "sharable" domains to dominated roles.  I don't have the
> > practical experience to recognize the impact of this setup.

I think that this approach (using role dominance) would work, but I don't
know whether it is really preferable.  The "dominated" roles for the
shared programs domains would not be useful by themselves, only for
defining the hierarchy.  There would be no reason to specify such roles in
any user declarations or role allow statements.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
