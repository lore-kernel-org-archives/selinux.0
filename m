Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12763
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 09:47:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08431
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:45:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA08427 for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:45:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Frank Mayer" <mayerf@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: login (new default_contexts)
Date: Tue, 19 Nov 2002 15:46:58 +0100
References: <000201c28fd7$a99d63c0$6600a8c0@columbia.tresys.com>
In-Reply-To: <000201c28fd7$a99d63c0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Message-Id: <200211191546.58254.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Nov 2002 15:26, Frank Mayer wrote:
> I must admit that I for one am confused about what changed with login
> and default contexts.  I'll also admit I haven't tried to look through
> the code to understand the changes yet, but perhaps someone can give a
> quick synopsis.  Before one had to have a default context in
> /etc/security/default_context to login.  From what I've seen here, it
> sounds like the file is no longer needed, but instead default_contexts
> is used, which has a different format.

The file was apparently renamed because the syntax is different.  This is good 
practise, and allows you to mix versions of the various login programs if you 
wish.

> It looks like its specifying a default context for a role rather than a
> user.  Is that correct? Does the old default context still work?  Or is
> this replaced with the user's own .defaul_context?  I'm sure this was
> probably discussed in list; I'd appreciate any pointers on what the
> effect of the changes are.

The new file specifies the order of contexts that should be attempted for each 
program.  This allows you to specify that sysadm_r:sysadm_t should be tried 
first (and therefore be the default if the identity permits it) for a login_t 
login.  However for a sshd_t login process you definately don't want that 
(see the discussion we had on this list after the last critical security hole 
in sshd) so you specify that user_r:user_t should be the default context.  Of 
course in the case of sshd the policy should prohibit that anyway.

We still don't have policy for .default_context...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
