Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA09743
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 07:12:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA14260
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 11:10:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA14256
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 11:10:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Fri, 19 Apr 2002 11:10:03 +0200
References: <20020418112238.A1788@lemuria.org> <20020418214440.887A644E3E@lyta.coker.com.au> <20020419081435.C11674@lemuria.org>
In-Reply-To: <20020419081435.C11674@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020419091003.585DD285DE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 08:14, Tom wrote:
> > If we have 10 users with 10 different domains and allow Apache to change
> > between them (forward and backward) at will, then anything which
> > compromises Apache or any of it's scripts can get any of the domains.  In
> > which case why not just save yourself the trouble and use a single
> > domain.
>
> I see two scenarios:
>
> 1) Apache itself is compromised. In that case, you are where you are
> right now, namely that the attacker has all the rights that apache has.
> Nothing gained, but nothing lost, either.

With the suexec model someone who gains access to the Apache domain will not 
gain direct access to the user domains, they will only be able to transition 
to them through suexec and through the cgi-bin script.  Therefore even if the 
Apache domain is controlled by a hostile user they still will be limited as 
to what they can do to the user domain.

> 2) A single script gets compromised. In that case, the attacker is in a
> tiny domain that allows access to only one user's files. That's a huge
> gain, and this danger is many times higher than the other one.
>
> There would be no transition between user domains. The transitions
> allowed would be from apache to a user and from a user to apache.

Which also allows user -> apache -> other-user...

> The
> later would happen on exit. As long as your script is still doing
> stuff, you are in the user domain.

What do you mean by "exit"?  File close of script file?  That doesn't 
necessarily stop code running...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
