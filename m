Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06785
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:28:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA06602
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 18:26:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA06592
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 18:26:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 20:28:07 +0200
References: <20020418171532.B6551@lemuria.org> <Pine.GSO.4.33.0204181124100.5560-100000@raven> <20020418182137.A7029@lemuria.org>
In-Reply-To: <20020418182137.A7029@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418182807.E89D630028@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 18:21, Tom wrote:
> On Thu, Apr 18, 2002 at 11:32:07AM -0400, Stephen Smalley wrote:
> > Immunix's SubDomain provides a mechanism for confining "subprocesses" for
> > web servers.  Read their paper for the details.
> >
> > IMHO, if you truly want to confine these "scripts" differently than the
> > main apache process, they should run in separate processes.
>
> Of course. The real-life problem is that I would prefer to reach this
> goal without major changes to apache or the environment. The regular
> workings of apache don't allow for anything like this, if for no other
> reason then the fact that the children "hang around" after they have
> one request done to handle the next ones. Anything else and you drown
> in fork() overhead.

That's easy to solve.  Such children hang around for a certain amount of time 
and then exit if they aren't being used.  Just like the model Apache uses for 
it's own processes.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
