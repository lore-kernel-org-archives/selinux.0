Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U76ggA019876
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 03:06:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U756Bs028127
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 07:05:06 GMT
Subject: Re: wish-list item for selinux policy analyss
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050630003700.GB8415@lkcl.net>
References: <20050629021349.GA10219@lkcl.net>
	 <1120058832.17121.38.camel@celtics.boston.redhat.com>
	 <20050630003700.GB8415@lkcl.net>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 03:05:56 -0400
Message-Id: <1120115156.26946.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > 2) It's not clear that policy source should fit as well as possible to
> > program usage patterns. Those patterns can change, and I think
> > it's a good idea to leave some room for such changes - policy usually
> > permits the program to do more than it actually does, and I think
> > that's okay, as long as nothing dangerous is allowed. 
> 
>  i am a little fried right now to explain why i believe that is
>  not a good argument, but i believe that if you look carefully
>  at what you have said, you are saying "i think allowing more
>  than is necessary is okay, therefore i don't think we should
>  tools to people who _might_ want to go a little further / make
>  a more restrictive policy because we want it to be _difficult_
>  for them to disagree with us and diverge from policy source
>  as controlled by us."

No, actually, what I was saying is that I don't believe such a 
tool (as described) would be very helpful to me at tracking down 
policy bit rot. I feel that taking out rules written by someone 
else, based on my particular usage patterns is the wrong way to 
go... though I've done it before, because there was no way to 
figure out what those rules try to do, and why they were there
(people didn't comment policy).

If I'm the app developer, I should know why the rules are in 
there. If I'm the policy developer, I should comment my policy 
to accomplish that, and to allow other policy writers to contribute,
and maintain policy.  If I'm the end user, I probably shouldn't 
be taking important rules out of the policy without consideration 
of the policy writer's intent, and expect it not to break.

This is just my personal opinion - it has nothing to do with
the company I work for, or some grand conspiracy to maintain
control of the policy (no such thing exists, since it is open
source). I don't understand why you need an internal kernel 
change to do what you like, however - what's wrong with working 
on top of the audit log? Just comment out all the rules you're
interested in, and look for denials?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
