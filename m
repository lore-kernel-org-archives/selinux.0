Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ODZ3sJ018149
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 09:35:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ODXId0022420
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:33:18 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8ODXGVY022413
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:33:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Some minor thoughts on syntax/semantics
Date: Wed, 24 Sep 2003 23:34:55 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030923150926.GG21997@vnl.com>
In-Reply-To: <20030923150926.GG21997@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309242334.55203.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Sep 2003 01:09, Dale Amon wrote:
> There seems to be a bit of mental gymnastics involved
> in reading allow statements. They are written like this:
>
> allow  this_t   that_t:class  {this that and the other};
>
> but semantically we want to think of it as:
>
> "Allow a domain this_t to do {this that and the other}
> from something like that_t:class"
>
> So I wonder if there was a reason you didn't go for
> a similar syntax, eg
>
> allow  this_t {this that and the other}  that_t:class;

The current syntax seems intuitive enough to me.  I learnt how to write SE 
policy by reading the existing policy and playing with it and it never seemed 
difficult.

Brian's point about C++ etc seems valid.

I'm in the same situation as Brian in that I wasn't involved when it was 
designed, and therefore I guess I'm slightly biased towards the current 
method having worked with it for years and not used any alternative.

Now when I think about what Unix programs do I think in SE policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
