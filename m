Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UKi3gA026426
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 16:44:03 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UKgwfl003568
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 20:42:58 GMT
Date: Thu, 30 Jun 2005 21:51:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630205143.GC8421@lkcl.net>
References: <20050629021349.GA10219@lkcl.net> <1120058832.17121.38.camel@celtics.boston.redhat.com> <20050630003700.GB8415@lkcl.net> <1120115156.26946.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120115156.26946.50.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 30, 2005 at 03:05:56AM -0400, Ivan Gyurdiev wrote:
 
> This is just my personal opinion - it has nothing to do with
> the company I work for, or some grand conspiracy to maintain
> control of the policy (no such thing exists, since it is open
> source). I don't understand why you need an internal kernel 
> change to do what you like, however - what's wrong with working 
> on top of the audit log? Just comment out all the rules you're
> interested in, and look for denials?
 
 hiya ivan,

 yes, joshua described something which would achieve the same thing
 using audit logging.

 (thank you joshua!)

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
