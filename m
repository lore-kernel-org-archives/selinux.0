Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CNM9Ii020402
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:22:10 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CNMBgF011377
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 23:22:12 GMT
Date: Wed, 12 Jan 2005 23:32:41 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112233241.GF11846@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 04:47:41PM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 15:11, Ivan Gyurdiev wrote:
> > Please explain this some more - Luke also seems confused about this
> > (unless I misunderstand). I don't understand how the change from one
> > context to multiple contexts stored per file translates into policy
> > being encoded in the file attributes.
> > 
> > It seems to me that this change would simply allow more accurate
> > association of the files with the proper security data.
> > 
> > It is still a centralized policy which decides whether to allow an
> > action or not - it just takes into consideration multiple contexts.
> > I am merely suggesting that when a security decision is necessary for
> > a file, all the contexts it is labeled with are provided by the
> > filesystem, and the security server makes a decision based on 
> > whether an access path (not sure of terminology here) exists
> > between the subject context and any object context.
> 
> If we followed that approach, then we wouldn't be able to tell whether
> information can flow from type A to type B without analyzing the
> filesystem state to see what files had multiple contexts and collapsing
> each such combination into a single security equivalence class (type).
 
 would you accept that that could be done at policy compile time,
 and that it would be unnecessary to do that at runtime?

 [if yes, then the question becomes a) who's gonna do the work
  b) is it useable without making selinux horribly complex]

 would you also agree that if someone wants to mess things up
 with chcon then all bets are off for _any_ kind of analysis?

 btw so you aren't thinking of doing something irrational in order
 to stay sane i should point out that i'm not pursuing this to be
 bloody-minded - hopefully you know me better than that by now!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
