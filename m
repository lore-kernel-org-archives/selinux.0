Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HBxrrT012951
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 07:59:53 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HBxqKV012092
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 11:59:52 GMT
Subject: Re: how does this port binding happen?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408171610.16785.russell@coker.com.au>
References: 
	 <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com>
	 <200408171610.16785.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1092743906.25650.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 07:58:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-17 at 02:10, Russell Coker wrote:
> On Tue, 17 Aug 2004 15:23, James Morris <jmorris@redhat.com> wrote:
> > On Tue, 17 Aug 2004, Russell Coker wrote:
> > > avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669
> > > scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t
> > > tclass=tcp_socket
> > >
> > > kview is a viewer for JPEG etc images.  It is never run as root.  How
> > > does it get to the stage of an SE Linux access check?
> >
> > This check is done before the kernel DAC check.
> 
> Is it practical to get that changed?

I doubt it.  SELinux is using one of the general socket layer hooks to
implement the name_bind check; the kernel performs its check in the
ipv4/af_inet.c code.  Getting a hook accepted in the ipv4 code is
unlikely, and moving the kernel check to the general socket layer is
likewise unlikely.  Simplest solution for us would be to reproduce the
kernel check in the SELinux hook prior to performing the SELinux check. 
That wouldn't be difficult, just duplicative.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
