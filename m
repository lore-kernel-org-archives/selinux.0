Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKGRrT000939
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:16:27 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKGMP2024599
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:16:22 -0400 (EDT)
Date: Thu, 10 Jun 2004 20:13:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
Subject: Re: se-samba - a possible way to get round no seteuid
Message-ID: <20040610201327.GA2861@lkcl.net>
References: <20040609100345.GA5727@lkcl.net> <200406101731.39235.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406101731.39235.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 05:31:39PM +1000, Russell Coker wrote:
> On Wed, 9 Jun 2004 20:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > then, a set of capabilities can be associated with each executable,
> > which will of course do a straight execve to /usr/sbin/exim4 -
> > taking the new context with it.
> >
> > it occurred to me that a similar approach could be taken with samba.
> >
> > instead of doing a seteuid back to root, you do an execve to
> > an executable named samba-root.
> 
> That doesn't work.  There are more possible UIDs than the root file system may 
> have Inodes...

 ? i am confused.  by execve'ing back to a context, shall we call it
 smbd_as_root_t, what connection does that have to UIDs?

> We just need to have Samba know about SE Linux and tell the kernel what 
> context it wants the child process to use.

 
> > or, in the main loop, you do an execve() to an executable named
> > smbd-child, and then do a setuid, and when you're done, you do
> > an execve back to smbd.
> 
> execve back to smbd is a bad idea.  I believe that samba already has code to 
> setuid() and then exit when finished with that UID, we should plan for the 
> same design.  

 ah, remember that you can have several UIDs over the same TCP
 connection (and multiple SMBsessionsetupX's to represent each
 and you get these SMB-MIDs - multiplexing ids - to represent
 each SMB session over the same TCP session),

 and at present, a single smbd process does a seteuid to that
 UID, and then back to root, and then seteuid to the other UID,
 and back to root, etc. etc.

 only when the last SMBsessionsetupX has been matched with 
 its SMBlogoff can you drop the connection [except if the
 SMBlogoff is with an SMB-MID of zero which is a special
 case job which says "drop the lot, we're off!"]


 i thought that instead of having the seteuid and back to root,
 you could execve back to the "smbd_as_root_t context".

 so you have three contexts:

 - smbd_the_daemon (waiting for connections)

 ... which transitions on a fork to...

 - smbd_as_root_t (dealing with "connections")

 ... which can transition to ...

 - smbd_as_user_t (passing over the tcp socket filedescriptor?)

 ... which can transition to ...

 - smbd_as_root_t (for it to deal with a different uid)


 does that sound workable to you?


> Letting smbd go back to the main context provides no real 
> benefit but a lot of work in serialisation.

 oh?  oh.  oh well :)

 just a thought.

 l.

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
