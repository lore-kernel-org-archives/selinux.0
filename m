Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NGRiOb029708
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 12:27:44 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430B3C86.60802@redhat.com>
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com>
	 <430B3049.5070402@redhat.com>
	 <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil>
	 <430B3C86.60802@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 12:15:21 -0400
Message-Id: <1124813721.7874.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 11:11 -0400, Daniel J Walsh wrote:
> I was thinking of issue of the multiple translations and how to do 
> SystemHigh also.  Currently I am just truncating off
> the s0: and asking for a translation of the remainder.

Seems like you want to able to support mapping particular combinations
(c0.c127=purity_control) as well as individual components
(c42=cassandra_spender), possibly falling through to individual
component translation if there is no mapping for the complete
combination.  Otherwise, you have to specify all possible combinations,
right?

> I was thinking conflicting rpm packages.  So You can not install MCS and 
> MLS translation libaries at the same time.

Hmmm...I recall that you didn't want to take that approach for multiple
policies, but in that case, you were providing multiple policies in the
distribution itself.  As long as you don't think you will ever need to
support multiple translation libraries in the base distribution, then
conflicting packages may be ok.  Darrel, what do you think?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
