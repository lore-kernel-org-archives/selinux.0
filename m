Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FL5jHa020218
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:05:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FL5iH5006225
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:05:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6FL5hRX006222 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:05:43 GMT
Subject: Re: another patch for the new release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200307122201.06936.russell@coker.com.au>
References: <200307122201.06936.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058303138.13738.809.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 17:05:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-07-12 at 08:01, Russell Coker wrote:
> I think that it is desirable that when a user is authorized for user_r and 
> staff_r that staff_r is the default.
> 
> I patched spasswd to have svigr, and to fix a bug in the Makefile with 
> creating a directory.
> 
> xstat_conv.h doesn't work for me, it seems that struct kern_stat not struct 
> stat is required.  Haven't fully tested this yet but at least it makes it 
> compile.
> 
> A couple of minor changes to the devfsd shared object that I've posted here a 
> couple of times but which don't seem to make it.
> 
> Also a patch to the makefile to make it compile on HPPA.  Of course it doesn't 
> really do much good without HPPA kernel support.  ;)

A subset of these diffs have been committed to the sourceforge CVS tree,
omitting the default_contexts diff and the xstat_conv.h diff.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
