Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67ImWrT008004
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 14:48:32 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67ImVaX004656
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 18:48:31 GMT
Subject: Re: Question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christopher Soghoian <genome4hire@dubfire.net>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20040705162019.A5156@sphinx.mythic-beasts.com>
References: <20040705162019.A5156@sphinx.mythic-beasts.com>
Content-Type: text/plain
Message-Id: <1089226058.1774.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 14:47:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-07-05 at 11:20, Christopher Soghoian wrote:
> What we'd like to be able to do, is to freeze the process right before
> the read/write request gets rejected.. and then call a script, which
> can gather some forensic information on the process.
> 
> It's important for us to be able to do this -before- the process's request
> is rejected.
> 
> I don't think theres anything in place right now to do this (or am I wrong?),
> but could someone please let me know how difficult it would be to add this,
> and where the code would have to go?
> 
> Ideally, we'd like to do a `kill -s SIGSTOP` on the process, and then run
> a script (passing in the misbehaving pid).

You would need to be selective in the set of permission checks that
triggered such behavior, as some permissions checks are called at points
where it would not be safe for you to block in this manner (e.g. kernel
locks may be held, or you may not even be in process context).  You
could introduce an additional access vector for this purpose, similar to
the existing vectors that control the auditing behavior.  You could then
modify avc_has_perm_noaudit() to (after releasing its own lock) call
force_sig_specific(SIGSTOP, current) if a) in process context, and b)
the requested permissions were denied, and c) the denied permissions
were present in the new vector, and to then call call_usermodehelper()
to run your script.  Or you could do likewise in specific hook
functions, e.g. selinux_inode_permission(), if you only wanted to apply
such behavior to specific hooks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
