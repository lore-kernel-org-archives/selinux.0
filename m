Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJB0rT025878
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:11:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UJ9png003870
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:09:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joe Nall <joe@nall.com>
Subject: Re: Representing releasibilities in SELinux
Date: Fri, 1 Oct 2004 05:10:41 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <C21693A0-1240-11D9-B045-000A95EED7F6@nall.com>
In-Reply-To: <C21693A0-1240-11D9-B045-000A95EED7F6@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010510.41928.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Sep 2004 03:55, Joe Nall <joe@nall.com> wrote:
> We have an application that we are considering porting from a
> Compartmented Mode Workstation (like Trusted Solaris) to SELinux. One of
> the issues we need to address is representing releasability information.
> We have a significant amount of data that is current marked with
> variations of 'releasable to country1, country2 and country3'. Data
> marked like this is releasable to any permutation of the countries
> involved. There are a few hundred countries, so any approach needs
> to scale to that level.

In SE Linux every process has exactly one domain and every resource that a 
process may access (IE file) has exactly one type.

If you had options to release to 5 different groups (EG continents) then you 
could have 2^5-1 types to represent all the different combinations.  
Obviously having 2^200-1 types isn't going to work though.

How do you do this on Trusted Solaris?  Does TSOL support multiple labels on 
one object?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
