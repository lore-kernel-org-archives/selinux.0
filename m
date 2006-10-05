Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95JtM5M000738
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 15:55:22 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k95JskZv014990
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 19:54:46 GMT
Subject: Re: policy patch against subversion tree
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200610052244.51091.russell@coker.com.au>
References: <200610052244.51091.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:55:14 -0400
Message-Id: <1160078114.26418.54.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, with some notes:

On Thu, 2006-10-05 at 22:44 +1000, Russell Coker wrote:
> Allow unconfined processes to see unlabeled processes in ps.

Enhanced the kern_unconfined rules in kernel.te instead.

> Removed a redundant rule in samba.te, and some inappropriate permissions in 
> amavis.te.

This amavis removals were added from Dan from August, so there needs to
be some discussion on this.  Dan?

> Removed support for the pre-Fedora Red Hat code to create sym-links in /boot.

Kept the interface, in case there are 3rd party callers of this
interface.

> Removed support for devpts_t files in /tmp (there is no way that would ever 
> work).
> 
> Allowed postgrey to create socket files.

Moved this hunk down.

> Made the specs for the /lib and /lib64 directories better support stem 
> compression.

Fixed the mailman addition to use an interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
