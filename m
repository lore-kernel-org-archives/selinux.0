Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10035
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:26:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA17230
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:24:44 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id MAA17226
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:24:43 GMT
Date: Fri, 19 Apr 2002 14:27:25 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020419142724.A18906@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418214440.887A644E3E@lyta.coker.com.au> <20020419081435.C11674@lemuria.org> <20020419091003.585DD285DE@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020419091003.585DD285DE@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 19, 2002 at 11:10:03AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 19, 2002 at 11:10:03AM +0200, Russell Coker wrote:
> > 1) Apache itself is compromised. In that case, you are where you are
> > right now, namely that the attacker has all the rights that apache has.
> > Nothing gained, but nothing lost, either.
> 
> With the suexec model someone who gains access to the Apache domain will not 
> gain direct access to the user domains, they will only be able to transition 
> to them through suexec and through the cgi-bin script.  Therefore even if the 
> Apache domain is controlled by a hostile user they still will be limited as 
> to what they can do to the user domain.

Ok, that makes sense.


> > There would be no transition between user domains. The transitions
> > allowed would be from apache to a user and from a user to apache.
> 
> Which also allows user -> apache -> other-user...
> 
> > The
> > later would happen on exit. As long as your script is still doing
> > stuff, you are in the user domain.
> 
> What do you mean by "exit"?  File close of script file?  That doesn't 
> necessarily stop code running...

Two possibilities here. One being an active transition by apache
(requesting to enter a new domain) at the end of the PHP execution. The
other being a socket close. The later would mean the process remains in
the domain during keepalive. Apache doesn't tear the socket down while
code is still running, since there may still be output being added.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
