Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21031
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 10:43:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26697
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 14:42:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA26689
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 14:42:02 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: New Apache policy
Date: Thu, 24 Oct 2002 16:43:38 +0200
Cc: selinux@tycho.nsa.gov
References: <20021024160624.B2010@lemuria.org>
In-Reply-To: <20021024160624.B2010@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210241643.38762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Oct 2002 16:06, Tom wrote:
> The attached patch includes the earlier one, fixes what Russell
> commented on and thus should get apache working in both the 1.x and 2.x
> versions. No guarantees for PHP, CGI and other modules, I will tackle
> that next.

The problem with PHP is that it requires giving the httpd_t domain more access 
than you might otherwise want.

I am thinking of addressing this by having some macros file doing define() 
statements for what functionality you want.  So you could do the following if 
you want PHP:
define(`use_http_php')

Your comment about sysadm terminal access is inaccurate.  Apache2 should work 
perfectly when started from system boot!

I suggest using r_dir_file() for the config entries, it means 1 line of policy 
instead of 3 and makes it easier to read.

> However, I have also included my very first own from-scratch policy
> file, for Subversion. Subversion is a CVS replacement and the server
> runs under Apache2 using DAV.
> My policy file tackles both the client tools and the server side,
> allowing a server and both remote and local repository access.
>
> Since this is my first from-scratch policy file, please take a look and
> comment on it. It works for me, but I may have granted too much
> permissions somewhere, even though I tried hard not to.

+# svn_t is the domain for the subversion client programs.
+# svn_sysadm_t is the domain for the subversion client programs if run by the 
sysadmin.

Why not use a macro for this as is done for the user_irc_t, user_ssh_t, etc?

I think that using a macro will give better security and also make the policy 
easier to read and manage.

> Finally, there is also a tiny fix for postfix that is required on my
> system to silence pickup. No idea if this was just missed elsewhere or
> if pickup works without and a simple dontaudit would've done it.

The thing to do with Postfix is to configure it to not use chroot.  I think 
that configuring Postfix with chroot on SE Linux actually decreases security 
as the types of the files for the chroot environment (which are re-copied at 
every system boot) are difficult to manage.

If you have chroot with Postfix you will have to do MUCH more than 1 line of 
changes to get it working properly!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
