Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H8W4rT012079
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 04:32:04 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H8VN2E008697
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 08:31:24 GMT
Date: Tue, 17 Aug 2004 09:42:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: how does this port binding happen?
Message-ID: <20040817084234.GK18321@lkcl.net>
References: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com> <200408171610.16785.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408171610.16785.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 17, 2004 at 04:10:16PM +1000, Russell Coker wrote:
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
> 
> There are quite a number of programs that make bogus attempts to bind to low 
> ports.  There is no excuse for a print client binding to port 631 or a POP 
> client binding to port 110.  

there is _one_ necessary exception: due to a bug in network
neighbourhood code in windows systems.

this bug was corrected and proper UDP behaviour observed in
ONE version of windows nt - 3.51 - whereup on the bug was
reintroduced thereafter.

all other windows systems respond _from_ port 137 _to_ port 137 for
the-equivalent-of-dynamic-dns (known as NetBIOS over TCP/UDP name
resolution: see rfcs 1001 and 1002).

consequently, any system wishing to query a dynamically registered
NetBIOS name on the TCP/UDP-emulated NetBIOS stack NEEDS to bind to
port 137.

or, needs the intervention and assistance of a proxy daemon to
perform the query and receive the response, because the client's UDP
"from" port is totally ignored by all windows client.

[unfortunately, the samba team refuse to cooperate in properly
 writing such a proxy daemon service, but that's another story.]

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
