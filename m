Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA13521
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 20:28:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA01301
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2002 00:26:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA01297
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2002 00:26:56 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: ppp
Date: Wed, 8 May 2002 10:28:46 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205071007430.22871-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205071007430.22871-100000@raven>
MIME-Version: 1.0
Message-Id: <20020508002846.8C7B56CF5@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 May 2002 00:22, Stephen Smalley wrote:
> > It is common to install pppd in such a fashion that it can be run as
> > "pppd call server" by a regular user.
> >
> > The problem is that it often starts daemons from it's ip-up script once
> > it connects, and such daemons aren't allowed to be in user_r!
> >
> > I am thinking of writing a pppd wrapper program which runs it as
> > "system_u:system_r:pppd_t", what do you think?
>
> I suppose that the question is whether we obtain any real security benefit
> from having such a wrapper vs. directly authorizing user_r for the
> necessary domains and directly authorizing user_t to transition via
> pppd_exec_t to pppd_t.  The domain transitions would still be limited
> based on the entrypoint program.  Can you clarify exactly what other
> daemons might be started in this manner?

In my policy I already have a user_t transition to pppd_t.  The issue is that 
pppd should not be running in user_r because the ip-up scripts will start 
other daemons which should be in domains that aren't permitted in user_r (EG 
the mail server).

Basically preserving the current mode of operation of pppd for manual 
call-out and keeping it in user_r means removing system_r because most things 
that belong in system_r will end up in user_r!

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
