Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0DIQhIi026056
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 13:26:43 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0DIQkdk008106
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 18:26:46 GMT
Date: Thu, 13 Jan 2005 18:37:05 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050113183704.GP17414@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil> <1105571319.11828.19.camel@cobra.ivg2.net> <1105632619.24406.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105632619.24406.27.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 13, 2005 at 11:10:19AM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 18:08, Ivan Gyurdiev wrote:
> > What about a tool that creates a hybrid type on demand, and stores that
> > information in the policy?

 i believe that the same issues apply to the "hybrid" types
 as apply to "ACLs" - the only difference that i perceive is
 the letters contained in the file_contexts [whether a ","
 is allowed in the name of the "hybrid" type].

 the only complication therefore would be that if your users expected
 to create a combination - a "hybrid" type not previously encountered
 before: that's doable though.

 l.
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
