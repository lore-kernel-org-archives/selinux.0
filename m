Subject: Re: Multiple contexts
From: Stephen Bennett <spb@gentoo.org>
To: ivg2@cornell.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
In-Reply-To: <1105560687.11135.26.camel@cobra.ivg2.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 21:40:46 +0000
Message-Id: <1105566046.3933.5.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 13:11 -0700, Ivan Gyurdiev wrote:
> > Because then policy would be encoded in the file attributes, not in a
> > centralized security policy.  Hence, one would be unable to analyze
> > information flow in the system based solely on the policy and would have
> > to also analyze the complete filesystem state, and that state is much
> > more subject to change at runtime than the policy itself (one would
> > hope).
> 
> Please explain this some more - Luke also seems confused about this
> (unless I misunderstand). I don't understand how the change from one
> context to multiple contexts stored per file translates into policy
> being encoded in the file attributes.

AIUI, the issue is something like this: 

With only one type per file, it's possible to look at the policy and be
certain (for example) that domain1 can't affect domain2 in any way,
because there are no interactions allowed between the two, and the file
types they can access don't overlap. If you allow multiple contexts per
file, that ability goes out of the window, and you have to look at which
files have multiple contexts and what contexts they are before you can
figure out where information can and can't flow.

Of course I may be off here, and I may have missed more subtleties, but
that's the problem I can see with multiple types per file. Someone
correct me if I'm wrong here. :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
