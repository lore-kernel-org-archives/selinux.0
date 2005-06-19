Date: Sun, 19 Jun 2005 23:10:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050619221035.GG8415@lkcl.net>
References: <1119214637.17213.41.camel@localhost.localdomain> <20050619213151.53651.qmail@web31601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050619213151.53651.qmail@web31601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 19, 2005 at 02:31:51PM -0700, Casey Schaufler wrote:
 
> Yes, he has. I hope that effort is successful.
> I strongly dislike the direction of RedHat
> shipping a binary only policy, and one that
> so few people understand, and that the
> applications it impacts can't even be repaired
> by their maintainers. 

 as the bun-fight over crond demonstrated (at least to me), the
 maintainers _can_ listen - if you have enough time, patience and
 flexibility.

 for those people who missed it, crond (not the vixie cron, the other
 one) did not properly support selinux, and needed it.

 a long _long_ time was spent explaining to the maintainer of crond
 that yes, selinux really _does_ have a concept of "system".

 the poor guy had added the concept of "*system*" to cater
 for the fact that unix-on-its-own doesn't have a clue about
 "system" privileges, and he had added some extra field
 into his internal data structures in order to be able to
 distinguish between "system" level cron jobs [run as root]
 and those that were explicitly to be run under the username
 of "root".

 after about 10-15 email exchanges, he eventually explained
 things clearly enough for it to get through our thick heads,
 and _then_ we had enough of an understanding of what he had
 created, in order to be able to successfully convince him that
 yes, selinux's "system_u" needs to ride "on the back of" his
 pseudo-created "*system*" concept.
 
 from there i kind of lost the plot a bit (i overdid it a
 bit :) and he and dan managed to finish it off and write an
 acceptable patch.

 i put it to you, therefore, casey, that it is _your_ job - and mine -
 to explain selinux clearly enough, to be patient enough, to listen
 enough.

 the one about openssh (the file handle one where an exec()
 had happened and the file handle hadn't been closed) was _way_
 over my head, but heck - there were people here who understood it.

 one step at a time.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
