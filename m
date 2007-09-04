Subject: Re: Get source and destination info
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shahbaz khan <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700709030306i72b7b343q1ddfd229df32586a@mail.gmail.com>
References: <20cbb9450709021618o42ae8047k10e52e880c97a0a8@mail.gmail.com>
	 <711567.2389.qm@web36603.mail.mud.yahoo.com>
	 <20cbb9450709030258m68278aferf1a3ed667979cc04@mail.gmail.com>
	 <7b740b700709030306i72b7b343q1ddfd229df32586a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 09:30:51 -0400
Message-Id: <1188912651.5227.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-03 at 15:06 +0500, shahbaz khan wrote:
> >> Hi,
> >>
> > >I am trying to figure out what part in the kernel code is the point
> > >from where I can get source and destination ip-address, port,
> security
> >> labels (selinux etc) from a packet before I export it to
> application 
> > >space for my needs. Any hints?
> 
> >Look into the netlabel and xfrm code. In Smack it gets dealt with
> >in smack_lsm.c, but Smack only uses netlabel. SELinux spreads the
> >handling into a number of files, including hooks.c, netlabel.c,
> xfrm.c,
> >and ss/services.c.
>  
> Can anyone explain this to me? Some elaboration and exactness
> required.

For SELinux, look at selinux_socket_sock_rcv_skb() for handling of
incoming packets, and selinux_ip_postroute_last() for handling of
outgoing packets, both in security/selinux/hooks.c.  selinux_parse_skb
extracts the header information.  skb->secmark contains the secmark
label if set via iptables.  selinux_skb_extlbl_sid() can be used to get
the external label of a packet if using labeled networking.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
