Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SGcPRb005972
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 11:38:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0SGb8VK027931
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:37:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0SGb7lx027928
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:37:08 GMT
Subject: Re: Problem with selinux configuration
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: keen@internode.on.net, selinux@tycho.nsa.gov
In-Reply-To: <200401290300.33895.russell@coker.com.au>
References: <4017be35.30f.6615.1100265729@internode.on.net>
	 <200401290300.33895.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1075307887.19427.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 11:38:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 11:00, Russell Coker wrote:
> Why are you building RPMs?  For Red Hat or Fedora you are best advised to use 
> Dan Walsh's packages: ftp://people.redhat.com/dwalsh/SELinux
> 
> Dan's packages are the official packages that are going into FC2.

That isn't really an option unless he is willing to install rawhide, as
Dan's packages have been rebuilt against it and now have dependencies on
packages from it, e.g. newer glibc, newer db4, etc.  People who want to
use SELinux on Fedora Core 1 still have to use the older userland.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
