Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26480
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 10:56:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1BFuqI04140
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 15:56:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1BFulf04048 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 15:56:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux newbie question
Date: Tue, 11 Feb 2003 16:56:17 +0100
References: <3E491178.8060403@redhat.com>
In-Reply-To: <3E491178.8060403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302111656.17963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Feb 2003 16:06, Daniel J Walsh wrote:
> I notice a hole bunch of man pages in libsecure/man/man1.
>
> ls
> msgget.1   msgsid.1    semperm.1  semwrite.1  shmread.1
> msgperm.1  msgwrite.1  semread.1  shmget.1    shmsid.1
> msgread.1  semget.1    semsid.1   shmperm.1   shmwrite.1

You could modify the makefile in libsecure/test to install $(TARGETS) as well 
as $(UTILS), but some of the file names don't match (and there appear to be 
programs in that directory that don't have man pages).

I may make a selinux-extra package for those programs and move the man pages 
into it.  It doesn't make sense to have man pages without binaries, and the 
typical user doesn't need them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
