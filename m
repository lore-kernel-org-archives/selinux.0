Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0DGaBIi024940
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 11:36:12 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0DGaEdk003158
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 16:36:14 GMT
Date: Thu, 13 Jan 2005 16:46:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, ivg2@cornell.edu,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Multiple contexts
Message-ID: <20050113164638.GH17414@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil> <20050112233241.GF11846@lkcl.net> <1105624601.15674.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105624601.15674.24.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 13, 2005 at 08:56:41AM -0500, James Carter wrote:
> On Wed, 2005-01-12 at 18:32, Luke Kenneth Casson Leighton wrote:
> 
> >  would you also agree that if someone wants to mess things up
> >  with chcon then all bets are off for _any_ kind of analysis?

 sorry i meant to qualify: any kind of analysis using just the
 policy files alone.

> > 
> 
> Not true.  Look at Steve's earlier example again.


 at some time when i woke up this morning, i had a flash of inspiration.

 i recognised that there was a problem with what i was proposing.

 it was something to do with creating new files, that not even
 an "intermediate" policy based off of combining and creating
 "intermediate" filetypes would fix, without, as you say,
 examining all files covered by an "intermediate" regexp.

 i could not, for the life of me, tell you what that is, now.

 ... something to do with working out what the overlaps between
 two regexps for file contexts, creating new regexps in a venn
 diagram like fashion, then applying them with setfiles...

 ... and yet that still doesn't help.

 so, yes.

 time to drop it :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
