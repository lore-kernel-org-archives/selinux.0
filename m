Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KDASWt019560
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:10:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KDAG0p024758
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:10:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KDAGr7024755
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:10:16 GMT
Subject: Re: old SE Linux patch for procps 3.1.12
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Colin Walters <walters@verbum.org>
In-Reply-To: <200310191452.43127.russell@coker.com.au>
References: <200310191452.43127.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066655423.22196.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 09:10:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-10-19 at 00:52, Russell Coker wrote:
> Procps includes SE Linux support upstream, but it's a bit outdated.
> 
> I have attached a patch to remove support for displaying SIDs.  It is a bit 
> rough and has a memory leak (allocates textual representations of contexts 
> but never frees them - may be a problem for "top").
> 
> I wrote this because I couldn't figure out how to get a straight patch for the 
> new SE Linux, so I updated the old SE Linux code to be more like the new SE 
> Linux code as an intermediate step.

My impression was that Albert Cahalan was going to directly implement
support for displaying the /proc/pid/attr/* values since /proc/pid/attr
is now part of the mainline kernel API.  At which point you don't really
need a SELinux-specific patch at all.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
