Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CMv1Ii020187
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 17:57:01 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CMuwgF010710
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 22:56:58 GMT
Date: Wed, 12 Jan 2005 23:07:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Bennett <spb@gentoo.org>
Cc: ivg2@cornell.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112230724.GD11846@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566046.3933.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105566046.3933.5.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 09:40:46PM +0000, Stephen Bennett wrote:
> On Wed, 2005-01-12 at 13:11 -0700, Ivan Gyurdiev wrote:
> > > Because then policy would be encoded in the file attributes, not in a
> > > centralized security policy.  Hence, one would be unable to analyze
> > > information flow in the system based solely on the policy and would have
> > > to also analyze the complete filesystem state, and that state is much
> > > more subject to change at runtime than the policy itself (one would
> > > hope).
> > 
> > Please explain this some more - Luke also seems confused about this
> > (unless I misunderstand). I don't understand how the change from one
> > context to multiple contexts stored per file translates into policy
> > being encoded in the file attributes.
> 
> AIUI, the issue is something like this: 
> 
> With only one type per file, it's possible to look at the policy and be
> certain (for example) that domain1 can't affect domain2 in any way,
> because there are no interactions allowed between the two, and the file
> types they can access don't overlap. If you allow multiple contexts per
> file, that ability goes out of the window, and you have to look at which
> files have multiple contexts and what contexts they are before you can
> figure out where information can and can't flow.
 
 and you'd need to take all of the files matched by a regexp for one
 filetype, and all of the files of the other, work out if there are any
 common ones, and those would be your "multiple contexted" files.

 this you could do at policy compilation time.

 the thing is - which is easier: to expect people to do that
 analysis themselves [by modifying the default policies]
 or to do it in an automated at-pol-compile-time?
 
 what is gained and is it worth it in terms of the cost of development
 and extra complexity of the policy macroing system and the useability?

 is the extra syntax useful or hazardously complex?

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
