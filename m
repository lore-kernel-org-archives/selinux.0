Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA22714
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 01:42:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA05315
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 06:39:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id GAA05311
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 06:39:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Solar Designer <solar@openwall.com>, Alexander Reelsen <ref@tretmine.org>
Subject: Re: tcb for debian?
Date: Tue, 28 Jan 2003 07:42:04 +0100
Cc: selinux@tycho.nsa.gov
References: <20030128021923.GA27564@openwall.com>
In-Reply-To: <20030128021923.GA27564@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301280742.04671.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Jan 2003 03:19, Solar Designer wrote:
> I've noticed your debian-devel postings on tcb via Google Groups and
> would like to thank you for bringing this topic up, and to comment on
> the postings.  Feel free to forward to the list.

Thanks for that invitation, I'll quote your message entirely to the SE Linux 
list to solicit advice from other experts in the field.

> Basically, I strongly disagree with Russell that the integration of
> the tcb scheme has to be in some way tied to access control enhancements
> in the kernel.  In fact, I see little point in bothering to do those
> enhancements without first using the traditional Unix semantics for
> security as much as we can.  The tcb scheme is a step in that direction.
>
> Russell's argument is that on a typical Linux setup there're many
> other flawed programs which run with high privileges.  While true,
> _this_ is something to be dealt with by teams such as Debian's.  I
> think that we do manage to deal with them in Owl.  It is possible to
> have a functional Owl system with mail (POP3, SMTP), ftpd, telnetd,
> sshd, -- offering remote shell access, -- without any SUID binary
> (some SGIDs) or any daemon which wouldn't deploy privilege separation.

This is where we differ.  You are creating a distribution that only supports 
secure software.  You are apparently not including any software in your 
distribution without first modifying it to use privsep and to drop privs it 
doesn't need.  This is a good thing, however it's not how Debian works.

In Debian there are a large number of maintainers, most of whom are not 
security experts, who all have the authority to add new software to Debian 
provided that it meets the appropriate license criteria.

Programs can be excluded from Debian for being insecure, but they will not be 
excluded for being likely to be insecure!  When a daemon needlessly runs as 
root it will not get fixed until someone files a bug report and/or offers a 
patch.  I won't name any packages as I don't want to criticise the 
maintainers in this forum, but I can think of a number of packages in Debian 
that have programs with a bad security history running as root.  For some of 
those packages I've been running them as non-root on my own machines for 
*years* without needing to make any significant changes.  However running as 
non-root has some trade-offs in terms of functionality and managability, and 
the package maintainers decided not to do it.

This situation is vastly different from your own and therefore the way we 
manage other issues has to be different to match.  So I don't disagree with 
you, I am just trying to achieve the same security goals in a different way 
and with different constraints on what I can do.

> I also don't see how a major distribution like Debian could afford to
> _depend_ on an unofficial kernel.  Such kernels may just be _installed_
> on the system, and this is possible already.

Regarding depending on an unofficial kernel.  Debian like all major 
distributions has a patched kernel.  If "different from ftp.kernel.org" == 
"unofficial" then it's unofficial.  IMHO a LSM patched kernel is no more 
unofficial than what we are currently using.

There are no plans to depend on SE Linux.  When the next version of Debian is 
released SE Linux will hopefully be one of several options for better 
security.  Now that I think about it, it would probably be a good idea if the 
standard Debian 2.4.x kernels were compiled with LSM and the OpenWall module.  
There is little reason for not doing this, Alexander, perhaps you could start 
pushing for this?

Anyway, I will be attending FOSDEM http://www.fosdem.org/ and look forward to 
seeing your presentation.  Afterwards perhaps we can discuss this matter over 
lunch.

> As for tcb, it is a userland thing and one that gets rather deep into
> the system(*).  For most people this means that it should be provided
> with the distribution to be used at all (adding it to each install is
> more work than building and using a custom kernel).

But I suspect that it is less work than installing and using SE Linux, and we 
will continue to manage without SE Linux as a mandatory part of Debian.

> BTW, even when the tcb scheme isn't used, the very use of pam_tcb and
> the new password hashing framework instead of Linux-PAM's pam_unix is
> an improvement.  (Of course, pam_tcb does all pam_unix could, without
> requiring that you also switch to the tcb scheme.)
>
> (*) The biggest change needed to support the tcb scheme (and not just
> use pam_tcb) is to the shadow suite user management tools.  The patch
> to them that's in Owl and ALT Linux is about 55 KB.  The glibc patch
> is tiny, it mostly just adds new stuff that comes as separate source
> files.  There's a version for glibc 2.2.x used in ALT Linux.  This is
> not much work for a distribution vendor, but is a bit too much to be
> done by a user.
>
> Some references:
>
> http://www.openwall.com/tcb/
> http://www.openwall.com/Owl/
> http://www.openwall.com/presentations/Owl/

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
