Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TFUPgA013175
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 11:30:26 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TFSvdE002734
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 15:28:57 GMT
Subject: Re: wish-list item for selinux policy analyss
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050629021349.GA10219@lkcl.net>
References: <20050629021349.GA10219@lkcl.net>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:27:12 -0400
Message-Id: <1120058832.17121.38.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  reason for this is to be able to fire up a system, run
> it for a while (live) say oh a few months, and then determine
> which bits of the selinux policy.conf have never ever actually
> been used.

I see several problems with this idea:

1) Usage frequency does not necessarily correlate to
whether the rule is valid or not - you'd have to test
every code path to establish whether the rule is needed or not.
I find this to be better accomplished with comments in policy
before every group of rules (and _not_ using audit2allow).

2) It's not clear that policy source should fit as well as possible to
program usage patterns. Those patterns can change, and I think
it's a good idea to leave some room for such changes - policy usually
permits the program to do more than it actually does, and I think
that's okay, as long as nothing dangerous is allowed. 

3) Another reason for (2) is that policy source is reduced 
to a number of primitives (macros) that you work with. Some of
those macros couple functionality that doesn't always go
together, but usually does - generic macros). The result
is permissions you don't need. However, that's not necessarily
a problem - it allows the policy writer to overlook certain
things, and focus on more important concerns. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
