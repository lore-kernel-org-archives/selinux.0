Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA02494
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 10:28:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA13682
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 14:28:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA13678
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 14:28:06 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00778
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 10:28:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA23801
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 03:53:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA23266
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 07:51:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id HAA23262 for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 07:51:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Frank Mayer" <mayerf@tresys.com>,
        "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: Re: Proposal: install policy.conf
Date: Sat, 25 May 2002 09:53:00 +0200
References: <ACEHIKGIGFEDAIKEMMMICENPKDAA.mayerf@tresys.com>
In-Reply-To: <ACEHIKGIGFEDAIKEMMMICENPKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Message-Id: <20020525075300.B4D0C15EB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 May 2002 18:30, Frank Mayer wrote:
> > I, Russell Coker and Howard Holm have gone through a lengthily
> > discussion on where things go.
> >
> > We have settled on the following directory for the policy files.
> > /etc/selinux/policy

We have settled for something under /etc/selinux.  I don't use the "policy" 
sub-directory because I don't think there's a need for it.

> > In this directory you will find policy.conf file
> > /etc/security/policy/policy.conf
> >
> > /ss_policy is the binary compiled version of policy.conf
> > and that has been moved to /etc/security/selinux/policy.9
> >
> > where .9 is the current version of the compiled policy.
>
> That's fine...just to be clear, I'm interested in policy.conf being treated
> as the officially installed policy, ot where it is put.  I don't have an
> opinion on where it is installed (the version I'm using does not have
> policy.conf installed), and at that point the use of ss_policy can be
> considered an internal implementation detail by policy writers and tool
> developers.

Except of course when you're writing scripts for initrd creation etc when you 
need to know such things.

> What I would hope we can avoid is installing the policy make directory, or
> at least not requiring the make directory.  I suggest we think of the
> current make structure as just one (of hopefully many to come) way to
> write, edit and manage policies.

Sure.  Although there's probably no benefit in discussing this until someone 
has an alternate method they wish to share with us (hint).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
