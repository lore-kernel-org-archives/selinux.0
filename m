Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B3uHrT004089
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 23:56:17 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B3uCaH004279
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 23:56:13 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: se-samba - a possible way to get round no seteuid
Date: Fri, 11 Jun 2004 13:56:08 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
References: <20040609100345.GA5727@lkcl.net> <200406101731.39235.russell@coker.com.au> <20040610201327.GA2861@lkcl.net>
In-Reply-To: <20040610201327.GA2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111356.08287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 06:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > instead of doing a seteuid back to root, you do an execve to
> > > an executable named samba-root.
> >
> > That doesn't work.  There are more possible UIDs than the root file
> > system may have Inodes...
>
>  ? i am confused.  by execve'ing back to a context, shall we call it
>  smbd_as_root_t, what connection does that have to UIDs?

The idea for Exim is that you have a set of wrapper binaries already there on 
disk.  If a particular installation of Exim doesn't use one of the ~6 
wrappers that are installed then it's only a waste of 4K of disk space.

If we do the same mechanism for each UID then we have many more executables, 
or we have to allow the daemon to create new executables which also adds more 
coding.

>  ah, remember that you can have several UIDs over the same TCP
>  connection (and multiple SMBsessionsetupX's to represent each
>  and you get these SMB-MIDs - multiplexing ids - to represent
>  each SMB session over the same TCP session),

[...]

>  i thought that instead of having the seteuid and back to root,
>  you could execve back to the "smbd_as_root_t context".

True, but re-execing requires serialising all the data to a file, shared 
memory region, or something else that will survive past an exec.  That's pain 
that we don't want to go through any more often than is necessary.

>  - smbd_the_daemon (waiting for connections)
>
>  ... which transitions on a fork to...
>
>  - smbd_as_root_t (dealing with "connections")
>
>  ... which can transition to ...

How about just smbd_the_daemon which can transition to smbd_as_a_user?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
