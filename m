Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H8vWrT012176
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 04:57:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H8vTKV008968
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 08:57:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: how does this port binding happen?
Date: Tue, 17 Aug 2004 18:57:26 +1000
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com> <200408171610.16785.russell@coker.com.au> <20040817084234.GK18321@lkcl.net>
In-Reply-To: <20040817084234.GK18321@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408171857.26056.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Aug 2004 18:42, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Tue, Aug 17, 2004 at 04:10:16PM +1000, Russell Coker wrote:
> > On Tue, 17 Aug 2004 15:23, James Morris <jmorris@redhat.com> wrote:
> > > On Tue, 17 Aug 2004, Russell Coker wrote:
> > > > avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669
> > > > scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t
> > > > tclass=tcp_socket
> > > >
> > > > kview is a viewer for JPEG etc images.  It is never run as root.  How
> > > > does it get to the stage of an SE Linux access check?
> > >
> > > This check is done before the kernel DAC check.
> >
> > Is it practical to get that changed?
> >
> > There are quite a number of programs that make bogus attempts to bind to
> > low ports.  There is no excuse for a print client binding to port 631 or
> > a POP client binding to port 110.
>
> there is _one_ necessary exception: due to a bug in network
> neighbourhood code in windows systems.
>
> this bug was corrected and proper UDP behaviour observed in
> ONE version of windows nt - 3.51 - whereup on the bug was
> reintroduced thereafter.

It's for this sort of thing that we need to get the kernel code changed.  We 
don't want to audit huge numbers of regular stupid operations from KDE 
programs, but we also don't want a dontaudit rule to catch the few cases 
where such access may be really needed (such as the example you gave).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
