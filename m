Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05915
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:06:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA16261
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:05:44 GMT
Received: from clic.norwich.edu (207-180-179-60.s60.tnt4.mnh.nh.dialup.rcn.com [207.180.179.60])
	by jazzswing.ncsc.mil  with ESMTP id NAA16228
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:05:27 GMT
Date: Tue, 8 Jul 2003 18:07:54 -0400
From: Ryan Emge <emger@norwich.edu>
To: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: XFS and LSM
Message-Id: <20030708180754.1bc130f8.emger@norwich.edu>
In-Reply-To: <20020613104731.CF50F1F09@lyta.coker.com.au>
References: <5772.1023963428@ocs3.intra.ocs.com.au>
	<20020613104731.CF50F1F09@lyta.coker.com.au>
Reply-To: emger@norwich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


So,

ext2 and ext3 would be optimum filesystems that would not "break" SE Linux?

- Ryan

-- 

Ryan O. Emge

Information Assurance & Security
Norwich University - http://www.norwich.edu
158 Harmon Drive
Northfield, VT 05663

An NSA "Center of Academic Excellence in Information Assurance"

E: emger@norwich.edu

On Thu, 13 Jun 2002 12:47:31 +0200
Russell Coker <russell@coker.com.au> wrote:

> On Thu, 13 Jun 2002 12:17, Keith Owens wrote:
> > At 10:15 13-6-2002 +0200, Russell Coker wrote:
> > >I wanted to build a system running the XFS file system and Linux Security
> > >Modules (LSM), so I had a look at hacking the patch files to make them
> > > work.
> > >
> > >I found one issue where the patches severely conflict, system call 1217 on
> > >IA64 is sys_setxattr for XFS and is sys_security for LSM!
> >
> > The *attr syscall numbers are official, in both Linus and Marcelo
> > kernels.  LSM is picking an arbitrary syscall number for testing so
> > they will have to find another number - and change user space to match.
> 
> OK.  Shouldn't be a big issue.
> 
> > Pity Linus did not take my patch that reserves a range of syscall
> > numbers for testing and provides a clean interface for determining
> > which number to use.  Linus does not consider this to be a problem.
> 
> Yes, reserving a separate range for testing would be good, especially if you 
> can make it work so that patches don't conflict...
> 
> 
> BTW  XFS also changes the quota system in a serious way which breaks SE Linux 
> (not LSM).
> 
> -- 
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in your
> address-book so that WHEN you get a virus it won't use my address in the
> From field.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
