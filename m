Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA03422
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:54:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA19524
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 22:52:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA19520 for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 22:52:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: uml policy
Date: Fri, 13 Sep 2002 00:53:55 +0200
Cc: selinux@tycho.nsa.gov
References: <20020912201240.B2594@lemuria.org> <200209122046.16947.russell@coker.com.au> <20020912231815.C2625@lemuria.org>
In-Reply-To: <20020912231815.C2625@lemuria.org>
MIME-Version: 1.0
Message-Id: <200209130053.55563.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 23:18, Tom wrote:
> On Thu, Sep 12, 2002 at 08:46:16PM +0200, Russell Coker wrote:
> > I suggest looking at my IRC domain for an example of how to do it.  Also
> > you have to make sure that the user can change the type of the file
> > to/from the type you choose for the UML kernel.
>
> Yes, that will be needed, especially for COW files.

NB You need separate types for the kernel and the disk image.  The kernel 
should not be writable...

> > Also I suggest having two types for the kernel, one per-user (IE
> > user_uml_kernel_t etc) and one for the system (maybe
> > system_uml_kernel_t).
>
> Actually, I think I don't want the system to run uml. Except in a
> run_init way. And I definitely don't want root/sysadm_r to run it. Hey,
> ever seen permissions 007 ? :)

You possibly don't want the system to run it (but that is debatable), however 
you certainly want to be able to install a kernel as the administrator and 
have regular users execute it.

> > Also for the data store, make sure that you define access for a directory
> > too, so that the UML program domain doesn't even get access to
> > user_home_dir_t or user_home_t directories.
>
> I was planning to borrow some ideas from your chroot domain, and set
> things up very close to that. I will also need an interesting type for
> the keystroke logger files.

Chroot is probably too heavy, irc is simpler and easier to copy from.  For 
keystroke logger files I guess you could make them append-only.  Or you could 
use the same read-write file you use for the data store.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
