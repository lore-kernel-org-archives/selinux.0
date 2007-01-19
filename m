Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0JFuH2V023871
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 10:56:17 -0500
Received: from host496.ipowerweb.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0JFvBi7025704
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 15:57:11 GMT
From: "Tom Fortmann" <tfortmann@xcapesolutions.net>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'James Morris'" <jmorris@namei.org>
References: <003801c739a6$461871f0$030a0a0a@ACER> <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil> <006801c73a73$643b81e0$030a0a0a@ACER> <1169124492.22731.199.camel@moss-spartans.epoch.ncsc.mil> <00a101c73b24$069aacd0$030a0a0a@ACER> <1169220662.22731.548.camel@moss-spartans.epoch.ncsc.mil>
Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules
Date: Fri, 19 Jan 2007 09:57:10 -0600
Message-ID: <000f01c73be2$7abdb850$030a0a0a@ACER>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1169220662.22731.548.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

Thank you.  You have been great.  I will move over to the netdev and
netfilter lists.  I know our application sits on the border between security
and networking - with the problem at hand being more networking.

Thanks again,
Tom

Thomas Fortmann
Sr. Software Engineer
Xcape Solutions, Inc.
-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, January 19, 2007 9:31 AM
To: Tom Fortmann
Cc: selinux@tycho.nsa.gov; 'James Morris'
Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules

On Thu, 2007-01-18 at 11:13 -0600, Tom Fortmann wrote:
> Stephen,
> 
> We are currently working at the netfilter level.  We have a working
> netfilter module that examines packets in a NF_IP_LOCAL_IN and
> NF_IP_LOCAL_OUT hook.  The problem with working at this level is the
> additional complexity involved with altering the data.  Any change in the
> application data value or length causes changes in the IP and TCP headers.
> Moving up above layer 3 would eliminate these issues and simplify our
> design.

Possible options to consider:
- socket filters (Documentation/networking/filter.txt),
- application proxies, or
- LD_PRELOAD of a library that overrides the socket calls.

The first option requires action by the application to set up the filter
on the socket, so you'd have to modify or wrap the application (e.g.
using LD_PRELOAD as in the last option), and only filters incoming data.
Both the first and last options naturally assume that the application is
benign and well-behaved, vs. mandatory enforcement by something like an
application proxy or netfilter.

> It looks like the selinux_socket_sock_rcv_skb() hook may give me what I
need
> on the receive side - access to received data after the layers 3
processing
> is complete.  Can you point me to more detailed information on how this
hook
> works and what can and can't be done to the skb at this time?  Also, is
> there a similar hook on the transmit side?

The hook was added to check permissions on incoming packets before they
are queued on the receiving socket.  It was needed because netfilter
didn't include a hook at the point where the skb is associated with the
receiving socket, and we needed both to perform a permission check.  It
is called by sk_filter(), which is also where socket filters are
applied; see include/net/sock.h.  I suppose one could mutate the data
there as with socket filters, although that is not the intent of the LSM
hook.  On the transmit side, we just use netfilter for permission
checking, as we have all the necessary information available there.

You may want to ask on a mailing list that is more suited to general
network filtering questions, like netdev or netfilter, as what you are
trying to do isn't really a good fit for LSM or SELinux.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
