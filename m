Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB8DdLJb013963
	for <selinux@tycho.nsa.gov>; Fri, 8 Dec 2006 08:39:21 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kB8DdorF012645
	for <selinux@tycho.nsa.gov>; Fri, 8 Dec 2006 13:39:50 GMT
Subject: Re: targeted policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Manoj Srivastava <srivasta@debian.org>
In-Reply-To: <200612052342.14538.russell@coker.com.au>
References: <200612052342.14538.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 08:39:48 -0500
Message-Id: <1165585188.4220.95.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-05 at 23:42 +1100, Russell Coker wrote:
> The attached patch is needed to quiet mdadm (and programs that do similar 
> things) for the case of unlabeled device nodes.  In Debian a typical install 
> of etch with SE Linux will result in /dev/.static/dev containing a lot of 
> unlabeled device nodes from the root filesystem (through a bind mount).
> 
> As for device_t, that's the default type upon creation and the type that new 
> device nodes get before we assign a type to them.

A couple things.  First, file_t cannot be referenced by name here,
because it is not owned by this module.  I'm not convinced it should be
added to this interface because its not generally applicable to any
domain that uses this interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
