Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i526VxrT002036
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 02:31:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i536VfeD020964
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 02:31:43 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Date: Wed, 2 Jun 2004 16:31:50 +1000
Cc: openssh-unix-dev@mindrot.org, pam-list@redhat.com,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040601090345.GM8312@lkcl.net>
In-Reply-To: <20040601090345.GM8312@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406021631.50230.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Jun 2004 19:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i have an issue on my newly created Debian/SELinux/unstable system.
>
> i have pam 0.77 se1 installed
> ssh            3.8.1p1-4      (OpenSSH)
> and libselinux1 1.12-1.
>
> i can log in as root, fine.
>
> but i cannot log in as an ordinary user, and i had to grant
> special permission to the _user_ process (NOT sshd or pam
> before a setuid and exec is carried out) to access
> /dev/pts/0.
>
> in other words, if i understand this correctly, there is a
> bug somewhere in either sshd or pam where control of the
> tty is given at the wrong point, or is not given at all.

When you login the terminal must be given a type label that permits you access 
to it.  Otherwise you can't access your terminal and get logged out.

There is a bug in the SE Linux pam code or in sshd which results in the 
terminal not being correctly relabelled in some situations.  Someone (maybe 
you) needs to debug this.  I would guess that the PAM code is doing the wrong 
thing, the PAM code in question is in Fedora and in my repository for SE 
Linux Debian packages.  It is not in the main-line PAM distribution because 
nothing happens there.

So asking the pam-list is not going to do any good because probably no-one on 
that list has even seen the code in question.  Same goes for the ssh list.

Best to just debug the code yourself.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
