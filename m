Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38HeiRb019357
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:40:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38HciUZ006912
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:38:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i38HchmT006907
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:38:43 GMT
Subject: Re: strange labeling problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1081445224.3361.107.camel@nexus.verbum.private>
References: <1081376404.9215.13.camel@nexus.verbum.private>
	 <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
	 <1081445224.3361.107.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1081446022.6379.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 13:40:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-08 at 13:27, Colin Walters wrote:
> On Thu, 2004-04-08 at 09:32, Stephen Smalley wrote:
> > chcon likely never called setfilecon at all, since getfilecon would have
> > told it that the file already had the right context.  
> 
> Ok, and this is basically an optimization, so we don't have to rewrite
> the xattr on disk?

Yes.  It would call getfilecon anyway to see whether the context is
being changed for verbose mode, and to determine the full context if
only a particular context field (e.g. -t) were specified.  Also avoids
any spurious permission denial, e.g. you do a chcon -R on a tree, and
lack permission to relabel a file in that tree, but the file already has
the right label.

> It's kind of confusing that there can be this kind of desynchronization
> between chcon and ls -Z.  It will probably be a pretty rare case - it'll
> likely only hit people who are developing policy.  

Yes.  This is a result of migrating to the xattr API; the old SELinux
API obtained the context from the actual inode SID, and was always
consistent.  But the xattr API calls down into the filesystem code to
obtain the context, not the security module.  The security module only
gets to mediate access before the call to the filesystem, and to update
its internal state (i.e. the inode SID) after a successful call to the
filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
