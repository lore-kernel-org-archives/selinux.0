Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IJmhRb004795
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:48:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IJkIB2020244
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:46:18 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
	by jazzswing.ncsc.mil  with SMTP id i4IJkHwi020241
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:46:18 GMT
Date: Tue, 18 May 2004 19:11:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Message-ID: <20040518191139.GN24917@lkcl.net>
References: <20040515232606.GA9378@lkcl.net> <1084898046.28966.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084898046.28966.100.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 12:34:06PM -0400, Stephen Smalley wrote:
> On Sat, 2004-05-15 at 19:26, Luke Kenneth Casson Leighton wrote:
> > idea: make all the modifications to e.g. coreutils, login etc.
> > compile with the header files but not necessarily _need_
> > libselinux at run-time.
> 
> Interestingly, this issue just came up on the userlinux mailing list;
> someone noticed that upon doing an apt-get update, they pulled in
> libselinux1.  After a bit of investigation, they found that this was due
> to updating gdm, because the SELinux patch for gdm is already
> upstreamed.
 
  ah ha!  great!  so it's begun.
 
> Note of caution:  Some people still build /sbin/init statically, I
> think, and we don't want to prevent people from doing so just for
> SELinux.  The current patches allow for that; if we rewrite them to use
> dlopen, won't that be a problem?
 
 hm.

 yes.

 you'd need two packages with the same name - two compile-time
 #ifdef things - to solve that one.

 all in all, i'd say the pros and cons weigh against a rewrite.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
