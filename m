Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA14619
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 06:13:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA19240
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 11:12:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA19236 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 11:12:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Mix and Match 2: relabel problems
Date: Mon, 25 Mar 2002 12:13:19 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020324154541.GA31389@vnl.com> <20020325011447.7E56B2398F@lyta.coker.com.au> <20020325015725.GA1555@vnl.com>
In-Reply-To: <20020325015725.GA1555@vnl.com>
MIME-Version: 1.0
Message-Id: <20020325111320.CC3632AB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Mar 2002 02:57, Dale Amon wrote:
> On Mon, Mar 25, 2002 at 01:31:51AM +0100, Russell Coker wrote:
> > The -2 release wasn't complete, it had some entries in file_contexts
> > without a matching .te file.  You can comment out those entries, use the
> > slapd.te file I mailed here, or wait for a -3 release (soon I hope).
>
> Hmmm, can't seem to find it with a grep of the mailq. Guess
> I'll have to wait or do the comment thing.

OK.  I've just put a new version of my selinux base packages online.  I've 
added new policy and made some changes to the devfsd shared object (which 
also requires a new version of the devfsd package for Debian so I've put it 
in the same directory).

One noteworthy thing I've done with the devfsd shared object is made any 
context that doesn't contain a ':' have "system_u:object_r:" be prepended.

I am wondering whether it would make sense to do the same for file_contexts, 
putting in system_u:object_r seems to be just needless typing.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
