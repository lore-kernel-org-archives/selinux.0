Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i912ATrT028605
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 22:10:29 -0400 (EDT)
Received: from smtp807.mail.sc5.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i9129Nng022442
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 02:09:24 GMT
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <200410010510.41928.russell@coker.com.au>
References: <C21693A0-1240-11D9-B045-000A95EED7F6@nall.com> <200410010510.41928.russell@coker.com.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03D69134-134F-11D9-B045-000A95EED7F6@nall.com>
From: Joe Nall <joe@nall.com>
Subject: Re: Representing releasibilities in SELinux
Date: Thu, 30 Sep 2004 21:10:07 -0500
To: SELinux Mail List <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 30, 2004, at 2:10 PM, Russell Coker wrote:

> On Thu, 30 Sep 2004 03:55, Joe Nall <joe@nall.com> wrote:
>> We have an application that we are considering porting from a
>> Compartmented Mode Workstation (like Trusted Solaris) to SELinux. One 
>> of
>> the issues we need to address is representing releasability 
>> information.
>> We have a significant amount of data that is current marked with
>> variations of 'releasable to country1, country2 and country3'. Data
>> marked like this is releasable to any permutation of the countries
>> involved. There are a few hundred countries, so any approach needs
>> to scale to that level.
>
> In SE Linux every process has exactly one domain and every resource 
> that a
> process may access (IE file) has exactly one type.
>
> If you had options to release to 5 different groups (EG continents) 
> then you
> could have 2^5-1 types to represent all the different combinations.
> Obviously having 2^200-1 types isn't going to work though.

Exactly my problem :) I'm hoping that those with a better understanding 
of
Flask can help me recast the problem into something more reasonable.

> How do you do this on Trusted Solaris?  Does TSOL support multiple 
> labels on
> one object?

There is a MAC label type with a bitmap for releasabilities. This 
bitmap can
represent membership in many 'country' domains.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
