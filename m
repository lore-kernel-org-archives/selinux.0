Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7FD0wHa002886
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 09:00:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7FCxbOD008890
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 12:59:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h7FCxbKO008887
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 12:59:37 GMT
Subject: Re: 2.6.0-test3 and UML
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200308141557.23034.russell@coker.com.au>
References: <200308141557.23034.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1060952448.13964.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Aug 2003 09:00:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-14 at 01:57, Russell Coker wrote:
> For 2.6.0-test3 to work with UML the following changes are necessary:
> 
> In security/selinux/avc.c add the following:
> #include <linux/init.h>

This is actually in the tree now, as part of Geert's patch to allow m68k
compilation.

> In include/asm-um/common.lds.S add the following:
>   __security_initcall_start = .;
>   .security_initcall.init : { *(.security_initcall.init) }
>   __security_initcall_end = .;
> 
> This makes it compile and appear to run.  I'm fairly certain that adding 
> init.h is OK, but I'm not sure if the initcall stuff is right.  Hopefully 
> Steve can advise.

Use SECURITY_INIT, which is defined in
include/asm-generic/vmlinux.lds.h.  This header is already included by
arch/um/vmlinux.lds.S prior to including common.lds.S, so you should be
able to use the SECURITY_INIT symbol.

You should submit the change to the UML maintainer.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
