Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VHWmWt020392
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 12:32:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9VHWNC7015749
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 17:32:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9VHWNuw015746
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 17:32:23 GMT
Subject: Re: successfull loaded policy on s390, 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031031145312.GA9652@wavehammer.waldi.eu.org>
References: <20031024210709.GA17189@wavehammer.waldi.eu.org>
	 <Pine.LNX.4.53.0310301830290.6332@rmt-desk.bmc.com>
	 <20031031085045.GA29900@wavehammer.waldi.eu.org>
	 <1067609436.30233.370.camel@moss-spartans.epoch.ncsc.mil>
	 <20031031145312.GA9652@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1067621560.30233.431.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Oct 2003 12:32:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-31 at 09:53, Bastian Blank wrote:
> On Fri, Oct 31, 2003 at 09:10:36AM -0500, Stephen Smalley wrote:
> > And how different is your userland from the upstream at this point?
> 
> - some 32/64 bit fixes
> - uses enums instead of integers in roleop/op (policy_parse.y)
> 
> just look into svn://bblank.thinkmo.de/selinux/selinux/trunk, i hope it
> includes any fix, need to recheck that this evening.

You'll have to continue to submit patches to the list if you want these
changes upstreamed.  I've raised various concerns with some of the
patches submitted to date that still haven't been resolved AFAIK.

Also, as a side note, access via svn:// may not be open to many (I seem
to be having a problem with it), so exporting access via http:// would
be better, or creating a separate CVS module on the sourceforge site.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
