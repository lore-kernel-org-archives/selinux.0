Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5UEBl73000870
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 10:11:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5UEBj5e023819
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 14:11:46 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5UEBg92023784 for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 14:11:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Colin Walters <walters@verbum.org>
Subject: Re: improvements to chcon.c
Date: Tue, 1 Jul 2003 00:11:22 +1000
Cc: selinux@tycho.nsa.gov
References: <1056781690.14920.81.camel@columbia> <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307010011.22778.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Jun 2003 22:31, Stephen Smalley wrote:
> (2) The omission of the ability to manipulate individual fields of the
> security context from the utility patches was intentional.   The goal is

I was expecting you to say that.

However the patch that Colin has written solves some real needs.  Changing the 
type of files is a routine administration task which should be as easy as 
possible.  Imagine if the "chown" command required that you specify 
user:group every time!

Steve, if you are totally convinced that the chcon program should not have 
such functionality then I think that perhaps we should have a Debian-specific 
program similar to chcon which offers it.  We can advise the users in the 
documentation that you don't recommend it and that future developments may 
break it, but I'm sure that most people will be happy to use it in the 
mean-time.

Also I have been thinking that the "-h" option to chcon should become the 
default.  It seems that most times I run it I want that, and that having it 
change symlinks rather than their destination is usually the safest option 
(CF a symlink to /etc/passwd).

Also for situations such as relabelling files under /tmp and for relabelling 
home directories it would be good to have an option to chcon to specify a 
source and a destination type/identity.

So relabelling a home directory would involve relabelling 
user_home_netscape_rw_t to staff_home_netscape_rw_t etc.  As programs such as 
Netscape use a very large number of files which constantly change such that 
the definitions in the file_contexts file are almost certainly out of date it 
seems that specifying source and destination components of the file is the 
only safe way to do it.

So for safe operation chcon would open a file, read the current context, 
determine how to change it, and then write the context back before closing 
the file.  Unfortunately it doesn't seem possible to do the same for 
sym-links.

NB  These same issues apply to chown/chgrp/chmod.  So a patch for this would 
best be written in a generic manner to solve the issue for all three.  The 
problems of "chown -R" etc are well known for many years...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
