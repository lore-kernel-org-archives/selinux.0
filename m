Return-Path: <owner-selinux@tycho.ncsc.mil>
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA01151
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 03:12:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA16339
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 07:12:00 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA16335
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 07:11:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: new Debian package
Date: Sun, 26 May 2002 09:11:52 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020525195638.734D015EB@lyta.coker.com.au> <3CF03C25.1050803@evoworks.evoserve.com> 
MIME-Version: 1.0
Message-Id: <20020526071153.488F71C0F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 May 2002 08:45, Russell Coker wrote:
> On Sun, 26 May 2002 03:36, Debian User wrote:
> > >I've just uploaded a new Debian package, this one has the latest patches
> > > and new policy that works a lot better.  I now have a Debian machine
> > > running in enforcing mode with a policy that is not much different from
> > > the default in my package.  It's running as an ADSL gateway machine
> > > (pppoatm with SpeedTouch USB driver), a web server, and has the courier
> > > POP server running.
> > >
> > >As the basic stuff is working it won't be too difficult for you to add
> > >support for other daemons etc.
> >
> > I tried it just now policy compilation fails with:
> >
> > /usr/sbin/checkpolicy -o policy.9 policy.conerror in the statement
> > ending on line 13924 (token ';'): unknown type ipsec_file_t
> >
> > /usr/sbin/checkpolicy: error(s) encountered while parsing configuration
>
> This means that some file you are using has a rule involving the
> ipsec_file_t while you have not included the ipsec.te file.  Including
> ipsec.te is one way of solving the problem, but a better solution (if you
> don't want ipsec) is to find the file in question and fix it.

As a follow up to this, that turned out to be a bug in my sample policy.  
Just remove the lines in question from initrc.te.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
