Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02824
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 17:18:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA08012
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 21:17:17 GMT
Received: from unicorn.lemuria.org (b067173.adsl.hansenet.de [62.109.67.173])
	by jazzswing.ncsc.mil  with ESMTP id VAA08008
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 21:17:16 GMT
Date: Thu, 12 Sep 2002 23:18:15 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: uml policy
Message-ID: <20020912231815.C2625@lemuria.org>
References: <20020912201240.B2594@lemuria.org> <200209122046.16947.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209122046.16947.russell@coker.com.au>; from russell@coker.com.au on Thu, Sep 12, 2002 at 08:46:16PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 12, 2002 at 08:46:16PM +0200, Russell Coker wrote:
> I suggest looking at my IRC domain for an example of how to do it.  Also you 
> have to make sure that the user can change the type of the file to/from the 
> type you choose for the UML kernel.

Yes, that will be needed, especially for COW files.

> Also I suggest having two types for the kernel, one per-user (IE 
> user_uml_kernel_t etc) and one for the system (maybe system_uml_kernel_t).

Actually, I think I don't want the system to run uml. Except in a
run_init way. And I definitely don't want root/sysadm_r to run it. Hey,
ever seen permissions 007 ? :)


> Also for the data store, make sure that you define access for a directory too, 
> so that the UML program domain doesn't even get access to user_home_dir_t or 
> user_home_t directories.

I was planning to borrow some ideas from your chroot domain, and set
things up very close to that. I will also need an interesting type for
the keystroke logger files.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
