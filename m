Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6UHQIHa028328
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 13:26:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6UHP1FB025270
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:25:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6UHP0GD025266
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:25:00 GMT
Subject: Re: [patch] policy metadata
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1058463241.14302.16.camel@columbia>
References: <1058463241.14302.16.camel@columbia>
Content-Type: text/plain
Message-Id: <1059585960.1052.51.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Jul 2003 13:26:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-07-17 at 13:34, Colin Walters wrote:
> While Debianizing all the SE 2.5 stuff, I got pretty fed up with
> answering 100+ questions about whether or not to install individual
> policy files.  So I've been working on a few new options for installing
> the Debian SELinux policy.
> 
> The main idea is to add information to each .te file about which Debian
> packages use it.  I went with the semi-RFC822 style formatting in use
> and called it "X-Debian-Packages:".
> 
> Since this is a 1-line change to more than 120 files, it'd be nice if it
> could be merged upstream to reduce the size of our policy diffs.  The
> metadata may be useful too for other systems which might use similar
> package names, or at least it will give a hint about what the software
> is if you're unsure.  And since this is just a change to the comments,
> it should be minimally intrusive.

This patch has been merged into our 2.5/6 policy tree, and has been
committed to the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
