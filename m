Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00823
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 14:46:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA29222
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:45:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA29218
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:45:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: uml policy
Date: Thu, 12 Sep 2002 20:46:16 +0200
References: <20020912201240.B2594@lemuria.org>
In-Reply-To: <20020912201240.B2594@lemuria.org>
MIME-Version: 1.0
Message-Id: <200209122046.16947.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 20:12, Tom wrote:
> During Linux Kongress, I had a little chat with Russell about uml
> (user-mode-linux) on top of SELinux (for now, I'll leave the
> mindboggling involved with SE-UML-Linux to someone else :) ).
>
> I've found out that uml runs fine as a standard userspace process (i.e.
> as it was intendend) with the default policy. So getting it simply to
> run is already done.
>
> I plan to spend some time on running uml in it's own domain, with
> minimal rights and auto-trans into it when you fire it up. I'm
> announcing this so anyone else working on something similiar can yell
> and we don't need to do redundant work.

Go for it!

I suggest looking at my IRC domain for an example of how to do it.  Also you 
have to make sure that the user can change the type of the file to/from the 
type you choose for the UML kernel.

Also I suggest having two types for the kernel, one per-user (IE 
user_uml_kernel_t etc) and one for the system (maybe system_uml_kernel_t).

Also for the data store, make sure that you define access for a directory too, 
so that the UML program domain doesn't even get access to user_home_dir_t or 
user_home_t directories.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
