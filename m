Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BKsrrT007498
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 16:54:54 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5BKsmP2006860
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 16:54:48 -0400 (EDT)
Date: Fri, 11 Jun 2004 20:52:03 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
Subject: Re: se-samba - a possible way to get round no seteuid
Message-ID: <20040611205203.GF2861@lkcl.net>
References: <20040609100345.GA5727@lkcl.net> <200406101731.39235.russell@coker.com.au> <20040610201327.GA2861@lkcl.net> <200406111356.08287.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111356.08287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 01:56:08PM +1000, Russell Coker wrote:
> On Fri, 11 Jun 2004 06:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > > instead of doing a seteuid back to root, you do an execve to
> > > > an executable named samba-root.
> > >
> > > That doesn't work.  There are more possible UIDs than the root file
> > > system may have Inodes...
> >
> >  ? i am confused.  by execve'ing back to a context, shall we call it
> >  smbd_as_root_t, what connection does that have to UIDs?
> 
> The idea for Exim is that you have a set of wrapper binaries already there on 
> disk.  If a particular installation of Exim doesn't use one of the ~6 
> wrappers that are installed then it's only a waste of 4K of disk space.
> 
> If we do the same mechanism for each UID then we have many more executables, 

 nono, i definitely didn't mean to suggest to have executables per UID.


> or we have to allow the daemon to create new executables which also adds more 
> coding.
> 
> >  ah, remember that you can have several UIDs over the same TCP
> >  connection (and multiple SMBsessionsetupX's to represent each
> >  and you get these SMB-MIDs - multiplexing ids - to represent
> >  each SMB session over the same TCP session),
> 
> [...]
> 
> >  i thought that instead of having the seteuid and back to root,
> >  you could execve back to the "smbd_as_root_t context".
> 
> True, but re-execing requires serialising all the data to a file, shared 
> memory region, or something else that will survive past an exec.  

 in samba, locks are already in shared memory because of the way that
 SMB file locking has to be done (e.g. global "opportunistic locks"
 whic are more of a write-cache plus notification of other people
 wanting write access to the same file thing)

 iirc correctly, the only things that need to be passed over
 are the open file handles.

> How about just smbd_the_daemon which can transition to smbd_as_a_user?
 
 fine for non-multi-connection stuff.

 l.

> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
