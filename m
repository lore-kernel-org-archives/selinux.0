Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H6AKrT011643
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 02:10:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H69d2E006915
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 06:09:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: how does this port binding happen?
Date: Tue, 17 Aug 2004 16:10:16 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408171610.16785.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Aug 2004 15:23, James Morris <jmorris@redhat.com> wrote:
> On Tue, 17 Aug 2004, Russell Coker wrote:
> > avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669
> > scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t
> > tclass=tcp_socket
> >
> > kview is a viewer for JPEG etc images.  It is never run as root.  How
> > does it get to the stage of an SE Linux access check?
>
> This check is done before the kernel DAC check.

Is it practical to get that changed?

There are quite a number of programs that make bogus attempts to bind to low 
ports.  There is no excuse for a print client binding to port 631 or a POP 
client binding to port 110.  If such a bind attempt did happen to succeed 
somehow then it would be a very bad thing as it could prevent the daemon from 
correctly starting up (think of the case where a daemon crashes and the 
sys-admin tries to restart it just after a user has run a buggy KDE program 
that binds to the port).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
