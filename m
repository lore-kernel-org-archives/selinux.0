Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA09311
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 12:53:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA26069
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 17:50:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA26065
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 17:50:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Justin Smith <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: Re: Systrace
Date: Tue, 3 Dec 2002 18:52:52 +0100
References: <1038930973.2041.2.camel@jsmith.org>
In-Reply-To: <1038930973.2041.2.camel@jsmith.org>
MIME-Version: 1.0
Message-Id: <200212031852.52199.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Dec 2002 16:56, Justin Smith wrote:
> I came across the Systrace site
>
> http://www.citi.umich.edu/u/provos/systrace/
>
> and it strikes me as somewhat similar to SELinux: although it lacks
> roles, it does intercept system calls and file accesses and apply access
> criteria. It seems to me that the most significant difference between
> systrace and SELinux is the lack of domains for running processes. On
> the other hand, one can specify which programs to monitor.

One thing that I think would be interesting would be to have a panel 
discussion at a conference comparing the different MAC systems for Linux.  I 
would like to talk about SE Linux at such a discussion.

I think that such a panel would be really good for the people developing the 
various security systems as well as the audience (we could ask each other 
questions such as "my system does X, how does your's get that result").

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
